import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { pctClass } from "@/components/sparkline";

export const dynamic = "force-dynamic";

function fmtDate(iso) {
  const d = new Date(iso);
  return d.toLocaleDateString("vi-VN") + " " + d.toLocaleTimeString("vi-VN", { hour: "2-digit", minute: "2-digit" });
}

export default async function HistoryPage() {
  const supabase = createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { data: attempts = [] } = await supabase
    .from("attempts")
    .select("id, score, total, submitted_at, exams(title)")
    .not("submitted_at", "is", null)
    .order("submitted_at", { ascending: false });

  const { data: notesRaw = [] } = await supabase
    .from("exam_notes")
    .select("exam_id, content, updated_at, exams(title)")
    .order("updated_at", { ascending: false });
  const notes = (notesRaw || []).filter((n) => (n.content || "").trim() !== "");

  const snippet = (md) =>
    (md || "")
      .replace(/[#*_>`~-]/g, " ")
      .replace(/\s+/g, " ")
      .trim()
      .slice(0, 120);

  const count = attempts.length;
  const avg = count
    ? Math.round(
        attempts.reduce((s, a) => s + (a.total ? (a.score / a.total) * 100 : 0), 0) / count
      )
    : 0;

  return (
    <section className="screen active">
      <div className="wrap">
        <div className="crumb">
          <Link href="/exams">← Tất cả đề</Link>
        </div>
        <h1 className="page">Lịch sử làm bài</h1>
        <p className="sub" style={{ margin: "0 0 22px" }}>
          {user?.email} · {count} lượt làm{count ? ` · trung bình ${avg}%` : ""}
        </p>

        {count ? (
          <div className="hlist">
            {attempts.map((a) => {
              const p = a.total ? Math.round((a.score / a.total) * 100) : 0;
              return (
                <Link key={a.id} href={`/result/${a.id}`} className="hrow">
                  <span className="ti">{a.exams?.title || "(đề đã xoá)"}</span>
                  <span className="mt">
                    <span className="dt">{fmtDate(a.submitted_at)}</span>
                    <span className="sc">{a.score}/{a.total}</span>
                    <span className={`pctpill ${pctClass(p)}`}>{p}%</span>
                  </span>
                </Link>
              );
            })}
          </div>
        ) : (
          <div className="hlist">
            <div className="hrow" style={{ color: "var(--ink-soft)" }}>
              Chưa có lượt làm nào — vào{" "}
              <Link href="/exams" style={{ color: "var(--accent-deep)", marginLeft: 4 }}>Tất cả đề</Link>{" "}
              để bắt đầu.
            </div>
          </div>
        )}

        <h3 className="serif" style={{ fontSize: 17, margin: "30px 0 12px" }}>
          Ghi chú đã lưu {notes.length ? `(${notes.length})` : ""}
        </h3>
        {notes.length ? (
          <div className="hlist">
            {notes.map((n) => (
              <Link key={n.exam_id} href={`/exam/${n.exam_id}`} className="hrow">
                <span className="ti">
                  {n.exams?.title || "(đề đã xoá)"}
                  <span style={{ display: "block", fontSize: 12.5, color: "var(--ink-soft)", fontWeight: 400, marginTop: 2 }}>
                    {snippet(n.content)}
                    {(n.content || "").length > 120 ? "…" : ""}
                  </span>
                </span>
                <span className="mt">
                  <span className="dt">{fmtDate(n.updated_at)}</span>
                </span>
              </Link>
            ))}
          </div>
        ) : (
          <div className="hlist">
            <div className="hrow" style={{ color: "var(--ink-soft)" }}>
              Chưa có ghi chú nào — mở một đề và viết ghi chú ở khối “Ghi chú của bạn”.
            </div>
          </div>
        )}
      </div>
    </section>
  );
}
