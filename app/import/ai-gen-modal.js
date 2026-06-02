"use client";

import { useState, useEffect } from "react";
import { createPortal } from "react-dom";
import { Sparkles, X, Loader2 } from "lucide-react";
import { generateExamCSV } from "@/app/actions";

export default function AiGenModal({ open, onClose, onResult }) {
  const [knowledge, setKnowledge] = useState("");
  const [type, setType] = useState("");
  const [format, setFormat] = useState("mcq");
  const [level, setLevel] = useState("D");
  const [count, setCount] = useState(3);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");

  // Lock background scroll while the modal is open.
  useEffect(() => {
    if (!open) return;
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = prev;
    };
  }, [open]);

  if (!open) return null;

  async function generate() {
    if (!knowledge.trim()) {
      setErr("Vui lòng nhập nội dung kiến thức.");
      return;
    }
    setBusy(true);
    setErr("");
    try {
      const { csv } = await generateExamCSV(knowledge, level, type, format, count);
      onResult(csv);
      onClose();
    } catch (e) {
      setErr(e?.message || "Lỗi khi sinh đề bằng AI.");
    } finally {
      setBusy(false);
    }
  }

  return createPortal(
    <div className="modal-overlay" onMouseDown={(e) => e.target === e.currentTarget && !busy && onClose()}>
      <div className="modal" role="dialog" aria-modal="true">
        <div className="modal-head">
          <h3 className="serif" style={{ margin: 0, fontSize: 18, display: "flex", alignItems: "center", gap: 8 }}>
            <Sparkles size={18} /> Generate with AI
          </h3>
          <button type="button" className="ai-btn" onClick={onClose} disabled={busy} aria-label="Đóng">
            <X size={16} />
          </button>
        </div>

        <p className="sub" style={{ margin: "0 0 16px", fontSize: 13.5 }}>
          Nhập nội dung kiến thức, chọn cấp độ. AI sẽ tạo 10 câu dạng CSV và đổ vào ô Nội dung CSV.
        </p>

        <div className="field" style={{ marginBottom: 14 }}>
          <label>Nội dung kiến thức</label>
          <textarea
            rows={6}
            placeholder={"VD: Động từ + to-V (decide, plan, agree...) và động từ + V-ing (avoid, finish, consider...). Phân biệt cách dùng."}
            value={knowledge}
            onChange={(e) => setKnowledge(e.target.value)}
            disabled={busy}
            style={{
              border: "1.5px solid var(--line)",
              borderRadius: 10,
              padding: "12px 14px",
              fontFamily: "inherit",
              fontSize: 14,
              outline: "none",
              resize: "vertical",
            }}
          />
        </div>

        <div style={{ display: "flex", gap: 14, flexWrap: "wrap", marginBottom: 16 }}>
          <div className="field" style={{ marginBottom: 0, flex: 1, minWidth: 140 }}>
            <label>Dạng bài</label>
            <select className="sel" value={format} onChange={(e) => setFormat(e.target.value)} disabled={busy}>
              <option value="mcq">Trắc nghiệm</option>
              <option value="text">Điền từ</option>
            </select>
          </div>
          <div className="field" style={{ marginBottom: 0, flex: 1, minWidth: 140 }}>
            <label>Loại đề</label>
            <select className="sel" value={type} onChange={(e) => setType(e.target.value)} disabled={busy}>
              <option value="">Không chọn</option>
              <option value="TOEIC">TOEIC</option>
              <option value="IELTS">IELTS</option>
            </select>
          </div>
          <div className="field" style={{ marginBottom: 0, flex: 1, minWidth: 140 }}>
            <label>Cấp độ</label>
            <select className="sel" value={level} onChange={(e) => setLevel(e.target.value)} disabled={busy}>
              <option value="D">Dễ</option>
              <option value="TB">Trung bình</option>
              <option value="K">Khó</option>
            </select>
          </div>
          <div className="field" style={{ marginBottom: 0, width: 110 }}>
            <label>Số câu</label>
            <input
              type="number"
              min={1}
              max={10}
              value={count}
              disabled={busy}
              onChange={(e) => setCount(Math.min(10, Math.max(1, Number.parseInt(e.target.value, 10) || 1)))}
            />
          </div>
        </div>

        {err && (
          <div className="sent" style={{ display: "block", background: "var(--red-bg)", color: "var(--red)", marginBottom: 14 }}>
            {err}
          </div>
        )}

        <div style={{ display: "flex", gap: 10, justifyContent: "flex-end" }}>
          <button type="button" className="btn btn-ghost" onClick={onClose} disabled={busy}>
            Huỷ
          </button>
          <button type="button" className="btn btn-accent" onClick={generate} disabled={busy}>
            {busy ? <Loader2 size={15} className="spin" /> : <Sparkles size={15} />}
            {busy ? "Đang tạo…" : "Tạo nội dung"}
          </button>
        </div>
      </div>
    </div>,
    document.body
  );
}
