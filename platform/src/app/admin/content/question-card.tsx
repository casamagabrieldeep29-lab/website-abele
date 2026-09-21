import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  archiveQuestion,
  publishQuestion,
  setQuestionAdditionalMockAreas,
  unarchiveQuestion,
  unpublishQuestion,
  updateQuestion,
} from "./actions";

const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };

export type QuestionCardData = {
  id: string;
  question_text: string;
  difficulty: string | null;
  status: string;
  explanation: string | null;
  additional_mock_areas: string[] | null;
  series_key: string | null;
  series_position: number | null;
  category: string | null;
  is_recalled: boolean;
  recalled_batch: string | null;
  choices: { id: string; choice_text: string; is_correct: boolean; sort_order: number }[];
};

/**
 * One question's review card: badges, choices, the edit form, additional-
 * mock-area tagging, and publish/unpublish/archive actions. Shared between
 * the per-topic review page and the cross-topic Flagged Questions page —
 * `otherAreas` and an optional `topicLabel` are passed in rather than
 * derived, since the flagged page spans many topics (each with its own
 * mock_area) instead of a single topic's fixed otherAreas.
 */
export function QuestionCard({
  question: q,
  topicId,
  otherAreas,
  topicLabel,
}: {
  question: QuestionCardData;
  topicId: string;
  otherAreas: readonly string[];
  topicLabel?: { name: string; href: string };
}) {
  const choices = [...q.choices].sort((a, b) => a.sort_order - b.sort_order);
  const isFlagged = q.explanation?.includes("FLAGGED FOR REVIEW");

  return (
    <Card className={isFlagged ? "border-destructive" : undefined}>
      <CardHeader>
        <div className="flex items-center justify-between gap-2">
          <div className="min-w-0 flex-1">
            {topicLabel && (
              <Link href={topicLabel.href} className="text-xs text-muted-foreground hover:underline">
                {topicLabel.name} →
              </Link>
            )}
            <CardTitle className="text-base font-medium">{q.question_text}</CardTitle>
          </div>
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
            <Badge variant={q.status === "published" ? "default" : "secondary"}>{q.status}</Badge>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <ul className="space-y-1 text-sm">
          {choices.map((c) => (
            <li key={c.id} className={c.is_correct ? "font-semibold text-primary" : "text-muted-foreground"}>
              {c.is_correct ? "✓ " : "— "}
              {c.choice_text}
            </li>
          ))}
        </ul>

        {q.explanation && (
          <p className={`mt-3 text-xs ${isFlagged ? "font-medium text-destructive" : "text-muted-foreground"}`}>
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
              {isFlagged && (
                <p className="text-[11px] text-destructive">
                  This question is flagged because its explanation text contains &ldquo;FLAGGED FOR
                  REVIEW&rdquo;. Edit the explanation to remove that marker once you&apos;ve reviewed it
                  — it&apos;ll then be eligible for bulk publishing again.
                </p>
              )}
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
                  Questions sharing the exact same label are treated as one connected series — never split
                  apart or reordered when a session shuffles questions.
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
}
