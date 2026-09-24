"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { completeMockExam } from "../actions";

export type MockChoice = { id: string; text: string };
export type MockQuestion = { id: string; text: string; choices: MockChoice[] };

/**
 * All 100 items render at once in one scrollable page (matching the real
 * paper exam — a student works through the whole booklet, not one item
 * revealed at a time) instead of the old single-question-per-screen flow.
 * Answer selection still calls record_mock_answer, which grades silently
 * server-side and never returns correctness — so nothing here reveals
 * right/wrong before the exam is submitted, same as before. The question-
 * number grid now scrolls to an item instead of switching a single-question
 * view to it.
 */
export function MockExamSession({
  attemptId,
  questions,
  initialAnswers,
  startedAt,
  timeLimitMinutes,
}: {
  attemptId: string;
  questions: MockQuestion[];
  initialAnswers: Record<string, string[]>;
  startedAt: string;
  timeLimitMinutes: number;
}) {
  const router = useRouter();
  const [answers, setAnswers] = useState<Record<string, string[]>>(initialAnswers);
  const [submitting, setSubmitting] = useState(false);
  const [marked, setMarked] = useState<Set<string>>(new Set());
  const [error, setError] = useState<string | null>(null);
  const [confirmingSubmit, setConfirmingSubmit] = useState(false);

  function toggleMarked(questionId: string) {
    setMarked((prev) => {
      const next = new Set(prev);
      if (next.has(questionId)) next.delete(questionId);
      else next.add(questionId);
      return next;
    });
  }

  function scrollToQuestion(i: number) {
    document.getElementById(`mock-q-${i}`)?.scrollIntoView({ behavior: "smooth", block: "start" });
  }

  const deadline = useMemo(
    () => new Date(startedAt).getTime() + timeLimitMinutes * 60 * 1000,
    [startedAt, timeLimitMinutes],
  );
  const [remainingMs, setRemainingMs] = useState(() => deadline - Date.now());

  const finishExam = useCallback(() => {
    setSubmitting(true);
    completeMockExam(attemptId).then(() => {
      router.push(`/mock/${attemptId}/results`);
    });
  }, [attemptId, router]);

  useEffect(() => {
    const interval = setInterval(() => {
      const remaining = deadline - Date.now();
      setRemainingMs(remaining);
      if (remaining <= 0) {
        clearInterval(interval);
        finishExam();
      }
    }, 1000);
    return () => clearInterval(interval);
  }, [deadline, finishExam]);

  const answeredCount = Object.keys(answers).length;
  const unansweredCount = questions.length - answeredCount;

  async function selectChoice(questionId: string, choiceId: string) {
    setAnswers((prev) => ({ ...prev, [questionId]: [choiceId] }));
    const supabase = createClient();
    const { error: saveError } = await supabase.rpc("record_mock_answer", {
      p_attempt_id: attemptId,
      p_question_id: questionId,
      p_selected_choice_ids: [choiceId],
    });
    setError(saveError ? "Couldn't save that answer. Check your connection and try again." : null);
  }

  const minutes = Math.max(0, Math.floor(remainingMs / 60000));
  const seconds = Math.max(0, Math.floor((remainingMs % 60000) / 1000));
  const timeLow = remainingMs < 5 * 60 * 1000;

  const submitBar = (
    <div className="flex items-center justify-between gap-3">
      <p className="text-sm text-muted-foreground">
        {answeredCount} of {questions.length} answered
        {marked.size > 0 && ` · ${marked.size} flagged`}
      </p>
      <div className="flex items-center gap-3">
        <p className={`font-mono text-lg font-semibold ${timeLow ? "text-destructive" : "text-primary"}`}>
          {minutes}:{seconds.toString().padStart(2, "0")}
        </p>
        <Button type="button" size="sm" disabled={submitting} onClick={() => setConfirmingSubmit(true)}>
          {submitting ? "Submitting…" : "Submit exam"}
        </Button>
      </div>
    </div>
  );

  const submitConfirmation = confirmingSubmit && (
    <div className="mt-3 rounded-md border border-border bg-muted/40 p-3">
      <p className="text-sm">
        {answeredCount} of {questions.length} answered
        {unansweredCount > 0 && `, ${unansweredCount} unanswered`}
        {marked.size > 0 && `, ${marked.size} marked for review`}. Submit now?
      </p>
      <div className="mt-2 flex gap-2">
        <Button type="button" size="sm" disabled={submitting} onClick={finishExam}>
          {submitting ? "Submitting…" : "Confirm submit"}
        </Button>
        <Button type="button" size="sm" variant="outline" onClick={() => setConfirmingSubmit(false)}>
          Keep reviewing
        </Button>
      </div>
    </div>
  );

  return (
    <div className="mx-auto max-w-4xl px-6 py-8">
      <div className="sticky top-0 z-20 -mx-6 border-b border-border bg-background/95 px-6 py-3 backdrop-blur-sm">
        {submitBar}

        <div className="mt-3 flex flex-wrap gap-1.5">
          {questions.map((q, i) => {
            const isAnswered = Boolean(answers[q.id]?.length);
            const isMarked = marked.has(q.id);
            return (
              <button
                key={q.id}
                type="button"
                onClick={() => scrollToQuestion(i)}
                title={`Jump to question ${i + 1}${isAnswered ? " (answered)" : " (unanswered)"}`}
                className={`relative flex h-7 w-7 items-center justify-center rounded text-[11px] font-medium transition-colors ${
                  isAnswered ? "bg-primary/15 text-primary" : "bg-muted text-muted-foreground hover:bg-muted/70"
                }`}
              >
                {i + 1}
                {isMarked && <span className="absolute -top-1 -right-1 h-2 w-2 rounded-full bg-gold" />}
              </button>
            );
          })}
        </div>

        {error && (
          <p className="mt-2 rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
            {error}
          </p>
        )}

        {submitConfirmation}
      </div>

      <div className="mt-6 space-y-5">
        {questions.map((question, i) => (
          <Card key={question.id} id={`mock-q-${i}`} className="scroll-mt-44">
            <CardHeader>
              <div className="flex items-start justify-between gap-3">
                <CardTitle className="text-base font-medium leading-relaxed">
                  {i + 1}. {question.text}
                </CardTitle>
                <Button
                  type="button"
                  size="sm"
                  variant={marked.has(question.id) ? "default" : "outline"}
                  className="shrink-0"
                  onClick={() => toggleMarked(question.id)}
                >
                  {marked.has(question.id) ? "Flagged" : "Flag for review"}
                </Button>
              </div>
            </CardHeader>
            <CardContent>
              <div className="space-y-2.5">
                {question.choices.map((choice) => {
                  const isSelected = answers[question.id]?.includes(choice.id);
                  return (
                    <button
                      key={choice.id}
                      type="button"
                      onClick={() => selectChoice(question.id, choice.id)}
                      className={`w-full rounded-lg border-2 px-4 py-3.5 text-left text-sm font-medium transition-colors ${
                        isSelected ? "border-primary bg-accent" : "border-border hover:border-primary/40 hover:bg-muted"
                      }`}
                    >
                      {choice.text}
                    </button>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="mt-6 flex justify-end">
        <Button type="button" size="lg" disabled={submitting} onClick={() => setConfirmingSubmit(true)}>
          {submitting ? "Submitting…" : "Submit exam"}
        </Button>
      </div>
    </div>
  );
}
