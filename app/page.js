import Link from "next/link";
import {
  Sparkles,
  ShieldCheck,
  NotebookPen,
  FileUp,
  Bot,
  LineChart,
  ArrowRight,
  GraduationCap,
} from "lucide-react";
import Reveal from "@/components/reveal";

export const metadata = {
  title: "TOEIC Trainer — Luyện đề tiếng Anh cùng AI",
  description:
    "Luyện đề TOEIC & IELTS: chấm điểm an toàn, giải thích đáp án bằng AI, sinh đề tự động, ghi chú Markdown và theo dõi tiến bộ.",
};

const FEATURES = [
  {
    icon: LineChart,
    title: "Theo dõi tiến bộ",
    desc: "Lưu điểm cao nhất, số lần làm và lịch sử từng lượt với sparkline trực quan.",
  },
  {
    icon: ShieldCheck,
    title: "Chấm điểm an toàn",
    desc: "Đáp án được ẩn tới khi nộp; chấm phía server với RLS đầy đủ — không gian lận.",
  },
  {
    icon: Sparkles,
    title: "Giải thích bằng AI",
    desc: "Một chạm để AI giải thích vì sao đúng/sai cho từng câu, tiếng Việt ngắn gọn.",
  },
  {
    icon: Bot,
    title: "Sinh đề bằng AI",
    desc: "Nhập kiến thức → AI tạo 10 câu TOEIC/IELTS, tự tráo đáp án ngẫu nhiên.",
  },
  {
    icon: NotebookPen,
    title: "Ghi chú Markdown",
    desc: "Tổng hợp ngữ pháp theo từng đề, soạn Markdown + xem trước, lưu riêng bạn.",
  },
  {
    icon: FileUp,
    title: "Import từ CSV",
    desc: "Nhập đề hàng loạt từ file CSV, xem trước và kiểm tra lỗi trước khi lưu.",
  },
];

const SHOWCASE = [
  {
    img: "/screens/quiz.png",
    tag: "Làm bài",
    title: "Trải nghiệm làm bài mượt mà",
    desc: "Chọn đáp án, theo dõi tiến độ, nộp bài chỉ trong một màn hình gọn gàng, tối ưu cả trên điện thoại.",
  },
  {
    img: "/screens/result-ai.png",
    tag: "Kết quả + AI",
    title: "Xem lại đáp án, hỏi AI ngay",
    desc: "Mỗi câu có nút giải thích AI và tra Google. Hiểu sâu lỗi sai thay vì chỉ biết đúng/sai.",
  },
  {
    img: "/screens/ai-gen.png",
    tag: "Generate with AI",
    title: "Tạo đề riêng trong vài giây",
    desc: "Nhập trọng tâm kiến thức và chọn TOEIC/IELTS — AI sinh ngay 10 câu chuẩn định dạng để luyện.",
  },
  {
    img: "/screens/notes.png",
    tag: "Ghi chú",
    title: "Sổ tay ôn tập của riêng bạn",
    desc: "Ghi lại quy tắc, bẫy ngữ pháp bằng Markdown cho từng đề và ôn lại bất cứ lúc nào.",
  },
];

export default function LandingPage() {
  return (
    <main className="lp">
      <header className="lp-nav">
        <div className="wrap row">
          <span className="brand">
            <span className="dot" />
            <span>
              TOEIC <span className="serif" style={{ color: "var(--accent-deep)" }}>Trainer</span>
            </span>
          </span>
          <Link href="/login" className="btn btn-primary no-lift">
            Đăng nhập
          </Link>
        </div>
      </header>

      {/* Hero */}
      <section className="lp-hero wrap">
        <div className="lp-hero-text">
          <span className="lp-badge">
            <GraduationCap size={15} /> TOEIC • IELTS • AI
          </span>
          <h1>
            Luyện đề tiếng Anh <span className="hl">thông minh</span> cùng AI
          </h1>
          <p>
            Làm đề, được chấm an toàn, và để AI giải thích từng câu. Tự sinh đề theo kiến thức của
            bạn, ghi chú ôn tập và theo dõi tiến bộ — tất cả trong một nơi.
          </p>
          <div className="lp-cta">
            <Link href="/login" className="btn btn-accent no-lift">
              Bắt đầu miễn phí <ArrowRight size={16} />
            </Link>
            <a href="#features" className="btn btn-ghost">
              Khám phá tính năng
            </a>
          </div>
          <div className="lp-stats">
            <div>
              <b>TOEIC & IELTS</b>
              <span>Hai định dạng đề</span>
            </div>
            <div>
              <b>AI</b>
              <span>Giải thích & sinh đề</span>
            </div>
            <div>
              <b>100%</b>
              <span>Chấm điểm an toàn</span>
            </div>
          </div>
        </div>
        <div className="lp-hero-shot">
          <div className="lp-frame floaty">
            <div className="lp-frame-bar">
              <i /><i /><i />
            </div>
            <img src="/screens/dashboard.png" alt="Bảng điều khiển TOEIC Trainer" />
          </div>
        </div>
      </section>

      {/* Features */}
      <section id="features" className="lp-section wrap">
        <Reveal className="lp-section-head">
          <h2>Mọi thứ bạn cần để luyện đề hiệu quả</h2>
          <p>Từ chấm điểm an toàn đến AI hỗ trợ học sâu.</p>
        </Reveal>
        <div className="lp-feature-grid">
          {FEATURES.map((f, i) => {
            const Icon = f.icon;
            return (
              <Reveal key={f.title} delay={i * 70} className="lp-feature">
                <span className="lp-feature-ic">
                  <Icon size={20} />
                </span>
                <h3>{f.title}</h3>
                <p>{f.desc}</p>
              </Reveal>
            );
          })}
        </div>
      </section>

      {/* Showcase */}
      <section className="lp-section wrap">
        {SHOWCASE.map((s, i) => (
          <Reveal key={s.title} className={`lp-show${i % 2 ? " alt" : ""}`}>
            <div className="lp-show-text">
              <span className="lp-tag">{s.tag}</span>
              <h3>{s.title}</h3>
              <p>{s.desc}</p>
            </div>
            <div className="lp-show-shot">
              <div className="lp-frame">
                <div className="lp-frame-bar">
                  <i /><i /><i />
                </div>
                <img src={s.img} alt={s.title} loading="lazy" />
              </div>
            </div>
          </Reveal>
        ))}
      </section>

      {/* Final CTA */}
      <section className="lp-final">
        <Reveal>
          <h2>Sẵn sàng nâng điểm của bạn?</h2>
          <p>Tạo tài khoản và bắt đầu luyện đề ngay hôm nay — hoàn toàn miễn phí.</p>
          <Link href="/login" className="btn btn-accent">
            Bắt đầu ngay <ArrowRight size={16} />
          </Link>
        </Reveal>
      </section>
    </main>
  );
}
