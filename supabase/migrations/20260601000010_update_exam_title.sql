-- ============================================================
-- 20260601000010_update_exam_title.sql — let the exam owner rename their exam.
-- Same ownership rule as delete_exam; NULL-owner (seeded) exams are locked.
-- ============================================================

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
