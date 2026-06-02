"use client";

import { useState } from "react";
import { Trash2 } from "lucide-react";
import { deleteExam } from "@/app/actions";

export default function DeleteExamButton({ examId, title }) {
  const [busy, setBusy] = useState(false);

  async function onDelete() {
    const ok = window.confirm(
      `Xoá đề "${title}"?\n\nToàn bộ câu hỏi và lịch sử làm bài của đề này sẽ bị xoá vĩnh viễn.`
    );
    if (!ok) return;
    setBusy(true);
    try {
      await deleteExam(examId); // redirects to "/" on success
    } catch (err) {
      setBusy(false);
      alert("Lỗi khi xoá đề: " + (err?.message || "không rõ"));
    }
  }

  return (
    <button type="button" className="btn btn-ghost" onClick={onDelete} disabled={busy}>
      <Trash2 size={15} />
      {busy ? "Đang xoá…" : "Xoá đề"}
    </button>
  );
}
