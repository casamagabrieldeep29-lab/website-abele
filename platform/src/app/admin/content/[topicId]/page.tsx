import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { createQuestion, publishAllInTopic } from "../actions";
import { QuestionCard } from "../question-card";

const ALL_AREAS = ["area_1", "area_2", "area_3"] as const;
const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };
const NEW_CHOICE_SLOTS = 4;
const DEFAULT_PAGE_SIZE = 50;

export default async function AdminTopicContentPage({
  params,
  searchParams,
}: {
  params: Promise<{ topicId: string }>;
  searchParams: Promise<{ showArchived?: string; q?: string; status?: string }>;
}) {
  await requireAdmin();
  const { topicId } = await params;
  const { showArchived, q, status: statusFilter } = await searchParams;
  const supabase = await createClient();

  const { data: topic } = await supabase
    .from("topics")
    .select("id, name, mock_area")
    .eq("id", topicId)
    .single();

  const { data: allQuestions } = await supabase
    .from("questions")
    .select("id, question_text, difficulty, status, explanation, additional_mock_areas, series_key, series_position, category, is_recalled, recalled_batch, is_paes, paes_reference, choices(id, choice_text, is_correct, sort_order)")
    .eq("topic_id", topicId)
    .order("created_at");

  const otherAreas = ALL_AREAS.filter((a) => a !== topic?.mock_area);

  const questions = (allQuestions ?? []).filter((q) => showArchived || q.status !== "archived");
  const archivedCount = (allQuestions ?? []).filter((q) => q.status === "archived").length;
  const publishableDraftCount = questions.filter(
    (q) => q.status === "draft" && !q.explanation?.includes("FLAGGED FOR REVIEW")
  ).length;

  // A busy topic (some run 300+ questions) rendering every one as a full
  // edit-form made this page slow to open — same fix as /admin/reviewers:
  // search/status narrow the set, and an unfiltered view is capped to the
  // most recent 50 rather than everything.
  const query = q?.trim().toLowerCase();
  const hasFilter = Boolean(query || statusFilter);
  const filteredQuestions = questions.filter((question) => {
    if (statusFilter && question.status !== statusFilter) return false;
    if (query && !question.question_text.toLowerCase().includes(query)) return false;
    return true;
  });
  const visibleQuestions = hasFilter ? filteredQuestions : filteredQuestions.slice(0, DEFAULT_PAGE_SIZE);

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Content Review</span>
        <Link href="/admin/content" className="text-sm text-muted-foreground hover:underline">
          Back to topics
        </Link>
      </header>

      <div className="w-full px-6 py-10">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-semibold">{topic?.name}</h1>
            <p className="text-sm text-muted-foreground">
              Default mock exam area: {AREA_LABELS[topic?.mock_area ?? ""] ?? "—"}
            </p>
          </div>
          <div className="flex gap-2">
            {archivedCount > 0 && (
              <Link
                href={{
                  pathname: `/admin/content/${topicId}`,
                  query: { ...(q ? { q } : {}), ...(statusFilter ? { status: statusFilter } : {}), ...(showArchived ? {} : { showArchived: "1" }) },
                }}
                className="text-sm text-muted-foreground hover:underline"
              >
                {showArchived ? "Hide" : "Show"} {archivedCount} archived
              </Link>
            )}
            {publishableDraftCount > 0 && (
              <form action={publishAllInTopic.bind(null, topicId)}>
                <Button type="submit">Publish all {publishableDraftCount} drafts</Button>
              </form>
            )}
          </div>
        </div>

        <form className="mt-4 flex flex-wrap gap-2 rounded-md border border-border bg-muted/30 p-3">
          <input type="hidden" name="showArchived" value={showArchived ?? ""} />
          <input
            name="q"
            defaultValue={q ?? ""}
            placeholder="Search question text…"
            className="min-w-[10rem] flex-1 rounded-md border border-border bg-background px-2 py-1.5 text-sm"
          />
          <select name="status" defaultValue={statusFilter ?? ""} className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
            <option value="">Any status</option>
            <option value="draft">Draft</option>
            <option value="review">Review</option>
            <option value="published">Published</option>
            {showArchived && <option value="archived">Archived</option>}
          </select>
          <Button type="submit" size="sm">
            Filter
          </Button>
          {hasFilter && (
            <Link href={`/admin/content/${topicId}`} className="self-center text-xs text-muted-foreground hover:underline">
              Clear
            </Link>
          )}
        </form>

        <p className="mt-2 text-xs text-muted-foreground">
          {hasFilter
            ? `${filteredQuestions.length} matching ${filteredQuestions.length === 1 ? "question" : "questions"} of ${questions.length} shown`
            : `Showing the ${visibleQuestions.length} most recent of ${questions.length} — search or filter above to see the rest.`}
        </p>

        <div className="mt-4 space-y-4">
          {visibleQuestions.map((question) => (
            <QuestionCard key={question.id} question={question} topicId={topicId} otherAreas={otherAreas} />
          ))}
          {visibleQuestions.length === 0 && (
            <p className="text-sm text-muted-foreground">
              {hasFilter ? "No questions match that search/filter." : "No questions in this topic yet."}
            </p>
          )}
        </div>

        <Card className="mt-6">
          <CardHeader>
            <CardTitle className="text-base">Add a new question</CardTitle>
          </CardHeader>
          <CardContent>
            <form action={createQuestion.bind(null, topicId)} className="space-y-3">
              <div className="space-y-1">
                <label className="text-xs font-medium text-muted-foreground">Question text</label>
                <textarea
                  name="questionText"
                  required
                  rows={2}
                  className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                />
              </div>
              <div className="space-y-1">
                <label className="text-xs font-medium text-muted-foreground">Choices (check the correct one)</label>
                {Array.from({ length: NEW_CHOICE_SLOTS }).map((_, i) => (
                  <div key={i} className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      name="newCorrectIndex"
                      value={i}
                      className="h-3.5 w-3.5 rounded border-border"
                    />
                    <input
                      name="newChoiceText"
                      placeholder={`Choice ${i + 1}`}
                      className="flex-1 rounded-md border border-border bg-background px-2 py-1 text-sm"
                    />
                  </div>
                ))}
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Difficulty</label>
                  <select
                    name="difficulty"
                    defaultValue="medium"
                    className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                  >
                    <option value="easy">Easy</option>
                    <option value="medium">Medium</option>
                    <option value="hard">Hard</option>
                  </select>
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Category</label>
                  <select
                    name="category"
                    defaultValue=""
                    className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                  >
                    <option value="">Not set</option>
                    <option value="term">Term (definition/concept)</option>
                    <option value="solving">Solving (computation)</option>
                  </select>
                </div>
              </div>
              <div className="space-y-1">
                <label className="text-xs font-medium text-muted-foreground">Explanation</label>
                <textarea
                  name="explanation"
                  rows={4}
                  placeholder={"Renders as markdown. For a worked solution:\n### Step 1: ...\n```\nyield = 20,000 m2 × 0.60 kg/m2 = 12,000 kg\n```"}
                  className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                />
                <p className="mt-1 text-[11px] text-muted-foreground">
                  Supports markdown: <code>### Step 1: ...</code> headings and a fenced <code>```</code> block
                  render as a boxed calculation step, matching Teach Me This&apos;s formatting.
                </p>
              </div>
              <div className="grid grid-cols-[1fr_auto] gap-3">
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">
                    Series label (leave blank if standalone)
                  </label>
                  <input
                    name="seriesKey"
                    placeholder="e.g. Cylinder Displacement Problem"
                    className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                  />
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Step #</label>
                  <input
                    name="seriesPosition"
                    type="number"
                    min={1}
                    placeholder="1"
                    className="w-20 rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                  />
                </div>
              </div>
              <div className="space-y-1.5 rounded-md border border-border bg-muted/30 p-2">
                <label className="flex items-center gap-2 text-xs font-medium">
                  <input type="checkbox" name="isRecalled" className="h-3.5 w-3.5 rounded border-border" />
                  Recalled question (from an actual past board exam, not a review-center book)
                </label>
                <input
                  name="recalledBatch"
                  placeholder="Which exam sitting, e.g. September 2025 ABE Board Exam"
                  className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                />
              </div>
              <div className="space-y-1.5 rounded-md border border-border bg-muted/30 p-2">
                <label className="flex items-center gap-2 text-xs font-medium">
                  <input type="checkbox" name="isPaes" className="h-3.5 w-3.5 rounded border-border" />
                  PAES question (specifically tests a Philippine Agricultural Engineering Standard)
                </label>
                <input
                  name="paesReference"
                  placeholder="Which standard, e.g. PAES 204:2015"
                  className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                />
              </div>
              <Button type="submit" size="sm">
                Add question (as draft)
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>
    </main>
  );
}
