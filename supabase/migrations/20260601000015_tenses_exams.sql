-- ============================================================
-- 20260601000015_tenses_exams.sql — exams generated from the
-- Mai Lan Hương Tenses exercises (sections I, XX, XXV). System exams.
-- ============================================================

do $$
declare ex uuid := '77777777-7777-7777-7777-777777777777'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Chia động từ — Thì hiện tại (AI chấm)','Điền/chia động từ thì hiện tại đơn & tiếp diễn; AI chấm. (Mai Lan Hương — bài I)',10,'{"D":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'The River Nile ______ into the Mediterranean.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'This book is mine. That one ______ to Pierre.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Look at Joan. She ______ her fingernails. She must be nervous.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'We usually ______ vegetables in our garden.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Let''s go out. It ______ (not rain) now.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'Every morning, the sun ______ me up.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Jim is very untidy. He always ______ his things all over the place.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Ann ______ very happy at the moment.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'He''s a photographer. He ______ a lot of photos.','D','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Oh! What''s the matter with your hand? It ______.','D','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := '55555555-5555-5555-5555-555555555555'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Will / Be going to (Tương lai)','Trắc nghiệm chọn dạng đúng: will / be going to / hiện tại. (Mai Lan Hương — bài XX)',20,'{"TB":20}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'Why are you working so hard? Because ______ a car, so I''m saving as much as I can.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll buy',false,0),(q,'B','I''m going to buy',true,1),(q,'C','I buy',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Oh, I haven''t got any money. — Don''t worry. ______ you some.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll lend',true,0),(q,'B','I''m going to lend',false,1),(q,'C','I''m lending',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'I''m in a big hurry. My train ______ in fifteen minutes.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','is going to leave',false,0),(q,'B','will leave',false,1),(q,'C','leaves',true,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'Let''s go to the carnival. — Yes, I expect ______ fun.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','it''ll be',true,0),(q,'B','it''s',false,1),(q,'C','it''s being',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Have you decided about the course? — Yes. ______ for a place.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I apply',false,0),(q,'B','I''m going to apply',true,1),(q,'C','I''ll apply',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'It''s a public holiday next month. — Yes. ______ anything special?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','Are you doing',true,0),(q,'B','Do you do',false,1),(q,'C','Will you do',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'I''ll take all my papers with me when ______.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll go',false,0),(q,'B','I''m going',false,1),(q,'C','I go',true,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'______ a party next Saturday. Can you come?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','We''ll have',false,0),(q,'B','We''re having',true,1),(q,'C','We have',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I''m trying to move this cupboard, but it''s heavy. — Well, ______ you, then.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll help',true,0),(q,'B','I''m going to help',false,1),(q,'C','I help',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Excuse me. What time ______ to London?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','will this train leave',false,0),(q,'B','is this train going to get',false,1),(q,'C','does this train get',true,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'I''ve decided to repaint this room. — What color ______ it?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','does you paint',false,0),(q,'B','are you going to paint',true,1),(q,'C','will you paint',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'Why are you putting on your coat? ______ somewhere?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','Are you going',true,0),(q,'B','Do you go',false,1),(q,'C','Will you go',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'Did you post that letter? — Sorry, I forgot. ______ it now.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I do',false,0),(q,'B','I''m doing',false,1),(q,'C','I''ll do',true,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'I''ve got a new job. ______ my new job on Monday.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''m starting',true,0),(q,'B','I''m going to start',false,1),(q,'C','I start',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'I''ve got a place at university. ______ maths at St Andrews.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll study',false,0),(q,'B','I''m going to study',true,1),(q,'C','I study',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,16,'The alarm''s making an awful noise. — OK, ______ it off.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I am switching',false,0),(q,'B','I am going to switch',false,1),(q,'C','I''ll switch',true,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,17,'Did you buy this book? — No, Emma did. ______ it on holiday.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','She''ll read',false,0),(q,'B','She is going to read',true,1),(q,'C','She reads',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,18,'Is the shop open yet? — No, but there''s someone inside. I think ______.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','it opens',false,0),(q,'B','it''s about to open',true,1),(q,'C','it will open',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,19,'Have you heard about Jane? She''s engaged. ______ married in June.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','She''s getting',true,0),(q,'B','She''ll get',false,1),(q,'C','She''s about to get',false,2);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,20,'I''m just going out to get a paper. — What newspaper ______?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','will you buy',false,0),(q,'B','are you buying',false,1),(q,'C','are you going to buy',true,2);
end $$;

do $$
declare ex uuid := '66666666-6666-6666-6666-666666666666'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Tổng hợp các thì (25 câu)','Trắc nghiệm tổng hợp các thì. (Mai Lan Hương — bài XXV)',25,'{"K":25}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'It was a boring weekend. ______ anything.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I won''t do',false,0),(q,'B','I don''t do',false,1),(q,'C','I didn''t do',true,2),(q,'D','I''m not doing',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'I''m busy at the moment. ______ on the computer.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I work',false,0),(q,'B','I''m work',false,1),(q,'C','I''m working',true,2),(q,'D','I worked',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'My friend ______ the answer to the question.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','is know',false,0),(q,'B','know',false,1),(q,'C','is knowing',false,2),(q,'D','knows',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'I think I''ll buy these shoes. ______ really well.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','They fit',true,0),(q,'B','They have fit',false,1),(q,'C','They''re fitting',false,2),(q,'D','They were fitting',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Where ______ the car?','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','did you park',true,0),(q,'B','have you parked',false,1),(q,'C','parked you',false,2),(q,'D','you parked',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'At nine o''clock yesterday morning we ______ for the bus.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','wait',false,0),(q,'B','is waiting',false,1),(q,'C','was waiting',false,2),(q,'D','were waiting',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'When I looked round the door, the baby ______ quietly.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','is sleeping',false,0),(q,'B','slept',false,1),(q,'C','was sleeping',true,2),(q,'D','were sleeping',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Here''s my report. ______ it at last.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I finish',false,0),(q,'B','I finished',false,1),(q,'C','I''d finished',false,2),(q,'D','I''ve finished',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'The earth ______ on the sun for its heat and light.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','is depended',false,0),(q,'B','depends',true,1),(q,'C','is depending',false,2),(q,'D','has depended',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'We ______ to Ireland for our holiday last year.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','go',false,0),(q,'B','are going',false,1),(q,'C','have gone',false,2),(q,'D','went',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'Robert ______ ill for three weeks. He''s still in hospital.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','had been',false,0),(q,'B','has been',true,1),(q,'C','is',false,2),(q,'D','was',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'My arms are aching now because ______ since two o''clock.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''m swimming',false,0),(q,'B','I swam',false,1),(q,'C','I swim',false,2),(q,'D','I''ve been swimming',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'I''m very tired. ______ over four hundred miles today.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I drive',false,0),(q,'B','I''m driving',false,1),(q,'C','I''ve been driving',false,2),(q,'D','I''ve driven',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'When Martin ______ the car, he took it out for a drive.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','had repaired',true,0),(q,'B','has repaired',false,1),(q,'C','repaired',false,2),(q,'D','was repairing',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'Janet was out of breath because ______.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','she''d been running',true,0),(q,'B','she ran',false,1),(q,'C','she''s been running',false,2),(q,'D','she''s run',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,16,'Don''t worry. I ______ here to help you.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','be',false,0),(q,'B','will be',true,1),(q,'C','am going to be',false,2),(q,'D','won''t be',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,17,'Our friends ______ meet us at the airport tonight.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','are',false,0),(q,'B','are going to',true,1),(q,'C','go to',false,2),(q,'D','will be to',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,18,'______ a party next Saturday. We''ve sent out the invitation.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','We had',false,0),(q,'B','We have',false,1),(q,'C','We''ll have',false,2),(q,'D','We''re having',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,19,'I''ll tell Anna all the news when ______ her.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll see',false,0),(q,'B','I''m going to see',false,1),(q,'C','I see',true,2),(q,'D','I''m seeing',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,20,'At this time tomorrow ______ over the Atlantic.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','we''re flying',false,0),(q,'B','we''ll be flying',true,1),(q,'C','we''ll fly',false,2),(q,'D','we''re to fly',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,21,'Where''s Robert? ______ a shower?','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','Does he have',false,0),(q,'B','Has he',false,1),(q,'C','Has he got',false,2),(q,'D','Is he having',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,22,'Your birthday party was the last time ______ myself.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ve really enjoyed',false,0),(q,'B','I really enjoyed',true,1),(q,'C','I''d really enjoyed',false,2),(q,'D','I really enjoy',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,23,'______ tomorrow, so we can go out somewhere.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''m not working',true,0),(q,'B','I don''t work',false,1),(q,'C','I won''t work',false,2),(q,'D','I''m not going to work',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,24,'It''s two years ______ Joe.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','that I don''t see',false,0),(q,'B','that I haven''t seen',false,1),(q,'C','since I didn''t see',false,2),(q,'D','since I saw',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,25,'Linda has lost her passport again. It''s the second time this ______.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','has happened',true,0),(q,'B','happens',false,1),(q,'C','happened',false,2),(q,'D','had happened',false,3);
end $$;

