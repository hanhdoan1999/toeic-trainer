-- ============================================================
-- 20260601000016_all_exams.sql — remaining Mai Lan Hương Tenses sections.
-- text => AI-graded; mcq => with answer key. System exams (created_by null).
-- ============================================================

do $$
declare ex uuid := 'a0000002-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hiện tại đơn / tiếp diễn (hội thoại)','Chia động từ trong ngoặc; AI chấm. Nhiều chỗ trống: gõ đáp án cách nhau bằng '';''. (bài II)',15,'{"TB":15}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'What ______ (you/ do)? — I ______ (write) to my parents. I ______ (write) to them every weekend.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Look, it ______ (snow). — It ______ (not snow) in my country.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Where ______ (he/ live)? ______ (you/ know)? — He ______ (live) in Milan, but now he ______ (stay) with his aunt.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'What time ______ (you/ usually/ finish) work? — Normally I ______ (finish) at five, but this week I ______ (work) until six.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'How ______ (you/ travel) to work? — I ______ (go) to work on the bus this week. Usually I ______ (drive).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'The sun ______ (rise) in the east, remember. It''s behind us, so we ______ (travel) west.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'______ (you/ look) for someone? — Yes, I ______ (need) to speak to Neil. I ______ (think) he''s busy. He ______ (talk) to the boss at the moment.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'I ______ (want) a new computer. I ______ (save) up to buy one. — But computers ______ (cost) so much. It ______ (get) out of date now.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'Your new dress ______ (look) very nice. — It ______ (not/ fit) properly. I ______ (not/ know) why I bought it.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'What ______ (you/ do)? — I ______ (taste) the sauce. It ______ (taste) too salty.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'I ______ (think) this road is dangerous. Look how fast that lorry ______ (go). — I ______ (agree).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'It seems they ______ (always/ fight) about something. — It will be better when they ______ (grow) up.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'I ______ (live) at a guest house at the moment as I ______ (look) for a flat. You''ll have the goods by the end of the week, I ______ (promise).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'I ______ (always/ fall) asleep. — What time ______ (you/ go) to bed? — But it ______ (not/ make) any difference.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'Why ______ (you/ want) to change the whole plan? — And I ______ (not/ understand) why you ______ (be) so difficult about it.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000003-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hiện tại hoàn thành / HTHT tiếp diễn','Chia động từ; AI chấm. (bài III)',12,'{"TB":12}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'How long ______ (you/ study) English? — I ______ (learn) English since I was twelve.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'I ______ (wait) for two hours, but my friend ______ (not come) yet.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'I ______ (lose) my address book. ______ (you/ see) it anywhere? — I ______ (just/ see) it on the bookshelf.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'______ (you/ work) so hard? — I ______ (study) for four hours and probably won''t finish until midnight.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'______ (you/ see) Mark recently? — No, I ______ (not/ see) him since Christmas. I wonder where he ______ (live) since then.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'It''s because you ______ (do) too much. — At least I ______ (finish) that report now.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Someone ______ (leave) the ladder outside. — Mike ______ (clean) the windows. I don''t think he ______ (finish) yet.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'I ______ (work) in the garden. — You ______ (do) a good job.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I ______ (hear) that you are building a garage. How long ______ (you/ do) that? — We ______ (do) about half of it.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'How long ______ (you/ read) it? — I ______ (read) it for three days, but I ______ (not/ finish) it yet.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'How long ______ (you/ know) Jane? — We ______ (know) each other for over ten years.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'______ (John/ always/ live) in London? — No, he ______ (live) in London for the last few years.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000004-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Tổng hợp thì hiện tại','Chia động từ; AI chấm. (bài IV)',15,'{"TB":15}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'Listen! I ______ (think) someone ______ (knock) at the door.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'We ______ (not/ know) why Sarah is upset, but she ______ (not/ speak) to us for ages.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'The earth ______ (circle) the sun once every 365 days.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'Why ______ (you/ stare) at me? I suppose you ______ (not/ see) a woman on a motorbike before!','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'How many times ______ (you/ see) him since he went to Edinburgh?','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'Trevor and Laura like Scrabble. They ______ (play) it most evenings.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'The number of vehicles on the road ______ (increase).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'''Sorry I''m late.'' ''That''s all right. I ______ (not/ wait) long.''','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'Mrs Green always ______ (go) to work by car, but this week she ______ (travel) by bus.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'We ______ (be) from France. We ______ (be) there for 20 years.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'These flowers are dying. You ______ (not/ water) them for ages.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'Mai ______ (lose) her keys, so she can''t get into the house.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'I ______ (not/ finish) typing those letters yet. I ______ (deal) with customers all morning.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'What ______ (your father/ do)? — He ______ (be) an architect but he ______ (not/ work) at the moment.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'______ (you/ ever/ see) a lion? — Yes, I ______ (see) one since I was a child.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000005-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Điền đoạn văn — lá thư (HTHT / hiện tại)','Điền động từ phù hợp vào đoạn văn; AI chấm. Gõ đáp án từng chỗ cách nhau bằng '';''. (bài V)',6,'{"K":6}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'We (be) ______ here for three days now and we (decide/plan) ______ to stay for the rest of the week because we (enjoy) ______ ourselves so much.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'We (see/visit) ______ the Cathedral and the Castle Museum and this morning we (walk/wander) ______ around the little old-fashioned streets.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'We (not/ spend) ______ much money yet but we''ll get some souvenirs before we leave.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'Besides the sightseeing, we (do/get) ______ some exercise and we (go/have) ______ some lovely long walks.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Fortunately, the weather (be) ______ very good so far. People (say/tell) ______ it can be very cold and it often (rain) ______ for days!','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'As this is the first time I (be/come) ______ to England, I (think) ______ I''m just lucky.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000006-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Viết câu từ từ cho sẵn (quá khứ)','Sắp xếp từ thành câu, dùng quá khứ đơn/tiếp diễn; AI chấm. (bài VI)',15,'{"TB":15}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'when Don / arrive / we / have / coffee','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'he / sit down / on a chair / while / I / paint / it','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'the students / play / a game / when / professor / arrive','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'Felix / phone / the fire brigade / when the cooker / catch / fire','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'while / he / walk / in the mountains / Henry / see / a bear','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'when the starter / fire / his pistol / the race / begin','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'I / walk / home / when it / start / to rain','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'when / Margaret / open / the door / the phone / ring','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'he / sit / in the garden / when / a wasp / sting / him / on the nose','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'while / he / run / for a bus / he / collide / with a lamp post','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'Vicky / have / a beautiful dream / when / the alarm clock / ring','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'when / Alex / see / the question / he / know / the answer / immediately','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'the train / wait / when / we / arrive / at the station','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'Sarah / have / an electric shock / when / she / touch / the wire','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'when / the campers / wake / they / see / the sun / shine','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000007-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Quá khứ đơn / tiếp diễn','Chia động từ; AI chấm. (bài VII)',15,'{"TB":15}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'When Martin ______ (arrive) home, Ann ______ (talk) to someone on the phone.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'It ______ (be) cold when we ______ (leave) the house, and a light snow ______ (fall).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'I ______ (call) Roger at nine last night, but he ______ (not/ be) at home. He ______ (study) at the library.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'I ______ (see) Sue in town yesterday but she ______ (not/ see) me. She ______ (look) the other way.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'When I ______ (open) the cupboard door, a pile of books ______ (fall) out.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'How ______ (you/ break) your arm? — I ______ (slip) on the ice while I ______ (cross) the street.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'What ______ (you/ do) this time yesterday? — We ______ (drive) to London, but on the way we ______ (hear) about a bomb scare. So we ______ (drive) back home.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'I ______ (meet) Tom and Ann at the airport. They ______ (go) to Berlin and I ______ (go) to Madrid. We ______ (have) a chat while we ______ (wait) for our flights.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I ______ (cycle) home when suddenly a man ______ (step) out into the road. I ______ (go) quite fast but luckily I ______ (manage) to stop and ______ (not/ hit) him.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Flight 2001 ______ (fly) from London to New York when it suddenly ______ (encounter) turbulence and ______ (drop) 15,000 feet. The plane ______ (carry) over 300 passengers.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'While divers ______ (work) off Florida, they ______ (discover) a shipwreck. The divers ______ (film) life on a coral reef when they ______ (find) the gold.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'The ambulance driver ______ (make) a phone call when the thief ______ (start up) the ambulance. He ______ (speed) away when the driver ______ (see) him and ______ (call) the police.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'Police ______ (stop) a motorist as she ______ (speed). While they ______ (search) the trunk, they ______ (find) three snakes. The driver said she ______ (take) them to a pet fair.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'Last night when we ______ (come) down the hill, we ______ (see) a strange object. We ______ (stop) the car. As we ______ (watch) it, it suddenly ______ (fly) away and ______ (disappear).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'I ______ (finally/ find) the right room. It ______ (already/ be) full of students. Some ______ (talk) in Spanish. I ______ (choose) a seat and ______ (sit) down. The teacher ______ (walk) in and the conversation ______ (stop).','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000009-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Quá khứ đơn / hiện tại hoàn thành','Chia động từ; AI chấm. (bài IX)',20,'{"TB":20}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'I ______ (have) this shirt for nearly four years.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Joanna ______ (tidy) her desk, but now it''s in a mess again.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Mike ______ (lose) his key. He can''t find it anywhere.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'The last time I ______ (go) to Brighton was in August.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'I ______ (finish) my homework. I ______ (do) it before tea.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'And the race is over! Micky Simpson ______ (win) in a record time!','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Martin ______ (be) to Greece five times. He loves the place.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Of course I can ride a bike. But I ______ (not/ ride) one for years.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I don''t know Carol''s husband. I ______ (never/ meet) him.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Rupert ______ (leave) a message for you. He ______ (ring) last night.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'Your car looks very clean. ______ (you/ wash) it?','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'We ______ (move) here in 1993. We ______ (be) here a long time now.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'Mr Clack ______ (work) in a bank for 15 years. Then he gave it up.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'Is this the first time you ______ (cook) pasta?','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'I ______ (work) for a computer company since I ______ (graduate) from university.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,16,'We ______ (post) the parcel three weeks ago. If you still ______ (not/ receive) it, please inform us.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,17,'Albert Einstein ______ (be) the scientist who ______ (develop) the theory of relativity.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,18,'My grandfather ______ (die) 30 years ago. I ______ (never/ meet) him.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,19,'Is your father at home? — No, he ______ (go) out. — When ______ (he/ go) out? — About ten minutes ago.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,20,'How long ______ (you/ live) there? — 5 years. — Where ______ (you/ live) before that?','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000010-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hội thoại — quá khứ / hiện tại hoàn thành','Chia động từ; AI chấm. Gõ nhiều đáp án cách nhau bằng '';''. (bài X)',6,'{"TB":6}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'______ (you/ hear) the news about David? — No. ______ (what/ happen)?','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'______ (he/ have) an accident. When he was walking down some steps, ______ (he/ fall) and ______ (break) his leg.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'When ______ (it/ happen)? — Yesterday afternoon. Melanie ______ (tell) me about it last night.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'______ (you/ know) about it last night, and ______ (you/ not/ tell) me!','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Well, ______ (I/ not/ see) you last night. And ______ (I/ not/ see) you today, until now.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'______ (he/ have) lots of accidents. ______ (he/ do) the same thing about two years ago.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000012-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hiện tại hoàn thành / quá khứ hoàn thành','Chia động từ (có thể phủ định); AI chấm. (bài XII)',15,'{"K":15}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'Who is that woman? I ______ (never/ see) her before.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'The house was dirty. They ______ (clean) it for weeks.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'There was no sign of a taxi, although I ______ (order) one half an hour before.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'You can have that newspaper. I ______ (finish) with it.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'We went to the box office at lunch-time, but they ______ (already/ sell) all the tickets.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'It isn''t raining now. It ______ (stop) at last.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'It''ll soon get warm here. I ______ (turn) the heating on.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'It was twenty to six. Most of the shops ______ (just/ close).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'Karen didn''t want to come because she ______ (already/ see) the film.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'There''s no more cheese. We ______ (eat) it all.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'I''m pleased to see you after such a long time. We ______ (not/ see) each other for five years.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'I spoke to Melanie at lunch-time. Someone ______ (tell) her the news earlier.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'By 1960 most of Britain''s old colonies ______ (become) independent.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'Don''t you want to see this program? It ______ (start).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'At first I thought I ______ (do) the right thing, but I soon realised that I ______ (make) a serious mistake.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000013-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Quá khứ đơn / quá khứ hoàn thành','Chia động từ; AI chấm. (bài XIII)',10,'{"K":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'The house was very quiet when I ______ (get) home. Everybody ______ (go) to bed.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'The apartment was hot when I got home, so I ______ (turn) on the air conditioner.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'______ (you/ meet) Tom at the party? — No, he ______ (already/ go) home when I ______ (arrive).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'I ______ (feel) better after I ______ (take) the medicine.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'I was late. The teacher ______ (already/ give) a quiz when I ______ (get) to class.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'It was raining hard, but by the time the class ______ (be) over, the rain ______ (stop).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'When I saw that Mike was having trouble, I ______ (help) him. He ______ (be) very appreciative.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'We were driving along when we ______ (see) a car which ______ (break) down, so we ______ (stop) to help.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'We ______ (arrive) at work and ______ (find) that somebody ______ (break) into the office. So we ______ (call) the police.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Yesterday I ______ (go) to my daughter''s dance recital. I ______ (never/ be) to one before. I ______ (not/ take) lessons when I ______ (be) a child.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000014-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'HTHT tiếp diễn / QKHT tiếp diễn','Chia động từ; AI chấm. (bài XIV)',10,'{"K":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'It was empty, but the television was still on. Someone ______ (watch) it.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'I really must go to the dentist. One of my teeth ______ (ache) for weeks.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'I hope the bus comes soon. I ______ (wait) for 20 minutes.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'He was very tired because he ______ (work) hard all day.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'At last the bus came. I ______ (wait) for 20 minutes.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'The telephone ______ (ring) for almost a minute. Why doesn''t someone answer it?','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Ken gave up smoking two years ago. He ______ (smoke) for 30 years.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'We were extremely tired at the end of the journey. We ______ (travel) for more than 24 hours.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I haven''t finished this letter yet. — You ______ (write) since lunch-time.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Our game of tennis was interrupted. We ______ (play) for about half an hour when it started to rain.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000015-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Tổng hợp thì quá khứ','Chia động từ; AI chấm. Gõ nhiều đáp án cách nhau bằng '';''. (bài XV)',7,'{"K":7}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'A few days ago I ______ (see) a man whose face ______ (be) familiar. I couldn''t think where I ______ (see) him before. Then I ______ (remember) who it ______ (be).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'I ______ (knock) on the door but there ______ (be) no answer. Either he ______ (go) out or he ______ (not/ want) to see anyone.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Sharon ______ (go) to the station to meet Paul. When she ______ (get) there, Paul ______ (already/ wait) for her. His train ______ (arrive) early.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'When I got home, Bill ______ (lie) on the sofa. He ______ (not/ watch) the TV. He ______ (fall) asleep and ______ (snore). I ______ (turn) the TV off and he ______ (wake) up.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Last night I ______ (just/ go) to bed and ______ (read) when suddenly I ______ (hear) a noise. I ______ (get) up but I ______ (not/ see) anything, so I ______ (go) back to bed.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'Mary ______ (have to) go to New York but she almost ______ (miss) the plane. She ______ (stand) in the queue when she ______ (realize) she ______ (leave) her passport at home. She ______ (get) back just in time.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'I ______ (meet) George and Linda as I ______ (walk) through the park. They ______ (be) to the Sports Center where they ______ (play) tennis. They ______ (invite) me but I ______ (not/ have) time.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000016-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hoàn thành câu hỏi','Viết câu hỏi với động từ phù hợp; AI chấm. (bài XVI)',12,'{"TB":12}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'I''m looking for Paul. ______ him? — Yes, he was here a moment ago.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Why ______ to bed so early last night? — Because I was feeling very tired.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Where ______? — Just to the postbox. I want to post these letters.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'______ television every evening? — No, only if there''s a good program.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'How long ______ here? — Nearly ten years.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'How was your holiday? ______ a nice time? — Yes, it was great.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'______ Julie recently? — Yes, I met her a few days ago.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'What ______ (she wearing)? — A red sweater and black jeans.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I''m sorry to keep you waiting. ______ long? — No, only about ten minutes.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'How long ______ you to get to work in the morning? — Usually about 45 minutes.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'______ with that newspaper yet? — No, I''m still reading it.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'______ to the United States? — No, never, but I went to Canada a few years ago.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000017-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hoàn thành câu theo gợi ý','Viết theo từ trong ngoặc, dùng thì phù hợp; AI chấm. (bài XVII)',20,'{"TB":20}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'We bought this picture a long time ago. ______ (we/ have/ it) for ages.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Sandra finds her mobile phone useful. ______ (she/ use/ it) all the time.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'There''s a new road to the motorway. ______ (they/ open/ it) yesterday.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'We decided not to go out because ______ (it/ rain) quite hard.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Vicky doesn''t know where her watch is. ______ (she/ lose/ it).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'We had no car at that time. ______ (we/ sell/ our old one).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'I bought a new jacket last week but ______ (I/ not/ wear/ it) yet.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Claire is on a skiing holiday. ______ (she/ enjoy/ it), she says.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'The color of this paint is awful. ______ (I/ hate/ it).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Henry is annoyed. ______ (he/ wait) a long time for Claire.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'______ (I/ check/ them) several times already.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'Sandra and Laura like tennis. ______ (they/ play/ it) every weekend.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'Sorry, I can''t stop now. ______ (I/ go) to an important meeting.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'It''s a long time since ______ (I/ last/ see/ her).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'I found my key when ______ (I/ look) for something else.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,16,'______ (I/ read) the book you lent me but ______ (I/ not finish/ it) yet.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,17,'I wasn''t hungry at lunchtime because ______ (I/ have/ a big breakfast).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,18,'Ann is out of breath. ______ (she/ run).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,19,'Where''s my bag? ______ (somebody/ take/ it).','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,20,'We were surprised when Jenny and Andy got married. ______ (they/ only/ know/ each other) for a few weeks.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000018-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hiện tại diễn tả tương lai','Chia động từ (hiện tại đơn/tiếp diễn cho tương lai); AI chấm. (bài XVIII)',10,'{"TB":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'We ______ (have) a party on Sunday. Would you like to come?','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'What time ______ (your train/ leave) tomorrow? — It ______ (get) into Paris at eleven twenty-three.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'______ (the film/ begin) at 3.30 or 4.30? — It ______ (begin) at 3.30. I ______ (pick) you up at 3.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'I ______ (go) to an ice hockey match this evening. What time ______ (the match/ start)? — It ______ (start) at half past seven.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'When ______ (the art exhibition/ open)? — It ______ (open) on 3 May and ______ (finish) on 15 July.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'What time ______ (you/ finish) work tomorrow? — I ______ (not/ go) to work tomorrow. I ______ (stay) at home.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'______ (you/ do) anything tomorrow morning? — Yes, I ______ (go) to the airport to meet Richard. His plane ______ (arrive) at eight fifteen.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Where ______ (you/ go) on your holiday? — We ______ (leave) for Paris next week. The train ______ (leave) early on Tuesday.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'When ______ (it/ finish)? — It ______ (last) till 2:30.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'I can''t. I ______ (meet) Jennifer at the library.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000019-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'will / be going to','Viết động từ với will hoặc be going to; AI chấm. (bài XIX)',12,'{"TB":12}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'Do you have any plans for this afternoon? — Yes, I ______ (look round) the museum.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'It''s coming towards us. It ______ (attack) us.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Can I speak to Jim, please? — Just a moment. I ______ (get) him.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'The weather''s too nice to stay indoors. I ______ (sit) in the garden. — I think I ______ (join) you.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Don''t worry about the letter. I''m sure you ______ (find) it.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'I think aliens ______ (land) on the earth in the next ten years.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Have you decided about the job? — Yes, I ______ (not/ apply) for it.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Shhh! Don''t make so much noise. You ______ (wake) everybody up.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'Have you heard about Michelle? — I heard that she ______ (get) married.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'I want to go out tomorrow but I haven''t got a baby-sitter. — That''s no problem. I ______ (look after) them.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'Shall we meet on Friday morning? — I can''t. I ______ (go) to the dentist.','TB','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'I need somebody to take me to the airport. — I ______ (take) you. — OK. We ______ (leave) at about 9 then.','TB','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000021-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hiện tại / tương lai đơn / tương lai tiếp diễn','Chia động từ; AI chấm. (bài XXI)',10,'{"K":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'I ______ (meet) you at the airport tomorrow. After you ______ (clear) customs, look for me. I ______ (stand) right by the door.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'When ______ (you/ leave) for Florida? — Two days from now I ______ (lie) on the beach.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Please visit today when you ______ (have) a chance. I ______ (shop) from 1:00 to 2:30, but I ______ (be) home after that.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'Would you like to come to our party? — Thanks, but I ______ (work) all day tomorrow.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'I ______ (call) you this afternoon. — Don''t call between 3 and 5 because I ______ (not/ be) home. I ______ (study) at the library.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'I ______ (attend) a seminar in Los Angeles. Ms. Gomes ______ (substitute-teach) for me. When I ______ (return), be ready for the exam.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'What ______ (you/ do) in five years'' time? — I''m going into business when I ______ (leave) college. Five years from now I ______ (run) a big company.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'As soon as your ankle ______ (heal), you can play soccer. At this time next week, you ______ (play) soccer.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I ______ (tell) you when I ______ (be) ready. I promise I ______ (not be) very long.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'Trevor and Laura ______ (not/ go) for a picnic tomorrow. They ______ (clean) the house. They always ______ (do) it on Sunday.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000022-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Tương lai tiếp diễn / tương lai hoàn thành','Chia động từ; AI chấm. (bài XXII)',10,'{"K":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'We''re going to play tennis from 3 until 4.30. So at 4 o''clock ______ (we/ play) tennis.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Can we meet tomorrow afternoon? — Not in the afternoon. ______ (I/ work).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Will you be free at 11.30? — Yes. ______ (the meeting/ finish) by that time.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'If he continues like this, ______ (he/ spend) all his money before the end of his holiday.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'If you need to contact me, ______ (I/ stay) at the Lion Hotel until Friday.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'We''re late. ______ (the film/ already/ start) by the time we get to the cinema.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Next Monday, ______ (Chuck/ be) in Britain for exactly three years.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Is it all right if I come at 8.30? — No, ______ (I/ watch) the football then. — What about 9.30? — ______ (the match/ finish) by then.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'By the end of the trip, ______ (she/ travel) more than 3,000 miles.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'______ (you/ pass) the post office on your way home? — The post office ______ (close) by the time I get home.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000024-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Hội thoại điền động từ (tổng hợp)','Chia động từ; AI chấm. Gõ nhiều đáp án cách nhau bằng '';''. (bài XXIV)',17,'{"K":17}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'______ (you/ buy) anything at the antiques sale yesterday? — No, ______ (I/ want) to buy some jewellery, but ______ (I/ leave) my credit card at home.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Are you still copying those addresses? — No, that''s all. ______ (I/ finish) now.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'How long ______ (we/ wait) now? — ______ (we/ be) here since ten to five.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'When ______ (we/ drink) our coffee, ______ (she/ hurry) off home.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'______ (I/ have) breakfast when ______ (I/ hear) the news.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'How long ______ (you/ do) that? — Since I was sixteen. ______ (we/ do) about a dozen concerts.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'I''m sure ______ (she/ cry). Her eyes looked red. — Perhaps ______ (she/ have) some bad news.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'When ______ (we/ hear) the shot, ______ (we/ throw) ourselves to the floor.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'I rang but you weren''t in. — No, ______ (I/ have) lunch at that time.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'You look tired. — ______ (I/ work) all day.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'Is Laura at home? — No, ______ (she/ go) out about an hour ago.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'______ (I/ not/ finish) this letter yet. — ______ (you/ write) it since lunchtime.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'You''ve got new neighbors. — Yes. ______ (they/ move) in last month.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'______ (you/ arrive) at the theatre in time? — No. By the time we got there, ______ (it/ already/ begin).','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'______ (I/ live) in a friend''s house at the moment. Luckily ______ (I/ find) a place of my own now.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,16,'______ (she/ never/ use) a computer before, so ______ (she/ not/ know) what to do.','K','text','[]'::jsonb);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,17,'Which language ______ (you/ learn)? — When ______ (the Spanish course/ start)? — ______ (it/ start) next week.','K','text','[]'::jsonb);
end $$;

do $$
declare ex uuid := 'a0000008-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Chọn dạng đúng (hội thoại Andy–Jane)','Chọn dạng đúng của động từ. (bài VIII)',18,'{"TB":18}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'What ______ in this part of London?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','are you doing',true,0),(q,'B','do you do',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Well, ______ at flats round here.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''m looking',true,0),(q,'B','I look',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'Flats? ______ to move?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','Are you wanting',false,0),(q,'B','Do you want',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'In fact, Adam and I ______ married.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','are getting',true,0),(q,'B','get',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'When ______?','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','have you decided',false,0),(q,'B','did you decide',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'It was while we ______ with his family in Scotland.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','were staying',true,0),(q,'B','stayed',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Now ______ to find a suitable flat.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','we try',false,0),(q,'B','we''re trying',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'______ you manage to buy one soon.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I hope',true,0),(q,'B','I''m hoping',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'Oh, we ______ for one to buy.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','aren''t looking',true,0),(q,'B','don''t look',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'We ______ enough money yet.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','aren''t having',false,0),(q,'B','don''t have',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'______ to find somewhere to rent.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','We''re wanting',false,0),(q,'B','We want',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'That''s what we ______ at first.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','have been doing',false,0),(q,'B','did',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'In the end my brother ______ us some money.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','was lending',false,0),(q,'B','lent',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'That''s how we ______ to buy ours.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','were managing',false,0),(q,'B','managed',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'Perhaps I''ll talk to my family before we ______ a flat.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','choose',true,0),(q,'B','have chosen',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,16,'My family ______ us a lot of helpful advice.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','gave',true,0),(q,'B','were giving',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,17,'I ______ for somewhere to sit down when I bumped into you.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','looked',false,0),(q,'B','was looking',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,18,'I ______ into you. Let''s go.','TB','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','bumped',true,0),(q,'B','have bumped',false,1);
end $$;

do $$
declare ex uuid := 'a0000011-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Điền lá thư — trắc nghiệm (Save Our Pub)','Chọn đáp án đúng điền vào lá thư. (bài XI)',10,'{"K":10}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'A few days ago I ______ that someone plans to knock down the White Horse Inn.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','had learned',false,0),(q,'B','learned',true,1),(q,'C','has learned',false,2),(q,'D','learn',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'This pub ______ the center of village life for centuries.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','has been',true,0),(q,'B','had been',false,1),(q,'C','was',false,2),(q,'D','is',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'It ______ at our crossroads for 500 years.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','stood',false,0),(q,'B','is standing',false,1),(q,'C','stands',false,2),(q,'D','has stood',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'It ______ famous in the old days.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','has been',false,0),(q,'B','is',false,1),(q,'C','was',true,2),(q,'D','had been',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Shakespeare once ______ there, they say.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','had stayed',false,0),(q,'B','stayed',true,1),(q,'C','stays',false,2),(q,'D','has stayed',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'I ______ in Brickfield all my life.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','lived',false,0),(q,'B','am living',false,1),(q,'C','was',false,2),(q,'D','have lived',true,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'The villagers ______ about the plans for less than a week.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','have known',true,0),(q,'B','knew',false,1),(q,'C','had known',false,2),(q,'D','know',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'Last week we ______ happy.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','are being',false,0),(q,'B','has been',false,1),(q,'C','were',true,2),(q,'D','had been',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'But this week we ______ angry.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','are',true,0),(q,'B','were',false,1),(q,'C','has been',false,2),(q,'D','are being',false,3);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'We ______ them, you''ll see.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','are stopping',false,0),(q,'B','will stop',true,1),(q,'C','stop',false,2),(q,'D','are going to stop',false,3);
end $$;

do $$
declare ex uuid := 'a0000023-0000-4000-8000-000000000000'; q uuid;
begin
  delete from exams where id = ex;
  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'Chọn dạng đúng (will / present / future)','Chọn dạng đúng của động từ. (bài XXIII)',15,'{"K":15}'::jsonb,null);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,1,'I''d better go. ______ home, and I haven''t got any lights on my bike.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''m cycling',true,0),(q,'B','I cycle',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,2,'Oh, yes. ______ dark soon.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','It''ll be',true,0),(q,'B','It''ll have been',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,3,'The rent is expensive. — Yes. ______, I''ve decided.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll move',false,0),(q,'B','I''m going to move',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,4,'I''d like a photo of Martin and me. — ______ one with your camera, then.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll take',true,0),(q,'B','I''m going to take',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,5,'Have you booked a holiday? — Yes, ______ to Spain.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','we go',false,0),(q,'B','we''re going',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,6,'Can I borrow your bike on Monday? — Sorry, but ______ it. I always cycle to work.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll be using',true,0),(q,'B','I''ll have used',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,7,'Oh dear, I''ve spilt my coffee. — ______ a cloth.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I get',false,0),(q,'B','I''ll get',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,8,'What''s that man doing up there? — Oh no! ______!','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','He''ll jump',false,0),(q,'B','He''s going to jump',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,9,'It''s quite a long way. — Yes. ______ about five miles by the time we get back.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','We''ll be walking',false,0),(q,'B','We''ll have walked',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,10,'It said on the radio that ______.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','it''s snowing',false,0),(q,'B','it''s going to snow',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,11,'By November ______ for this company for 6 years.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I will be working',false,0),(q,'B','I will have worked',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,12,'______ until Wednesday because I''ve got an exam.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I revise',false,0),(q,'B','I''m revising',true,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,13,'______ your work by 9 tonight? — No, ______ a meeting at that time.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','Will you have finished … I''ll be having',true,0),(q,'B','Will you finish … I''m going to have',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,14,'I''m going to a job interview this afternoon. — ______ you one of mine.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','I''ll lend',true,0),(q,'B','I''m going to lend',false,1);
  insert into questions (exam_id,position,stem,level,type,accept) values (ex,15,'I can''t go out until ______. I haven''t got a raincoat.','K','mcq','[]'::jsonb) returning id into q;
  insert into choices (question_id,label,content,is_correct,position) values (q,'A','it will stop raining',false,0),(q,'B','it stops raining',true,1);
end $$;

