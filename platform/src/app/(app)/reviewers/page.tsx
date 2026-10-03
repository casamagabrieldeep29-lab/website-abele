import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getPublishedReviewerEntries, getTaxonomy } from "@/lib/shared-content";
import { ReviewersBrowser, type ReviewerEntry } from "./reviewers-browser";
import { PageHeader } from "@/components/page-header";
import { RequestTranscription } from "@/components/request-transcription";
import { Button } from "@/components/ui/button";
import { getSessionUser } from "@/lib/auth/session";

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
  const user = await getSessionUser(supabase);
  if (!user) redirect("/login");

  // ~2,000 entries / ~1.3 MB of text, identical for every student — served from
  // the shared cache (src/lib/shared-content.ts) instead of re-downloaded from
  // Supabase on every visit. The taxonomy is shared the same way.
  const [allEntries, taxonomy] = await Promise.all([getPublishedReviewerEntries(), getTaxonomy()]);
  const entries: ReviewerEntryRow[] = allEntries;
  const { topics, examAreas, subtopics, subjects } = taxonomy;

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
        action={
          <div className="flex flex-wrap items-center gap-2">
            <Button render={<Link href="/reviewers/quiz">Formula Trainer →</Link>} nativeButton={false} size="sm" variant="secondary" />
            <RequestTranscription />
          </div>
        }
      />

      <ReviewersBrowser entries={rows} initialSearch={q ?? ""} />
    </div>
  );
}
