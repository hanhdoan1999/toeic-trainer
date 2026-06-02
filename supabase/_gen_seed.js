/* Generates 03_seed.sql from the original exam HTML question bank.
   Run: node supabase/_gen_seed.js  (expects the original html path arg) */
const fs = require("fs");

const SRC = process.argv[2] || "/mnt/user-data/uploads/de-thi-toeic.html";
const html = fs.readFileSync(SRC, "utf8");

function bank(name){
  const m = html.match(new RegExp("var "+name+" = \\[([\\s\\S]*?)\\];"));
  // eslint-disable-next-line no-new-func
  return Function("return ["+m[1]+"]")();
}
const EASY = bank("EASY"), MED = bank("MED"), HARD = bank("HARD");

// strip "(vietnamese hint)" like the original clean()
const clean = t => t.replace(/\s*\([^)]{1,50}\)/g, "");
// deterministic shuffle (seed per index) so the correct option isn't always A
function mulberry32(a){return function(){a|=0;a=a+0x6D2B79F5|0;var t=Math.imul(a^a>>>15,1|a);t=t+Math.imul(t^t>>>7,61|t)^t;return ((t^t>>>14)>>>0)/4294967296;};}
function shuffled(arr, seed){const r=mulberry32(seed);const a=arr.slice();for(let i=a.length-1;i>0;i--){const j=Math.floor(r()*(i+1));[a[i],a[j]]=[a[j],a[i]];}return a;}

const esc = s => s.replace(/'/g, "''");
const LETTERS = ["A","B","C","D"];
const EXAM_ID = "11111111-1111-1111-1111-111111111111";

let out = [];
out.push("-- AUTO-GENERATED seed: Exam 1 (100 questions from the original bank)");
out.push("-- Run after 01_schema.sql and 02_functions.sql");
out.push("begin;");
out.push(`delete from exams where id = '${EXAM_ID}';`);
out.push(`insert into exams (id, title, description, total_questions, levels) values
  ('${EXAM_ID}', 'Part 5 — To-V / V-ing / V nguyên thể',
   'Trọng tâm: động từ + to-V, V-ing, và động từ nguyên thể.',
   100, '{"D":20,"TB":30,"K":50}'::jsonb);`);

let pos = 0;
function emit(list, level){
  list.forEach((item, i) => {
    pos++;
    const qid = `gen_random_uuid()`;
    const qIdent = `q_${pos}`;
    const stem = clean(item.s);
    out.push(`with ${qIdent} as (
  insert into questions (exam_id, position, stem, level)
  values ('${EXAM_ID}', ${pos}, '${esc(stem)}', '${level}') returning id
)`);
    const opts = shuffled(
      [{t:item.c, ok:true}].concat(item.w.map(w=>({t:w, ok:false}))),
      1000 + pos
    );
    const rows = opts.map((o, idx) =>
      `select id, '${LETTERS[idx]}', '${esc(clean(o.t))}', ${o.ok}, ${idx} from ${qIdent}`
    ).join("\nunion all\n");
    out.push(`insert into choices (question_id, label, content, is_correct, position)
${rows};`);
  });
}
emit(EASY, "D");
emit(MED, "TB");
emit(HARD, "K");
out.push("commit;");

fs.writeFileSync(__dirname + "/03_seed.sql", out.join("\n") + "\n");
console.log("Wrote 03_seed.sql with", pos, "questions.");
