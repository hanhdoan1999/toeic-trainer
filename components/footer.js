import { Send } from "lucide-react";

export default function Footer() {
  return (
    <footer className="site-footer">
      <div className="wrap row">
        <span>© TOEIC Trainer</span>
        <a
          className="support-link"
          href="https://t.me/hanhdoan99"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Send size={15} /> Support: @hanhdoan99
        </a>
      </div>
    </footer>
  );
}
