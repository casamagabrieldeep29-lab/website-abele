import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { PaesLibraryBrowser, type PaesLibraryEntry } from "./paes-library-browser";
import { PageHeader } from "@/components/page-header";
import { derivePaesCategory } from "@/lib/paes-categories";

export default async function PaesLibraryPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // Same shape as /reviewers, plus paes_reference — this is what tells
  // published reviewer_entries apart as PAES Library content vs the
  // general Reviewers pool, and what the entries get grouped by below.
  const [{ data: entries, error }, { data: topics }, { data: examAreas }, { data: subtopics }, { data: subjects }] =
    await Promise.all([
      supabase
        .from("reviewer_entries")
        .select(
          "id, kind, title, formula, variables, symbol, value, unit, table_content, description, notes, source, topic_id, subtopic_id, paes_reference",
        )
        .eq("status", "published")
        .not("paes_reference", "is", null)
        .order("title"),
      supabase.from("topics").select("id, name, exam_area_id, subject_id"),
      supabase.from("exam_areas").select("id, name, sort_order"),
      supabase.from("subtopics").select("id, name"),
      supabase.from("subjects").select("id, name"),
    ]);

  if (error) {
    return (
      <p className="text-sm text-destructive">
        Couldn&apos;t load PAES Library: {error.message}
      </p>
    );
  }

  const topicById = new Map((topics ?? []).map((t) => [t.id, t]));
  const areaById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));
  const subtopicById = new Map((subtopics ?? []).map((s) => [s.id, s.name]));
  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const rows: PaesLibraryEntry[] = (entries ?? [])
    .filter((e): e is typeof e & { paes_reference: string } => Boolean(e.paes_reference))
    .map((e) => {
      const topic = topicById.get(e.topic_id);
      return {
        ...e,
        paes_reference: e.paes_reference,
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
