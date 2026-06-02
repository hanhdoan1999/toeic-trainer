-- ============================================================
-- 20260601000018_passages.sql — passage type (context) + rebuild V & X.
-- ============================================================

-- get_attempt_review now also returns the passage context.
drop function if exists get_attempt_review(uuid);
create function get_attempt_review(p_attempt_id uuid)
returns table (
  "position" int,
  stem text,
  level text,
  type text,
  context text,
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
    q.position, q.stem, q.level, q.type, q.context, aa.typed_answer, q.accept,
    sc.label as selected_label, sc.content as selected_content,
    cc.label as correct_label, cc.content as correct_content,
    aa.is_correct,
    (select jsonb_agg(jsonb_build_object('label', c.label, 'content', c.content) order by c.position)
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

do $$
declare ex uuid := 'a0000005-0000-4000-8000-000000000000';
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Điền đoạn văn — Lá thư ở York (V)','Passage: điền động từ vào từng chỗ trống của lá thư; AI chấm từng ô. (bài V)',13,'{"K":13}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,1,'We (be) ______ here for three days now.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,2,'We (decide / plan) ______ to stay for the rest of the week.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,3,'We (enjoy) ______ ourselves so much.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,4,'We (see / visit) ______ the Cathedral and the Castle Museum.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,5,'This morning we (walk / wander) ______ around the little old-fashioned streets.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,6,'We (not / spend) ______ much money yet.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,7,'Besides the sightseeing, we (do) ______ some exercise.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,8,'We (have / go) ______ some lovely long walks.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,9,'Fortunately, the weather (be) ______ very good so far.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,10,'People (say) ______ it can be very cold.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,11,'It often (rain) ______ for days!','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,12,'This is the first time I (be / come) ______ to England.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,13,'I (think) ______ I''m just lucky.','K','text','[]'::jsonb,'Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).');
end $$;

do $$
declare ex uuid := 'a0000010-0000-4000-8000-000000000000';
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Điền hội thoại — Tin về David (X)','Passage: chia động từ trong hội thoại (quá khứ đơn / hiện tại hoàn thành); AI chấm từng ô. (bài X)',13,'{"TB":13}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,1,'______ (you / hear) the news about David?','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,2,'______ (what / happen)?','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,3,'______ (he / have) an accident.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,4,'When he was walking down some steps, ______ (he / fall).','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,5,'... and ______ (break) his leg.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,6,'When ______ (it / happen)?','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,7,'Melanie ______ (tell) me about it last night.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,8,'______ (you / know) about it last night,','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,9,'and ______ (you / not / tell) me!','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,10,'Well, ______ (I / not / see) you last night.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,11,'And ______ (I / not / see) you today, until now.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,12,'______ (he / have) lots of accidents, you know.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,13,'______ (he / do) the same thing about two years ago.','TB','text','[]'::jsonb,'Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.');
end $$;

