import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getPublishedReviewerEntries, getTaxonomy } from "@/lib/shared-content";
import { PaesLibraryBrowser, type PaesLibraryEntry } from "./paes-library-browser";
import { PageHeader } from "@/components/page-header";
import { derivePaesCategory } from "@/lib/paes-categories";
import { getSessionUser } from "@/lib/auth/session";

type PaesLibraryRow = Pick<
  PaesLibraryEntry,
  "id" | "kind" | "title" | "formula" | "variables" | "symbol" | "value" | "unit" | "table_content" | "description" | "notes" | "source" | "topic_id" | "subtopic_id" | "paes_reference"
>;

export default async function PaesLibraryPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
  if (!user) redirect("/login");

  // Same shape as /reviewers, plus paes_reference — this is what tells
  // published reviewer_entries apart as PAES Library content vs the
  // general Reviewers pool, and what the entries get grouped by below.
  // reviewer_entries is well past PostgREST's 1000-row default cap — a
  // plain `.select()` silently truncates the title-ordered result, and
  // since "PAES 6xx" titles sort late among the ~1100+ rows that pass this
  // filter, higher-numbered series (500/600) were the ones getting cut off.
  // Paginated, same as /reviewers and /admin/reviewers.
  // Same shared, cached snapshot the Reviewers page uses (one download for
  // everyone, not ~1 MB per visit) — the PAES subset is filtered here.
  const [allEntries, taxonomy] = await Promise.all([getPublishedReviewerEntries(), getTaxonomy()]);
  const entries = allEntries.filter((e) => e.paes_reference !== null) as PaesLibraryRow[];
  const { topics, examAreas, subtopics, subjects } = taxonomy;

  const topicById = new Map((topics ?? []).map((t) => [t.id, t]));
  const areaById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));
  const subtopicById = new Map((subtopics ?? []).map((s) => [s.id, s.name]));
  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const rows: PaesLibraryEntry[] = entries.map((e) => {
    const topic = topicById.get(e.topic_id);
    return {
      ...e,
      topic_name: topic?.name ?? "Unknown topic",
      exam_area_id: topic?.exam_area_id ?? "unknown",
      exam_area_name: topic ? (areaById.get(topic.exam_area_id) ?? "Unknown area") : "Unknown area",
      subject_name: topic?.subject_id ? (subjectNameById.get(topic.subject_id) ?? "Other Topics") : "Other Topics",
      subtopic_name: e.subtopic_id ? (subtopicById.get(e.subtopic_id) ?? null) : null,
      category: derivePaesCategory(e.paes_reference, e.title),
    };
  });

  return (
    <div className="mx-auto max-w-6xl">
      <PageHeader
        title="PAES Library"
        description="Official PAES standard numbers, grouped into per-standard quick-reference pages — formulas, tables, and constants sourced from the standards themselves."
      />

      <PaesLibraryBrowser entries={rows} initialSearch={q ?? ""} />
    </div>
  );
}
