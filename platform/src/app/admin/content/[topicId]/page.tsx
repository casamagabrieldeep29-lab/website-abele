import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  archiveQuestion,
  createQuestion,
  publishAllInTopic,
  publishQuestion,
  setQuestionAdditionalMockAreas,
  unarchiveQuestion,
  unpublishQuestion,
  updateQuestion,
} from "../actions";

const ALL_AREAS = ["area_1", "area_2", "area_3"] as const;
const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };
const NEW_CHOICE_SLOTS = 4;

export default async function AdminTopicContentPage({
  params,
  searchParams,
}: {
  params: Promise<{ topicId: string }>;
  searchParams: Promise<{ showArchived?: string }>;
}) {
  await requireAdmin();
  const { topicId } = await params;
  const { showArchived } = await searchParams;
  const supabase = await createClient();

  const { data: topic } = await supabase
    .from("topics")
    .select("id, name, mock_area")
    .eq("id", topicId)
    .single();

  const { data: allQuestions } = await supabase
    .from("questions")
    .select("id, question_text, difficulty, status, explanation, additional_mock_areas, series_key, series_position, category, is_recalled, recalled_batch, choices(id, choice_text, is_correct, sort_order)")
    .eq("topic_id", topicId)
    .order("created_at");

  const otherAreas = ALL_AREAS.filter((a) => a !== topic?.mock_area);

  const questions = (allQuestions ?? []).filter((q) => showArchived || q.status !== "archived");
  const archivedCount = (allQuestions ?? []).filter((q) => q.status === "archived").length;
  const draftCount = questions.filter((q) => q.status === "draft").length;

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Content Review</span>
        <Link href="/admin/content" className="text-sm text-muted-foreground hover:underline">
          Back to topics
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10">
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
                href={showArchived ? `/admin/content/${topicId}` : `/admin/content/${topicId}?showArchived=1`}
                className="text-sm text-muted-foreground hover:underline"
              >
                {showArchived ? "Hide" : "Show"} {archivedCount} archived
              </Link>
            )}
            {draftCount > 0 && (
              <form action={publishAllInTopic.bind(null, topicId)}>
                <Button type="submit">Publish all {draftCount} drafts</Button>
              </form>
            )}
          </div>
        </div>

        <div className="mt-6 space-y-4">
          {questions.map((q) => {
            const choices = ((q.choices ?? []) as {
              id: string;
              choice_text: string;
              is_correct: boolean;
              sort_order: number;
            }[]).sort((a, b) => a.sort_order - b.sort_order);
            const isFlagged = q.explanation?.includes("FLAGGED FOR REVIEW");

            return (
              <Card key={q.id} className={isFlagged ? "border-destructive" : undefined}>
                <CardHeader>
                  <div className="flex items-center justify-between gap-2">
                    <CardTitle className="text-base font-medium">{q.question_text}</CardTitle>
                    <div className="flex shrink-0 gap-2">
                      {q.is_recalled && (
                        <Badge variant="outline" className="border-success/40 text-success">
                          Recalled{q.recalled_batch ? ` · ${q.recalled_batch}` : ""}
                        </Badge>
                      )}
                      {q.series_key && (
                        <Badge variant="outline" className="border-primary/40 text-primary">
                          {q.series_key} #{q.series_position ?? "?"}
                        </Badge>
                      )}
                      {q.category && (
                        <Badge variant="outline" className="border-gold/40 text-gold">
                          {q.category === "term" ? "Term" : "Solving"}
                        </Badge>
                      )}
                      <Badge variant="outline">{q.difficulty}</Badge>
                      <Badge variant={q.status === "published" ? "default" : "secondary"}>
                        {q.status}
                      </Badge>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <ul className="space-y-1 text-sm">
                    {choices.map((c) => (
                      <li
                        key={c.id}
                        className={c.is_correct ? "font-semibold text-primary" : "text-muted-foreground"}
                      >
                        {c.is_correct ? "✓ " : "— "}
                        {c.choice_text}
                      </li>
                    ))}
                  </ul>

                  {q.explanation && (
                    <p
                      className={`mt-3 text-xs ${isFlagged ? "font-medium text-destructive" : "text-muted-foreground"}`}
                    >
                      {q.explanation}
                    </p>
                  )}

                  <details className="mt-3 border-t pt-3">
                    <summary className="cursor-pointer text-xs font-medium text-primary">Edit question</summary>
                    <form action={updateQuestion.bind(null, q.id, topicId)} className="mt-3 space-y-3">
                      <div className="space-y-1">
                        <label className="text-xs font-medium text-muted-foreground">Question text</label>
                        <textarea
                          name="questionText"
                          defaultValue={q.question_text}
                          rows={2}
                          className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-xs font-medium text-muted-foreground">Choices (check the correct one)</label>
                        {choices.map((c) => (
                          <div key={c.id} className="flex items-center gap-2">
                            <input type="hidden" name="choiceId" value={c.id} />
                            <input
                              type="checkbox"
                              name="correctChoiceId"
                              value={c.id}
                              defaultChecked={c.is_correct}
                              className="h-3.5 w-3.5 rounded border-border"
                            />
                            <input
                              name="choiceText"
                              defaultValue={c.choice_text}
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
                            defaultValue={q.difficulty ?? ""}
                            className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                          >
                            <option value="easy">Easy</option>
                            <option value="medium">Medium</option>
                            <option value="hard">Hard</option>
                          </select>
                        </div>
                        <div className="space-y-1">
                          <label className="text-xs font-medium text-muted-foreground">
                            Category (for the Custom Quiz Builder&apos;s terms/solving filter)
                          </label>
                          <select
                            name="category"
                            defaultValue={q.category ?? ""}
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
                          defaultValue={q.explanation ?? ""}
                          rows={2}
                          className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                        />
                      </div>
                      <div className="grid grid-cols-[1fr_auto] gap-3">
                        <div className="space-y-1">
                          <label className="text-xs font-medium text-muted-foreground">
                            Series label (leave blank if standalone)
                          </label>
                          <input
                            name="seriesKey"
                            defaultValue={q.series_key ?? ""}
                            placeholder="e.g. Cylinder Displacement Problem"
                            className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                          />
                          <p className="text-[11px] text-muted-foreground">
                            Questions sharing the exact same label are treated as one connected series — never
                            split apart or reordered when a session shuffles questions.
                          </p>
                        </div>
                        <div className="space-y-1">
                          <label className="text-xs font-medium text-muted-foreground">Step #</label>
                          <input
                            name="seriesPosition"
                            type="number"
                            min={1}
                            defaultValue={q.series_position ?? ""}
                            placeholder="1"
                            className="w-20 rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                          />
                        </div>
                      </div>
                      <div className="space-y-1.5 rounded-md border border-border bg-muted/30 p-2">
                        <label className="flex items-center gap-2 text-xs font-medium">
                          <input
                            type="checkbox"
                            name="isRecalled"
                            defaultChecked={q.is_recalled}
                            className="h-3.5 w-3.5 rounded border-border"
                          />
                          Recalled question (from an actual past board exam, not a review-center book)
                        </label>
                        <input
                          name="recalledBatch"
                          defaultValue={q.recalled_batch ?? ""}
                          placeholder="Which exam sitting, e.g. September 2025 ABE Board Exam"
                          className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                        />
                      </div>
                      <Button type="submit" size="sm">
                        Save changes
                      </Button>
                    </form>
                  </details>

                  {otherAreas.length > 0 && (
                    <form
                      action={setQuestionAdditionalMockAreas.bind(null, q.id, topicId)}
                      className="mt-3 flex flex-wrap items-center gap-3 border-t pt-3"
                    >
                      <span className="text-xs text-muted-foreground">Also relevant to:</span>
                      {otherAreas.map((area) => (
                        <label key={area} className="flex items-center gap-1.5 text-xs">
                          <input
                            type="checkbox"
                            name="additionalMockAreas"
                            value={area}
                            defaultChecked={(q.additional_mock_areas ?? []).includes(area)}
                            className="h-3.5 w-3.5 rounded border-border"
                          />
                          {AREA_LABELS[area]}
                        </label>
                      ))}
                      <Button type="submit" size="sm" variant="ghost" className="h-6 px-2 text-xs">
                        Save
                      </Button>
                    </form>
                  )}

                  <div className="mt-4 flex gap-2">
                    {q.status === "draft" && (
                      <form action={publishQuestion.bind(null, q.id)}>
                        <Button type="submit" size="sm">
                          Publish
                        </Button>
                      </form>
                    )}
                    {q.status === "published" && (
                      <form action={unpublishQuestion.bind(null, q.id)}>
                        <Button type="submit" size="sm" variant="outline">
                          Unpublish
                        </Button>
                      </form>
                    )}
                    {q.status === "archived" ? (
                      <form action={unarchiveQuestion.bind(null, q.id, topicId)}>
                        <Button type="submit" size="sm" variant="outline">
                          Restore to draft
                        </Button>
                      </form>
                    ) : (
                      <form action={archiveQuestion.bind(null, q.id, topicId)}>
                        <Button type="submit" size="sm" variant="ghost" className="text-destructive">
                          Archive
                        </Button>
                      </form>
                    )}
                  </div>
                </CardContent>
              </Card>
            );
          })}
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
                  rows={2}
                  className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm"
                />
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
