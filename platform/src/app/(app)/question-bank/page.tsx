import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { checkIsAdmin } from "@/lib/auth/is-admin";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { startAdaptivePracticeAttempt, startSubtopicPracticeAttempt } from "@/app/practice/actions";
import { startFlashcardsByTopic } from "@/app/flashcards/actions";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import { PageHeader } from "@/components/page-header";

const SESSION_SIZE = 20;

export default async function QuestionBankPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const isAdmin = await checkIsAdmin(supabase, user.id);

  const [{ data: examAreas }, { data: topics }, { data: subtopics }, { data: published }] = await Promise.all([
    supabase.from("exam_areas").select("id, name, sort_order").order("sort_order"),
    supabase.from("topics").select("id, name, exam_area_id").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
    supabase.from("student_questions").select("topic_id, subtopic_id"),
  ]);

  const topicCount = new Map<string, number>();
  const subtopicCount = new Map<string, number>();
  for (const q of published ?? []) {
    topicCount.set(q.topic_id, (topicCount.get(q.topic_id) ?? 0) + 1);
    if (q.subtopic_id) subtopicCount.set(q.subtopic_id, (subtopicCount.get(q.subtopic_id) ?? 0) + 1);
  }

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
    <div className="mx-auto max-w-3xl space-y-6">
      <PageHeader
        title="Question Bank"
        description="Browse by subject, area, and concept. Drill into a specific concept to practice just that."
      />

      {(examAreas ?? []).map((area) => {
        const areaTopics = topicsByArea.get(area.id) ?? [];
        if (areaTopics.length === 0) return null;

        const accent = getHarmonizedAccent(area.name);

        return (
          <div key={area.id}>
            <h2 className="text-sm font-semibold text-muted-foreground">{area.name}</h2>
            <div className="mt-2 space-y-3">
              {areaTopics.map((topic) => {
                const tCount = topicCount.get(topic.id) ?? 0;
                const topicSubtopics = (subtopicsByTopic.get(topic.id) ?? []).filter(
                  (s) => (subtopicCount.get(s.id) ?? 0) > 0,
                );

                return (
                  <Card key={topic.id} className={`border-l-4 ${accent.border} ${accent.bg}`}>
                    <CardContent className="py-3">
                      <div className="flex items-center justify-between gap-3">
                        <p className="text-sm font-medium">{topic.name}</p>
                        <div className="flex items-center gap-2">
                          {isAdmin && (
                            <Badge className={tCount > 0 ? accent.badge : undefined} variant={tCount > 0 ? undefined : "secondary"}>{tCount} questions</Badge>
                          )}
                          <form action={startAdaptivePracticeAttempt.bind(null, topic.id, SESSION_SIZE)}>
                            <Button type="submit" size="sm" variant="outline" disabled={tCount === 0}>
                              Practice →
                            </Button>
                          </form>
                          <form action={startFlashcardsByTopic.bind(null, topic.id)}>
                            <Button type="submit" size="sm" variant="ghost">
                              Flashcards →
                            </Button>
                          </form>
                          <Button
                            render={<Link href={`/reviewers?q=${encodeURIComponent(topic.name)}`}>Reviewers →</Link>}
                            nativeButton={false}
                            size="sm"
                            variant="ghost"
                          />
                        </div>
                      </div>

                      {topicSubtopics.length > 0 && (
                        <ul className="mt-2 space-y-1.5 border-t pt-2">
                          {topicSubtopics.map((s) => (
                            <li key={s.id} className="flex items-center justify-between gap-3 pl-3 text-sm">
                              <span className="text-muted-foreground">{s.name}</span>
                              <div className="flex items-center gap-2">
                                {isAdmin && (
                                  <span className="text-xs text-muted-foreground">
                                    {subtopicCount.get(s.id)} questions
                                  </span>
                                )}
                                <form action={startSubtopicPracticeAttempt.bind(null, s.id, SESSION_SIZE)}>
                                  <Button type="submit" size="sm" variant="ghost">
                                    Practice →
                                  </Button>
                                </form>
                              </div>
                            </li>
                          ))}
                        </ul>
                      )}
                    </CardContent>
                  </Card>
                );
              })}
            </div>
          </div>
        );
      })}
    </div>
  );
}
