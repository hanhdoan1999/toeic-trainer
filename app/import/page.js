"use client";

import { useState } from "react";
import Link from "next/link";
import { Sparkles, Upload } from "lucide-react";
import { parseExamCSV } from "@/lib/csv";
import { importExam } from "@/app/actions";
import AiGenModal from "./ai-gen-modal";

const LEVEL_LABEL = { D: "Dễ", TB: "TB", K: "Khó" };
const LEVEL_CLASS = { D: "d", TB: "tb", K: "k" };

const SAMPLE = `position,level,stem,A,B,C,D,answer
1,D,"The manager decided ______ the meeting.",to cancel,canceled,canceling,cancel,A
2,D,"Please avoid ______ during the presentation.",talked,to talk,talking,talk,C
21,TB,"We must carefully ______ the contract.",to review,reviewing,reviewed,review,D`;

export default function ImportPage() {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [csv, setCsv] = useState("");
  const [result, setResult] = useState(null); // parseExamCSV output
  const [submitting, setSubmitting] = useState(false);
  const [serverError, setServerError] = useState("");
  const [aiOpen, setAiOpen] = useState(false);
  const [fileName, setFileName] = useState("");

  function onFile(e) {
    const file = e.target.files?.[0];
    if (!file) return;
    setFileName(file.name);
    const reader = new FileReader();
    reader.onload = () => {
      setCsv(String(reader.result || ""));
      setResult(null);
    };
    reader.readAsText(file);
  }

  function preview() {
    setServerError("");
    setResult(parseExamCSV(csv));
  }

  const hasErrors =
    !result ||
    !!result.globalError ||
    result.rowErrors.length > 0 ||
    result.questions.length === 0;
  const canSubmit = !hasErrors && title.trim() && !submitting;

  async function submit() {
    if (!canSubmit) return;
    setSubmitting(true);
    setServerError("");
    try {
      // server action redirects on success
      await importExam(title.trim(), description.trim(), result.questions);
    } catch (err) {
      setServerError(err?.message || "Có lỗi khi nhập đề.");
      setSubmitting(false);
    }
  }

  return (
    <section className="screen active">
      <div className="wrap">
        <div className="crumb">
          <Link href="/exams">← Tất cả đề</Link>
        </div>
        <h1 className="page">Nhập đề từ CSV</h1>
        <p className="sub">
          Tải lên hoặc dán file CSV (8 cột: position, level, stem, A, B, C, D, answer). Xem trước rồi nhập.
        </p>

        <div className="field" style={{ marginBottom: 16 }}>
          <label>Tên đề *</label>
          <input
            type="text"
            placeholder="VD: Part 5 — To-V / V-ing"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
        </div>
        <div className="field" style={{ marginBottom: 16 }}>
          <label>Mô tả (tùy chọn)</label>
          <input
            type="text"
            placeholder="Trọng tâm ngữ pháp…"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
        </div>

        <div className="field" style={{ marginBottom: 12 }}>
          <label>Nội dung CSV</label>
          <textarea
            rows={8}
            placeholder={SAMPLE}
            value={csv}
            onChange={(e) => {
              setCsv(e.target.value);
              setResult(null);
            }}
            style={{
              border: "1.5px solid var(--line)",
              borderRadius: 10,
              padding: "12px 14px",
              fontFamily: "ui-monospace, Menlo, monospace",
              fontSize: 13,
              outline: "none",
              resize: "vertical",
            }}
          />
        </div>

        <div style={{ display: "flex", gap: 10, alignItems: "center", flexWrap: "wrap", marginBottom: 8 }}>
          <button className="btn btn-accent" type="button" onClick={() => setAiOpen(true)}>
            <Sparkles size={15} /> Generate with AI
          </button>
          <label className="btn btn-ghost" style={{ cursor: "pointer" }}>
            <Upload size={15} /> Tải file CSV
            <input type="file" accept=".csv,text/csv" onChange={onFile} style={{ display: "none" }} />
          </label>
          {fileName && (
            <span style={{ fontSize: 13, color: "var(--ink-soft)" }}>{fileName}</span>
          )}
          <button className="btn btn-ghost" type="button" onClick={() => { setCsv(SAMPLE); setResult(null); setFileName(""); }}>
            Dùng CSV mẫu
          </button>
          <button className="btn btn-primary" type="button" onClick={preview} disabled={!csv.trim()}>
            Xem trước
          </button>
        </div>

        {result && <Preview result={result} />}

        {serverError && (
          <div className="sent" style={{ display: "block", background: "var(--red-bg)", color: "var(--red)", marginTop: 14 }}>
            Lỗi: {serverError}
          </div>
        )}

        {result && (
          <div style={{ marginTop: 18 }}>
            <button className="btn btn-accent" type="button" onClick={submit} disabled={!canSubmit}>
              {submitting ? "Đang nhập…" : `Nhập đề (${result.questions.length} câu)`}
            </button>
            {!title.trim() && (
              <span style={{ marginLeft: 12, color: "var(--ink-soft)", fontSize: 13 }}>
                Nhập "Tên đề" để tiếp tục.
              </span>
            )}
          </div>
        )}
      </div>

      <AiGenModal
        open={aiOpen}
        onClose={() => setAiOpen(false)}
        onResult={(csvText) => {
          setCsv(csvText);
          setServerError("");
          setResult(parseExamCSV(csvText));
        }}
      />
    </section>
  );
}

function Preview({ result }) {
  if (result.globalError) {
    return (
      <div className="sent" style={{ display: "block", background: "var(--red-bg)", color: "var(--red)" }}>
        {result.globalError}
      </div>
    );
  }

  const counts = result.levelCounts;
  return (
    <div style={{ marginTop: 6 }}>
      <div className="chips" style={{ marginBottom: 12 }}>
        <span className="chip">{result.questions.length}/{result.totalRows} câu hợp lệ</span>
        {counts.D != null && <span className="chip d">Dễ {counts.D}</span>}
        {counts.TB != null && <span className="chip tb">TB {counts.TB}</span>}
        {counts.K != null && <span className="chip k">Khó {counts.K}</span>}
      </div>

      {result.rowErrors.length > 0 && (
        <div className="sent" style={{ display: "block", background: "var(--red-bg)", color: "var(--red)", marginBottom: 12 }}>
          <b>{result.rowErrors.length} dòng lỗi (bỏ qua):</b>
          <ul style={{ margin: "6px 0 0", paddingLeft: 18 }}>
            {result.rowErrors.slice(0, 20).map((e) => (
              <li key={e.line} style={{ fontSize: 13 }}>{e.msg}</li>
            ))}
          </ul>
          {result.rowErrors.length > 20 && <div style={{ fontSize: 13 }}>… và {result.rowErrors.length - 20} dòng nữa.</div>}
        </div>
      )}

      {result.questions.length > 0 && (
        <div style={{ border: "1px solid var(--line)", borderRadius: 12, overflow: "hidden" }}>
          {result.questions.slice(0, 10).map((q) => (
            <div key={q.position} style={{ padding: "12px 14px", borderBottom: "1px solid var(--line)" }}>
              <div style={{ display: "flex", gap: 8, alignItems: "center", marginBottom: 6, flexWrap: "wrap" }}>
                <span style={{ fontWeight: 600 }}>#{q.position}</span>
                <span className={`chip ${LEVEL_CLASS[q.level]}`}>{LEVEL_LABEL[q.level]}</span>
                {q.type === "text" && <span className="chip">Điền từ</span>}
                <span style={{ fontSize: 14 }}>{q.stem}</span>
              </div>
              {q.type === "text" ? (
                <div style={{ fontSize: 13.5, color: "var(--ink-soft)" }}>
                  Đáp án:{" "}
                  {q.accept && q.accept.length ? (
                    <b style={{ color: "#3d6b2b" }}>{q.accept.join(" / ")}</b>
                  ) : (
                    <span>AI chấm (không có đáp án cố định)</span>
                  )}
                </div>
              ) : (
                <div className="chips">
                  {q.options.map((o) => (
                    <span
                      key={o.label}
                      className="chip"
                      style={o.label === q.answer ? { background: "#e3eed9", color: "#3d6b2b", fontWeight: 600 } : undefined}
                    >
                      {o.label}. {o.content}
                      {o.label === q.answer ? " ✓" : ""}
                    </span>
                  ))}
                </div>
              )}
            </div>
          ))}
          {result.questions.length > 10 && (
            <div style={{ padding: "10px 14px", color: "var(--ink-soft)", fontSize: 13 }}>
              … và {result.questions.length - 10} câu nữa.
            </div>
          )}
        </div>
      )}
    </div>
  );
}
