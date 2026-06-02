"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

export default function LoginPage() {
  const router = useRouter();
  const [mode, setMode] = useState("signin"); // signin | signup
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [status, setStatus] = useState("idle"); // idle | working | error | confirm
  const [msg, setMsg] = useState("");

  async function submit() {
    if (!email.trim() || !password) return;
    setStatus("working");
    setMsg("");
    const supabase = createClient();

    if (mode === "signup") {
      const { data, error } = await supabase.auth.signUp({
        email: email.trim(),
        password,
      });
      if (error) {
        setStatus("error");
        setMsg(error.message);
        return;
      }
      // If email confirmation is OFF, a session is returned and we can go in.
      if (data.session) {
        router.push("/exams");
        router.refresh();
      } else {
        setStatus("confirm");
      }
      return;
    }

    const { error } = await supabase.auth.signInWithPassword({
      email: email.trim(),
      password,
    });
    if (error) {
      setStatus("error");
      setMsg(error.message);
    } else {
      router.push("/");
      router.refresh();
    }
  }

  return (
    <div className="login-wrap">
      <div className="login-card">
        <div className="logo serif">T</div>
        <h1>TOEIC Trainer</h1>

        <div className="field">
          <label>Email</label>
          <input
            type="email"
            placeholder="ban@example.com"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </div>

        <div className="field">
          <label>Mật khẩu</label>
          <input
            type="password"
            placeholder="Tối thiểu 6 ký tự"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && submit()}
          />
        </div>

        <button className="btn btn-primary" onClick={submit} disabled={status === "working"}>
          {status === "working"
            ? "Đang xử lý…"
            : mode === "signup"
            ? "Đăng ký"
            : "Đăng nhập"}
        </button>

        {status === "confirm" && (
          <div className="sent" style={{ display: "block" }}>
            ✓ Đã tạo tài khoản <b>{email}</b>. Hãy xác nhận email (nếu được bật) rồi đăng nhập.
          </div>
        )}
        {status === "error" && (
          <div className="sent" style={{ display: "block", background: "var(--red-bg)", color: "var(--red)" }}>
            Lỗi: {msg}
          </div>
        )}

        <div className="magic-note">
          {mode === "signin" ? (
            <>
              Chưa có tài khoản?{" "}
              <a onClick={() => { setMode("signup"); setStatus("idle"); setMsg(""); }} style={{ cursor: "pointer", color: "var(--accent-deep)", fontWeight: 600 }}>
                Đăng ký
              </a>
            </>
          ) : (
            <>
              Đã có tài khoản?{" "}
              <a onClick={() => { setMode("signin"); setStatus("idle"); setMsg(""); }} style={{ cursor: "pointer", color: "var(--accent-deep)", fontWeight: 600 }}>
                Đăng nhập
              </a>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
