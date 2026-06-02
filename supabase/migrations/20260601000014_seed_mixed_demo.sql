-- ============================================================
-- 20260601000014_seed_mixed_demo.sql — a demo exam mixing MCQ + typed (text)
-- questions, incl. one AI-graded open question. System exam (created_by NULL).
-- ============================================================

do $$
declare
  ex uuid := '44444444-4444-4444-4444-444444444444';
  q  uuid;
begin
  delete from exams where id = ex;

  insert into exams (id, title, description, total_questions, levels, created_by)
  values (
    ex,
    'Đề test — Thì hiện tại (Trắc nghiệm + Điền từ)',
    'Đề mẫu minh hoạ 2 dạng câu: trắc nghiệm và điền từ (có 1 câu để AI chấm).',
    10, '{"D":6,"TB":3,"K":1}'::jsonb, null
  );

  -- ----- text (typed) questions with accepted answers -----
  insert into questions (exam_id, position, stem, level, type, accept) values
    (ex, 1, 'The River Nile ______ into the Mediterranean.',            'D',  'text', '["flows"]'::jsonb),
    (ex, 2, 'This book is mine. That one ______ to Pierre.',            'D',  'text', '["belongs"]'::jsonb),
    (ex, 3, 'Look! It ______ (snow) outside.',                          'D',  'text', '["is snowing","''s snowing"]'::jsonb),
    (ex, 6, 'Water ______ (boil) at 100 degrees.',                      'D',  'text', '["boils"]'::jsonb),
    (ex, 7, 'She ______ (not work) at the moment; she is on holiday.',  'TB', 'text', '["isn''t working","is not working"]'::jsonb),
    (ex, 9, 'He ______ (finish) the report yesterday.',                 'TB', 'text', '["finished"]'::jsonb),
    (ex, 10,'Write a sentence about your daily routine (present simple).','K', 'text', '[]'::jsonb);

  -- ----- mcq questions -----
  insert into questions (exam_id, position, stem, level, type, accept)
  values (ex, 4, 'The manager decided ______ the meeting.', 'D', 'mcq', '[]'::jsonb)
  returning id into q;
  insert into choices (question_id, label, content, is_correct, position) values
    (q,'A','to cancel',true,0),(q,'B','canceled',false,1),(q,'C','canceling',false,2),(q,'D','cancel',false,3);

  insert into questions (exam_id, position, stem, level, type, accept)
  values (ex, 5, 'Please avoid ______ during the presentation.', 'D', 'mcq', '[]'::jsonb)
  returning id into q;
  insert into choices (question_id, label, content, is_correct, position) values
    (q,'A','talked',false,0),(q,'B','to talk',false,1),(q,'C','talking',true,2),(q,'D','talk',false,3);

  insert into questions (exam_id, position, stem, level, type, accept)
  values (ex, 8, 'We must carefully ______ the contract.', 'TB', 'mcq', '[]'::jsonb)
  returning id into q;
  insert into choices (question_id, label, content, is_correct, position) values
    (q,'A','to review',false,0),(q,'B','reviewing',false,1),(q,'C','reviewed',false,2),(q,'D','review',true,3);
end $$;
