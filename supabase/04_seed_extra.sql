-- ============================================================
-- 04_seed_extra.sql — two more (small) exams
-- Run after 03_seed.sql
-- ============================================================
begin;

-- ---------- Exam 2: Prepositions & phrasal verbs ----------
delete from exams where id = '22222222-2222-2222-2222-222222222222';
insert into exams (id, title, description, total_questions, levels) values
  ('22222222-2222-2222-2222-222222222222', 'Part 5 — Giới từ & Cụm động từ',
   'Giới từ phổ biến và phrasal verbs trong văn phòng.', 4, '{"D":2,"TB":1,"K":1}'::jsonb);

with q as (insert into questions (exam_id, position, stem, level)
  values ('22222222-2222-2222-2222-222222222222', 1, 'She is good ______ solving problems.', 'D') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','at',true,0 from q union all select id,'B','in',false,1 from q
union all select id,'C','on',false,2 from q union all select id,'D','for',false,3 from q;

with q as (insert into questions (exam_id, position, stem, level)
  values ('22222222-2222-2222-2222-222222222222', 2, 'The report is due ______ Friday.', 'D') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','in',false,0 from q union all select id,'B','on',true,1 from q
union all select id,'C','at',false,2 from q union all select id,'D','to',false,3 from q;

with q as (insert into questions (exam_id, position, stem, level)
  values ('22222222-2222-2222-2222-222222222222', 3, 'We need to follow ______ on the request.', 'TB') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','up',true,0 from q union all select id,'B','in',false,1 from q
union all select id,'C','off',false,2 from q union all select id,'D','over',false,3 from q;

with q as (insert into questions (exam_id, position, stem, level)
  values ('22222222-2222-2222-2222-222222222222', 4, 'Please refrain ______ smoking here.', 'K') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','of',false,0 from q union all select id,'B','to',false,1 from q
union all select id,'C','from',true,2 from q union all select id,'D','with',false,3 from q;

-- ---------- Exam 3: Tenses & subject-verb agreement ----------
delete from exams where id = '33333333-3333-3333-3333-333333333333';
insert into exams (id, title, description, total_questions, levels) values
  ('33333333-3333-3333-3333-333333333333', 'Part 5 — Thì & Sự hoà hợp chủ vị',
   'Chọn đúng thì và hoà hợp chủ ngữ – động từ.', 3, '{"D":1,"TB":1,"K":1}'::jsonb);

with q as (insert into questions (exam_id, position, stem, level)
  values ('33333333-3333-3333-3333-333333333333', 1, 'The team ______ the project last week.', 'D') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','finish',false,0 from q union all select id,'B','finished',true,1 from q
union all select id,'C','finishes',false,2 from q union all select id,'D','finishing',false,3 from q;

with q as (insert into questions (exam_id, position, stem, level)
  values ('33333333-3333-3333-3333-333333333333', 2, 'Each of the documents ______ reviewed.', 'TB') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','are',false,0 from q union all select id,'B','were',false,1 from q
union all select id,'C','is',true,2 from q union all select id,'D','have',false,3 from q;

with q as (insert into questions (exam_id, position, stem, level)
  values ('33333333-3333-3333-3333-333333333333', 3, 'By next year, sales ______ doubled.', 'K') returning id)
insert into choices (question_id, label, content, is_correct, position)
select id,'A','will have',true,0 from q union all select id,'B','have',false,1 from q
union all select id,'C','had',false,2 from q union all select id,'D','has',false,3 from q;

commit;
