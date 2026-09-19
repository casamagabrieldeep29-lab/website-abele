import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  createSubtopic,
  createTopic,
  deleteSubtopic,
  deleteTopic,
  renameSubtopic,
  renameTopic,
} from "./actions";

const MOCK_AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };

export default async function AdminTopicsPage() {
  await requireAdmin();
  const supabase = await createClient();

  const [{ data: examAreas }, { data: topics }, { data: subtopics }, { data: questionCounts }] = await Promise.all([
    supabase.from("exam_areas").select("id, name, sort_order").order("sort_order"),
    supabase.from("topics").select("id, name, exam_area_id, mock_area").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
    supabase.from("questions").select("topic_id, subtopic_id"),
  ]);

  const topicHasQuestions = new Set((questionCounts ?? []).map((q) => q.topic_id));
  const subtopicHasQuestions = new Set((questionCounts ?? []).map((q) => q.subtopic_id).filter(Boolean));

  const topicsByArea = new Map<string, typeof topics>();
  for (const t of topics ?? []) {
    const list = topicsByArea.get(t.exam_area_id) ?? [];
    list.push(t);
    topicsByArea.set(t.exam_area_id, list);
  }
  const subtopicsByTopic = new Map<string, typeof subtopics>();
  for (const s of subtopics ?? []) {
    const list = subtopicsByTopic.get(s.topic_id) ?? [];
    list.push(s);
    subtopicsByTopic.set(s.topic_id, list);
  }

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Topics &amp; Subtopics</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10 space-y-8">
        <p className="text-sm text-muted-foreground">
          The 8 official PRC exam areas are fixed (Table of Specifications) — only topics and subtopics within
          them are editable here. A topic can&apos;t be deleted while it still has published or draft questions.
        </p>

        {(examAreas ?? []).map((area) => (
          <div key={area.id}>
            <h2 className="text-sm font-semibold text-muted-foreground">{area.name}</h2>
            <div className="mt-2 space-y-3">
              {(topicsByArea.get(area.id) ?? []).map((topic) => (
                <Card key={topic.id}>
                  <CardContent className="py-3">
                    <div className="flex flex-wrap items-center gap-2">
                      <form action={renameTopic.bind(null, topic.id)} className="flex flex-wrap items-center gap-2">
                        <input
                          name="name"
                          defaultValue={topic.name}
                          className="min-w-[200px] flex-1 rounded-md border border-border bg-background px-2 py-1 text-sm"
                        />
                        <select
                          name="mockArea"
                          defaultValue={topic.mock_area}
                          className="rounded-md border border-border bg-background px-2 py-1 text-xs"
                        >
                          {Object.entries(MOCK_AREA_LABELS).map(([value, label]) => (
                            <option key={value} value={value}>
                              {label}
                            </option>
                          ))}
                        </select>
                        <Button type="submit" size="sm" variant="outline">
                          Save
                        </Button>
                      </form>
                      {!topicHasQuestions.has(topic.id) && (
                        <form action={deleteTopic.bind(null, topic.id)}>
                          <Button type="submit" size="sm" variant="ghost" className="text-destructive">
                            Delete
                          </Button>
                        </form>
                      )}
                    </div>

                    <ul className="mt-3 space-y-1.5 border-t pt-2">
                      {(subtopicsByTopic.get(topic.id) ?? []).map((s) => (
                        <li key={s.id} className="flex items-center gap-2 pl-3">
                          <form action={renameSubtopic.bind(null, s.id)} className="flex flex-1 items-center gap-2">
                            <input
                              name="name"
                              defaultValue={s.name}
                              className="min-w-[160px] flex-1 rounded-md border border-border bg-background px-2 py-1 text-xs"
                            />
                            <Button type="submit" size="sm" variant="outline" className="h-7 px-2 text-xs">
                              Save
                            </Button>
                          </form>
                          {!subtopicHasQuestions.has(s.id) && (
                            <form action={deleteSubtopic.bind(null, s.id)}>
                              <Button type="submit" size="sm" variant="ghost" className="h-7 px-2 text-xs text-destructive">
                                Delete
                              </Button>
                            </form>
                          )}
                        </li>
                      ))}
                    </ul>

                    <form action={createSubtopic.bind(null, topic.id)} className="mt-2 flex items-center gap-2 pl-3">
                      <input
                        name="name"
                        placeholder="New subtopic name"
                        className="min-w-[160px] flex-1 rounded-md border border-border bg-background px-2 py-1 text-xs"
                      />
                      <Button type="submit" size="sm" variant="ghost" className="h-7 px-2 text-xs">
                        + Add subtopic
                      </Button>
                    </form>
                  </CardContent>
                </Card>
              ))}
            </div>

            <form action={createTopic.bind(null, area.id)} className="mt-2 flex flex-wrap items-center gap-2">
              <input
                name="name"
                placeholder="New topic name"
                className="min-w-[200px] flex-1 rounded-md border border-border bg-background px-2 py-1 text-sm"
              />
              <select name="mockArea" defaultValue="area_3" className="rounded-md border border-border bg-background px-2 py-1 text-xs">
                {Object.entries(MOCK_AREA_LABELS).map(([value, label]) => (
                  <option key={value} value={value}>
                    {label}
                  </option>
                ))}
              </select>
              <Button type="submit" size="sm" variant="outline">
                + Add topic
              </Button>
            </form>
          </div>
        ))}
      </div>
    </main>
  );
}
