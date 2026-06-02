"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Pencil } from "lucide-react";
import { updateExamTitle } from "@/app/actions";

export default function EditableTitle({ examId, initialTitle, canEdit }) {
  const router = useRouter();
  const [title, setTitle] = useState(initialTitle);
  const [editing, setEditing] = useState(false);
  const [value, setValue] = useState(initialTitle);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");

  if (!canEdit) {
    return <h1 className="page">{title}</h1>;
  }

  function start() {
    setValue(title);
    setErr("");
    setEditing(true);
  }

  async function save() {
    const next = value.trim();
    if (!next) {
      setErr("Tên đề không được để trống");
      return;
    }
    if (next === title) {
      setEditing(false);
      return;
    }
    setBusy(true);
    setErr("");
    try {
      await updateExamTitle(examId, next);
      setTitle(next);
      setEditing(false);
      router.refresh();
    } catch (e) {
      setErr(e?.message || "Lỗi khi đổi tên đề.");
    } finally {
      setBusy(false);
    }
  }

  if (!editing) {
    return (
      <h1 className="page" style={{ display: "flex", alignItems: "center", gap: 10 }}>
        <span>{title}</span>
        <button
          type="button"
          className="ai-btn"
          onClick={start}
          title="Đổi tên đề"
          aria-label="Đổi tên đề"
        >
          <Pencil size={15} />
        </button>
      </h1>
    );
  }

  return (
    <div style={{ marginBottom: 6 }}>
      <div style={{ display: "flex", gap: 8, alignItems: "center", flexWrap: "wrap" }}>
        <input
          type="text"
          value={value}
          autoFocus
          disabled={busy}
          onChange={(e) => setValue(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") save();
            if (e.key === "Escape") setEditing(false);
          }}
          style={{
            border: "1.5px solid var(--line)",
            borderRadius: 10,
            padding: "8px 12px",
            fontFamily: '"Fraunces", serif',
            fontSize: 22,
            fontWeight: 600,
            color: "var(--ink)",
            minWidth: 240,
            flex: 1,
            outline: "none",
          }}
        />
        <button type="button" className="btn btn-primary" onClick={save} disabled={busy}>
          {busy ? "Đang lưu…" : "Lưu"}
        </button>
        <button type="button" className="btn btn-ghost" onClick={() => setEditing(false)} disabled={busy}>
          Huỷ
        </button>
      </div>
      {err && <div style={{ color: "var(--red)", fontSize: 13, marginTop: 6 }}>{err}</div>}
    </div>
  );
}
