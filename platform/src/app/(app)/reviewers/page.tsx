import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getPublishedReviewerEntries, getTaxonomy, toLightEntry } from "@/lib/shared-content";
import { buildEntryLookup } from "./entry-lookup";
import { ReviewersBrowser, type ReviewerEntry } from "./reviewers-browser";
import { PageHeader } from "@/components/page-header";
import { RequestTranscription } from "@/components/request-transcription";
import { Button } from "@/components/ui/button";
import { getSessionUser } from "@/lib/auth/session";

type ReviewerEntryRow = Pick<
  ReviewerEntry,
  "id" | "kind" | "title" | "formula" | "variables" | "symbol" | "value" | "unit" | "table_content" | "description" | "notes" | "source" | "topic_id" | "subtopic_id" | "has_details"
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
  const entries: ReviewerEntryRow[] = allEntries.map(toLightEntry);
  // Names are attached in the browser from this small lookup instead of being
  // copied onto every one of the ~2,000 entries (see entry-lookup.ts).
  const lookup = buildEntryLookup(taxonomy);

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

      <ReviewersBrowser entries={entries} lookup={lookup} initialSearch={q ?? ""} />
    </div>
  );
}
