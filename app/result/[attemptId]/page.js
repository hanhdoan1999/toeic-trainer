import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import ReviewItem from "./review-item";

export const dynamic = "force-dynamic";

export default async function ResultPage({ params }) {
  const supabase = createClient();
  const { attemptId } = params;

  const { data: attempt } = await supabase
    .from("attempts")
    .select("id, exam_id, score, total")
    .eq("id", attemptId)
    .single();
  if (!attempt) notFound();

  const { data: review = [] } = await supabase.rpc("get_attempt_review", {
    p_attempt_id: attemptId,
  });

  const pct = attempt.total ? Math.round((attempt.score / attempt.total) * 100) : 0;
  const r = 52;
  const circ = 2 * Math.PI * r;
  const off = circ * (1 - pct / 100);

  return (
    <section className="screen active">
      <div className="wrap" style={{ maxWidth: 680 }}>
        <div className="result-hero">
          <div className="ring">
            <svg width="120" height="120">
              <circle cx="60" cy="60" r={r} fill="none" stroke="#ece5d6" strokeWidth="11" />
              <circle
                cx="60"
                cy="60"
                r={r}
                fill="none"
                stroke="var(--accent)"
                strokeWidth="11"
                strokeLinecap="round"
                strokeDasharray={circ.toFixed(1)}
                strokeDashoffset={off.toFixed(1)}
              />
            </svg>
            <div className="mid">{pct}%</div>
          </div>
          <div className="pl">Kết quả của bạn</div>
          <div className="big">
            Đúng {attempt.score} / {attempt.total} câu
          </div>
          <div className="pl">Tỉ lệ chính xác {pct}%</div>
        </div>

        <div style={{ display: "flex", gap: 12, justifyContent: "center", marginBottom: 26 }}>
          <Link href={`/exam/${attempt.exam_id}`} className="btn btn-ghost">
            Về trang đề
          </Link>
          <Link href={`/exam/${attempt.exam_id}/take`} className="btn btn-primary">
            Làm lại
          </Link>
        </div>

        <h3 className="serif" style={{ fontSize: 16, margin: "0 0 12px" }}>
          Xem lại đáp án
        </h3>
        {(() => {
          let prevCtx = null;
          return review.map((row) => {
            const showCtx = row.context && row.context !== prevCtx ? row.context : null;
            prevCtx = row.context || null;
            return (
              <div key={row.position}>
                {showCtx && <div className="passage">{showCtx}</div>}
                <ReviewItem row={row} />
              </div>
            );
          });
        })()}
      </div>
    </section>
  );
}
