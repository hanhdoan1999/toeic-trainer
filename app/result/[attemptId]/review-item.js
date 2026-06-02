"use client";

import { useState } from "react";
import { Globe, Sparkles, Loader2 } from "lucide-react";
import { explainQuestion } from "@/app/actions";

export default function ReviewItem({ row }) {
  const [open, setOpen] = useState(false);
  const [status, setStatus] = useState("idle"); // idle | loading | done | error
  const [text, setText] = useState("");

  async function onExplain() {
    // toggle if we already have content
    if (status === "done" || status === "error") {
      setOpen((o) => !o);
      return;
    }
    setOpen(true);
    setStatus("loading");
    const isText = row.type === "text";
    const acceptStr = Array.isArray(row.accept) ? row.accept.join(" / ") : "";
    try {
      const { text } = await explainQuestion({
        stem: row.stem,
        correctLabel: isText ? "" : row.correct_label,
        correctContent: isText ? acceptStr || "(không có đáp án cố định)" : row.correct_content,
        selectedLabel: isText ? null : row.selected_label,
        options: isText ? [] : row.options || [],
      });
      setText(text);
      setStatus("done");
    } catch (err) {
      setText(err?.message || "Có lỗi khi gọi AI.");
      setStatus("error");
    }
  }

  const googleQuery =
    row.type === "text"
      ? `${row.stem} ${(row.accept || []).join(" ")}`.trim()
      : `${row.stem} ${row.correct_label}. ${row.correct_content}`;
  const googleUrl = `https://www.google.com/search?q=${encodeURIComponent(googleQuery)}`;

  return (
    <div className="q" style={{ boxShadow: "none", marginBottom: 8 }}>
      <div className="stem" style={{ margin: 0, fontSize: 14, display: "flex", gap: 8, alignItems: "flex-start" }}>
        <span style={{ flex: 1 }}>
          <b style={{ color: row.is_correct ? "var(--green)" : "var(--red)" }}>
            {row.is_correct ? "✓" : "✗"}
          </b>{" "}
          <span style={{ color: "var(--ink-soft)" }}>Câu {row.position}.</span>{" "}
          {row.type === "text" ? (
            <>
              {row.stem.replace("______", "____")}
              {Array.isArray(row.accept) && row.accept.length > 0 ? (
                <>
                  {" "}→{" "}
                  <b style={{ color: "var(--green)" }}>{row.accept.join(" / ")}</b>
                </>
              ) : (
                <span style={{ color: "var(--ink-soft)" }}> (AI chấm)</span>
              )}
              <div style={{ marginTop: 4 }}>
                {row.typed_answer ? (
                  <span style={{ color: row.is_correct ? "var(--green)" : "var(--red)" }}>
                    Bạn nhập: <b>{row.typed_answer}</b>
                  </span>
                ) : (
                  <span style={{ color: "var(--red)" }}>(bỏ trống)</span>
                )}
              </div>
            </>
          ) : (
            <>
              {row.stem.replace("______", "____")} →{" "}
              <b style={{ color: "var(--green)" }}>
                {row.correct_label}. {row.correct_content}
              </b>
              {row.selected_label && !row.is_correct && (
                <span style={{ color: "var(--red)" }}> (bạn chọn {row.selected_label})</span>
              )}
              {!row.selected_label && <span style={{ color: "var(--red)" }}> (bỏ trống)</span>}
            </>
          )}
        </span>
        <a
          className="ai-btn"
          href={googleUrl}
          target="_blank"
          rel="noopener noreferrer"
          title="Tìm trên Google"
          aria-label="Tìm câu hỏi này trên Google"
        >
          <Globe size={16} />
        </a>
        <button
          type="button"
          className="ai-btn"
          onClick={onExplain}
          disabled={status === "loading"}
          title="Giải thích bằng AI"
          aria-label="Giải thích bằng AI"
        >
          {status === "loading" ? <Loader2 size={16} className="spin" /> : <Sparkles size={16} />}
        </button>
      </div>

      {open && (
        <div className={`ai-box${status === "error" ? " err" : ""}`}>
          {status === "loading" && "Đang hỏi AI…"}
          {status !== "loading" && text}
        </div>
      )}
    </div>
  );
}
