import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  deleteReviewerEntry,
  publishReviewerEntry,
  unpublishReviewerEntry,
  updateReviewerEntry,
} from "./actions";

const KIND_LABELS: Record<string, string> = { formula: "Formula", table: "Table", constant: "Constant" };

export type Topic = { id: string; name: string };
export type Subtopic = { id: string; name: string; topic_id: string };
export type ReviewerEntryRow = {
  id: string;
  kind: string;
  title: string;
  formula: string | null;
  variables: string | null;
  symbol: string | null;
  value: string | null;
  unit: string | null;
  table_content: string | null;
  description: string | null;
  notes: string | null;
  topic_id: string;
  subtopic_id: string | null;
  status: string;
};

export function TopicSubtopicFields({
  topics,
  subtopics,
  defaultTopicId,
  defaultSubtopicId,
}: {
  topics: Topic[];
  subtopics: Subtopic[];
  defaultTopicId?: string;
  defaultSubtopicId?: string | null;
}) {
  return (
    <div className="grid grid-cols-2 gap-2">
      <select name="topicId" defaultValue={defaultTopicId ?? ""} required className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
        <option value="" disabled>
          Topic…
        </option>
        {topics.map((t) => (
          <option key={t.id} value={t.id}>
            {t.name}
          </option>
        ))}
      </select>
      <select name="subtopicId" defaultValue={defaultSubtopicId ?? ""} className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
        <option value="">(no subtopic / concept)</option>
        {subtopics.map((s) => (
          <option key={s.id} value={s.id}>
            {s.name}
          </option>
        ))}
      </select>
    </div>
  );
}

/** One reviewer_entry's admin card — edit form, publish/unpublish, delete.
 * Shared between /admin/reviewers and /admin/reviewers/flagged so the two
 * pages can never drift on what an entry's admin controls look like. */
export function ReviewerEntryCard({
  e,
  topics,
  subtopics,
}: {
  e: ReviewerEntryRow;
  topics: Topic[];
  subtopics: Subtopic[];
}) {
  return (
    <Card>
      <CardContent className="py-3">
        <div className="flex items-center justify-between gap-2">
          <p className="text-sm font-medium">{e.title}</p>
          <div className="flex shrink-0 gap-2">
            {e.notes?.includes("FLAGGED FOR REVIEW") && <Badge variant="destructive">⚑ Flagged</Badge>}
            <Badge variant="outline">{KIND_LABELS[e.kind]}</Badge>
            <Badge variant={e.status === "published" ? "default" : "secondary"}>{e.status}</Badge>
          </div>
        </div>

        <details className="mt-2 border-t pt-2">
          <summary className="cursor-pointer text-xs font-medium text-primary">Edit</summary>
          <form action={updateReviewerEntry.bind(null, e.id)} className="mt-3 space-y-2">
            <select name="kind" defaultValue={e.kind} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm">
              <option value="formula">Formula</option>
              <option value="table">Table</option>
              <option value="constant">Constant</option>
            </select>
            <input name="title" defaultValue={e.title} placeholder="Title" required className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
            <TopicSubtopicFields topics={topics} subtopics={subtopics} defaultTopicId={e.topic_id} defaultSubtopicId={e.subtopic_id} />
            <input name="formula" defaultValue={e.formula ?? ""} placeholder="Formula (e.g. P = F × v)" className="w-full rounded-md border border-border bg-background px-2 py-1.5 font-mono text-sm" />
            <input name="variables" defaultValue={e.variables ?? ""} placeholder="Variables (e.g. P = power (kW), F = force (N))" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
            <div className="grid grid-cols-3 gap-2">
              <input name="symbol" defaultValue={e.symbol ?? ""} placeholder="Symbol" className="rounded-md border border-border bg-background px-2 py-1.5 font-mono text-sm" />
              <input name="value" defaultValue={e.value ?? ""} placeholder="Value" className="rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <input name="unit" defaultValue={e.unit ?? ""} placeholder="Unit" className="rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
            </div>
            <textarea
              name="tableContent"
              defaultValue={e.table_content ?? ""}
              placeholder={"Renders as a table when formatted as markdown:\n| Property | Symbol | Value | Unit |\n|---|---|---|---|\n| Density | ρ | 998.2 | kg/m³ |"}
              rows={4}
              className="w-full rounded-md border border-border bg-background px-2 py-1.5 font-mono text-xs"
            />
            <textarea name="description" defaultValue={e.description ?? ""} placeholder="Description" rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
            <input name="notes" defaultValue={e.notes ?? ""} placeholder="Notes / important reminders" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
            <Button type="submit" size="sm">
              Save changes
            </Button>
          </form>
        </details>

        <div className="mt-3 flex gap-2">
          {e.status === "draft" ? (
            <form action={publishReviewerEntry.bind(null, e.id)}>
              <Button type="submit" size="sm">
                Publish
              </Button>
            </form>
          ) : (
            <form action={unpublishReviewerEntry.bind(null, e.id)}>
              <Button type="submit" size="sm" variant="outline">
                Unpublish
              </Button>
            </form>
          )}
          <form action={deleteReviewerEntry.bind(null, e.id)}>
            <Button type="submit" size="sm" variant="ghost" className="text-destructive">
              Delete
            </Button>
          </form>
        </div>
      </CardContent>
    </Card>
  );
}
