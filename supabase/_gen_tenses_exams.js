/* Generate migration 20260601000015_tenses_exams.sql from the Mai Lan Hương
   "Thì (Tenses)" exercises (sections I, XX, XXV). Run: node supabase/_gen_tenses_exams.js */
const fs = require("fs");

const esc = (s) => String(s).replace(/'/g, "''");
const LETTERS = ["A", "B", "C", "D"];

// ---- Section I: present-simple/progressive fill (AI-graded, accept empty) ----
const SEC_I = [
  "The River Nile ______ into the Mediterranean.",
  "This book is mine. That one ______ to Pierre.",
  "Look at Joan. She ______ her fingernails. She must be nervous.",
  "We usually ______ vegetables in our garden.",
  "Let's go out. It ______ (not rain) now.",
  "Every morning, the sun ______ me up.",
  "Jim is very untidy. He always ______ his things all over the place.",
  "Ann ______ very happy at the moment.",
  "He's a photographer. He ______ a lot of photos.",
  "Oh! What's the matter with your hand? It ______.",
];

// ---- Section XX: will / be going to / present (3 options a/b/c) ----
// [stem, [opt a, b, c], correctIndex]
const SEC_XX = [
  ["Why are you working so hard? Because ______ a car, so I'm saving as much as I can.", ["I'll buy", "I'm going to buy", "I buy"], 1],
  ["Oh, I haven't got any money. — Don't worry. ______ you some.", ["I'll lend", "I'm going to lend", "I'm lending"], 0],
  ["I'm in a big hurry. My train ______ in fifteen minutes.", ["is going to leave", "will leave", "leaves"], 2],
  ["Let's go to the carnival. — Yes, I expect ______ fun.", ["it'll be", "it's", "it's being"], 0],
  ["Have you decided about the course? — Yes. ______ for a place.", ["I apply", "I'm going to apply", "I'll apply"], 1],
  ["It's a public holiday next month. — Yes. ______ anything special?", ["Are you doing", "Do you do", "Will you do"], 0],
  ["I'll take all my papers with me when ______.", ["I'll go", "I'm going", "I go"], 2],
  ["______ a party next Saturday. Can you come?", ["We'll have", "We're having", "We have"], 1],
  ["I'm trying to move this cupboard, but it's heavy. — Well, ______ you, then.", ["I'll help", "I'm going to help", "I help"], 0],
  ["Excuse me. What time ______ to London?", ["will this train leave", "is this train going to get", "does this train get"], 2],
  ["I've decided to repaint this room. — What color ______ it?", ["does you paint", "are you going to paint", "will you paint"], 1],
  ["Why are you putting on your coat? ______ somewhere?", ["Are you going", "Do you go", "Will you go"], 0],
  ["Did you post that letter? — Sorry, I forgot. ______ it now.", ["I do", "I'm doing", "I'll do"], 2],
  ["I've got a new job. ______ my new job on Monday.", ["I'm starting", "I'm going to start", "I start"], 0],
  ["I've got a place at university. ______ maths at St Andrews.", ["I'll study", "I'm going to study", "I study"], 1],
  ["The alarm's making an awful noise. — OK, ______ it off.", ["I am switching", "I am going to switch", "I'll switch"], 2],
  ["Did you buy this book? — No, Emma did. ______ it on holiday.", ["She'll read", "She is going to read", "She reads"], 1],
  ["Is the shop open yet? — No, but there's someone inside. I think ______.", ["it opens", "it's about to open", "it will open"], 1],
  ["Have you heard about Jane? She's engaged. ______ married in June.", ["She's getting", "She'll get", "She's about to get"], 0],
  ["I'm just going out to get a paper. — What newspaper ______?", ["will you buy", "are you buying", "are you going to buy"], 2],
];

// ---- Section XXV: mixed tenses (4 options a/b/c/d) ----
const SEC_XXV = [
  ["It was a boring weekend. ______ anything.", ["I won't do", "I don't do", "I didn't do", "I'm not doing"], 2],
  ["I'm busy at the moment. ______ on the computer.", ["I work", "I'm work", "I'm working", "I worked"], 2],
  ["My friend ______ the answer to the question.", ["is know", "know", "is knowing", "knows"], 3],
  ["I think I'll buy these shoes. ______ really well.", ["They fit", "They have fit", "They're fitting", "They were fitting"], 0],
  ["Where ______ the car?", ["did you park", "have you parked", "parked you", "you parked"], 0],
  ["At nine o'clock yesterday morning we ______ for the bus.", ["wait", "is waiting", "was waiting", "were waiting"], 3],
  ["When I looked round the door, the baby ______ quietly.", ["is sleeping", "slept", "was sleeping", "were sleeping"], 2],
  ["Here's my report. ______ it at last.", ["I finish", "I finished", "I'd finished", "I've finished"], 3],
  ["The earth ______ on the sun for its heat and light.", ["is depended", "depends", "is depending", "has depended"], 1],
  ["We ______ to Ireland for our holiday last year.", ["go", "are going", "have gone", "went"], 3],
  ["Robert ______ ill for three weeks. He's still in hospital.", ["had been", "has been", "is", "was"], 1],
  ["My arms are aching now because ______ since two o'clock.", ["I'm swimming", "I swam", "I swim", "I've been swimming"], 3],
  ["I'm very tired. ______ over four hundred miles today.", ["I drive", "I'm driving", "I've been driving", "I've driven"], 3],
  ["When Martin ______ the car, he took it out for a drive.", ["had repaired", "has repaired", "repaired", "was repairing"], 0],
  ["Janet was out of breath because ______.", ["she'd been running", "she ran", "she's been running", "she's run"], 0],
  ["Don't worry. I ______ here to help you.", ["be", "will be", "am going to be", "won't be"], 1],
  ["Our friends ______ meet us at the airport tonight.", ["are", "are going to", "go to", "will be to"], 1],
  ["______ a party next Saturday. We've sent out the invitation.", ["We had", "We have", "We'll have", "We're having"], 3],
  ["I'll tell Anna all the news when ______ her.", ["I'll see", "I'm going to see", "I see", "I'm seeing"], 2],
  ["At this time tomorrow ______ over the Atlantic.", ["we're flying", "we'll be flying", "we'll fly", "we're to fly"], 1],
  ["Where's Robert? ______ a shower?", ["Does he have", "Has he", "Has he got", "Is he having"], 3],
  ["Your birthday party was the last time ______ myself.", ["I've really enjoyed", "I really enjoyed", "I'd really enjoyed", "I really enjoy"], 1],
  ["______ tomorrow, so we can go out somewhere.", ["I'm not working", "I don't work", "I won't work", "I'm not going to work"], 0],
  ["It's two years ______ Joe.", ["that I don't see", "that I haven't seen", "since I didn't see", "since I saw"], 3],
  ["Linda has lost her passport again. It's the second time this ______.", ["has happened", "happens", "happened", "had happened"], 0],
];

function levels(arr) {
  const c = {};
  for (const lv of arr) c[lv] = (c[lv] || 0) + 1;
  return JSON.stringify(c);
}

function examBlock({ id, title, desc, items, level, type }) {
  const lines = [];
  lines.push(`do $$`);
  lines.push(`declare ex uuid := '${id}'; q uuid;`);
  lines.push(`begin`);
  lines.push(`  delete from exams where id = ex;`);
  const lvs = levels(items.map(() => level));
  lines.push(`  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'${esc(title)}','${esc(desc)}',${items.length},'${lvs}'::jsonb,null);`);
  items.forEach((it, i) => {
    const pos = i + 1;
    if (type === "text") {
      lines.push(`  insert into questions (exam_id,position,stem,level,type,accept) values (ex,${pos},'${esc(it)}','${level}','text','[]'::jsonb);`);
    } else {
      const [stem, opts, ok] = it;
      lines.push(`  insert into questions (exam_id,position,stem,level,type,accept) values (ex,${pos},'${esc(stem)}','${level}','mcq','[]'::jsonb) returning id into q;`);
      const rows = opts
        .map((o, idx) => `(q,'${LETTERS[idx]}','${esc(o)}',${idx === ok},${idx})`)
        .join(",");
      lines.push(`  insert into choices (question_id,label,content,is_correct,position) values ${rows};`);
    }
  });
  lines.push(`end $$;`);
  return lines.join("\n");
}

const out = [];
out.push("-- ============================================================");
out.push("-- 20260601000015_tenses_exams.sql — exams generated from the");
out.push("-- Mai Lan Hương Tenses exercises (sections I, XX, XXV). System exams.");
out.push("-- ============================================================");
out.push("");
out.push(examBlock({
  id: "77777777-7777-7777-7777-777777777777",
  title: "Chia động từ — Thì hiện tại (AI chấm)",
  desc: "Điền/chia động từ thì hiện tại đơn & tiếp diễn; AI chấm. (Mai Lan Hương — bài I)",
  items: SEC_I, level: "D", type: "text",
}));
out.push("");
out.push(examBlock({
  id: "55555555-5555-5555-5555-555555555555",
  title: "Will / Be going to (Tương lai)",
  desc: "Trắc nghiệm chọn dạng đúng: will / be going to / hiện tại. (Mai Lan Hương — bài XX)",
  items: SEC_XX, level: "TB", type: "mcq",
}));
out.push("");
out.push(examBlock({
  id: "66666666-6666-6666-6666-666666666666",
  title: "Tổng hợp các thì (25 câu)",
  desc: "Trắc nghiệm tổng hợp các thì. (Mai Lan Hương — bài XXV)",
  items: SEC_XXV, level: "K", type: "mcq",
}));
out.push("");

fs.writeFileSync(__dirname + "/migrations/20260601000015_tenses_exams.sql", out.join("\n") + "\n");
console.log("Wrote migration: I(%d text) + XX(%d mcq) + XXV(%d mcq)", SEC_I.length, SEC_XX.length, SEC_XXV.length);
