"use client";

import { useRef, useState } from "react";
import { marked } from "marked";
import { Save, Pencil, Eye, Bold, List } from "lucide-react";
import { saveExamNote } from "@/app/actions";

marked.setOptions({ breaks: true });

function fmt(iso) {
  if (!iso) return null;
  const d = new Date(iso);
  return (
    d.toLocaleDateString("vi-VN") +
    " " +
    d.toLocaleTimeString("vi-VN", { hour: "2-digit", minute: "2-digit" })
  );
}

export default function NotesEditor({ examId, initialContent, initialUpdatedAt }) {
  const [content, setContent] = useState(initialContent || "");
  const [tab, setTab] = useState("edit"); // edit | preview
  const [saved, setSaved] = useState(initialContent || "");
  const [savedAt, setSavedAt] = useState(initialUpdatedAt || null);
  const [status, setStatus] = useState("idle"); // idle | saving | error
  const [err, setErr] = useState("");
  const taRef = useRef(null);

  const dirty = content !== saved;

  // wrap the current selection (or insert at caret) with before/after markers
  function surround(before, after = before, placeholder = "") {
    const ta = taRef.current;
    if (!ta) return;
    const start = ta.selectionStart;
    const end = ta.selectionEnd;
    const sel = content.slice(start, end) || placeholder;
    const next = content.slice(0, start) + before + sel + after + content.slice(end);
    setContent(next);
    requestAnimationFrame(() => {
      ta.focus();
      ta.selectionStart = start + before.length;
      ta.selectionEnd = start + before.length + sel.length;
    });
  }

  function prefixLines(prefix) {
    const ta = taRef.current;
    if (!ta) return;
    const start = ta.selectionStart;
    const end = ta.selectionEnd;
    const ls = content.lastIndexOf("\n", start - 1) + 1;
    const block = content.slice(ls, end) || "mục";
    const next =
      content.slice(0, ls) +
      block
        .split("\n")
        .map((l) => (l.startsWith(prefix) ? l : prefix + l))
        .join("\n") +
      content.slice(end);
    setContent(next);
    requestAnimationFrame(() => ta.focus());
  }

  async function save() {
    setStatus("saving");
    setErr("");
    try {
      await saveExamNote(examId, content);
      setSaved(content);
      setSavedAt(new Date().toISOString());
      setStatus("idle");
    } catch (e) {
      setErr(e?.message || "Lỗi khi lưu ghi chú.");
      setStatus("error");
    }
  }

  return (
    <div className="notes">
      <div className="notes-head">
        <div className="notes-tabs">
          <button
            type="button"
            className={`notes-tab${tab === "edit" ? " active" : ""}`}
            onClick={() => setTab("edit")}
          >
            <Pencil size={14} /> Soạn
          </button>
          <button
            type="button"
            className={`notes-tab${tab === "preview" ? " active" : ""}`}
            onClick={() => setTab("preview")}
          >
            <Eye size={14} /> Xem trước
          </button>
        </div>
        <div className="notes-meta">
          {dirty ? (
            <span style={{ color: "var(--accent-deep)" }}>● Chưa lưu</span>
          ) : savedAt ? (
            <span>Đã lưu lúc {fmt(savedAt)}</span>
          ) : (
            <span>Chưa có ghi chú</span>
          )}
        </div>
      </div>

      {tab === "edit" ? (
        <>
          <div className="notes-toolbar">
            <button type="button" className="ai-btn" title="In đậm" onClick={() => surround("**", "**", "đậm")}>
              <Bold size={15} />
            </button>
            <button type="button" className="ai-btn" title="Danh sách" onClick={() => prefixLines("- ")}>
              <List size={15} />
            </button>
          </div>
          <textarea
            ref={taRef}
            className="notes-area"
            rows={10}
            placeholder={"Ghi chú Markdown…\n\nVí dụ:\n## Cấu trúc cần nhớ\n- Would you mind **+ V-ing** → opening\n- Watch + O + V-inf: chứng kiến trọn vẹn"}
            value={content}
            onChange={(e) => setContent(e.target.value)}
          />
        </>
      ) : (
        <div
          className="md"
          dangerouslySetInnerHTML={{
            __html: content.trim()
              ? marked.parse(content)
              : "<p style='color:var(--ink-soft)'>Chưa có nội dung để xem trước.</p>",
          }}
        />
      )}

      <div className="notes-foot">
        <button type="button" className="btn btn-primary" onClick={save} disabled={status === "saving" || !dirty}>
          <Save size={15} />
          {status === "saving" ? "Đang lưu…" : "Lưu ghi chú"}
        </button>
        {err && <span style={{ color: "var(--red)", fontSize: 13 }}>{err}</span>}
      </div>
    </div>
  );
}
