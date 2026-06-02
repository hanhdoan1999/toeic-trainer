// Dependency-free CSV parsing + TOEIC-exam validation. Runs client-side.

const LETTERS = ["A", "B", "C", "D"];
const LEVELS = ["D", "TB", "K"];
const TYPES = ["mcq", "text"];
// v1 (legacy, all MCQ) vs v2 (with a `type` column)
const EXPECTED_HEADER = ["position", "level", "stem", "A", "B", "C", "D", "answer"];
const EXPECTED_HEADER_V2 = ["position", "level", "type", "stem", "A", "B", "C", "D", "answer"];

// RFC-4180-ish parser: handles quoted fields, "" escapes, commas/newlines
// inside quotes, CRLF/LF, a leading BOM, and skips fully blank lines.
// Never throws — returns { rows: string[][], error: string|null }.
export function parseCSV(text) {
  if (typeof text !== "string") return { rows: [], error: "Không có dữ liệu." };
  let s = text.replace(/^﻿/, ""); // strip BOM
  const rows = [];
  let field = "";
  let row = [];
  let inQuotes = false;
  let i = 0;

  const pushField = () => {
    row.push(field);
    field = "";
  };
  const pushRow = () => {
    pushField();
    // skip a row that is entirely empty (e.g. blank line)
    const allEmpty = row.every((c) => c.trim() === "");
    if (!allEmpty) rows.push(row);
    row = [];
  };

  while (i < s.length) {
    const c = s[i];
    if (inQuotes) {
      if (c === '"') {
        if (s[i + 1] === '"') {
          field += '"';
          i += 2;
          continue;
        }
        inQuotes = false;
        i++;
        continue;
      }
      field += c;
      i++;
      continue;
    }
    if (c === '"') {
      inQuotes = true;
      i++;
      continue;
    }
    if (c === ",") {
      pushField();
      i++;
      continue;
    }
    if (c === "\r") {
      i++;
      continue;
    }
    if (c === "\n") {
      pushRow();
      i++;
      continue;
    }
    field += c;
    i++;
  }
  // flush last field/row
  if (field !== "" || row.length) pushRow();

  if (inQuotes) return { rows, error: 'CSV lỗi: thiếu dấu " đóng.' };
  return { rows, error: null };
}

// High-level: validate header + map rows to question objects.
// Returns { questions, levelCounts, totalRows, rowErrors[], globalError }.
export function parseExamCSV(text) {
  const { rows, error } = parseCSV(text);
  if (error) return empty(error);
  if (!rows.length) return empty("CSV rỗng — không có dòng nào.");

  const header = rows[0].map((h) => h.trim());
  const mode = headerMode(header);
  if (!mode) {
    return empty(`Header sai. Cần: ${EXPECTED_HEADER.join(",")} (hoặc có thêm cột type: ${EXPECTED_HEADER_V2.join(",")})`);
  }
  const hasType = mode === "v2";
  const ncols = hasType ? EXPECTED_HEADER_V2.length : EXPECTED_HEADER.length;

  const questions = [];
  const rowErrors = [];
  const levelCounts = {};
  const seenPos = new Set();

  for (let r = 1; r < rows.length; r++) {
    const cells = rows[r];
    const lineNo = r + 1; // 1-based line in file
    const errs = [];

    if (cells.length < ncols) {
      rowErrors.push({ line: lineNo, msg: `Dòng ${lineNo}: thiếu cột (cần ${ncols}, có ${cells.length}).` });
      continue;
    }

    let posRaw, levelRaw, typeRaw, stemRaw, a, b, c, d, ansRaw;
    if (hasType) {
      [posRaw, levelRaw, typeRaw, stemRaw, a, b, c, d, ansRaw] = cells;
    } else {
      [posRaw, levelRaw, stemRaw, a, b, c, d, ansRaw] = cells;
      typeRaw = "mcq";
    }

    const position = Number.parseInt((posRaw || "").trim(), 10);
    const level = (levelRaw || "").trim().toUpperCase();
    const type = ((typeRaw || "mcq").trim().toLowerCase()) || "mcq";
    const stem = (stemRaw || "").trim();

    if (!Number.isInteger(position)) errs.push("position không phải số nguyên");
    else if (seenPos.has(position)) errs.push(`position ${position} bị trùng`);
    if (!LEVELS.includes(level)) errs.push(`level "${levelRaw}" phải là D / TB / K`);
    if (!stem) errs.push("stem (đề) trống");
    if (!TYPES.includes(type)) errs.push(`type "${typeRaw}" phải là mcq / text`);

    let question = null;
    if (type === "mcq") {
      const answer = (ansRaw || "").trim().toUpperCase();
      const optContents = [a, b, c, d].map((x) => (x ?? "").trim());
      if (!LETTERS.includes(answer)) errs.push(`answer "${ansRaw}" phải là A / B / C / D`);
      optContents.forEach((content, idx) => {
        if (!content) errs.push(`đáp án ${LETTERS[idx]} trống`);
      });
      if (!errs.length) {
        question = {
          position,
          level,
          stem,
          type: "mcq",
          answer,
          accept: [],
          options: LETTERS.map((label, idx) => ({ label, content: optContents[idx], position: idx })),
        };
      }
    } else {
      // text: answer column holds accepted answers separated by '|' (empty => AI-graded)
      const accept = (ansRaw || "").split("|").map((s) => s.trim()).filter(Boolean);
      if (!errs.length) {
        question = { position, level, stem, type: "text", accept, options: [] };
      }
    }

    if (errs.length || !question) {
      rowErrors.push({ line: lineNo, msg: `Dòng ${lineNo}: ${errs.join("; ")}.` });
      continue;
    }

    seenPos.add(position);
    levelCounts[level] = (levelCounts[level] || 0) + 1;
    questions.push(question);
  }

  return {
    questions,
    levelCounts,
    totalRows: rows.length - 1,
    rowErrors,
    globalError: null,
  };
}

// Returns "v1" | "v2" | null based on the header row.
function headerMode(header) {
  const got = header.map((h) => h.trim().toLowerCase());
  const eq = (want) => want.every((w, i) => got[i] === w.toLowerCase());
  if (got[2] === "type" && eq(EXPECTED_HEADER_V2)) return "v2";
  if (eq(EXPECTED_HEADER)) return "v1";
  return null;
}

function empty(globalError) {
  return { questions: [], levelCounts: {}, totalRows: 0, rowErrors: [], globalError };
}
