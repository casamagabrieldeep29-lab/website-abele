import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  createReviewerEntry,
  deleteReviewerEntry,
  publishReviewerEntry,
  unpublishReviewerEntry,
  updateReviewerEntry,
} from "./actions";
import { PublishAllReviewerDraftsButton } from "./publish-all-drafts-button";

const KIND_LABELS: Record<string, string> = { formula: "Formula", table: "Table", constant: "Constant" };

type Topic = { id: string; name: string };
type Subtopic = { id: string; name: string; topic_id: string };
type ReviewerEntryRow = {
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

function TopicSubtopicFields({
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

export default async function AdminReviewersPage() {
  await requireAdmin();
  const supabase = await createClient();

  const [entries, { data: topics }, { data: subtopics }] = await Promise.all([
    // reviewer_entries just crossed 1000 rows — a plain `.select()` would
    // silently cap at PostgREST's 1000-row default and hide the newest
    // entries from this admin management view. Paginated.
    fetchAllRows<ReviewerEntryRow>((from, to) =>
      supabase.from("reviewer_entries").select("*").order("created_at", { ascending: false }).range(from, to),
    ),
    supabase.from("topics").select("id, name").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
  ]);

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Reviewer Materials</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10 space-y-4">
        <p className="text-sm text-muted-foreground">
          Tables, formulas, and constants for the student-facing Reviewers section. Never invent values — only
          enter verified content.
        </p>

        <PublishAllReviewerDraftsButton
          draftCount={(entries ?? []).filter((e) => e.status === "draft").length}
        />

        {(entries ?? []).map((e) => (
          <Card key={e.id}>
            <CardContent className="py-3">
              <div className="flex items-center justify-between gap-2">
                <p className="text-sm font-medium">{e.title}</p>
                <div className="flex shrink-0 gap-2">
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
                  <TopicSubtopicFields topics={topics ?? []} subtopics={subtopics ?? []} defaultTopicId={e.topic_id} defaultSubtopicId={e.subtopic_id} />
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
        ))}
        {(entries ?? []).length === 0 && <p className="text-sm text-muted-foreground">No reviewer materials yet.</p>}

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
