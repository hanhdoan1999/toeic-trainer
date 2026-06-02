-- AUTO-GENERATED seed: Exam 1 (100 questions from the original bank)
-- Run after 01_schema.sql and 02_functions.sql
begin;
delete from exams where id = '11111111-1111-1111-1111-111111111111';
insert into exams (id, title, description, total_questions, levels) values
  ('11111111-1111-1111-1111-111111111111', 'Part 5 — To-V / V-ing / V nguyên thể',
   'Trọng tâm: động từ + to-V, V-ing, và động từ nguyên thể.',
   100, '{"D":20,"TB":30,"K":50}'::jsonb);
with q_1 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 1, 'The manager decided ______ the meeting.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'canceling', false, 0 from q_1
union all
select id, 'B', 'cancel', false, 1 from q_1
union all
select id, 'C', 'canceled', false, 2 from q_1
union all
select id, 'D', 'to cancel', true, 3 from q_1;
with q_2 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 2, 'Please avoid ______ during the presentation.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'talk', false, 0 from q_2
union all
select id, 'B', 'talking', true, 1 from q_2
union all
select id, 'C', 'talked', false, 2 from q_2
union all
select id, 'D', 'to talk', false, 3 from q_2;
with q_3 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 3, 'All employees must ______ the safety rules.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'following', false, 0 from q_3
union all
select id, 'B', 'followed', false, 1 from q_3
union all
select id, 'C', 'follow', true, 2 from q_3
union all
select id, 'D', 'to follow', false, 3 from q_3;
with q_4 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 4, 'I would like ______ a table for two.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reserving', false, 0 from q_4
union all
select id, 'B', 'reserve', false, 1 from q_4
union all
select id, 'C', 'reserved', false, 2 from q_4
union all
select id, 'D', 'to reserve', true, 3 from q_4;
with q_5 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 5, 'Thank you for ______ the report on time.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'submitting', true, 0 from q_5
union all
select id, 'B', 'submitted', false, 1 from q_5
union all
select id, 'C', 'submit', false, 2 from q_5
union all
select id, 'D', 'to submit', false, 3 from q_5;
with q_6 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 6, 'They agreed ______ the proposal.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'approve', false, 0 from q_6
union all
select id, 'B', 'approved', false, 1 from q_6
union all
select id, 'C', 'to approve', true, 2 from q_6
union all
select id, 'D', 'approving', false, 3 from q_6;
with q_7 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 7, 'He finished ______ the report.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to write', false, 0 from q_7
union all
select id, 'B', 'write', false, 1 from q_7
union all
select id, 'C', 'writing', true, 2 from q_7
union all
select id, 'D', 'wrote', false, 3 from q_7;
with q_8 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 8, 'The boss made the team ______ late.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'stay', true, 0 from q_8
union all
select id, 'B', 'to stay', false, 1 from q_8
union all
select id, 'C', 'staying', false, 2 from q_8
union all
select id, 'D', 'stayed', false, 3 from q_8;
with q_9 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 9, 'You should ______ the instructions first.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reads', false, 0 from q_9
union all
select id, 'B', 'read', true, 1 from q_9
union all
select id, 'C', 'to read', false, 2 from q_9
union all
select id, 'D', 'reading', false, 3 from q_9;
with q_10 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 10, 'She refused ______ the document.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to sign', true, 0 from q_10
union all
select id, 'B', 'signed', false, 1 from q_10
union all
select id, 'C', 'sign', false, 2 from q_10
union all
select id, 'D', 'signing', false, 3 from q_10;
with q_11 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 11, 'They are interested in ______ for our company.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'working', true, 0 from q_11
union all
select id, 'B', 'to work', false, 1 from q_11
union all
select id, 'C', 'work', false, 2 from q_11
union all
select id, 'D', 'worked', false, 3 from q_11;
with q_12 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 12, 'Would you mind ______ the window?', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'open', false, 0 from q_12
union all
select id, 'B', 'opening', true, 1 from q_12
union all
select id, 'C', 'opened', false, 2 from q_12
union all
select id, 'D', 'to open', false, 3 from q_12;
with q_13 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 13, 'Would you like ______ something to drink?', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'have', false, 0 from q_13
union all
select id, 'B', 'having', false, 1 from q_13
union all
select id, 'C', 'had', false, 2 from q_13
union all
select id, 'D', 'to have', true, 3 from q_13;
with q_14 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 14, 'Visitors may ______ the museum for free.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'entered', false, 0 from q_14
union all
select id, 'B', 'to enter', false, 1 from q_14
union all
select id, 'C', 'entering', false, 2 from q_14
union all
select id, 'D', 'enter', true, 3 from q_14;
with q_15 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 15, 'We planned ______ a new branch.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'opened', false, 0 from q_15
union all
select id, 'B', 'to open', true, 1 from q_15
union all
select id, 'C', 'open', false, 2 from q_15
union all
select id, 'D', 'opening', false, 3 from q_15;
with q_16 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 16, 'The company postponed ______ the event.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to hold', false, 0 from q_16
union all
select id, 'B', 'holding', true, 1 from q_16
union all
select id, 'C', 'hold', false, 2 from q_16
union all
select id, 'D', 'held', false, 3 from q_16;
with q_17 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 17, 'Let me ______ you with your bags.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to help', false, 0 from q_17
union all
select id, 'B', 'helping', false, 1 from q_17
union all
select id, 'C', 'helped', false, 2 from q_17
union all
select id, 'D', 'help', true, 3 from q_17;
with q_18 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 18, 'He left the office without ______ anyone.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to tell', false, 0 from q_18
union all
select id, 'B', 'telling', true, 1 from q_18
union all
select id, 'C', 'told', false, 2 from q_18
union all
select id, 'D', 'tell', false, 3 from q_18;
with q_19 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 19, '______ a foreign language takes time.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'Learns', false, 0 from q_19
union all
select id, 'B', 'Learn', false, 1 from q_19
union all
select id, 'C', 'Learned', false, 2 from q_19
union all
select id, 'D', 'Learning', true, 3 from q_19;
with q_20 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 20, 'She managed ______ the problem alone.', 'D') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'solved', false, 0 from q_20
union all
select id, 'B', 'solving', false, 1 from q_20
union all
select id, 'C', 'solve', false, 2 from q_20
union all
select id, 'D', 'to solve', true, 3 from q_20;
with q_21 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 21, 'We must carefully ______ the contract.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to review', false, 0 from q_21
union all
select id, 'B', 'review', true, 1 from q_21
union all
select id, 'C', 'reviewing', false, 2 from q_21
union all
select id, 'D', 'reviewed', false, 3 from q_21;
with q_22 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 22, 'I will have the technician ______ the printer.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'fix', true, 0 from q_22
union all
select id, 'B', 'fixing', false, 1 from q_22
union all
select id, 'C', 'to fix', false, 2 from q_22
union all
select id, 'D', 'fixed', false, 3 from q_22;
with q_23 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 23, 'I heard the director ______ at the meeting.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to speak', false, 0 from q_23
union all
select id, 'B', 'speak', true, 1 from q_23
union all
select id, 'C', 'spoken', false, 2 from q_23
union all
select id, 'D', 'spoke', false, 3 from q_23;
with q_24 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 24, 'It is important ______ the deadline.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'meet', false, 0 from q_24
union all
select id, 'B', 'met', false, 1 from q_24
union all
select id, 'C', 'to meet', true, 2 from q_24
union all
select id, 'D', 'meeting', false, 3 from q_24;
with q_25 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 25, 'The board considered ______ the policy.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'change', false, 0 from q_25
union all
select id, 'B', 'changing', true, 1 from q_25
union all
select id, 'C', 'to change', false, 2 from q_25
union all
select id, 'D', 'changed', false, 3 from q_25;
with q_26 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 26, 'The plan failed ______ enough revenue.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'generated', false, 0 from q_26
union all
select id, 'B', 'generate', false, 1 from q_26
union all
select id, 'C', 'generating', false, 2 from q_26
union all
select id, 'D', 'to generate', true, 3 from q_26;
with q_27 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 27, 'Before ______ the contract, read all terms.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'signed', false, 0 from q_27
union all
select id, 'B', 'signing', true, 1 from q_27
union all
select id, 'C', 'sign', false, 2 from q_27
union all
select id, 'D', 'to sign', false, 3 from q_27;
with q_28 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 28, 'He arrived early in order ______ the room.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'prepare', false, 0 from q_28
union all
select id, 'B', 'preparing', false, 1 from q_28
union all
select id, 'C', 'prepared', false, 2 from q_28
union all
select id, 'D', 'to prepare', true, 3 from q_28;
with q_29 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 29, 'I will have the report ______ by noon.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'finishing', false, 0 from q_29
union all
select id, 'B', 'to finish', false, 1 from q_29
union all
select id, 'C', 'finish', false, 2 from q_29
union all
select id, 'D', 'finished', true, 3 from q_29;
with q_30 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 30, 'This software helps users ______ time.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'saves', false, 0 from q_30
union all
select id, 'B', 'saving', false, 1 from q_30
union all
select id, 'C', 'save', true, 2 from q_30
union all
select id, 'D', 'saved', false, 3 from q_30;
with q_31 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 31, 'The client would like ______ the terms before signing.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to discuss', true, 0 from q_31
union all
select id, 'B', 'discussing', false, 1 from q_31
union all
select id, 'C', 'discuss', false, 2 from q_31
union all
select id, 'D', 'discussed', false, 3 from q_31;
with q_32 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 32, 'They had to delay ______ the new model.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'launch', false, 0 from q_32
union all
select id, 'B', 'launching', true, 1 from q_32
union all
select id, 'C', 'to launch', false, 2 from q_32
union all
select id, 'D', 'launched', false, 3 from q_32;
with q_33 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 33, 'Staff should regularly ______ their passwords.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'update', true, 0 from q_33
union all
select id, 'B', 'to update', false, 1 from q_33
union all
select id, 'C', 'updated', false, 2 from q_33
union all
select id, 'D', 'updating', false, 3 from q_33;
with q_34 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 34, 'We watched the engineers ______ the machine.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'install', true, 0 from q_34
union all
select id, 'B', 'to install', false, 1 from q_34
union all
select id, 'C', 'installed', false, 2 from q_34
union all
select id, 'D', 'installs', false, 3 from q_34;
with q_35 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 35, 'Both sides agreed ______ the negotiation.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'continuing', false, 0 from q_35
union all
select id, 'B', 'to continue', true, 1 from q_35
union all
select id, 'C', 'continued', false, 2 from q_35
union all
select id, 'D', 'continue', false, 3 from q_35;
with q_36 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 36, 'She is responsible for ______ the accounts.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'managing', true, 0 from q_36
union all
select id, 'B', 'to manage', false, 1 from q_36
union all
select id, 'C', 'manage', false, 2 from q_36
union all
select id, 'D', 'managed', false, 3 from q_36;
with q_37 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 37, 'The fee includes ______ all materials.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'provided', false, 0 from q_37
union all
select id, 'B', 'providing', true, 1 from q_37
union all
select id, 'C', 'to provide', false, 2 from q_37
union all
select id, 'D', 'provide', false, 3 from q_37;
with q_38 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 38, 'It is easy ______ this device.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'operated', false, 0 from q_38
union all
select id, 'B', 'operate', false, 1 from q_38
union all
select id, 'C', 'operating', false, 2 from q_38
union all
select id, 'D', 'to operate', true, 3 from q_38;
with q_39 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 39, 'The supervisor made everyone ______ overtime.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'work', true, 0 from q_39
union all
select id, 'B', 'worked', false, 1 from q_39
union all
select id, 'C', 'to work', false, 2 from q_39
union all
select id, 'D', 'working', false, 3 from q_39;
with q_40 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 40, 'Management decided ______ the office.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'relocate', false, 0 from q_40
union all
select id, 'B', 'relocated', false, 1 from q_40
union all
select id, 'C', 'relocating', false, 2 from q_40
union all
select id, 'D', 'to relocate', true, 3 from q_40;
with q_41 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 41, 'He is good at ______ problems quickly.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'solve', false, 0 from q_41
union all
select id, 'B', 'solving', true, 1 from q_41
union all
select id, 'C', 'solved', false, 2 from q_41
union all
select id, 'D', 'to solve', false, 3 from q_41;
with q_42 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 42, 'The manual helps customers ______ the product correctly.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to assemble', true, 0 from q_42
union all
select id, 'B', 'assembled', false, 1 from q_42
union all
select id, 'C', 'assembles', false, 2 from q_42
union all
select id, 'D', 'assembling', false, 3 from q_42;
with q_43 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 43, 'To stay safe, avoid ______ the machine while it runs.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'touching', true, 0 from q_43
union all
select id, 'B', 'touch', false, 1 from q_43
union all
select id, 'C', 'touched', false, 2 from q_43
union all
select id, 'D', 'to touch', false, 3 from q_43;
with q_44 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 44, 'The shipment might ______ tomorrow.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'arrived', false, 0 from q_44
union all
select id, 'B', 'arriving', false, 1 from q_44
union all
select id, 'C', 'arrive', true, 2 from q_44
union all
select id, 'D', 'to arrive', false, 3 from q_44;
with q_45 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 45, 'We upgraded the system so as ______ errors.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reduced', false, 0 from q_45
union all
select id, 'B', 'reduce', false, 1 from q_45
union all
select id, 'C', 'to reduce', true, 2 from q_45
union all
select id, 'D', 'reducing', false, 3 from q_45;
with q_46 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 46, 'The supplier refused ______ the prices.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'lowering', false, 0 from q_46
union all
select id, 'B', 'lowered', false, 1 from q_46
union all
select id, 'C', 'to lower', true, 2 from q_46
union all
select id, 'D', 'lower', false, 3 from q_46;
with q_47 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 47, 'I saw smoke ______ from the building.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'coming', true, 0 from q_47
union all
select id, 'B', 'come', false, 1 from q_47
union all
select id, 'C', 'came', false, 2 from q_47
union all
select id, 'D', 'to come', false, 3 from q_47;
with q_48 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 48, 'Once you finish ______ the form, submit it.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'completing', true, 0 from q_48
union all
select id, 'B', 'complete', false, 1 from q_48
union all
select id, 'C', 'completed', false, 2 from q_48
union all
select id, 'D', 'to complete', false, 3 from q_48;
with q_49 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 49, '______ feedback from clients improves service.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'Collecting', true, 0 from q_49
union all
select id, 'B', 'Collect', false, 1 from q_49
union all
select id, 'C', 'Collected', false, 2 from q_49
union all
select id, 'D', 'Collects', false, 3 from q_49;
with q_50 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 50, 'The policy lets employees ______ from home.', 'TB') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to work', false, 0 from q_50
union all
select id, 'B', 'work', true, 1 from q_50
union all
select id, 'C', 'worked', false, 2 from q_50
union all
select id, 'D', 'working', false, 3 from q_50;
with q_51 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 51, 'The team must immediately ______ the issue.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'addressing', false, 0 from q_51
union all
select id, 'B', 'address', true, 1 from q_51
union all
select id, 'C', 'addressed', false, 2 from q_51
union all
select id, 'D', 'to address', false, 3 from q_51;
with q_52 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 52, 'We had the equipment ______ before the inspection.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'checked', true, 0 from q_52
union all
select id, 'B', 'check', false, 1 from q_52
union all
select id, 'C', 'checking', false, 2 from q_52
union all
select id, 'D', 'to check', false, 3 from q_52;
with q_53 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 53, 'The trainer watched each new hire ______ the procedure correctly.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'perform', true, 0 from q_53
union all
select id, 'B', 'performed', false, 1 from q_53
union all
select id, 'C', 'performs', false, 2 from q_53
union all
select id, 'D', 'to perform', false, 3 from q_53;
with q_54 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 54, 'The manager insisted on ______ every invoice.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reviewing', true, 0 from q_54
union all
select id, 'B', 'review', false, 1 from q_54
union all
select id, 'C', 'to review', false, 2 from q_54
union all
select id, 'D', 'reviewed', false, 3 from q_54;
with q_55 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 55, 'Despite delays, they managed somehow ______ the target.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reaching', false, 0 from q_55
union all
select id, 'B', 'reach', false, 1 from q_55
union all
select id, 'C', 'reached', false, 2 from q_55
union all
select id, 'D', 'to reach', true, 3 from q_55;
with q_56 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 56, 'The committee decided to postpone ______ a final vote.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'taking', true, 0 from q_56
union all
select id, 'B', 'take', false, 1 from q_56
union all
select id, 'C', 'to take', false, 2 from q_56
union all
select id, 'D', 'taken', false, 3 from q_56;
with q_57 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 57, 'The new rules made staff ______ ID badges daily.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'wear', true, 0 from q_57
union all
select id, 'B', 'to wear', false, 1 from q_57
union all
select id, 'C', 'worn', false, 2 from q_57
union all
select id, 'D', 'wearing', false, 3 from q_57;
with q_58 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 58, 'From my desk I could hear the printer ______ all morning.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'run', false, 0 from q_58
union all
select id, 'B', 'running', true, 1 from q_58
union all
select id, 'C', 'ran', false, 2 from q_58
union all
select id, 'D', 'to run', false, 3 from q_58;
with q_59 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 59, 'All drivers should always ______ their seatbelts.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'fasten', true, 0 from q_59
union all
select id, 'B', 'fastening', false, 1 from q_59
union all
select id, 'C', 'fastened', false, 2 from q_59
union all
select id, 'D', 'to fasten', false, 3 from q_59;
with q_60 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 60, 'It is essential for managers ______ clear instructions.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to give', true, 0 from q_60
union all
select id, 'B', 'giving', false, 1 from q_60
union all
select id, 'C', 'give', false, 2 from q_60
union all
select id, 'D', 'gave', false, 3 from q_60;
with q_61 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 61, 'Regular maintenance helps the machines ______ longer.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'last', true, 0 from q_61
union all
select id, 'B', 'lasting', false, 1 from q_61
union all
select id, 'C', 'lasts', false, 2 from q_61
union all
select id, 'D', 'lasted', false, 3 from q_61;
with q_62 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 62, 'The firm plans ______ overseas next year.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to expand', true, 0 from q_62
union all
select id, 'B', 'expand', false, 1 from q_62
union all
select id, 'C', 'expanding', false, 2 from q_62
union all
select id, 'D', 'expanded', false, 3 from q_62;
with q_63 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 63, 'Employees can avoid ______ fines by following the rules.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'paid', false, 0 from q_63
union all
select id, 'B', 'pay', false, 1 from q_63
union all
select id, 'C', 'to pay', false, 2 from q_63
union all
select id, 'D', 'paying', true, 3 from q_63;
with q_64 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 64, 'She had her secretary ______ the visitors in.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to show', false, 0 from q_64
union all
select id, 'B', 'showing', false, 1 from q_64
union all
select id, 'C', 'show', true, 2 from q_64
union all
select id, 'D', 'shown', false, 3 from q_64;
with q_65 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 65, 'They had the broken window ______ the next day.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'replaced', true, 0 from q_65
union all
select id, 'B', 'replacing', false, 1 from q_65
union all
select id, 'C', 'replace', false, 2 from q_65
union all
select id, 'D', 'to replace', false, 3 from q_65;
with q_66 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 66, 'Witnesses saw the truck ______ the barrier.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'hits', false, 0 from q_66
union all
select id, 'B', 'to hit', false, 1 from q_66
union all
select id, 'C', 'hitted', false, 2 from q_66
union all
select id, 'D', 'hit', true, 3 from q_66;
with q_67 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 67, 'They cut costs by ______ energy use.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reduced', false, 0 from q_67
union all
select id, 'B', 'reduce', false, 1 from q_67
union all
select id, 'C', 'to reduce', false, 2 from q_67
union all
select id, 'D', 'reducing', true, 3 from q_67;
with q_68 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 68, 'Candidates must clearly ______ their qualifications.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'stating', false, 0 from q_68
union all
select id, 'B', 'stated', false, 1 from q_68
union all
select id, 'C', 'state', true, 2 from q_68
union all
select id, 'D', 'to state', false, 3 from q_68;
with q_69 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 69, '______ the new software will take several weeks.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'Installing', true, 0 from q_69
union all
select id, 'B', 'Install', false, 1 from q_69
union all
select id, 'C', 'To installing', false, 2 from q_69
union all
select id, 'D', 'Installed', false, 3 from q_69;
with q_70 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 70, 'In order ______ delays, submit forms early.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'avoiding', false, 0 from q_70
union all
select id, 'B', 'avoid', false, 1 from q_70
union all
select id, 'C', 'to avoid', true, 2 from q_70
union all
select id, 'D', 'avoided', false, 3 from q_70;
with q_71 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 71, 'The union refused ______ the new schedule.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'accepted', false, 0 from q_71
union all
select id, 'B', 'to accept', true, 1 from q_71
union all
select id, 'C', 'accepting', false, 2 from q_71
union all
select id, 'D', 'accept', false, 3 from q_71;
with q_72 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 72, 'The CEO is considering ______ a subsidiary abroad.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'open', false, 0 from q_72
union all
select id, 'B', 'to open', false, 1 from q_72
union all
select id, 'C', 'opened', false, 2 from q_72
union all
select id, 'D', 'opening', true, 3 from q_72;
with q_73 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 73, 'The brochure helps tourists ______ the city easily.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'navigating', false, 0 from q_73
union all
select id, 'B', 'navigates', false, 1 from q_73
union all
select id, 'C', 'to navigate', true, 2 from q_73
union all
select id, 'D', 'navigated', false, 3 from q_73;
with q_74 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 74, 'The supervisor wouldn''t let the trainees ______ the equipment unsupervised.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'used', false, 0 from q_74
union all
select id, 'B', 'to use', false, 1 from q_74
union all
select id, 'C', 'use', true, 2 from q_74
union all
select id, 'D', 'using', false, 3 from q_74;
with q_75 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 75, 'I heard the alarm ______ for several minutes.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'rung', false, 0 from q_75
union all
select id, 'B', 'to ring', false, 1 from q_75
union all
select id, 'C', 'ringing', true, 2 from q_75
union all
select id, 'D', 'rang', false, 3 from q_75;
with q_76 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 76, 'Workers should never ______ safety procedures.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'ignored', false, 0 from q_76
union all
select id, 'B', 'ignoring', false, 1 from q_76
union all
select id, 'C', 'ignore', true, 2 from q_76
union all
select id, 'D', 'to ignore', false, 3 from q_76;
with q_77 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 77, 'The device failed ______ properly after the update.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'function', false, 0 from q_77
union all
select id, 'B', 'to function', true, 1 from q_77
union all
select id, 'C', 'functioning', false, 2 from q_77
union all
select id, 'D', 'functioned', false, 3 from q_77;
with q_78 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 78, 'Would you mind ______ me the file?', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'send', false, 0 from q_78
union all
select id, 'B', 'sending', true, 1 from q_78
union all
select id, 'C', 'to send', false, 2 from q_78
union all
select id, 'D', 'sent', false, 3 from q_78;
with q_79 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 79, 'The report is about ______ customer satisfaction.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to improve', false, 0 from q_79
union all
select id, 'B', 'improved', false, 1 from q_79
union all
select id, 'C', 'improve', false, 2 from q_79
union all
select id, 'D', 'improving', true, 3 from q_79;
with q_80 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 80, 'The delay made customers ______ angry.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'feel', true, 0 from q_80
union all
select id, 'B', 'feeling', false, 1 from q_80
union all
select id, 'C', 'to feel', false, 2 from q_80
union all
select id, 'D', 'felt', false, 3 from q_80;
with q_81 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 81, 'It was difficult ______ everyone during the holidays.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'contact', false, 0 from q_81
union all
select id, 'B', 'contacted', false, 1 from q_81
union all
select id, 'C', 'contacting', false, 2 from q_81
union all
select id, 'D', 'to contact', true, 3 from q_81;
with q_82 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 82, 'The visitors watched the artisan ______ a vase by hand.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to make', false, 0 from q_82
union all
select id, 'B', 'makes', false, 1 from q_82
union all
select id, 'C', 'make', true, 2 from q_82
union all
select id, 'D', 'made', false, 3 from q_82;
with q_83 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 83, 'After negotiation, both parties agreed ______ the dispute.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'settled', false, 0 from q_83
union all
select id, 'B', 'to settle', true, 1 from q_83
union all
select id, 'C', 'settling', false, 2 from q_83
union all
select id, 'D', 'settle', false, 3 from q_83;
with q_84 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 84, 'Bad weather delayed ______ the cargo.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to ship', false, 0 from q_84
union all
select id, 'B', 'shipped', false, 1 from q_84
union all
select id, 'C', 'ship', false, 2 from q_84
union all
select id, 'D', 'shipping', true, 3 from q_84;
with q_85 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 85, 'The system can automatically ______ backups every night.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'create', true, 0 from q_85
union all
select id, 'B', 'creating', false, 1 from q_85
union all
select id, 'C', 'created', false, 2 from q_85
union all
select id, 'D', 'to create', false, 3 from q_85;
with q_86 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 86, 'The hotel had the rooms ______ before guests arrived.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to clean', false, 0 from q_86
union all
select id, 'B', 'cleaning', false, 1 from q_86
union all
select id, 'C', 'clean', false, 2 from q_86
union all
select id, 'D', 'cleaned', true, 3 from q_86;
with q_87 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 87, 'Clear signage helps drivers ______ the right exit.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'find', true, 0 from q_87
union all
select id, 'B', 'finding', false, 1 from q_87
union all
select id, 'C', 'finds', false, 2 from q_87
union all
select id, 'D', 'found', false, 3 from q_87;
with q_88 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 88, 'He completed the task without ______ any help.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'requested', false, 0 from q_88
union all
select id, 'B', 'request', false, 1 from q_88
union all
select id, 'C', 'to request', false, 2 from q_88
union all
select id, 'D', 'requesting', true, 3 from q_88;
with q_89 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 89, 'Label the boxes so as ______ confusion.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'prevent', false, 0 from q_89
union all
select id, 'B', 'prevented', false, 1 from q_89
union all
select id, 'C', 'to prevent', true, 2 from q_89
union all
select id, 'D', 'preventing', false, 3 from q_89;
with q_90 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 90, 'The board decided ______ the merger.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'approve', false, 0 from q_90
union all
select id, 'B', 'approving', false, 1 from q_90
union all
select id, 'C', 'approved', false, 2 from q_90
union all
select id, 'D', 'to approve', true, 3 from q_90;
with q_91 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 91, 'The renovation will include ______ the lobby.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'redesigned', false, 0 from q_91
union all
select id, 'B', 'redesigning', true, 1 from q_91
union all
select id, 'C', 'to redesign', false, 2 from q_91
union all
select id, 'D', 'redesign', false, 3 from q_91;
with q_92 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 92, 'Applicants must accurately ______ all fields.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'completed', false, 0 from q_92
union all
select id, 'B', 'complete', true, 1 from q_92
union all
select id, 'C', 'to complete', false, 2 from q_92
union all
select id, 'D', 'completing', false, 3 from q_92;
with q_93 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 93, 'We could feel the building ______ during the earthquake.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to shake', false, 0 from q_93
union all
select id, 'B', 'shaken', false, 1 from q_93
union all
select id, 'C', 'shook', false, 2 from q_93
union all
select id, 'D', 'shaking', true, 3 from q_93;
with q_94 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 94, 'The new policy lets customers ______ items within 30 days.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'returning', false, 0 from q_94
union all
select id, 'B', 'returned', false, 1 from q_94
union all
select id, 'C', 'to return', false, 2 from q_94
union all
select id, 'D', 'return', true, 3 from q_94;
with q_95 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 95, 'It is necessary ______ all data regularly.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to back up', true, 0 from q_95
union all
select id, 'B', 'backing up', false, 1 from q_95
union all
select id, 'C', 'backed up', false, 2 from q_95
union all
select id, 'D', 'back up', false, 3 from q_95;
with q_96 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 96, 'The department plans ______ two new positions.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'to create', true, 0 from q_96
union all
select id, 'B', 'created', false, 1 from q_96
union all
select id, 'C', 'creating', false, 2 from q_96
union all
select id, 'D', 'create', false, 3 from q_96;
with q_97 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 97, 'The driver swerved to avoid ______ the pedestrian.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'hitting', true, 0 from q_97
union all
select id, 'B', 'hit', false, 1 from q_97
union all
select id, 'C', 'to hit', false, 2 from q_97
union all
select id, 'D', 'hits', false, 3 from q_97;
with q_98 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 98, 'The client had his lawyer ______ the agreement.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'reviewing', false, 0 from q_98
union all
select id, 'B', 'to review', false, 1 from q_98
union all
select id, 'C', 'reviewed', false, 2 from q_98
union all
select id, 'D', 'review', true, 3 from q_98;
with q_99 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 99, 'The supervisor heard the alarm ______ once and rushed out.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'sound', true, 0 from q_99
union all
select id, 'B', 'sounded', false, 1 from q_99
union all
select id, 'C', 'to sound', false, 2 from q_99
union all
select id, 'D', 'sounding', false, 3 from q_99;
with q_100 as (
  insert into questions (exam_id, position, stem, level)
  values ('11111111-1111-1111-1111-111111111111', 100, 'To pass inspection, the factory must strictly ______ all regulations.', 'K') returning id
)
insert into choices (question_id, label, content, is_correct, position)
select id, 'A', 'follow', true, 0 from q_100
union all
select id, 'B', 'to follow', false, 1 from q_100
union all
select id, 'C', 'followed', false, 2 from q_100
union all
select id, 'D', 'following', false, 3 from q_100;
commit;
