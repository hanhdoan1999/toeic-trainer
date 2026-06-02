import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import TakeForm from "./take-form";

export const dynamic = "force-dynamic";

export default async function TakePage({ params }) {
  const supabase = createClient();
  const { examId } = params;

  const { data: exam } = await supabase
    .from("exams")
    .select("id, title")
    .eq("id", examId)
    .single();
  if (!exam) notFound();

  const { data: questions = [] } = await supabase
    .from("questions")
    .select("id, position, stem, level, type, context")
    .eq("exam_id", examId)
    .order("position", { ascending: true });

  // Only MCQ questions need choices; text questions are typed (no choices, and
  // accepted answers are never sent to the client).
  const mcqIds = questions.filter((q) => q.type !== "text").map((q) => q.id);
  const { data: choices = [] } = mcqIds.length
    ? await supabase
        .from("choices_public") // <-- no is_correct exposed to the client
        .select("id, question_id, label, content, position")
        .in("question_id", mcqIds)
        .order("position", { ascending: true })
    : { data: [] };

  const byQ = {};
  for (const c of choices) (byQ[c.question_id] ||= []).push(c);
  const full = questions.map((q) => ({ ...q, choices: byQ[q.id] || [] }));

  return (
    <section className="screen active">
      <div className="wrap">
        <div className="crumb">
          <Link href={`/exam/${examId}`}>← Quay lại đề</Link>
        </div>
        <h1 className="page">{exam.title}</h1>
        <p className="sub">Chọn một đáp án cho mỗi câu, rồi bấm Nộp bài.</p>
        <TakeForm examId={examId} questions={full} />
      </div>
    </section>
  );
}
