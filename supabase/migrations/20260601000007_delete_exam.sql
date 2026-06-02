-- ============================================================
-- 20260601000007_delete_exam.sql — delete an exam and everything under it.
-- Cascades to questions, choices, attempts and attempt_answers via FK
-- (on delete cascade). SECURITY DEFINER to bypass RLS, like submit_attempt.
-- ============================================================

create or replace function delete_exam(p_exam_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  delete from exams where id = p_exam_id;
end;
$$;

revoke all on function delete_exam(uuid) from public;
grant execute on function delete_exam(uuid) to authenticated;
