import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

type QuestionRow = {
  id: string;
  topic_id: string;
  question_text: string;
  question_type: string;
  explanation: string | null;
  status: string;
  choices: { is_correct: boolean }[];
};

function normalize(text: string) {
  return text.trim().toLowerCase().replace(/\s+/g, " ");
}

export default async function AdminQualityPage() {
  await requireAdmin();
  const supabase = await createClient();

  // questions now has 2200+ rows — a plain `.select()` would silently cap at
  // PostgREST's 1000-row default, hiding quality issues (missing
  // explanation, no correct choice, duplicates) in everything past the cap.
  // Paginated.
  const questions = await fetchAllRows<QuestionRow>((from, to) =>
    supabase
      .from("questions")
      .select("id, topic_id, question_text, question_type, explanation, status, choices(is_correct)")
      .order("created_at")
      .range(from, to),
  );

  const rows = questions;

  const noExplanation = rows.filter((q) => !q.explanation || !q.explanation.trim());
  const noCorrectChoice = rows.filter((q) => q.choices.every((c) => !c.is_correct));
  const multipleCorrect = rows.filter(
    (q) => q.question_type === "single_choice" && q.choices.filter((c) => c.is_correct).length > 1,
  );

  const byNormalizedText = new Map<string, QuestionRow[]>();
  for (const q of rows) {
    const key = normalize(q.question_text);
    const list = byNormalizedText.get(key) ?? [];
    list.push(q);
    byNormalizedText.set(key, list);
  }
  const duplicateGroups = [...byNormalizedText.values()].filter((g) => g.length > 1);

  const sections = [
    {
      title: "No explanation",
      description: "Students won't get a real explanation after answering these.",
      rows: noExplanation,
    },
    {
      title: "No choice marked correct",
      description: "These can never be graded correctly — nothing to compare the student's answer against.",
      rows: noCorrectChoice,
    },
    {
      title: "Multiple correct choices on a single-choice question",
      description: "single_choice questions should have exactly one correct choice.",
      rows: multipleCorrect,
    },
  ];

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Content Quality</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10 space-y-8">
        <p className="text-sm text-muted-foreground">
          Automatic flags only — nothing here is auto-fixed. Every flag needs a human look, same as the rest of
          this project&apos;s content pipeline.
        </p>

        {sections.map((section) => (
          <div key={section.title}>
            <h2 className="text-sm font-semibold">
              {section.title} <Badge variant="secondary" className="ml-1">{section.rows.length}</Badge>
            </h2>
            <p className="text-xs text-muted-foreground">{section.description}</p>
            {section.rows.length > 0 ? (
              <div className="mt-2 space-y-2">
                {section.rows.map((q) => (
                  <Card key={q.id}>
                    <CardContent className="flex items-center justify-between gap-3 py-3">
                      <p className="text-sm">{q.question_text}</p>
                      <Link
                        href={`/admin/content/${q.topic_id}`}
                        className="shrink-0 text-xs font-medium text-primary hover:underline"
                      >
                        Review →
                      </Link>
                    </CardContent>
                  </Card>
                ))}
              </div>
            ) : (
              <p className="mt-2 text-sm text-muted-foreground">None found.</p>
            )}
          </div>
        ))}

        <div>
          <h2 className="text-sm font-semibold">
            Possible duplicate questions{" "}
            <Badge variant="secondary" className="ml-1">{duplicateGroups.length}</Badge>
          </h2>
          <p className="text-xs text-muted-foreground">
            Exact text matches after trimming/case-folding — near-duplicates with rewording won&apos;t be caught.
          </p>
          {duplicateGroups.length > 0 ? (
            <div className="mt-2 space-y-3">
              {duplicateGroups.map((group, i) => (
                <Card key={i}>
                  <CardHeader>
                    <CardTitle className="text-sm font-normal">{group[0].question_text}</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-1">
                    {group.map((q) => (
                      <div key={q.id} className="flex items-center justify-between gap-3 text-xs">
                        <Badge variant="outline">{q.status}</Badge>
                        <Link href={`/admin/content/${q.topic_id}`} className="text-primary hover:underline">
                          Review →
                        </Link>
                      </div>
                    ))}
                  </CardContent>
                </Card>
              ))}
            </div>
          ) : (
            <p className="mt-2 text-sm text-muted-foreground">None found.</p>
          )}
        </div>
      </div>
    </main>
  );
}
