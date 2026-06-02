-- ============================================================
-- 01_schema.sql — TOEIC Trainer
-- Run this first in the Supabase SQL editor.
-- ============================================================

-- ---------- Tables ----------
create table if not exists exams (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  total_questions int not null default 0,
  levels jsonb not null default '{}'::jsonb,   -- {"D":20,"TB":30,"K":50}
  created_at timestamptz not null default now()
);

create table if not exists questions (
  id uuid primary key default gen_random_uuid(),
  exam_id uuid not null references exams(id) on delete cascade,
  position int not null,
  stem text not null,
  level text not null check (level in ('D','TB','K')),
  explanation text
);
create index if not exists questions_exam_idx on questions(exam_id, position);

create table if not exists choices (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references questions(id) on delete cascade,
  label text not null,
  content text not null,
  is_correct boolean not null default false,
  position int not null
);
create index if not exists choices_question_idx on choices(question_id, position);

create table if not exists attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  exam_id uuid not null references exams(id) on delete cascade,
  started_at timestamptz not null default now(),
  submitted_at timestamptz,
  score int not null default 0,
  total int not null default 0,
  duration_seconds int                            -- reserved for v2
);
create index if not exists attempts_user_idx on attempts(user_id, submitted_at desc);

create table if not exists attempt_answers (
  id uuid primary key default gen_random_uuid(),
  attempt_id uuid not null references attempts(id) on delete cascade,
  question_id uuid not null references questions(id) on delete cascade,
  selected_choice_id uuid references choices(id),
  is_correct boolean not null default false
);
create index if not exists attempt_answers_attempt_idx on attempt_answers(attempt_id);

-- ---------- Public view of choices WITHOUT the answer key ----------
-- The client must never see is_correct before submitting.
create or replace view choices_public
with (security_invoker = true) as
  select id, question_id, label, content, position
  from choices;

-- ---------- Row Level Security ----------
alter table exams           enable row level security;
alter table questions       enable row level security;
alter table choices         enable row level security;
alter table attempts        enable row level security;
alter table attempt_answers enable row level security;

-- Content: readable by any logged-in user
drop policy if exists read_exams on exams;
create policy read_exams on exams
  for select to authenticated using (true);

drop policy if exists read_questions on questions;
create policy read_questions on questions
  for select to authenticated using (true);

-- NOTE: no SELECT policy on `choices` for normal users → they read via
-- choices_public (no is_correct) or via the SECURITY DEFINER functions.

-- Attempts: only the owner
drop policy if exists own_attempts on attempts;
create policy own_attempts on attempts
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Attempt answers: only via own attempts
drop policy if exists own_answers on attempt_answers;
create policy own_answers on attempt_answers
  for all to authenticated
  using (exists (select 1 from attempts a
                 where a.id = attempt_answers.attempt_id and a.user_id = auth.uid()))
  with check (exists (select 1 from attempts a
                 where a.id = attempt_answers.attempt_id and a.user_id = auth.uid()));

-- Let logged-in users read the answer-key-free view
grant select on choices_public to authenticated;
