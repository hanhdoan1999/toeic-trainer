import Link from "next/link";
import { Upload } from "lucide-react";

export default function Topbar({ email }) {
  const initial = (email?.[0] || "B").toUpperCase();
  return (
    <header className="topbar">
      <div className="wrap row">
        <Link href="/exams" className="brand" style={{ textDecoration: "none", color: "inherit" }}>
          <span className="dot" />
          <span>
            TOEIC <span className="serif" style={{ color: "var(--accent-deep)" }}>Trainer</span>
          </span>
        </Link>
        <div className="spacer" />
        <Link
          href="/import"
          className="link-btn import-link"
          style={{ marginRight: 14, textDecoration: "none", display: "inline-flex", alignItems: "center", gap: 5 }}
        >
          <Upload size={14} /> Nhập đề
        </Link>
        <Link href="/history" className="userchip" title="Xem lịch sử làm bài" style={{ textDecoration: "none", color: "inherit" }}>
          <span className="av">{initial}</span>
          <span className="email">{email}</span>
        </Link>
        <form action="/auth/signout" method="post">
          <button type="submit" className="link-btn">Đăng xuất</button>
        </form>
      </div>
    </header>
  );
}
