"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { parseCSV } from "@/lib/csv";

// CSV field quoting: wrap in quotes if it contains comma/quote/newline.
function csvField(v) {
  const s = String(v ?? "");
  return /[",\n\r]/.test(s) ? '"' + s.replace(/"/g, '""') + '"' : s;
}

// answers: [{ question_id, choice_id|null, typed_answer|null }]
export async function submitAttempt(examId, answers) {
  const supabase = createClient();
  const { data: attemptId, error } = await supabase.rpc("submit_attempt", {
    p_exam_id: examId,
    p_answers: answers,
  });
  if (error) {
    throw new Error(error.message);
  }

  // Grade open-ended text answers (type='text' with no accepted-answers list) via AI.
  // Wrapped so a Gemini outage never breaks submission (those stay marked wrong).
  try {
    const { data: rows } = await supabase
      .from("attempt_answers")
      .select("id, typed_answer, questions!inner(stem, type, accept)")
      .eq("attempt_id", attemptId)
      .eq("questions.type", "text");

    const pending = (rows || []).filter(
      (r) =>
        Array.isArray(r.questions?.accept) &&
        r.questions.accept.length === 0 &&
        (r.typed_answer || "").trim() !== ""
    );

    if (pending.length) {
      const verdicts = await gradeTypedAnswers(
        pending.map((r) => ({ id: r.id, stem: r.questions.stem, userAnswer: r.typed_answer }))
      );
      const grades = pending.map((r) => ({
        answer_id: r.id,
        is_correct: !!verdicts[r.id],
      }));
      await supabase.rpc("apply_ai_grades", { p_attempt_id: attemptId, p_grades: grades });
    }
  } catch {
    // ignore — open answers remain marked wrong; submission still succeeds
  }

  redirect(`/result/${attemptId}`);
}

// items: [{id, stem, userAnswer}] -> { [id]: boolean }. One batched Gemini call.
async function gradeTypedAnswers(items) {
  const lines = items
    .map((it, i) => `${i + 1}) id=${it.id} | Đề: ${it.stem} | Trả lời: ${it.userAnswer}`)
    .join("\n");
  const prompt = `Bạn là giám khảo chấm bài tiếng Anh. Với mỗi câu, quyết định câu trả lời của người học có ĐÚNG về ngữ pháp và ngữ nghĩa cho chỗ trống/đề bài hay không.
CHỈ trả về JSON thuần (không markdown, không giải thích), dạng mảng:
[{"id":"<id>","correct":true},{"id":"<id>","correct":false}]
Quy tắc: chấp nhận các biến thể đúng tương đương; sai chính tả rõ ràng -> false; bỏ trống -> false.

Các câu:
${lines}`;

  const text = await geminiText(prompt, Math.max(256, 40 * items.length), 0.1);
  let raw = text.trim().replace(/^```[a-zA-Z]*\s*/, "").replace(/```\s*$/, "").trim();
  const start = raw.indexOf("[");
  const end = raw.lastIndexOf("]");
  if (start >= 0 && end > start) raw = raw.slice(start, end + 1);
  const out = {};
  try {
    const arr = JSON.parse(raw);
    if (Array.isArray(arr)) {
      for (const v of arr) {
        if (v && v.id != null) out[String(v.id)] = v.correct === true || v.correct === "true";
      }
    }
  } catch {
    // leave empty -> all treated as wrong (provisional)
  }
  return out;
}

// questions: [{ position, level, stem, options:[{label,content,position}], answer }]
export async function importExam(title, description, questions) {
  const supabase = createClient();
  const { data, error } = await supabase.rpc("import_exam", {
    p_title: title,
    p_description: description ?? null,
    p_questions: questions,
  });
  if (error) {
    throw new Error(error.message);
  }
  redirect(`/exam/${data}`);
}

export async function saveExamNote(examId, content) {
  const supabase = createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Chưa đăng nhập");
  }
  const { error } = await supabase.from("exam_notes").upsert(
    {
      user_id: user.id,
      exam_id: examId,
      content,
      updated_at: new Date().toISOString(),
    },
    { onConflict: "user_id,exam_id" }
  );
  if (error) {
    throw new Error(error.message);
  }
}

export async function updateExamTitle(examId, title) {
  const supabase = createClient();
  const { error } = await supabase.rpc("update_exam_title", {
    p_exam_id: examId,
    p_title: title,
  });
  if (error) {
    throw new Error(error.message);
  }
}

export async function deleteExam(examId) {
  const supabase = createClient();
  const { error } = await supabase.rpc("delete_exam", { p_exam_id: examId });
  if (error) {
    throw new Error(error.message);
  }
  redirect("/exams");
}

// q: { stem, correctLabel, correctContent, selectedLabel, options:[{label,content}] }
// Returns { text } — a short Vietnamese explanation from Gemini.
export async function explainQuestion(q) {
  const optsText = (q.options || [])
    .map((o) => `${o.label}. ${o.content}`)
    .join("\n");
  const userPick =
    q.selectedLabel && q.selectedLabel !== q.correctLabel
      ? `Người học đã chọn sai đáp án ${q.selectedLabel}.`
      : "";

  const prompt = `Bạn là giáo viên TOEIC. Giải thích NGẮN GỌN bằng tiếng Việt (2-4 câu) cho câu hỏi Part 5 sau.
Nêu rõ: vì sao đáp án đúng là đúng (điểm ngữ pháp), và vì sao các đáp án còn lại sai (bẫy). Không lặp lại đề bài, không dùng markdown.

Câu hỏi: ${q.stem}
Các lựa chọn:
${optsText}
Đáp án đúng: ${q.correctLabel}. ${q.correctContent}
${userPick}`;

  const text = await geminiText(prompt, 300, 0.3);
  return { text };
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

// Shared low-level Gemini text call, with retry on transient overload (503/429/5xx).
async function geminiText(prompt, maxOutputTokens = 512, temperature = 0.3) {
  const key = process.env.GEMINI_API_KEY?.trim();
  if (!key || key === "YOUR-GEMINI-API-KEY") {
    throw new Error("Chưa cấu hình GEMINI_API_KEY trong .env.local.");
  }
  const model = (process.env.GEMINI_MODEL || "gemini-2.5-flash-lite").trim();
  const url = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${key}`;
  const body = JSON.stringify({
    contents: [{ parts: [{ text: prompt }] }],
    generationConfig: { temperature, maxOutputTokens },
  });
  const RETRIABLE = new Set([429, 500, 502, 503, 504]);
  const MAX_ATTEMPTS = 4;

  let lastErr = "";
  for (let attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
    let res;
    try {
      res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body,
        cache: "no-store",
      });
    } catch {
      lastErr = "Không gọi được Gemini (lỗi mạng).";
      if (attempt < MAX_ATTEMPTS) {
        await sleep(700 * attempt);
        continue;
      }
      throw new Error(lastErr);
    }

    if (res.ok) {
      const data = await res.json();
      const text = data?.candidates?.[0]?.content?.parts
        ?.map((p) => p.text)
        .filter(Boolean)
        .join("")
        .trim();
      if (!text) throw new Error("Gemini không trả về nội dung.");
      return text;
    }

    let detail = "";
    try {
      const j = await res.json();
      detail = j?.error?.message || "";
    } catch {}

    if (RETRIABLE.has(res.status) && attempt < MAX_ATTEMPTS) {
      lastErr = `Gemini lỗi ${res.status}${detail ? ": " + detail : ""}`;
      await sleep(800 * attempt); // 800ms, 1.6s, 2.4s backoff
      continue;
    }

    // non-retriable, or out of attempts
    if (res.status === 503) {
      throw new Error("Gemini đang quá tải (503). Vui lòng thử lại sau ít phút.");
    }
    throw new Error(`Gemini lỗi ${res.status}${detail ? ": " + detail : ""}`);
  }

  throw new Error(lastErr || "Gemini không phản hồi.");
}

// Generate N questions (CSV import format) from a knowledge blurb.
// format: 'mcq' (trắc nghiệm) | 'text' (điền từ / tự luận). count default 3.
export async function generateExamCSV(knowledge, level, type, format, count) {
  if (!knowledge || !knowledge.trim()) {
    throw new Error("Vui lòng nhập nội dung kiến thức.");
  }
  const lv = ["D", "TB", "K"].includes(level) ? level : "D";
  const lvLabel = { D: "Dễ", TB: "Trung bình", K: "Khó" }[lv];
  const fmt = format === "text" ? "text" : "mcq";
  const n = Math.min(20, Math.max(1, Number.parseInt(count, 10) || 3));
  const style = type === "IELTS" ? "phong cách học thuật IELTS" : type === "TOEIC" ? "phong cách TOEIC Part 5" : "";

  if (fmt === "text") {
    // Use a compact 5-column header so the model can't miscount the empty A–D
    // option columns; we re-emit the canonical 9-column CSV ourselves.
    const prompt = `Bạn là giáo viên tiếng Anh. Dựa trên nội dung kiến thức dưới đây, tạo CHÍNH XÁC ${n} câu bài tập ĐIỀN TỪ / CHIA ĐỘNG TỪ bằng tiếng Anh${style ? " (" + style + ")" : ""}, đúng trọng tâm kiến thức, ở mức độ ${lvLabel}.

CHỈ trả về dữ liệu CSV thuần — KHÔNG giải thích, KHÔNG bọc trong dấu \`\`\`:
- Dòng đầu là header CHÍNH XÁC: position,level,type,stem,answer
- Đúng ${n} dòng dữ liệu, position từ 1 đến ${n}.
- Cột type LUÔN là: text
- Cột level LUÔN là: ${lv}
- stem: câu tiếng Anh có đúng MỘT chỗ trống ghi là ______ (sáu dấu gạch dưới). Nếu là bài chia động từ, ghi động từ gốc trong ngoặc, ví dụ: She ______ (go) to school every day.
- answer: BẮT BUỘC điền — CHỈ là (các) từ cần điền vào chỗ trống, KHÔNG chép lại cả câu, KHÔNG để trống, KHÔNG chứa dấu ______. Ví dụ: với stem "She ______ (go) to school every day." thì answer là: goes
- Nếu có nhiều biến thể đúng thì nối bằng dấu | (ví dụ: don't|do not).
- Nếu stem hoặc answer chứa dấu phẩy, hãy bọc trường đó trong dấu nháy kép "...".

Nội dung kiến thức:
${knowledge.trim()}`;

    const text = await geminiText(prompt, 2048, 0.6);
    let csv = text.trim().replace(/^```[a-zA-Z]*\s*/, "").replace(/```\s*$/, "").trim();
    const i = csv.search(/position\s*,\s*level/i);
    if (i > 0) csv = csv.slice(i);
    csv = csv.trim();

    // Rebuild a clean 9-column CSV regardless of how many columns the model emitted.
    try {
      const { rows } = parseCSV(csv);
      if (rows.length > 1) {
        const hdr = rows[0].map((h) => h.trim().toLowerCase());
        let si = hdr.indexOf("stem");
        let ai = hdr.indexOf("answer");
        const out = ["position,level,type,stem,A,B,C,D,answer"];
        let pos = 0;
        for (let r = 1; r < rows.length; r++) {
          const row = rows[r];
          const stem = (row[si >= 0 && si < row.length ? si : 3] || "").trim();
          let answer = (row[ai >= 0 && ai < row.length ? ai : row.length - 1] || "").trim();
          if (!stem) continue;
          // Guard against a bogus answer (model copied the stem / left it blank):
          // fall back to empty => the question becomes AI-graded instead of wrong.
          if (!answer || answer === stem || answer.includes("______")) answer = "";
          pos++;
          out.push([pos, lv, "text", csvField(stem), "", "", "", "", csvField(answer)].join(","));
        }
        if (out.length > 1) csv = out.join("\n");
      }
    } catch {
      // fall back to raw model CSV
    }

    return { csv };
  }

  let intro;
  if (type === "IELTS") {
    intro = `Bạn là người ra đề luyện thi IELTS. Dựa trên nội dung kiến thức dưới đây, tạo CHÍNH XÁC ${n} câu trắc nghiệm tiếng Anh (dạng chọn từ/cụm từ đúng điền vào chỗ trống, phong cách học thuật IELTS), đúng trọng tâm kiến thức đó, ở mức độ ${lvLabel}.`;
  } else if (type === "TOEIC") {
    intro = `Bạn là người ra đề thi TOEIC Part 5. Dựa trên nội dung kiến thức dưới đây, tạo CHÍNH XÁC ${n} câu trắc nghiệm điền vào chỗ trống bằng tiếng Anh, đúng trọng tâm kiến thức đó, ở mức độ ${lvLabel}.`;
  } else {
    intro = `Bạn là giáo viên tiếng Anh ra đề trắc nghiệm. Dựa trên nội dung kiến thức dưới đây, tạo CHÍNH XÁC ${n} câu trắc nghiệm điền vào chỗ trống bằng tiếng Anh, đúng trọng tâm kiến thức đó, ở mức độ ${lvLabel}.`;
  }

  const prompt = `${intro}

CHỈ trả về dữ liệu CSV thuần — KHÔNG giải thích, KHÔNG bọc trong dấu \`\`\`:
- Dòng đầu là header chính xác: position,level,stem,A,B,C,D,answer
- Đúng ${n} dòng dữ liệu, position từ 1 đến ${n}.
- Cột level LUÔN là: ${lv}
- stem: một câu tiếng Anh có đúng MỘT chỗ trống ghi là ______ (sáu dấu gạch dưới).
- A,B,C,D: bốn phương án khác nhau; chỉ một phương án đúng.
- answer: BẮT BUỘC là MỘT CHỮ CÁI A, B, C hoặc D (không ghi nội dung đáp án). Phân bố đáp án đúng đều giữa A/B/C/D qua 10 câu, không để luôn ở A.
- Nếu stem hoặc phương án chứa dấu phẩy, hãy bọc trường đó trong dấu nháy kép "...".

Nội dung kiến thức:
${knowledge.trim()}`;

  const text = await geminiText(prompt, 2048, 0.6);

  // Strip code fences / any preamble before the header.
  let csv = text
    .trim()
    .replace(/^```[a-zA-Z]*\s*/, "")
    .replace(/```\s*$/, "")
    .trim();
  const idx = csv.search(/position\s*,\s*level/i);
  if (idx > 0) csv = csv.slice(idx);
  csv = csv.trim();

  // Robust normalization: the model sometimes puts the option CONTENT (not the
  // letter) in `answer`, or always picks A. Parse leniently, resolve the correct
  // option (by letter OR by matching content), shuffle, and re-emit clean CSV
  // with letter answers + forced level + sequential positions.
  try {
    const { rows } = parseCSV(csv);
    if (rows.length > 1) {
      const LETTERS = ["A", "B", "C", "D"];
      const out = ["position,level,stem,A,B,C,D,answer"];
      let pos = 0;
      for (let i = 1; i < rows.length; i++) {
        const r = rows[i];
        if (r.length < 8) continue;
        const stem = (r[2] || "").trim();
        const opts = [r[3], r[4], r[5], r[6]].map((x) => (x || "").trim());
        const ansRaw = (r[7] || "").trim();
        if (!stem || opts.some((o) => !o)) continue;

        let correct;
        const up = ansRaw.toUpperCase();
        if (LETTERS.includes(up)) {
          correct = opts[LETTERS.indexOf(up)];
        } else {
          const mi = opts.findIndex((o) => o.toLowerCase() === ansRaw.toLowerCase());
          if (mi >= 0) correct = opts[mi];
        }
        if (!correct) continue; // unresolvable answer → skip this row

        const contents = opts.slice();
        for (let k = contents.length - 1; k > 0; k--) {
          const j = Math.floor(Math.random() * (k + 1));
          [contents[k], contents[j]] = [contents[j], contents[k]];
        }
        const ai = contents.findIndex((c) => c === correct);
        pos++;
        out.push([pos, lv, csvField(stem), ...contents.map(csvField), LETTERS[ai >= 0 ? ai : 0]].join(","));
      }
      if (out.length > 1) csv = out.join("\n");
    }
  } catch {
    // if anything goes wrong, fall back to the raw model CSV
  }

  return { csv };
}
