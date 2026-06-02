# TOEIC Trainer — Next.js + Supabase

🔗 **Live demo:** https://toeic-trainer-rose.vercel.app

Web app luyện TOEIC Part 5: chọn đề → làm bài → nộp → **lưu điểm và lịch sử qua từng lần làm**.
Hỗ trợ nhiều đề, đăng nhập bằng magic link, chấm điểm phía server (an toàn), RLS đầy đủ.

## Tính năng
- Đăng nhập **magic link** (không mật khẩu) qua Supabase Auth.
- **Danh sách nhiều đề**, mỗi đề kèm điểm cao nhất / số lần làm / sparkline tiến bộ.
- **Chi tiết đề**: thống kê + lịch sử các lần làm (bấm vào để xem lại).
- **Làm bài**: chọn đáp án, thanh tiến độ, nộp bài.
- **Chấm điểm trên server** (RPC `submit_attempt`) — client không bao giờ thấy đáp án đúng trước khi nộp (view `choices_public` ẩn cột `is_correct`).
- **Kết quả + xem lại** từng câu (RPC `get_attempt_review`, chỉ lộ đáp án cho chính chủ).

## Yêu cầu
- Node.js 18.18+ (khuyến nghị 20+)
- Một project Supabase miễn phí

## Cài đặt

### 1. Tạo project Supabase & nạp database
Vào **SQL Editor** của Supabase và chạy lần lượt:
1. `supabase/01_schema.sql` — bảng + RLS + view ẩn đáp án
2. `supabase/02_functions.sql` — hàm chấm điểm & xem lại
3. `supabase/03_seed.sql` — Đề 1 (100 câu, sinh từ đề gốc)
4. `supabase/04_seed_extra.sql` — Đề 2 & 3 (nhỏ)

> Sinh lại seed Đề 1 nếu cần: `node supabase/_gen_seed.js đường/dẫn/de-thi-toeic.html`

### 2. Bật magic link
Supabase → **Authentication → Providers → Email**: bật "Email" (magic link mặc định đã bật).
Thêm URL redirect trong **Authentication → URL Configuration**:
- Site URL: `http://localhost:3000`
- Redirect URLs: `http://localhost:3000/auth/confirm` (và URL production sau này)

### 3. Biến môi trường
```bash
cp .env.local.example .env.local
```
Điền `NEXT_PUBLIC_SUPABASE_URL` và `NEXT_PUBLIC_SUPABASE_ANON_KEY` (Supabase → Project Settings → API).

### 4. Chạy
```bash
npm install
npm run dev
```
Mở http://localhost:3000 → nhập email → bấm link trong email → vào app.

## Cấu trúc
```
app/
  layout.js                 # bố cục + topbar (hiện khi đã đăng nhập)
  page.js                   # trang chủ: danh sách đề
  login/page.js             # form magic link
  auth/confirm/route.js     # xác thực token từ email
  auth/signout/route.js     # đăng xuất
  exam/[examId]/page.js          # chi tiết đề + lịch sử
  exam/[examId]/take/page.js     # tải câu hỏi (ẩn đáp án)
  exam/[examId]/take/take-form.js# UI chọn đáp án (client)
  result/[attemptId]/page.js     # kết quả + xem lại
  actions.js                # server action submitAttempt
lib/supabase/               # client / server / middleware
middleware.js               # refresh session + chặn route khi chưa đăng nhập
supabase/                   # SQL: schema, functions, seed
```

## Bảo mật (tóm tắt)
- RLS bật trên mọi bảng; user chỉ đọc/ghi `attempts` & `attempt_answers` của mình.
- Bảng `choices` **không** mở SELECT cho user thường → client đọc qua view `choices_public` (không có `is_correct`).
- Chấm điểm và lộ đáp án chỉ qua hàm `SECURITY DEFINER` đã kiểm tra `auth.uid()`.

## Lộ trình tiếp theo (v2)
Dữ liệu `attempt_answers` + cột `duration_seconds` đã có sẵn để làm: biểu đồ tiến bộ theo thời gian, phân tích câu/chủ điểm hay sai, đo thời gian làm bài.

## Triển khai
Đẩy lên GitHub → import vào **Vercel** → thêm 2 biến môi trường → thêm domain Vercel vào Redirect URLs của Supabase.
