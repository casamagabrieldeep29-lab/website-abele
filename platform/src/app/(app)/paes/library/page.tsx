import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getPublishedReviewerEntries, getTaxonomy, toLightEntry } from "@/lib/shared-content";
import { buildEntryLookup } from "../../reviewers/entry-lookup";
import { PaesLibraryBrowser, type PaesLibraryEntry } from "./paes-library-browser";
import { PageHeader } from "@/components/page-header";
import { getSessionUser } from "@/lib/auth/session";

type PaesLibraryRow = Pick<
  PaesLibraryEntry,
  "id" | "kind" | "title" | "formula" | "variables" | "symbol" | "value" | "unit" | "table_content" | "description" | "notes" | "source" | "topic_id" | "subtopic_id" | "paes_reference" | "has_details"
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
  const entries = allEntries.filter((e) => e.paes_reference !== null).map(toLightEntry) as PaesLibraryRow[];
  // Names and categories are attached in the browser from this small lookup
  // instead of being copied onto every entry (see reviewers/entry-lookup.ts).
  const lookup = buildEntryLookup(taxonomy);

  return (
    <div className="mx-auto max-w-6xl">
      <PageHeader
        title="PAES Library"
        description="Official PAES standard numbers, grouped into per-standard quick-reference pages — formulas, tables, and constants sourced from the standards themselves."
      />

      <PaesLibraryBrowser entries={entries} lookup={lookup} initialSearch={q ?? ""} />
    </div>
  );
}
