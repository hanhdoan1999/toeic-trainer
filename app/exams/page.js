import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { Sparkline } from "@/components/sparkline";

export const dynamic = "force-dynamic";

export default async function HomePage() {
  const supabase = createClient();

  const { data: exams = [] } = await supabase
    .from("exams")
    .select("id, title, total_questions, levels")
    .order("created_at", { ascending: false });

  const { data: attempts = [] } = await supabase
    .from("attempts")
    .select("exam_id, score, total, submitted_at")
    .not("submitted_at", "is", null)
    .order("submitted_at", { ascending: true });

  const byExam = {};
  for (const a of attempts) {
    (byExam[a.exam_id] ||= []).push(a);
  }

  return (
    <section className="screen active">
      <div className="wrap">
        <h1 className="page">Chọn đề luyện tập</h1>
        <p className="sub">Mỗi đề lưu lại điểm và lịch sử của riêng bạn.</p>

        <div className="grid">
          {exams.map((e, i) => {
            const list = byExam[e.id] || [];
            const best = list.length ? Math.max(...list.map((a) => a.score)) : 0;
            const bestPct = list.length ? Math.round((best / e.total_questions) * 100) : 0;
            const last = list[list.length - 1];
            const lv = e.levels || {};
            const sparkVals = list.map((a) => (a.score / a.total) * 100);

            return (
              <Link
                key={e.id}
                href={`/exam/${e.id}`}
                className="card click"
                style={{ animationDelay: `${i * 70}ms`, textDecoration: "none", color: "inherit" }}
              >
                <div>
                  <h3>{e.title}</h3>
                  <div className="chips" style={{ marginTop: 10 }}>
                    {lv.D != null && <span className="chip d">Dễ {lv.D}</span>}
                    {lv.TB != null && <span className="chip tb">TB {lv.TB}</span>}
                    {lv.K != null && <span className="chip k">Khó {lv.K}</span>}
                  </div>
                </div>
                <div className="statrow">
                  <div className="stat">
                    <div className="v big">{list.length ? bestPct + "%" : "—"}</div>
                    <div className="l">Điểm cao nhất</div>
                  </div>
                  <div className="stat">
                    <div className="v">{list.length}</div>
                    <div className="l">lần làm</div>
                  </div>
                  <Sparkline values={sparkVals} />
                </div>
                <div className="cardfoot">
                  <span className="lastscore">
                    {last ? (
                      <>
                        Gần nhất: <b>{last.score}/{last.total}</b>
                      </>
                    ) : (
                      "Chưa làm lần nào"
                    )}
                  </span>
                  <span style={{ marginLeft: "auto", color: "var(--accent-deep)", fontWeight: 600, fontSize: 13.5 }}>
                    Làm đề →
                  </span>
                </div>
              </Link>
            );
          })}
        </div>
      </div>
    </section>
  );
}
