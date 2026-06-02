-- ============================================================
-- 20260601000011_delete_exam_8903ba84.sql — one-off: remove a specific exam
-- and everything under it (questions, choices, attempts, attempt_answers via
-- on delete cascade). Requested manually. No-op if the id is already gone.
-- ============================================================

do $$
declare
  v_id    uuid := '8903ba84-f627-411a-92b9-1134819c2fd2';
  v_title text;
  v_q     int;
  v_a     int;
begin
  select title into v_title from exams where id = v_id;
  if v_title is null then
    raise notice 'Exam % not found — nothing to delete.', v_id;
  else
    select count(*) into v_q from questions where exam_id = v_id;
    select count(*) into v_a from attempts  where exam_id = v_id;
    raise notice 'Deleting exam "%" (% questions, % attempts) + related data.', v_title, v_q, v_a;
    delete from exams where id = v_id;
  end if;
end $$;
