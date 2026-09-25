"use client";

import { useCallback, useEffect, useMemo, useRef, useState, useTransition } from "react";
import Link from "next/link";
import { CheckCircle2, Timer, XCircle } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { completePracticeAttempt } from "@/app/practice/actions";
import { ExplanationDisplay } from "@/components/explanation-display";
import { studentFacingExplanation } from "@/lib/explanation";
import { useCountdown } from "@/hooks/use-countdown";

export type PaesChoice = { id: string; text: string };
export type PaesQuestion = {
  id: string;
  text: string;
  paesReference: string | null;
  choices: PaesChoice[];
};

type ExistingAnswer = {
  question_id: string;
  selected_choice_ids: string[];
  is_correct: boolean | null;
};

type Feedback = { isCorrect: boolean; correctChoiceIds: string[]; explanation: string | null };
type Confidence = "knew_it" | "not_sure" | "guessed";

const LETTERS = ["A", "B", "C", "D", "E", "F"];

const CONFIDENCE_OPTIONS: { value: Confidence; label: string }[] = [
  { value: "knew_it", label: "Knew it" },
  { value: "not_sure", label: "Not sure" },
  { value: "guessed", label: "Guessed" },
];

/**
 * Large countdown badge + thin fraction bar for a single question. Rendered
 * with `key={index}` by the parent so a fresh instance (and therefore a
 * fresh `useCountdown` deadline) mounts for every question — see
 * use-countdown.ts's header comment for why that's the reset mechanism
 * instead of recomputing the deadline in place.
 */
function QuestionTimer({ durationSeconds, onExpire }: { durationSeconds: number; onExpire: () => void }) {
  const remainingMs = useCountdown(durationSeconds, onExpire);
  const secondsLeft = remainingMs === null ? durationSeconds : Math.max(0, Math.ceil(remainingMs / 1000));
  const timerFraction =
    remainingMs === null ? 1 : Math.max(0, Math.min(1, remainingMs / (durationSeconds * 1000)));
  const timerLow = secondsLeft <= 5;

  return (
    <div className="mt-5 flex flex-col items-center gap-1.5">
      <span
        className={`flex items-center gap-1.5 font-mono text-3xl font-bold tabular-nums transition-colors ${
          timerLow ? "text-destructive" : "text-primary"
        }`}
      >
        <Timer className="size-6" />
        {secondsLeft}
      </span>
      <div className="h-1 w-32 overflow-hidden rounded-full bg-muted">
        <div
          className={`h-full transition-[width] duration-1000 ease-linear ${
            timerLow ? "bg-destructive" : "bg-primary"
          }`}
          style={{ width: `${timerFraction * 100}%` }}
        />
      </div>
    </div>
  );
}

/**
 * Phase 2 "special feature" quiz session for /paes — deliberately distinct
 * from the plain, two-column /practice/[attemptId] layout: one question at
 * a time, full-width, large tap targets, an optional per-question
 * countdown (Quickfire), and a post-answer confidence check before the
 * student can move on. Dark-modern via the existing design tokens
 * (--success/--destructive/--primary/--gold), not a colorful Kahoot clone.
 */
export function PaesQuizSession({
  attemptId,
  questions,
  initialAnswers,
  timedSeconds,
  alreadyCompleted,
  finalScore,
}: {
  attemptId: string;
  questions: PaesQuestion[];
  initialAnswers: ExistingAnswer[];
  timedSeconds: number | null;
  alreadyCompleted: boolean;
  finalScore: { correct: number; total: number } | null;
}) {
  const answeredMap = useMemo(() => {
    const map = new Map<string, ExistingAnswer>();
    for (const a of initialAnswers) map.set(a.question_id, a);
    return map;
  }, [initialAnswers]);

  const firstUnansweredIndex = questions.findIndex((q) => !answeredMap.has(q.id));
  const [index, setIndex] = useState(firstUnansweredIndex === -1 ? questions.length - 1 : firstUnansweredIndex);
  const [selectedChoiceId, setSelectedChoiceId] = useState<string | null>(null);
  const [feedback, setFeedback] = useState<Feedback | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [confidence, setConfidence] = useState<Confidence | null>(null);
  const [confidenceSaving, setConfidenceSaving] = useState(false);
  const [timedOut, setTimedOut] = useState(false);
  const [correctSoFar, setCorrectSoFar] = useState(initialAnswers.filter((a) => a.is_correct).length);
  const [finished, setFinished] = useState(alreadyCompleted);
  const [score, setScore] = useState(finalScore);
  const [error, setError] = useState<string | null>(null);
  const [isPending, startTransition] = useTransition();

  const answeredRef = useRef(false);
  useEffect(() => {
    answeredRef.current = false;
  }, [index]);

  const question = questions[index];
  const isLast = index === questions.length - 1;

  const handleTimeout = useCallback(() => {
    if (answeredRef.current) return;
    answeredRef.current = true;
    setTimedOut(true);
  }, []);

  function advance() {
    if (isLast) {
      startTransition(async () => {
        await completePracticeAttempt(attemptId);
        setScore({ correct: correctSoFar, total: questions.length });
        setFinished(true);
      });
      return;
    }
    setIndex((i) => i + 1);
    setSelectedChoiceId(null);
    setFeedback(null);
    setConfidence(null);
    setTimedOut(false);
  }

  // A timeout with nothing selected behaves like the existing "Skip" —
  // no attempt_answers row is written — after a brief transition beat.
  useEffect(() => {
    if (!timedOut || feedback) return;
    const t = setTimeout(() => advance(), 1200);
    return () => clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [timedOut]);

  async function selectChoice(choiceId: string) {
    if (feedback || submitting || timedOut) return;
    answeredRef.current = true;
    setSelectedChoiceId(choiceId);
    setSubmitting(true);
    setError(null);
    const supabase = createClient();
    const { data, error: submitError } = await supabase.rpc("submit_attempt_answer", {
      p_attempt_id: attemptId,
      p_question_id: question.id,
      p_selected_choice_ids: [choiceId],
    });

    if (submitError) {
      setError("Couldn't submit your answer. Check your connection and try again.");
      setSubmitting(false);
      setSelectedChoiceId(null);
      answeredRef.current = false;
      return;
    }

    const result = Array.isArray(data) ? data[0] : data;
    setFeedback({
      isCorrect: result.is_correct,
      correctChoiceIds: result.correct_choice_ids ?? [],
      explanation: studentFacingExplanation(result.explanation),
    });
    if (result.is_correct) setCorrectSoFar((n) => n + 1);
    setSubmitting(false);
  }

  async function pickConfidence(value: Confidence) {
    if (!selectedChoiceId || confidenceSaving) return;
    setConfidence(value);
    setConfidenceSaving(true);
    const supabase = createClient();
    const { error: confError } = await supabase.rpc("submit_attempt_answer", {
      p_attempt_id: attemptId,
      p_question_id: question.id,
      p_selected_choice_ids: [selectedChoiceId],
      p_confidence: value,
    });
    if (confError) {
      // The 028 migration (p_confidence 4th param) may not be live on this
      // DB yet — Postgres reports an unknown-function-signature error in
      // that case. Retry the original 3-arg shape so the already-graded
      // answer is untouched and the quiz keeps working; confidence just
      // doesn't get persisted this time. Purely diagnostic, never fatal.
      console.warn("submit_attempt_answer with confidence failed, retrying without it:", confError.message);
      await supabase.rpc("submit_attempt_answer", {
        p_attempt_id: attemptId,
        p_question_id: question.id,
        p_selected_choice_ids: [selectedChoiceId],
      });
    }
    setConfidenceSaving(false);
  }

  if (finished) {
    const correct = score?.correct ?? correctSoFar;
    const total = score?.total ?? questions.length;
    const accuracy = total ? Math.round((100 * correct) / total) : 0;
    const missedAny = correct < total;

    return (
      <div className="mx-auto max-w-2xl px-4 py-10 sm:px-6">
        <Card className="animate-in fade-in zoom-in-95 duration-300">
          <CardHeader>
            <CardTitle>Quiz Results</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-baseline gap-3">
              <p className="text-4xl font-semibold text-primary">{accuracy}%</p>
              <p className="text-sm text-muted-foreground">
                {correct} of {total} correct
              </p>
            </div>

            <div className="mt-6 flex flex-wrap gap-2">
              {missedAny ? (
                <>
                  <Button render={<Link href="/mistakes">Review mistakes</Link>} nativeButton={false} />
                  <Button
                    render={<Link href="/paes">Back to PAES</Link>}
                    nativeButton={false}
                    variant="outline"
                  />
                </>
              ) : (
                <Button render={<Link href="/paes">Back to PAES</Link>} nativeButton={false} />
              )}
              <Button render={<Link href="/paes/quiz">Quiz again</Link>} nativeButton={false} variant="ghost" />
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-8 sm:px-6">
      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>
          Question {index + 1} of {questions.length}
        </span>
        <span>{correctSoFar} correct so far</span>
      </div>
      <Progress value={((index + 1) / questions.length) * 100} className="mt-2" />

      {timedSeconds !== null && !feedback && !timedOut && (
        <QuestionTimer key={index} durationSeconds={timedSeconds} onExpire={handleTimeout} />
      )}

      {error && (
        <p className="mt-3 rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
          {error}
        </p>
      )}

      <div className="mt-6">
        {timedOut && !feedback ? (
          <Card className="animate-in fade-in zoom-in-95 duration-200">
            <CardContent className="flex flex-col items-center gap-2 py-14 text-center">
              <Timer className="size-8 text-muted-foreground" />
              <p className="text-lg font-semibold">Time&rsquo;s up</p>
              <p className="text-sm text-muted-foreground">Moving to the next question…</p>
            </CardContent>
          </Card>
        ) : (
          <Card key={question.id} className="animate-in fade-in slide-in-from-bottom-2 duration-300">
            <CardHeader>
              <CardTitle className="text-center text-base font-medium leading-relaxed sm:text-lg">
                {question.text}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
                {question.choices.map((choice, i) => {
                  const isSelected = selectedChoiceId === choice.id;
                  const isCorrectChoice = feedback?.correctChoiceIds.includes(choice.id);
                  const showResult = feedback !== null;

                  return (
                    <button
                      key={choice.id}
                      type="button"
                      disabled={showResult || submitting}
                      onClick={() => selectChoice(choice.id)}
                      className={`flex items-center gap-3 rounded-xl border-2 px-4 py-4 text-left text-sm font-medium transition-all active:not-disabled:scale-[0.98] ${
                        showResult
                          ? isCorrectChoice
                            ? "border-success bg-success/10 text-success"
                            : isSelected
                              ? "border-destructive bg-destructive/10 text-destructive"
                              : "border-border text-muted-foreground"
                          : isSelected
                            ? "border-primary bg-accent"
                            : "border-border hover:border-primary/40 hover:bg-muted"
                      }`}
                    >
                      <span
                        className={`flex size-7 shrink-0 items-center justify-center rounded-full text-xs font-bold ${
                          showResult
                            ? isCorrectChoice
                              ? "bg-success text-success-foreground"
                              : isSelected
                                ? "bg-destructive text-white"
                                : "bg-muted text-muted-foreground"
                            : "bg-primary/15 text-primary"
                        }`}
                      >
                        {LETTERS[i]}
                      </span>
                      <span className="flex-1">{choice.text}</span>
                      {showResult && isCorrectChoice && <CheckCircle2 className="size-5 shrink-0" />}
                      {showResult && isSelected && !isCorrectChoice && <XCircle className="size-5 shrink-0" />}
                    </button>
                  );
                })}
              </div>

              {!feedback && !timedOut && (
                <div className="mt-4 flex justify-center">
                  <button
                    type="button"
                    onClick={advance}
                    disabled={submitting || isPending}
                    className="text-xs text-muted-foreground hover:text-foreground hover:underline"
                  >
                    Skip this question
                  </button>
                </div>
              )}

              {feedback && (
                <div className="mt-5 animate-in fade-in slide-in-from-bottom-1 border-t pt-4 duration-300">
                  <p
                    className={`flex items-center gap-1.5 text-sm font-medium ${
                      feedback.isCorrect ? "text-success" : "text-destructive"
                    }`}
                  >
                    {feedback.isCorrect ? <CheckCircle2 className="size-4" /> : <XCircle className="size-4" />}
                    {feedback.isCorrect ? "Correct" : "Incorrect"}
                  </p>

                  {feedback.explanation && (
                    <div className="mt-2 text-sm">
                      <ExplanationDisplay text={feedback.explanation} />
                    </div>
                  )}

                  {/* Public standard designation (e.g. "PAES 401") — never
                      questions.source/source_reference, which are never
                      fetched by this route at all. */}
                  {question.paesReference && (
                    <p className="mt-2 text-xs font-medium tracking-wide text-muted-foreground">
                      SOURCE: {question.paesReference}
                    </p>
                  )}

                  <div className="mt-4 border-t pt-4">
                    <p className="text-sm font-medium">How confident were you?</p>
                    <div className="mt-2 flex gap-2">
                      {CONFIDENCE_OPTIONS.map((opt) => (
                        <button
                          key={opt.value}
                          type="button"
                          onClick={() => pickConfidence(opt.value)}
                          disabled={confidenceSaving}
                          className={`flex-1 rounded-lg border-2 px-2 py-2 text-xs font-medium transition-colors sm:text-sm ${
                            confidence === opt.value
                              ? "border-primary bg-accent"
                              : "border-border hover:border-primary/40 hover:bg-muted"
                          }`}
                        >
                          {opt.label}
                        </button>
                      ))}
                    </div>

                    {confidence ? (
                      <div className="mt-4 flex justify-end">
                        <Button onClick={advance} disabled={isPending}>
                          {isLast ? "Finish" : "Next question"}
                        </Button>
                      </div>
                    ) : (
                      <p className="mt-2 text-xs text-muted-foreground">Pick one to continue.</p>
                    )}
                  </div>
                </div>
              )}
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}
