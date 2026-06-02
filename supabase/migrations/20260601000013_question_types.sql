-- ============================================================
-- 20260601000013_question_types.sql — add a second question type ("text",
-- typed answer) alongside "mcq". Deterministic grading in SQL; open-ended
-- (no accepted answers) graded by AI in the Node layer via apply_ai_grades.
-- ============================================================

alter table questions
  add column if not exists type text not null default 'mcq' check (type in ('mcq','text')),
  add column if not exists accept jsonb not null default '[]'::jsonb;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'accept_is_array'
  ) then
    alter table questions add constraint accept_is_array check (jsonb_typeof(accept) = 'array');
  end if;
end $$;

alter table attempt_answers add column if not exists typed_answer text;

-- Normalize for matching: lower + collapse spaces + straighten curly quotes +
-- drop trailing punctuation. Vietnamese diacritics are kept (meaningful).
create or replace function norm_answer(p text)
returns text
language sql
immutable
as $$
  select regexp_replace(
    btrim(lower(regexp_replace(
      translate(coalesce(p, ''), '’‘`´“”', '''''''''""'),
      '\s+', ' ', 'g'))),
    '[.!?,;:]+$', '');
$$;

-- ---------- submit_attempt: grade mcq + text(with accept); leave AI rows pending ----------
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
  v_typed text;
  v_correct boolean;
  v_nt text;
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

  for q in select id, type, accept from questions where exam_id = p_exam_id loop
    if q.type = 'mcq' then
      v_sel := nullif(
        (select x->>'choice_id'
           from jsonb_array_elements(p_answers) x
          where (x->>'question_id')::uuid = q.id
          limit 1), ''
      )::uuid;
      v_typed := null;
      v_correct := coalesce(
        (select c.is_correct from choices c where c.id = v_sel and c.question_id = q.id),
        false
      );
    else
      v_sel := null;
      v_typed := nullif(btrim(
        (select x->>'typed_answer'
           from jsonb_array_elements(p_answers) x
          where (x->>'question_id')::uuid = q.id
          limit 1)), '');
      if v_typed is null then
        v_correct := false;
      elsif jsonb_array_length(q.accept) > 0 then
        v_nt := norm_answer(v_typed);
        v_correct := exists (
          select 1 from jsonb_array_elements_text(q.accept) a
          where norm_answer(a) = v_nt
        );
      else
        v_correct := false; -- AI-graded later (provisional)
      end if;
    end if;

    insert into attempt_answers (attempt_id, question_id, selected_choice_id, typed_answer, is_correct)
    values (v_attempt, q.id, v_sel, v_typed, v_correct);

    if v_correct then v_score := v_score + 1; end if;
  end loop;

  update attempts set score = v_score where id = v_attempt;
  return v_attempt;
end;
$$;

revoke all on function submit_attempt(uuid, jsonb) from public;
grant execute on function submit_attempt(uuid, jsonb) to authenticated;

-- ---------- apply_ai_grades: owner-only, attempt-scoped, authoritative recompute ----------
create or replace function apply_ai_grades(p_attempt_id uuid, p_grades jsonb)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_owner uuid;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;
  select user_id into v_owner from attempts where id = p_attempt_id;
  if v_owner is null then
    raise exception 'Attempt not found';
  end if;
  if v_owner is distinct from v_uid then
    raise exception 'Forbidden';
  end if;

  update attempt_answers aa
     set is_correct = (g->>'is_correct')::boolean
    from jsonb_array_elements(p_grades) g
   where aa.id = (g->>'answer_id')::uuid
     and aa.attempt_id = p_attempt_id;

  update attempts
     set score = (select count(*) from attempt_answers
                   where attempt_id = p_attempt_id and is_correct)
   where id = p_attempt_id;
end;
$$;

revoke all on function apply_ai_grades(uuid, jsonb) from public;
grant execute on function apply_ai_grades(uuid, jsonb) to authenticated;

-- ---------- get_attempt_review: add type/typed_answer/accept; LEFT JOIN correct choice ----------
drop function if exists get_attempt_review(uuid);
create function get_attempt_review(p_attempt_id uuid)
returns table (
  "position" int,
  stem text,
  level text,
  type text,
  typed_answer text,
  accept jsonb,
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
    q.position, q.stem, q.level, q.type, aa.typed_answer, q.accept,
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
  left join choices cc on cc.question_id = q.id and cc.is_correct = true
  where aa.attempt_id = p_attempt_id
  order by q.position;
$$;

revoke all on function get_attempt_review(uuid) from public;
grant execute on function get_attempt_review(uuid) to authenticated;

-- ---------- import_exam: support type='text' (accept array, no choices) ----------
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
  v_type   text;
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
    v_pos   := (q->>'position')::int;
    v_level := q->>'level';
    v_stem  := q->>'stem';
    v_type  := coalesce(nullif(lower(btrim(q->>'type')), ''), 'mcq');

    if v_level not in ('D','TB','K') then
      raise exception 'Invalid level "%" at position %', v_level, v_pos;
    end if;
    if v_stem is null or btrim(v_stem) = '' then
      raise exception 'Empty stem at position %', v_pos;
    end if;
    if v_type not in ('mcq','text') then
      raise exception 'Invalid type "%" at position %', v_type, v_pos;
    end if;

    if v_type = 'mcq' then
      v_answer := upper(btrim(q->>'answer'));
      if v_answer not in ('A','B','C','D') then
        raise exception 'Invalid answer "%" at position %', v_answer, v_pos;
      end if;

      insert into questions (exam_id, position, stem, level, type, accept)
      values (v_exam, v_pos, v_stem, v_level, 'mcq', '[]'::jsonb)
      returning id into v_qid;

      v_seen_correct := false;
      for opt in select * from jsonb_array_elements(q->'options') loop
        insert into choices (question_id, label, content, is_correct, position)
        values (
          v_qid, opt->>'label', opt->>'content',
          (upper(btrim(opt->>'label')) = v_answer), (opt->>'position')::int
        );
        if upper(btrim(opt->>'label')) = v_answer then
          v_seen_correct := true;
        end if;
      end loop;

      if not v_seen_correct then
        raise exception 'Answer "%" not found among options at position %', v_answer, v_pos;
      end if;
    else
      insert into questions (exam_id, position, stem, level, type, accept)
      values (v_exam, v_pos, v_stem, v_level, 'text', coalesce(q->'accept', '[]'::jsonb));
    end if;
  end loop;

  return v_exam;
end;
$$;

revoke all on function import_exam(text, text, jsonb) from public;
grant execute on function import_exam(text, text, jsonb) to authenticated;
