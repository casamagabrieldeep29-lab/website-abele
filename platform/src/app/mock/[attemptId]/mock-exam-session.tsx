"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { completeMockExam } from "../actions";

export type MockChoice = { id: string; text: string };
export type MockQuestion = { id: string; text: string; choices: MockChoice[] };

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
  const [index, setIndex] = useState(0);
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

  const question = questions[index];
  const answeredCount = Object.keys(answers).length;

  async function selectChoice(choiceId: string) {
    setAnswers((prev) => ({ ...prev, [question.id]: [choiceId] }));
    const supabase = createClient();
    const { error: saveError } = await supabase.rpc("record_mock_answer", {
      p_attempt_id: attemptId,
      p_question_id: question.id,
      p_selected_choice_ids: [choiceId],
    });
    setError(saveError ? "Couldn't save that answer. Check your connection and try again." : null);
  }

  const minutes = Math.max(0, Math.floor(remainingMs / 60000));
  const seconds = Math.max(0, Math.floor((remainingMs % 60000) / 1000));
  const timeLow = remainingMs < 5 * 60 * 1000;

  return (
    <div className="mx-auto max-w-4xl px-6 py-8">
      <div className="flex items-center justify-between">
        <p className="text-sm text-muted-foreground">
          {answeredCount} of {questions.length} answered
        </p>
        <p className={`text-lg font-mono font-semibold ${timeLow ? "text-destructive" : "text-primary"}`}>
          {minutes}:{seconds.toString().padStart(2, "0")}
        </p>
      </div>

      <div className="mt-4 flex flex-wrap gap-1.5">
        {questions.map((q, i) => {
          const isAnswered = Boolean(answers[q.id]?.length);
          const isCurrent = i === index;
          const isMarked = marked.has(q.id);
          return (
            <button
              key={q.id}
              type="button"
              onClick={() => setIndex(i)}
              className={`relative flex h-8 w-8 items-center justify-center rounded text-xs font-medium ${
                isCurrent
                  ? "border-2 border-primary text-primary"
                  : isAnswered
                    ? "bg-primary/15 text-primary"
                    : "bg-muted text-muted-foreground"
              }`}
            >
              {i + 1}
              {isMarked && (
                <span className="absolute -right-1 -top-1 h-2.5 w-2.5 rounded-full bg-gold" />
              )}
            </button>
          );
        })}
      </div>
      {marked.size > 0 && (
        <p className="mt-2 text-xs text-muted-foreground">
          {marked.size} question{marked.size === 1 ? "" : "s"} marked for review
        </p>
      )}
      {error && (
        <p className="mt-2 rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
          {error}
        </p>
      )}

      <Card className="mt-6">
        <CardHeader>
          <div className="flex items-start justify-between gap-3">
            <CardTitle className="text-base font-medium leading-relaxed">
              {index + 1}. {question.text}
            </CardTitle>
            <Button
              type="button"
              size="sm"
              variant={marked.has(question.id) ? "default" : "outline"}
              className="shrink-0"
              onClick={() => toggleMarked(question.id)}
            >
              {marked.has(question.id) ? "Marked" : "Mark for review"}
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
                  onClick={() => selectChoice(choice.id)}
                  className={`w-full rounded-lg border-2 px-4 py-3.5 text-left text-sm font-medium transition-colors ${
                    isSelected ? "border-primary bg-accent" : "border-border hover:border-primary/40 hover:bg-muted"
                  }`}
                >
                  {choice.text}
                </button>
              );
            })}
          </div>

          <div className="mt-6 flex items-center justify-between">
            <Button
              type="button"
              variant="outline"
              disabled={index === 0}
              onClick={() => setIndex((i) => Math.max(0, i - 1))}
            >
              Previous
            </Button>
            {index < questions.length - 1 ? (
              <Button type="button" onClick={() => setIndex((i) => Math.min(questions.length - 1, i + 1))}>
                Next
              </Button>
            ) : (
              <Button type="button" disabled={submitting} onClick={() => setConfirmingSubmit(true)}>
                {submitting ? "Submitting…" : "Submit exam"}
              </Button>
            )}
          </div>

          {confirmingSubmit && (
            <div className="mt-4 rounded-md border border-border bg-muted/40 p-3">
              <p className="text-sm">
                {answeredCount} of {questions.length} answered
                {questions.length - answeredCount > 0 && `, ${questions.length - answeredCount} unanswered`}
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
          )}
        </CardContent>
      </Card>
    </div>
  );
}
