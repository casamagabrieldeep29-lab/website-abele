import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { ReviewerQuiz, type QuizEntry } from "@/components/reviewer-quiz";
import type { ReviewerEntry } from "@/app/(app)/reviewers/reviewers-browser";

export default async function FormulaQuizSessionPage({
  searchParams,
}: {
  searchParams: Promise<{ ids?: string }>;
}) {
  const { ids } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const idList = (ids ?? "").split(",").filter(Boolean);
  if (idList.length === 0) redirect("/reviewers/quiz");

  const [{ data: entries }, { data: topics }, { data: subtopics }, { data: progress }] = await Promise.all([
    supabase
      .from("reviewer_entries")
      .select("id, kind, title, formula, variables, symbol, value, unit, table_content, description, notes, source, topic_id, subtopic_id")
      .in("id", idList),
    supabase.from("topics").select("id, name"),
    supabase.from("subtopics").select("id, name"),
    supabase.from("reviewer_entry_progress").select("entry_id, is_saved").eq("user_id", user.id).in("entry_id", idList),
  ]);

  const topicById = new Map((topics ?? []).map((t) => [t.id, t.name]));
  const subtopicById = new Map((subtopics ?? []).map((s) => [s.id, s.name]));
  const savedIds = new Set((progress ?? []).filter((p) => p.is_saved).map((p) => p.entry_id));
  const entryById = new Map((entries ?? []).map((e) => [e.id, e]));

  const quizEntries: QuizEntry[] = idList
    .map((id) => entryById.get(id))
    .filter((e): e is NonNullable<typeof e> => Boolean(e))
    .map((e) => {
      const entry: ReviewerEntry = {
        ...e,
        topic_name: topicById.get(e.topic_id) ?? "Unknown topic",
        exam_area_id: "unknown",
        exam_area_name: "",
        subject_name: "",
        subtopic_name: e.subtopic_id ? (subtopicById.get(e.subtopic_id) ?? null) : null,
      };
      return { ...entry, isSaved: savedIds.has(e.id) };
    });

  if (quizEntries.length === 0) {
    return (
      <div className="mx-auto max-w-lg text-center">
        <p className="text-sm text-muted-foreground">These formulas are no longer available.</p>
        <Link href="/reviewers/quiz" className="mt-2 inline-block text-sm text-primary hover:underline">
          Back to Formula Trainer →
        </Link>
      </div>
    );
  }

  return <ReviewerQuiz entries={quizEntries} backHref="/reviewers/quiz" backLabel="Back to Formula Trainer" />;
}
