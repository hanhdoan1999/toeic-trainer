import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { pctClass } from "@/components/sparkline";
import DeleteExamButton from "./delete-exam-button";
import EditableTitle from "./editable-title";
import NotesEditor from "./notes-editor";

export const dynamic = "force-dynamic";

function fmtDate(iso) {
  const d = new Date(iso);
  return d.toLocaleDateString("vi-VN") + " " + d.toLocaleTimeString("vi-VN", { hour: "2-digit", minute: "2-digit" });
}

export default async function ExamDetailPage({ params }) {
  const supabase = createClient();
  const { examId } = params;

  const { data: exam } = await supabase
    .from("exams")
    .select("id, title, total_questions, levels, created_by")
    .eq("id", examId)
    .single();

  if (!exam) notFound();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  const isOwner = !!user && exam.created_by === user.id;

  const { data: note } = await supabase
    .from("exam_notes")
    .select("content, updated_at")
    .eq("exam_id", examId)
    .maybeSingle();

  const { data: attempts = [] } = await supabase
    .from("attempts")
    .select("id, score, total, submitted_at")
    .eq("exam_id", examId)
    .not("submitted_at", "is", null)
    .order("submitted_at", { ascending: false });

  const scores = attempts.map((a) => a.score);
  const best = scores.length ? Math.max(...scores) : 0;
  const avg = scores.length ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length) : 0;
  const last = attempts[0];
  const lv = exam.levels || {};

  return (
    <section className="screen active">
      <div className="wrap">
        <div className="crumb">
          <Link href="/exams">← Tất cả đề</Link>
        </div>

        <div className="detail-head">
          <div>
            <EditableTitle examId={exam.id} initialTitle={exam.title} canEdit={isOwner} />
            <p className="sub" style={{ margin: 0 }}>
              {exam.total_questions} câu · Dễ {lv.D ?? 0} · TB {lv.TB ?? 0} · Khó {lv.K ?? 0}
            </p>
          </div>
          <div style={{ display: "flex", gap: 10, alignItems: "center" }}>
            {isOwner && <DeleteExamButton examId={exam.id} title={exam.title} />}
            <Link href={`/exam/${exam.id}/take`} className="btn btn-accent">
              Làm đề →
            </Link>
          </div>
        </div>

        <div className="statbar">
          <div className="statbox">
            <div className="v">{attempts.length ? Math.round((best / exam.total_questions) * 100) + "%" : "—"}</div>
            <div className="l">Cao nhất ({best}/{exam.total_questions})</div>
          </div>
          <div className="statbox">
            <div className="v">{last ? Math.round((last.score / last.total) * 100) + "%" : "—"}</div>
            <div className="l">Gần nhất</div>
          </div>
          <div className="statbox">
            <div className="v">{attempts.length ? Math.round((avg / exam.total_questions) * 100) + "%" : "—"}</div>
            <div className="l">Trung bình</div>
          </div>
          <div className="statbox">
            <div className="v">{attempts.length}</div>
            <div className="l">Số lần làm</div>
          </div>
        </div>

        <h3 className="serif" style={{ fontSize: 17, margin: "0 0 12px" }}>
          Ghi chú của bạn
        </h3>
        <NotesEditor
          examId={exam.id}
          initialContent={note?.content || ""}
          initialUpdatedAt={note?.updated_at || null}
        />

        <h3 className="serif" style={{ fontSize: 17, margin: "30px 0 12px" }}>
          Lịch sử các lần làm
        </h3>
        <div className="hist">
          <div className="hh">
            <span>#</span>
            <span className="when">Thời gian</span>
            <span>Điểm</span>
            <span>Tỉ lệ</span>
            <span />
          </div>
          {attempts.length ? (
            attempts.map((a, idx) => {
              const p = Math.round((a.score / a.total) * 100);
              return (
                <Link
                  key={a.id}
                  href={`/result/${a.id}`}
                  className="hr"
                  style={{ textDecoration: "none", color: "inherit" }}
                >
                  <span className="idx">#{attempts.length - idx}</span>
                  <span className="when">{fmtDate(a.submitted_at)}</span>
                  <span className="sc">{a.score}/{a.total}</span>
                  <span className={`pctpill ${pctClass(p)}`}>{p}%</span>
                  <span className="pbar">
                    <i style={{ width: p + "%" }} />
                  </span>
                </Link>
              );
            })
          ) : (
            <div className="hr" style={{ gridTemplateColumns: "1fr", color: "var(--ink-soft)" }}>
              Chưa có lần làm nào — bấm “Làm đề”.
            </div>
          )}
        </div>
      </div>
    </section>
  );
}
