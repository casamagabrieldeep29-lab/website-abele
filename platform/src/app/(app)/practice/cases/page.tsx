import { redirect } from "next/navigation";
import Link from "next/link";
import { getAuthContext } from "@/lib/auth/session";
import { getTaxonomy } from "@/lib/shared-content";
import { groupIntoUnits } from "@/lib/series";
import { startCaseProblems } from "@/app/practice/actions";
import { PageHeader } from "@/components/page-header";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

const SNIPPET_LENGTH = 160;

function snippet(text: string): string {
  const flat = text.replace(/\s+/g, " ").trim();
  return flat.length > SNIPPET_LENGTH ? `${flat.slice(0, SNIPPET_LENGTH).trimEnd()}…` : flat;
}

export default async function ConnectedProblemsPage() {
  const { supabase, user } = await getAuthContext();
  if (!user) redirect("/login");

  // Only the few questions that belong to a connected problem — never the whole bank.
  const [{ data: members }, taxonomy] = await Promise.all([
    supabase
      .from("student_questions")
      .select("id, series_key, series_position, topic_id, question_text")
      .not("series_key", "is", null),
    getTaxonomy(),
  ]);
  const topicName = new Map((taxonomy.topics ?? []).map((t) => [t.id, t.name]));

  const problems = groupIntoUnits(members ?? [])
    .map((parts) => ({ key: parts[0].series_key as string, opening: parts[0], topic: topicName.get(parts[0].topic_id) ?? "" }))
    .sort((a, b) => a.topic.localeCompare(b.topic) || a.key.localeCompare(b.key));

  return (
    <div className="mx-auto w-full max-w-4xl">
      <PageHeader
        title="Connected problems"
        description="Problems with follow-up questions. Each one is played in order: the opening question first, then every follow-up, with the problem statement kept in view."
      />
      <Link href="/practice" className="mt-2 inline-block text-sm text-muted-foreground hover:underline">
        ← Practice
      </Link>

      {problems.length === 0 ? (
        <p className="mt-6 text-sm text-muted-foreground">No connected problems published yet.</p>
      ) : (
        <>
          <form action={startCaseProblems.bind(null, undefined)} className="mt-5">
            <Button type="submit" size="sm">
              Play all in order →
            </Button>
          </form>

          <div className="mt-5 grid gap-3 sm:grid-cols-2">
            {problems.map((p) => (
              <Card key={p.key}>
                <CardHeader>
                  {p.topic && <p className="text-xs font-medium text-primary">{p.topic}</p>}
                  <CardTitle className="text-sm font-medium leading-relaxed">{snippet(p.opening.question_text)}</CardTitle>
                </CardHeader>
                <CardContent>
                  <form action={startCaseProblems.bind(null, p.key)}>
                    <Button type="submit" size="sm" variant="secondary">
                      Start →
                    </Button>
                  </form>
                </CardContent>
              </Card>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
