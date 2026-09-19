import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { startPracticeAttempt } from "@/app/practice/actions";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import { PageHeader } from "@/components/page-header";

export default async function PracticePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // PostgREST can't embed through a view via a topics(...) join, so fetch
  // topics and published-question counts separately and merge in JS.
  const [{ data: topics }, { data: publishedQuestions }] = await Promise.all([
    supabase.from("topics").select("id, name, exam_areas(name)").order("name"),
    supabase.from("student_questions").select("id, topic_id"),
  ]);

  const countByTopic = new Map<string, number>();
  for (const q of publishedQuestions ?? []) {
    countByTopic.set(q.topic_id, (countByTopic.get(q.topic_id) ?? 0) + 1);
  }

  return (
    <div className="mx-auto max-w-3xl">
      <PageHeader
        title="Practice"
        description="Pick a topic. Questions are answered one at a time with immediate feedback."
      />

      <div className="mt-6 space-y-3">
        {topics?.map((topic) => {
          const count = countByTopic.get(topic.id) ?? 0;
          const examAreaName = (topic.exam_areas as unknown as { name: string } | null)?.name;
          const accent = getHarmonizedAccent(examAreaName ?? topic.name);

          return (
            <Card key={topic.id} className={`border-l-4 ${accent.border} ${accent.bg}`}>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle>{topic.name}</CardTitle>
                    <CardDescription>{examAreaName}</CardDescription>
                  </div>
                  <Badge className={count > 0 ? accent.badge : undefined} variant={count > 0 ? undefined : "secondary"}>
                    {count} question{count === 1 ? "" : "s"}
                  </Badge>
                </div>
              </CardHeader>
              <CardContent>
                <form action={startPracticeAttempt.bind(null, topic.id)}>
                  <Button type="submit" disabled={count === 0} className="w-full">
                    {count === 0 ? "No published questions yet" : "Start practicing"}
                  </Button>
                </form>
              </CardContent>
            </Card>
          );
        })}

        {!topics?.length && (
          <p className="text-sm text-muted-foreground">No topics yet.</p>
        )}
      </div>
    </div>
  );
}
