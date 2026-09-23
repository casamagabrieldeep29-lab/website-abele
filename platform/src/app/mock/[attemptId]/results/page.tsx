import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { CheckCircle2, XCircle } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { TeachMeThis } from "@/components/teach-me-this";
import { AIMarkdown } from "@/components/ai-markdown";
import { studentFacingExplanation } from "@/lib/explanation";

type ReviewRow = {
  question_id: string;
  question_text: string;
  choices: { id: string; text: string; is_correct: boolean }[];
  selected_choice_ids: string[];
  is_correct: boolean;
  explanation: string | null;
};

export default async function MockExamResultsPage({
  params,
}: {
  params: Promise<{ attemptId: string }>;
}) {
  const { attemptId } = await params;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: attempt } = await supabase
    .from("attempts")
    .select("id, status, total_questions, correct_count")
    .eq("id", attemptId)
    .eq("user_id", user.id)
    .single();

  if (!attempt) notFound();
  if (attempt.status !== "completed") redirect(`/mock/${attemptId}`);

  const { data: review, error } = await supabase.rpc("get_attempt_review", {
    p_attempt_id: attemptId,
  });

  if (error) {
    return <p className="p-10 text-sm text-destructive">Couldn&apos;t load results: {error.message}</p>;
  }

  const rows = (review ?? []) as ReviewRow[];
  const percent = attempt.total_questions
    ? Math.round((attempt.correct_count / attempt.total_questions) * 100)
    : 0;

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <Link href="/dashboard" className="text-lg font-bold text-primary">
          ABELIEVER
        </Link>
        <Link href="/mock" className="text-sm text-muted-foreground hover:underline">
          New mock exam
        </Link>
      </header>

      <div className="mx-auto max-w-2xl px-6 py-10">
        <Card>
          <CardHeader>
            <CardTitle>Results</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-baseline gap-3">
              <p className="text-3xl font-semibold text-primary">{percent}%</p>
              <p className="text-sm text-muted-foreground">
                {attempt.correct_count} of {attempt.total_questions} correct
              </p>
            </div>
            <div className="mt-4 flex flex-wrap gap-2">
              <Button render={<Link href="/mistakes">Review mistakes</Link>} nativeButton={false} />
              <Button render={<Link href="/dashboard">Back to Dashboard</Link>} nativeButton={false} variant="outline" />
            </div>
          </CardContent>
        </Card>

        <h2 className="mt-8 text-lg font-semibold">Question review</h2>
        <div className="mt-4 space-y-4">
          {rows.map((row, i) => (
            <Card key={row.question_id} className={row.is_correct ? undefined : "border-destructive"}>
              <CardHeader>
                <CardTitle className="text-base font-medium leading-relaxed">
                  {i + 1}. {row.question_text}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ul className="space-y-1 text-sm">
                  {row.choices.map((c) => {
                    const wasSelected = row.selected_choice_ids?.includes(c.id);
                    return (
                      <li
                        key={c.id}
                        className={`flex items-center gap-1.5 ${
                          c.is_correct
                            ? "font-semibold text-success"
                            : wasSelected
                              ? "font-medium text-destructive"
                              : "text-muted-foreground"
                        }`}
                      >
                        {c.is_correct ? (
                          <CheckCircle2 className="size-3.5 shrink-0" />
                        ) : wasSelected ? (
                          <XCircle className="size-3.5 shrink-0" />
                        ) : (
                          <span className="w-3.5 shrink-0" />
                        )}
                        {c.text}
                        {wasSelected && !c.is_correct ? " (your answer)" : ""}
                      </li>
                    );
                  })}
                </ul>
                {studentFacingExplanation(row.explanation) && (
                  <div className="mt-3">
                    <AIMarkdown text={studentFacingExplanation(row.explanation)!} />
                  </div>
                )}
                <TeachMeThis attemptId={attemptId} questionId={row.question_id} />
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </main>
  );
}
