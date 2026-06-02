"use client";

import { useMemo, useState, useTransition } from "react";
import { submitAttempt } from "@/app/actions";

const LEVEL_LABEL = { D: "DỄ", TB: "TRUNG BÌNH", K: "KHÓ" };

export default function TakeForm({ examId, questions }) {
  const [answers, setAnswers] = useState({}); // questionId -> choiceId | typed string
  const [isPending, startTransition] = useTransition();
  const [error, setError] = useState("");

  const answeredCount = questions.filter((q) => {
    const v = answers[q.id];
    return q.type === "text" ? (v || "").trim() !== "" : v != null;
  }).length;
  const total = questions.length;

  function pick(qId, cId) {
    setAnswers((a) => ({ ...a, [qId]: cId }));
  }

  function onSubmit() {
    if (answeredCount < total) {
      const ok = window.confirm(`Còn ${total - answeredCount} câu chưa trả lời. Vẫn nộp?`);
      if (!ok) return;
    }
    const payload = questions.map((q) => ({
      question_id: q.id,
      choice_id: q.type === "text" ? null : answers[q.id] ?? null,
      typed_answer: q.type === "text" ? (answers[q.id] ?? "") : null,
    }));
    setError("");
    startTransition(async () => {
      try {
        await submitAttempt(examId, payload);
      } catch (e) {
        // redirect() throws NEXT_REDIRECT on success — ignore that one
        if (!String(e?.message || e).includes("NEXT_REDIRECT")) {
          setError("Có lỗi khi nộp bài. Thử lại nhé.");
        }
      }
    });
  }

  // group level headers + passage context (shown once when it changes)
  const rendered = useMemo(() => {
    let curLv = null;
    let curCtx = null;
    return questions.map((q, i) => {
      const header = q.level !== curLv ? ((curLv = q.level), LEVEL_LABEL[q.level]) : null;
      const ctx = q.context && q.context !== curCtx ? ((curCtx = q.context), q.context) : null;
      if (!q.context) curCtx = null;
      return { q, n: i + 1, header, ctx };
    });
  }, [questions]);

  return (
    <>
      {rendered.map(({ q, n, header, ctx }) => (
        <div key={q.id}>
          {header && <div className="levelhead">Mức độ: {header}</div>}
          {ctx && <div className="passage">{ctx}</div>}
          <div className="q">
            <div className="stem">
              <b style={{ color: "var(--ink)" }}>Câu {n}.</b>{" "}
              {q.stem.split("______").map((part, idx, arr) => (
                <span key={idx}>
                  {part}
                  {idx < arr.length - 1 && <b style={{ color: "var(--accent-deep)" }}>______</b>}
                </span>
              ))}
            </div>
            {q.type === "text" ? (
              <input
                type="text"
                className="text-answer"
                placeholder="Nhập đáp án…"
                value={answers[q.id] ?? ""}
                onChange={(e) => pick(q.id, e.target.value)}
              />
            ) : (
              <div className="opts">
                {q.choices.map((c) => (
                  <label key={c.id} className="opt">
                    <input
                      type="radio"
                      name={q.id}
                      checked={answers[q.id] === c.id}
                      onChange={() => pick(q.id, c.id)}
                    />
                    <span className="lbl">{c.label}.</span>
                    <span>{c.content}</span>
                  </label>
                ))}
              </div>
            )}
          </div>
        </div>
      ))}

      <div className="dock">
        <span className="prog">
          Đã chọn <b>{answeredCount}</b> / {total}
        </span>
        {error && <span style={{ color: "var(--red)", fontSize: 13 }}>{error}</span>}
        <div className="right">
          <button type="button" className="btn btn-ghost" onClick={() => setAnswers({})} disabled={isPending}>
            Làm lại
          </button>
          <button type="button" className="btn btn-accent" onClick={onSubmit} disabled={isPending}>
            {isPending ? "Đang chấm…" : "Nộp bài"}
          </button>
        </div>
      </div>
    </>
  );
}
