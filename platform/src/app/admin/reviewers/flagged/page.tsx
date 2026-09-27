import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { ReviewerEntryCard, type ReviewerEntryRow } from "../reviewer-entry-card";

/**
 * Every reviewer_entry whose `notes` carries the "[FLAGGED FOR REVIEW: ...]"
 * marker — the PAES source standard itself had a genuine anomaly (e.g. a
 * formula contradicting its own method text, or a non-monotonic table)
 * that a human needs to look at. Mirrors /admin/content/flagged for
 * questions. Deliberately excluded from publishAllReviewerDrafts — clear
 * the marker from notes (or leave it and just fix the content) once
 * resolved, then publish individually.
 */
export default async function FlaggedReviewerEntriesPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; topicId?: string }>;
}) {
  await requireAdmin();
  const supabase = await createClient();
  const { q, topicId: topicFilter } = await searchParams;

  const [{ data: entries }, { data: topics }, { data: subtopics }] = await Promise.all([
    supabase.from("reviewer_entries").select("*").ilike("notes", "%FLAGGED FOR REVIEW%").order("created_at"),
    supabase.from("topics").select("id, name").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
  ]);

  const allFlagged = (entries ?? []) as ReviewerEntryRow[];

  const query = q?.trim().toLowerCase();
  const hasFilter = Boolean(query || topicFilter);
  const flagged = allFlagged.filter((e) => {
    if (topicFilter && e.topic_id !== topicFilter) return false;
    if (query && !e.title.toLowerCase().includes(query)) return false;
    return true;
  });

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Reviewer Materials</span>
        <Link href="/admin/reviewers" className="text-sm text-muted-foreground hover:underline">
          Back to reviewer materials
        </Link>
      </header>

      <div className="w-full px-6 py-10">
        <h1 className="text-2xl font-semibold">Flagged Reviewer Entries</h1>
        <p className="mt-1 text-sm text-muted-foreground">
          Entries whose PAES source standard itself had a genuine anomaly (a formula contradicting its own
          method text, a non-monotonic table, values that don&apos;t add up). These are excluded from Publish
          All Drafts — review each one, edit its notes/content once resolved, then publish individually.
        </p>

        <form className="mt-4 flex flex-wrap gap-2 rounded-md border border-border bg-muted/30 p-3">
          <input
            name="q"
            defaultValue={q ?? ""}
            placeholder="Search by title…"
            className="min-w-[10rem] flex-1 rounded-md border border-border bg-background px-2 py-1.5 text-sm"
          />
          <select name="topicId" defaultValue={topicFilter ?? ""} className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
            <option value="">All topics</option>
            {(topics ?? []).map((t) => (
              <option key={t.id} value={t.id}>
                {t.name}
              </option>
            ))}
          </select>
          <Button type="submit" size="sm">
            Filter
          </Button>
          {hasFilter && (
            <Link href="/admin/reviewers/flagged" className="self-center text-xs text-muted-foreground hover:underline">
              Clear
            </Link>
          )}
        </form>

        <p className="mt-2 text-xs text-muted-foreground">
          {hasFilter
            ? `${flagged.length} matching ${flagged.length === 1 ? "entry" : "entries"} of ${allFlagged.length} total`
            : `${allFlagged.length} flagged ${allFlagged.length === 1 ? "entry" : "entries"} total.`}
        </p>

        <div className="mt-4 space-y-4">
          {flagged.map((e) => (
            <ReviewerEntryCard key={e.id} e={e} topics={topics ?? []} subtopics={subtopics ?? []} />
          ))}
          {flagged.length === 0 && (
            <p className="text-sm text-muted-foreground">
              {hasFilter ? "No flagged entries match that search/filter." : "No flagged reviewer entries right now."}
            </p>
          )}
        </div>
      </div>
    </main>
  );
}
