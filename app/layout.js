import "./globals.css";
import { createClient } from "@/lib/supabase/server";
import Topbar from "@/components/topbar";
import Footer from "@/components/footer";

export const metadata = {
  title: "TOEIC Trainer",
  description: "Luyện thi TOEIC Part 5 — lưu lịch sử điểm qua từng lần làm.",
};

export const viewport = {
  width: "device-width",
  initialScale: 1,
};

export default async function RootLayout({ children }) {
  const supabase = createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  return (
    <html lang="vi">
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
        <link
          href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap"
          rel="stylesheet"
        />
      </head>
      <body>
        {user && <Topbar email={user.email} />}
        {children}
        <Footer />
      </body>
    </html>
  );
}
