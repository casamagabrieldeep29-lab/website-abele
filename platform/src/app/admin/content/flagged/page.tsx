import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { QuestionCard } from "../question-card";

const ALL_AREAS = ["area_1", "area_2", "area_3"] as const;
const DEFAULT_PAGE_SIZE = 50;

/**
 * Every question across every topic whose explanation carries the
 * "[FLAGGED FOR REVIEW: ...]" marker (see generate-import-sql.js's
 * `flag` handling), gathered in one place instead of admin having to
 * stumble onto them topic by topic. These are deliberately excluded from
 * publishAllInTopic/publishAllDrafts — they need a human look, then an
 * edit to clear the marker, before they're eligible for bulk publishing.
 */
export default async function FlaggedQuestionsPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; topicId?: string }>;
}) {
  await requireAdmin();
  const supabase = await createClient();
  const { q, topicId: topicFilter } = await searchParams;

  const [{ data: questions }, { data: topics }] = await Promise.all([
    supabase
      .from("questions")
      .select(
        "id, question_text, difficulty, status, explanation, additional_mock_areas, series_key, series_position, category, is_recalled, recalled_batch, is_paes, paes_reference, topic_id, topics(name, mock_area), choices(id, choice_text, is_correct, sort_order)"
      )
      .ilike("explanation", "%FLAGGED FOR REVIEW%")
      .neq("status", "archived")
      .order("created_at"),
    supabase.from("topics").select("id, name").order("name"),
  ]);

  const allFlagged = questions ?? [];

  // 195 flagged questions and growing across every topic — rendering all of
  // them as full edit-forms unfiltered is the same slowness pattern fixed
  // on /admin/reviewers. Search/topic narrow it; unfiltered defaults to the
  // most recent 50.
  const query = q?.trim().toLowerCase();
  const hasFilter = Boolean(query || topicFilter);
  const filtered = allFlagged.filter((question) => {
    if (topicFilter && question.topic_id !== topicFilter) return false;
    if (query && !question.question_text.toLowerCase().includes(query)) return false;
    return true;
  });
  const flagged = hasFilter ? filtered : filtered.slice(0, DEFAULT_PAGE_SIZE);

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Content Review</span>
        <Link href="/admin/content" className="text-sm text-muted-foreground hover:underline">
          Back to topics
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10">
        <h1 className="text-2xl font-semibold">Flagged Questions</h1>
        <p className="mt-1 text-sm text-muted-foreground">
          Questions whose source material flagged uncertainty about the answer or content. These are
          excluded from Publish All Drafts and per-topic bulk publishing — review each one, edit its
          explanation to remove the flag once resolved, then publish it individually.
        </p>

        <form className="mt-4 flex flex-wrap gap-2 rounded-md border border-border bg-muted/30 p-3">
          <input
            name="q"
            defaultValue={q ?? ""}
            placeholder="Search question text…"
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
            <Link href="/admin/content/flagged" className="self-center text-xs text-muted-foreground hover:underline">
              Clear
            </Link>
          )}
        </form>

        <p className="mt-2 text-xs text-muted-foreground">
          {hasFilter
            ? `${filtered.length} matching ${filtered.length === 1 ? "question" : "questions"} of ${allFlagged.length} total`
            : `Showing the ${flagged.length} most recent of ${allFlagged.length} total — search or filter above to see the rest.`}
        </p>

        <div className="mt-4 space-y-4">
          {flagged.map((q) => {
            const topic = q.topics as unknown as { name: string; mock_area: string } | null;
            const otherAreas = ALL_AREAS.filter((a) => a !== topic?.mock_area);
            return (
              <QuestionCard
                key={q.id}
                question={q}
                topicId={q.topic_id}
                otherAreas={otherAreas}
                topicLabel={topic ? { name: topic.name, href: `/admin/content/${q.topic_id}` } : undefined}
              />
            );
          })}

          {flagged.length === 0 && (
            <p className="text-sm text-muted-foreground">
              {hasFilter ? "No flagged questions match that search/filter." : "No flagged questions right now."}
            </p>
          )}
        </div>
      </div>
    </main>
  );
}
