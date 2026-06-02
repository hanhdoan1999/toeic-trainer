/* Generate migration 20260601000018_passages.sql: add context to get_attempt_review,
   and rebuild exams V (letter) and X (conversation) as passages — one input per
   blank (AI-graded), all sharing a context paragraph.
   Run: node supabase/_gen_passages.js */
const fs = require("fs");
const esc = (s) => String(s).replace(/'/g, "''");
const uuid = (h) => `${h}-0000-4000-8000-000000000000`;

const V = {
  id: uuid("a0000005"),
  title: "Điền đoạn văn — Lá thư ở York (V)",
  desc: "Passage: điền động từ vào từng chỗ trống của lá thư; AI chấm từng ô. (bài V)",
  level: "K",
  context: "Thư của Roberta gửi Francesca kể về chuyến đi York. Điền động từ phù hợp vào mỗi chỗ trống (gợi ý động từ trong ngoặc).",
  gaps: [
    "We (be) ______ here for three days now.",
    "We (decide / plan) ______ to stay for the rest of the week.",
    "We (enjoy) ______ ourselves so much.",
    "We (see / visit) ______ the Cathedral and the Castle Museum.",
    "This morning we (walk / wander) ______ around the little old-fashioned streets.",
    "We (not / spend) ______ much money yet.",
    "Besides the sightseeing, we (do) ______ some exercise.",
    "We (have / go) ______ some lovely long walks.",
    "Fortunately, the weather (be) ______ very good so far.",
    "People (say) ______ it can be very cold.",
    "It often (rain) ______ for days!",
    "This is the first time I (be / come) ______ to England.",
    "I (think) ______ I'm just lucky.",
  ],
};

const X = {
  id: uuid("a0000010"),
  title: "Điền hội thoại — Tin về David (X)",
  desc: "Passage: chia động từ trong hội thoại (quá khứ đơn / hiện tại hoàn thành); AI chấm từng ô. (bài X)",
  level: "TB",
  context: "Hội thoại giữa Tom và Harriet về tai nạn của David. Chia động từ trong ngoặc cho từng chỗ trống.",
  gaps: [
    "______ (you / hear) the news about David?",
    "______ (what / happen)?",
    "______ (he / have) an accident.",
    "When he was walking down some steps, ______ (he / fall).",
    "... and ______ (break) his leg.",
    "When ______ (it / happen)?",
    "Melanie ______ (tell) me about it last night.",
    "______ (you / know) about it last night,",
    "and ______ (you / not / tell) me!",
    "Well, ______ (I / not / see) you last night.",
    "And ______ (I / not / see) you today, until now.",
    "______ (he / have) lots of accidents, you know.",
    "______ (he / do) the same thing about two years ago.",
  ],
};

function examBlock(p) {
  const out = [];
  out.push(`do $$`);
  out.push(`declare ex uuid := '${p.id}';`);
  out.push(`begin`);
  out.push(`  delete from exams where id = ex;`);
  out.push(`  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'${esc(p.title)}','${esc(p.desc)}',${p.gaps.length},'{"${p.level}":${p.gaps.length}}'::jsonb,null);`);
  p.gaps.forEach((g, i) => {
    out.push(`  insert into questions (exam_id,position,stem,level,type,accept,context) values (ex,${i + 1},'${esc(g)}','${p.level}','text','[]'::jsonb,'${esc(p.context)}');`);
  });
  out.push(`end $$;`);
  return out.join("\n");
}

const review = `-- get_attempt_review now also returns the passage context.
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
grant execute on function get_attempt_review(uuid) to authenticated;`;

const parts = [
  "-- ============================================================",
  "-- 20260601000018_passages.sql — passage type (context) + rebuild V & X.",
  "-- ============================================================",
  "",
  review,
  "",
  examBlock(V),
  "",
  examBlock(X),
  "",
];

fs.writeFileSync(__dirname + "/migrations/20260601000018_passages.sql", parts.join("\n") + "\n");
console.log("Wrote passages migration: V(%d) + X(%d) gaps.", V.gaps.length, X.gaps.length);
