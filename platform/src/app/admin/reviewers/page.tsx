import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { isAdminOnlyReviewerTitle } from "@/lib/flagged-questions";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { createReviewerEntry } from "./actions";
import { PublishAllReviewerDraftsButton } from "./publish-all-drafts-button";
import { ReviewerEntryCard, TopicSubtopicFields, type ReviewerEntryRow } from "./reviewer-entry-card";

const DEFAULT_PAGE_SIZE = 50;

export default async function AdminReviewersPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; topicId?: string; status?: string }>;
}) {
  await requireAdmin();
  const supabase = await createClient();
  const { q, topicId: topicFilter, status: statusFilter } = await searchParams;

  const [everyEntry, { data: topics }, { data: subtopics }] = await Promise.all([
    // reviewer_entries just crossed 1000 rows — a plain `.select()` would
    // silently cap at PostgREST's 1000-row default and hide the newest
    // entries from this admin management view. Paginated.
    fetchAllRows<ReviewerEntryRow>((from, to) =>
      supabase.from("reviewer_entries").select("*").order("created_at", { ascending: false }).range(from, to),
    ),
    supabase.from("topics").select("id, name").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
  ]);

  // Admin-only midterm reviewer rows live in their own section (/admin/reviewers/midterm), not in this list.
  const allEntries = everyEntry.filter((e) => !isAdminOnlyReviewerTitle(e.title));
  const adminOnlyCount = everyEntry.length - allEntries.length;
  const hasFilter = Boolean(q?.trim() || topicFilter || statusFilter);
  const query = q?.trim().toLowerCase();
  const filtered = allEntries.filter((e) => {
    if (topicFilter && e.topic_id !== topicFilter) return false;
    if (statusFilter && e.status !== statusFilter) return false;
    if (query && !e.title.toLowerCase().includes(query)) return false;
    return true;
  });
  // Rendering all 1000+ entries as full edit-forms in one page load is what
  // made this page slow to open — capped to a page's worth by default.
  // Filtering (search/topic/status) bypasses the cap entirely, since a
  // filtered result set is already the size the admin actually asked for.
  const entries = hasFilter ? filtered : filtered.slice(0, DEFAULT_PAGE_SIZE);
  const flaggedCount = allEntries.filter((e) => e.notes?.includes("FLAGGED FOR REVIEW")).length;

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Reviewer Materials</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="w-full px-6 py-10 space-y-4">
        <p className="text-sm text-muted-foreground">
          Tables, formulas, and constants for the student-facing Reviewers section. Never invent values — only
          enter verified content.
        </p>

        <div className="flex flex-wrap items-center gap-3">
          <PublishAllReviewerDraftsButton
            draftCount={
              allEntries.filter((e) => e.status === "draft" && !e.notes?.includes("FLAGGED FOR REVIEW")).length
            }
          />
          {adminOnlyCount > 0 && (
            <Link href="/admin/reviewers/midterm" className="inline-flex items-center gap-1.5 text-sm font-medium text-primary hover:underline">
              Midterm Reviewer (admin only, {adminOnlyCount} entries) →
            </Link>
          )}
          {flaggedCount > 0 && (
            <Link
              href="/admin/reviewers/flagged"
              className="inline-flex items-center gap-1.5 text-sm font-medium text-destructive hover:underline"
            >
              ⚑ {flaggedCount} flagged {flaggedCount === 1 ? "entry needs" : "entries need"} review →
            </Link>
          )}
        </div>

        <form className="flex flex-wrap gap-2 rounded-md border border-border bg-muted/30 p-3" action="/admin/reviewers">
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
          <select name="status" defaultValue={statusFilter ?? ""} className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
            <option value="">Any status</option>
            <option value="draft">Draft</option>
            <option value="published">Published</option>
          </select>
          <Button type="submit" size="sm">
            Filter
          </Button>
          {hasFilter && (
            <Link href="/admin/reviewers" className="self-center text-xs text-muted-foreground hover:underline">
              Clear
            </Link>
          )}
        </form>

        <p className="text-xs text-muted-foreground">
          {hasFilter
            ? `${filtered.length} matching ${filtered.length === 1 ? "entry" : "entries"} of ${allEntries.length} total`
            : `Showing the ${entries.length} most recent of ${allEntries.length} total — search or filter above to see the rest.`}
        </p>

        {entries.map((e) => (
          <ReviewerEntryCard key={e.id} e={e} topics={topics ?? []} subtopics={subtopics ?? []} />
        ))}
        {entries.length === 0 && (
          <p className="text-sm text-muted-foreground">
            {hasFilter ? "No entries match that search/filter." : "No reviewer materials yet."}
          </p>
        )}

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Add a reviewer entry</CardTitle>
          </CardHeader>
          <CardContent>
            <form action={createReviewerEntry} className="space-y-2">
              <select name="kind" defaultValue="formula" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm">
                <option value="formula">Formula</option>
                <option value="table">Table</option>
                <option value="constant">Constant</option>
              </select>
              <input name="title" placeholder="Title" required className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <TopicSubtopicFields topics={topics ?? []} subtopics={subtopics ?? []} />
              <input name="formula" placeholder="Formula (e.g. P = F × v)" className="w-full rounded-md border border-border bg-background px-2 py-1.5 font-mono text-sm" />
              <input name="variables" placeholder="Variables (e.g. P = power (kW), F = force (N))" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <div className="grid grid-cols-3 gap-2">
                <input name="symbol" placeholder="Symbol" className="rounded-md border border-border bg-background px-2 py-1.5 font-mono text-sm" />
                <input name="value" placeholder="Value" className="rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
                <input name="unit" placeholder="Unit" className="rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              </div>
              <textarea
                name="tableContent"
                placeholder={"Renders as a table when formatted as markdown:\n| Property | Symbol | Value | Unit |\n|---|---|---|---|\n| Density | ρ | 998.2 | kg/m³ |"}
                rows={4}
                className="w-full rounded-md border border-border bg-background px-2 py-1.5 font-mono text-xs"
              />
              <textarea name="description" placeholder="Description" rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <input name="notes" placeholder="Notes / important reminders" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <Button type="submit" size="sm">
                Add entry (as draft)
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>
    </main>
  );
}
