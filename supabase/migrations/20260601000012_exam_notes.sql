-- ============================================================
-- 20260601000012_exam_notes.sql — per-user study notes for each exam.
-- Owner-only CRUD via RLS (no RPC needed). One note per (user, exam).
-- ============================================================

create table if not exists exam_notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  exam_id uuid not null references exams(id) on delete cascade,
  content text not null default '',
  updated_at timestamptz not null default now(),
  unique (user_id, exam_id)
);

alter table exam_notes enable row level security;

drop policy if exists own_notes_sel on exam_notes;
create policy own_notes_sel on exam_notes
  for select to authenticated using (user_id = auth.uid());

drop policy if exists own_notes_ins on exam_notes;
create policy own_notes_ins on exam_notes
  for insert to authenticated with check (user_id = auth.uid());

drop policy if exists own_notes_upd on exam_notes;
create policy own_notes_upd on exam_notes
  for update to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
