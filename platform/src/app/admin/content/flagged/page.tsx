import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { QuestionCard } from "../question-card";

const ALL_AREAS = ["area_1", "area_2", "area_3"] as const;

/**
 * Every question across every topic whose explanation carries the
 * "[FLAGGED FOR REVIEW: ...]" marker (see generate-import-sql.js's
 * `flag` handling), gathered in one place instead of admin having to
 * stumble onto them topic by topic. These are deliberately excluded from
 * publishAllInTopic/publishAllDrafts — they need a human look, then an
 * edit to clear the marker, before they're eligible for bulk publishing.
 */
export default async function FlaggedQuestionsPage() {
  await requireAdmin();
  const supabase = await createClient();

  const { data: questions } = await supabase
    .from("questions")
    .select(
      "id, question_text, difficulty, status, explanation, additional_mock_areas, series_key, series_position, category, is_recalled, recalled_batch, topic_id, topics(name, mock_area), choices(id, choice_text, is_correct, sort_order)"
    )
    .ilike("explanation", "%FLAGGED FOR REVIEW%")
    .neq("status", "archived")
    .order("created_at");

  const flagged = questions ?? [];

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

        <div className="mt-6 space-y-4">
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

          {flagged.length === 0 && <p className="text-sm text-muted-foreground">No flagged questions right now.</p>}
        </div>
      </div>
    </main>
  );
}
