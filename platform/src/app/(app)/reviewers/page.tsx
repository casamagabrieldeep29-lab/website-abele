import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { ReviewersBrowser, type ReviewerEntry } from "./reviewers-browser";
import { PageHeader } from "@/components/page-header";

export default async function ReviewersPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: entries, error }, { data: topics }, { data: examAreas }, { data: subtopics }, { data: subjects }] =
    await Promise.all([
      supabase
        .from("reviewer_entries")
        .select("id, kind, title, formula, variables, symbol, value, unit, table_content, description, notes, source, topic_id, subtopic_id")
        .eq("status", "published")
        .order("title"),
      supabase.from("topics").select("id, name, exam_area_id, subject_id"),
      supabase.from("exam_areas").select("id, name, sort_order"),
      supabase.from("subtopics").select("id, name"),
      supabase.from("subjects").select("id, name"),
    ]);

  if (error) {
    return (
      <p className="text-sm text-destructive">
        Couldn&apos;t load reviewer materials: {error.message}
      </p>
    );
  }

  const topicById = new Map((topics ?? []).map((t) => [t.id, t]));
  const areaById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));
  const subtopicById = new Map((subtopics ?? []).map((s) => [s.id, s.name]));
  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const rows: ReviewerEntry[] = (entries ?? []).map((e) => {
    const topic = topicById.get(e.topic_id);
    return {
      ...e,
      topic_name: topic?.name ?? "Unknown topic",
      exam_area_id: topic?.exam_area_id ?? "unknown",
      exam_area_name: topic ? (areaById.get(topic.exam_area_id) ?? "Unknown area") : "Unknown area",
      subject_name: topic?.subject_id ? (subjectNameById.get(topic.subject_id) ?? "Other Topics") : "Other Topics",
      subtopic_name: e.subtopic_id ? (subtopicById.get(e.subtopic_id) ?? null) : null,
    };
  });

  return (
    <div className="mx-auto max-w-3xl">
      <PageHeader
        title="Reviewers"
        description="Quick-reference tables, formulas, and constants — filterable by area and topic."
      />

      <ReviewersBrowser entries={rows} initialSearch={q ?? ""} />
    </div>
  );
}
