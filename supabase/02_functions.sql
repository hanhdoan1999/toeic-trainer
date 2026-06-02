-- ============================================================
-- 02_functions.sql — server-side grading (never trust the client)
-- Run after 01_schema.sql.
--
-- NOTE: Multi-type question support (type='text', norm_answer, apply_ai_grades,
-- and the updated submit_attempt / get_attempt_review / import_exam) lives in
-- migration supabase/migrations/20260601000013_question_types.sql, which is the
-- authoritative source applied via `supabase db push`. Apply migrations for the
-- complete, current definitions.
-- ============================================================

-- submit_attempt: grades against the DB answer key and stores the attempt.
-- p_answers is a jsonb array: [{"question_id":"...","choice_id":"..."|null}, ...]
-- Returns the new attempt id.
create or replace function submit_attempt(p_exam_id uuid, p_answers jsonb)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_attempt uuid;
  v_total int;
  v_score int := 0;
  q record;
  v_sel uuid;
  v_correct boolean;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  select count(*) into v_total from questions where exam_id = p_exam_id;
  if v_total = 0 then
    raise exception 'Exam % has no questions', p_exam_id;
  end if;

  insert into attempts (user_id, exam_id, total, submitted_at)
  values (v_uid, p_exam_id, v_total, now())
  returning id into v_attempt;

  -- iterate over EVERY question so blanks are recorded as wrong
  for q in select id from questions where exam_id = p_exam_id loop
    v_sel := nullif(
      (select x->>'choice_id'
         from jsonb_array_elements(p_answers) x
        where (x->>'question_id')::uuid = q.id
        limit 1), ''
    )::uuid;

    v_correct := coalesce(
      (select c.is_correct from choices c where c.id = v_sel and c.question_id = q.id),
      false
    );

    insert into attempt_answers (attempt_id, question_id, selected_choice_id, is_correct)
    values (v_attempt, q.id, v_sel, v_correct);

    if v_correct then v_score := v_score + 1; end if;
  end loop;

  update attempts set score = v_score where id = v_attempt;
  return v_attempt;
end;
$$;

revoke all on function submit_attempt(uuid, jsonb) from public;
grant execute on function submit_attempt(uuid, jsonb) to authenticated;

-- get_attempt_review: reveals correct answers ONLY for the caller's own attempt.
create or replace function get_attempt_review(p_attempt_id uuid)
returns table (
  "position" int,
  stem text,
  level text,
  selected_label text,
  selected_content text,
  correct_label text,
  correct_content text,
  is_correct boolean,
  options jsonb
)
language sql
security definer
set search_path = public
as $$
  select
    q.position, q.stem, q.level,
    sc.label   as selected_label,
    sc.content as selected_content,
    cc.label   as correct_label,
    cc.content as correct_content,
    aa.is_correct,
    (select jsonb_agg(jsonb_build_object('label', c.label, 'content', c.content)
                      order by c.position)
       from choices c where c.question_id = q.id) as options
  from attempt_answers aa
  join attempts a   on a.id = aa.attempt_id and a.user_id = auth.uid()
  join questions q  on q.id = aa.question_id
  left join choices sc on sc.id = aa.selected_choice_id
  join choices cc   on cc.question_id = q.id and cc.is_correct = true
  where aa.attempt_id = p_attempt_id
  order by q.position;
$$;

revoke all on function get_attempt_review(uuid) from public;
grant execute on function get_attempt_review(uuid) to authenticated;

-- import_exam: bulk-import an exam (exam + questions + choices) in one
-- transaction. p_questions is a jsonb array of:
--   {"position":int,"level":"D|TB|K","stem":text,
--    "options":[{"label":"A","content":text,"position":int}, ...],"answer":"A|B|C|D"}
create or replace function import_exam(
  p_title       text,
  p_description text,
  p_questions   jsonb
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid    uuid := auth.uid();
  v_exam   uuid;
  v_qid    uuid;
  v_total  int;
  v_levels jsonb;
  q        jsonb;
  opt      jsonb;
  v_pos    int;
  v_level  text;
  v_stem   text;
  v_answer text;
  v_seen_correct boolean;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  if p_title is null or btrim(p_title) = '' then
    raise exception 'Title is required';
  end if;

  v_total := jsonb_array_length(coalesce(p_questions, '[]'::jsonb));
  if v_total = 0 then
    raise exception 'No questions provided';
  end if;

  select jsonb_object_agg(lvl, cnt)
    into v_levels
  from (
    select (e->>'level') as lvl, count(*)::int as cnt
    from jsonb_array_elements(p_questions) e
    group by (e->>'level')
  ) s;

  insert into exams (title, description, total_questions, levels, created_by)
  values (
    btrim(p_title),
    nullif(btrim(coalesce(p_description, '')), ''),
    v_total,
    coalesce(v_levels, '{}'::jsonb),
    v_uid
  )
  returning id into v_exam;

  for q in select * from jsonb_array_elements(p_questions) loop
    v_pos    := (q->>'position')::int;
    v_level  := q->>'level';
    v_stem   := q->>'stem';
    v_answer := upper(btrim(q->>'answer'));

    if v_level not in ('D','TB','K') then
      raise exception 'Invalid level "%" at position %', v_level, v_pos;
    end if;
    if v_stem is null or btrim(v_stem) = '' then
      raise exception 'Empty stem at position %', v_pos;
    end if;
    if v_answer not in ('A','B','C','D') then
      raise exception 'Invalid answer "%" at position %', v_answer, v_pos;
    end if;

    insert into questions (exam_id, position, stem, level)
    values (v_exam, v_pos, v_stem, v_level)
    returning id into v_qid;

    v_seen_correct := false;
    for opt in select * from jsonb_array_elements(q->'options') loop
      insert into choices (question_id, label, content, is_correct, position)
      values (
        v_qid,
        opt->>'label',
        opt->>'content',
        (upper(btrim(opt->>'label')) = v_answer),
        (opt->>'position')::int
      );
      if upper(btrim(opt->>'label')) = v_answer then
        v_seen_correct := true;
      end if;
    end loop;

    if not v_seen_correct then
      raise exception 'Answer "%" not found among options at position %', v_answer, v_pos;
    end if;
  end loop;

  return v_exam;
end;
$$;

revoke all on function import_exam(text, text, jsonb) from public;
grant execute on function import_exam(text, text, jsonb) to authenticated;

-- delete_exam: remove an exam and all rows under it (questions, choices,
-- attempts, attempt_answers cascade via FK). Only the owner (created_by) may
-- delete; NULL-owner (seeded) exams are non-deletable.
create or replace function delete_exam(p_exam_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid   uuid := auth.uid();
  v_owner uuid;
  v_found boolean;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  select created_by, true into v_owner, v_found
  from exams where id = p_exam_id;

  if not v_found then
    raise exception 'Đề không tồn tại';
  end if;

  if v_owner is distinct from v_uid then
    raise exception 'Bạn không có quyền xoá đề này';
  end if;

  delete from exams where id = p_exam_id;
end;
$$;

revoke all on function delete_exam(uuid) from public;
grant execute on function delete_exam(uuid) to authenticated;

-- update_exam_title: rename an exam (owner only).
create or replace function update_exam_title(p_exam_id uuid, p_title text)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid   uuid := auth.uid();
  v_owner uuid;
  v_found boolean;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;
  if p_title is null or btrim(p_title) = '' then
    raise exception 'Tên đề không được để trống';
  end if;

  select created_by, true into v_owner, v_found
  from exams where id = p_exam_id;

  if not v_found then
    raise exception 'Đề không tồn tại';
  end if;
  if v_owner is distinct from v_uid then
    raise exception 'Bạn không có quyền sửa đề này';
  end if;

  update exams set title = btrim(p_title) where id = p_exam_id;
end;
$$;

revoke all on function update_exam_title(uuid, text) from public;
grant execute on function update_exam_title(uuid, text) to authenticated;
