import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { ReviewersBrowser, type ReviewerEntry } from "./reviewers-browser";
import { PageHeader } from "@/components/page-header";
import { RequestTranscription } from "@/components/request-transcription";

type ReviewerEntryRow = Pick<
  ReviewerEntry,
  "id" | "kind" | "title" | "formula" | "variables" | "symbol" | "value" | "unit" | "table_content" | "description" | "notes" | "source" | "topic_id" | "subtopic_id"
>;

export default async function ReviewersPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [entries, { data: topics }, { data: examAreas }, { data: subtopics }, { data: subjects }] =
    await Promise.all([
      // reviewer_entries is well past PostgREST's 1000-row default cap —
      // a plain `.select()` silently truncates the alphabetically-ordered
      // result, dropping every title past the cutoff (e.g. all of PAES
      // 5xx/6xx). Paginated, same as /admin/reviewers.
      fetchAllRows<ReviewerEntryRow>((from, to) =>
        supabase
          .from("reviewer_entries")
          .select("id, kind, title, formula, variables, symbol, value, unit, table_content, description, notes, source, topic_id, subtopic_id")
          .eq("status", "published")
          .order("title")
          .range(from, to),
      ),
      supabase.from("topics").select("id, name, exam_area_id, subject_id"),
      supabase.from("exam_areas").select("id, name, sort_order"),
      supabase.from("subtopics").select("id, name"),
      supabase.from("subjects").select("id, name"),
    ]);

  const topicById = new Map((topics ?? []).map((t) => [t.id, t]));
  const areaById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));
  const subtopicById = new Map((subtopics ?? []).map((s) => [s.id, s.name]));
  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const rows: ReviewerEntry[] = entries.map((e) => {
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
    <div className="mx-auto max-w-6xl">
      <PageHeader
        title="Reviewers"
        description="Quick-reference tables, formulas, and constants — filterable by area and topic."
        action={<RequestTranscription />}
      />

      <ReviewersBrowser entries={rows} initialSearch={q ?? ""} />
    </div>
  );
}
