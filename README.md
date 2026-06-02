# TOEIC Trainer — Next.js + Supabase

🔗 **Live demo:** https://toeic-trainer-rose.vercel.app

Web app luyện đề tiếng Anh (TOEIC / IELTS): chọn đề → làm bài → **chấm điểm phía server** → xem lại đáp án (kèm **AI giải thích**) → **lưu điểm & lịch sử qua từng lần làm**. Hỗ trợ import đề bằng CSV, sinh đề bằng AI, và ghi chú Markdown cho từng đề.

## Tính năng
- **Đăng nhập email + mật khẩu** qua Supabase Auth (`signUp` / `signInWithPassword`). Xác nhận email là tuỳ chọn (bật/tắt ở Supabase).
- **Landing page công khai** + **dashboard danh sách đề** (cần đăng nhập), mỗi đề kèm điểm cao nhất / số lần làm / sparkline tiến bộ.
- **Hai dạng câu hỏi**: trắc nghiệm (MCQ) và điền từ (text).
- **Làm bài**: chọn đáp án, thanh tiến độ, nộp bài.
- **Chấm điểm trên server** (RPC `submit_attempt`) — client không bao giờ thấy đáp án đúng trước khi nộp (view `choices_public` ẩn cột `is_correct`).
- **Kết quả + xem lại** từng câu (RPC `get_attempt_review`, chỉ lộ đáp án cho chính chủ), kèm **nút AI giải thích** (Gemini) và tra Google.
- **Import đề từ CSV** + **sinh đề bằng AI** (modal "Generate with AI").
- **Ghi chú Markdown** cho từng đề (mỗi user 1 note/đề).
- **Quản lý đề của mình**: đổi tên / xoá (đề hệ thống không sửa/xoá được).

## Stack
- **Next.js 14** (App Router, JavaScript — không dùng TypeScript), **React 18**.
- **Supabase** (Postgres + Auth + RLS) qua `@supabase/ssr`.
- **lucide-react** (icon), **marked** (render Markdown).
- **Google Gemini** (REST, server-only) cho giải thích đáp án & sinh đề.

## Yêu cầu
- Node.js 18.18+ (khuyến nghị 20+)
- Một project Supabase miễn phí
- (Tuỳ chọn) API key Google Gemini cho tính năng AI

## Cài đặt

### 1. Tạo project Supabase & nạp database
Cách khuyến nghị — dùng Supabase CLI (đã link project):
```bash
supabase db push   # áp toàn bộ migration trong supabase/migrations/
```
Hoặc mở **SQL Editor** của Supabase và chạy lần lượt các file trong `supabase/` (`01_schema.sql`, `02_functions.sql`, `03_seed.sql`, `04_seed_extra.sql`).

### 2. Cấu hình Auth
Supabase → **Authentication → Providers → Email**: bật **Email** (mặc định đã bật, dùng email + mật khẩu).
Nếu bật xác nhận email, thêm URL redirect trong **Authentication → URL Configuration**:
- Site URL: `http://localhost:3000`
- Redirect URLs: `http://localhost:3000/auth/confirm` (và URL production sau này)

### 3. Biến môi trường
```bash
cp .env.local.example .env.local
```
Điền vào `.env.local`:
- `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY` (Supabase → Project Settings → API)
- `GEMINI_API_KEY` (lấy tại https://aistudio.google.com) — **server-only**, không có tiền tố `NEXT_PUBLIC`
- `GEMINI_MODEL` (tuỳ chọn, mặc định `gemini-2.5-flash-lite`)

### 4. Chạy
```bash
npm install
npm run dev
```
Mở http://localhost:3000 → đăng ký / đăng nhập bằng email + mật khẩu → vào app.

## Cấu trúc
```
app/
  layout.js                      # bố cục + topbar (hiện khi đã đăng nhập) + footer
  page.js                        # landing page công khai (CTA → /login)
  login/page.js                  # đăng nhập / đăng ký (email + mật khẩu)
  auth/confirm/route.js          # xác nhận email (verifyOtp)
  auth/signout/route.js          # đăng xuất
  exams/page.js                  # dashboard danh sách đề
  exam/[examId]/page.js          # chi tiết đề + lịch sử + ghi chú
  exam/[examId]/take/            # làm bài (page.js tải câu hỏi ẩn đáp án, take-form.js là UI)
  result/[attemptId]/            # kết quả + xem lại (review-item.js: AI giải thích, tra Google)
  import/                        # import CSV (page.js) + sinh đề AI (ai-gen-modal.js)
  actions.js                     # server actions: submit/grade, import/delete/rename, note, Gemini
components/                      # topbar, footer, reveal, sparkline
lib/supabase/                    # client / server / middleware
lib/csv.js                       # parser CSV (không phụ thuộc thư viện)
middleware.js                    # refresh session + chặn route khi chưa đăng nhập
supabase/                        # SQL: schema, functions, seed + migrations/
```

## Bảo mật (tóm tắt)
- RLS bật trên mọi bảng; user chỉ đọc/ghi `attempts`, `attempt_answers`, `exam_notes` của mình.
- Bảng `choices` **không** mở SELECT cho user thường → client đọc qua view `choices_public` (ẩn `is_correct`). Chấm điểm hoàn toàn ở server.
- Ghi DB vượt RLS qua hàm `SECURITY DEFINER` đã kiểm tra `auth.uid()` (`submit_attempt`, `get_attempt_review`, `import_exam`, `delete_exam`, `update_exam_title`).
- Phân quyền theo `exams.created_by`: chỉ chủ đề mới sửa/xoá; đề seed (`created_by` NULL) là đề hệ thống, không sửa/xoá được.
- `GEMINI_API_KEY` chỉ ở server (không `NEXT_PUBLIC`).

## Triển khai
Đẩy lên GitHub → import vào **Vercel** → thêm biến môi trường (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `GEMINI_API_KEY`, `GEMINI_MODEL`) → thêm domain Vercel vào Redirect URLs của Supabase (nếu bật xác nhận email).
