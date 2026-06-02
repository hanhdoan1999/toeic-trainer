-- ============================================================
-- 02_functions.sql — server-side grading (never trust the client)
-- Run after 01_schema.sql.
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
  is_correct boolean
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
    aa.is_correct
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
