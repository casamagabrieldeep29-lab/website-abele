import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getPublishedReviewerEntries, getTaxonomy } from "@/lib/shared-content";
import { PaesNumberBankBrowser, type PaesNumberBankEntry } from "./paes-number-bank-browser";
import { PageHeader } from "@/components/page-header";
import { derivePaesCategory } from "@/lib/paes-categories";
import { Button } from "@/components/ui/button";
import { getSessionUser } from "@/lib/auth/session";

// Constants are always "one number" (value + unit) — an obvious fit for a
// number bank. Table entries can't be reduced to a single number, but the
// current PAES content is overwhelmingly table-kind (space requirements,
// dimension standards, etc. — exactly the kind of quick-lookup content this
// page is for), so they're included too, just rendered as compact reference
// cards rather than a big single value. See PaesNumberBankBrowser.
const NUMBER_BANK_KINDS = ["constant", "table"] as const;

export default async function PaesNumberBankPage() {
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
  if (!user) redirect("/login");

  // The same shared, cached reviewer snapshot as /reviewers and the PAES Library
  // (this page used to re-download ~750 KB from Supabase on every visit).
  const [allEntries, taxonomy] = await Promise.all([getPublishedReviewerEntries(), getTaxonomy()]);
  const entries = allEntries.filter(
    (e) => e.paes_reference !== null && (NUMBER_BANK_KINDS as readonly string[]).includes(e.kind),
  );
  const { topics, examAreas, subtopics, subjects } = taxonomy;

  const topicById = new Map((topics ?? []).map((t) => [t.id, t]));
  const areaById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));
  const subtopicById = new Map((subtopics ?? []).map((s) => [s.id, s.name]));
  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const rows: PaesNumberBankEntry[] = (entries ?? [])
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
        title="PAES Number Bank"
        description="Scannable numeric quick-lookups — values, dimensions, and space requirements straight out of the PAES standards."
        action={<Button render={<Link href="/paes/numbers/quiz">Quiz Me →</Link>} nativeButton={false} size="sm" variant="secondary" />}
      />

      <PaesNumberBankBrowser entries={rows} />
    </div>
  );
}
