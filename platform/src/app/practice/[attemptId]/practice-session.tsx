"use client";

import { useMemo, useState, useTransition } from "react";
import Link from "next/link";
import { CheckCircle2, StickyNote, Star, XCircle } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { completePracticeAttempt } from "../actions";
import { saveNote } from "../notes-actions";
import { setBookmark } from "../bookmarks-actions";
import { TeachMeThis } from "@/components/teach-me-this";
import { ExplanationDisplay } from "@/components/explanation-display";
import { studentFacingExplanation } from "@/lib/explanation";

export type PracticeChoice = { id: string; text: string };
export type PracticeQuestion = { id: string; text: string; choices: PracticeChoice[] };

type ExistingAnswer = {
  question_id: string;
  selected_choice_ids: string[];
  is_correct: boolean | null;
};

type Feedback = { isCorrect: boolean; correctChoiceIds: string[]; explanation: string | null };

export function PracticeSession({
  attemptId,
  questions,
  initialAnswers,
  initialNotes,
  initialBookmarkedIds,
  alreadyCompleted,
  finalScore,
}: {
  attemptId: string;
  questions: PracticeQuestion[];
  initialAnswers: ExistingAnswer[];
  initialNotes: Record<string, string>;
  initialBookmarkedIds: string[];
  alreadyCompleted: boolean;
  finalScore: { correct: number; total: number } | null;
}) {
  const [notes, setNotes] = useState<Record<string, string>>(initialNotes);
  const [bookmarked, setBookmarked] = useState<Set<string>>(new Set(initialBookmarkedIds));
  const [bookmarkPending, setBookmarkPending] = useState(false);
  const [noteOpen, setNoteOpen] = useState(false);
  const [noteDraft, setNoteDraft] = useState("");
  const [noteSaving, setNoteSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const answeredMap = useMemo(() => {
    const map = new Map<string, ExistingAnswer>();
    for (const a of initialAnswers) map.set(a.question_id, a);
    return map;
  }, [initialAnswers]);

  const firstUnansweredIndex = questions.findIndex((q) => !answeredMap.has(q.id));
  const [index, setIndex] = useState(
    firstUnansweredIndex === -1 ? questions.length - 1 : firstUnansweredIndex,
  );
  const [selectedChoiceId, setSelectedChoiceId] = useState<string | null>(null);
  const [feedback, setFeedback] = useState<Feedback | null>(null);
  const [correctSoFar, setCorrectSoFar] = useState(
    initialAnswers.filter((a) => a.is_correct).length,
  );
  const [finished, setFinished] = useState(alreadyCompleted);
  const [score, setScore] = useState(finalScore);
  const [isPending, startTransition] = useTransition();

  const question = questions[index];
  const isLast = index === questions.length - 1;

  async function handleSubmit() {
    if (!selectedChoiceId) return;
    setError(null);
    const supabase = createClient();
    const { data, error: submitError } = await supabase.rpc("submit_attempt_answer", {
      p_attempt_id: attemptId,
      p_question_id: question.id,
      p_selected_choice_ids: [selectedChoiceId],
    });

    if (submitError) {
      setError("Couldn't submit your answer. Check your connection and try again.");
      return;
    }

    const result = Array.isArray(data) ? data[0] : data;
    setFeedback({
      isCorrect: result.is_correct,
      correctChoiceIds: result.correct_choice_ids ?? [],
      explanation: studentFacingExplanation(result.explanation),
    });
    if (result.is_correct) setCorrectSoFar((n) => n + 1);
  }

  function handleNext() {
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
    setNoteOpen(false);
  }

  async function toggleBookmark() {
    const isBookmarked = bookmarked.has(question.id);
    setBookmarkPending(true);
    setError(null);
    try {
      await setBookmark(question.id, !isBookmarked);
      setBookmarked((prev) => {
        const next = new Set(prev);
        if (isBookmarked) next.delete(question.id);
        else next.add(question.id);
        return next;
      });
    } catch {
      setError("Couldn't update bookmark. Please try again.");
    } finally {
      setBookmarkPending(false);
    }
  }

  function openNote() {
    setNoteDraft(notes[question.id] ?? "");
    setNoteOpen(true);
  }

  async function handleSaveNote() {
    setNoteSaving(true);
    setError(null);
    try {
      await saveNote(question.id, noteDraft);
      setNotes((prev) => {
        const next = { ...prev };
        if (noteDraft.trim()) next[question.id] = noteDraft.trim();
        else delete next[question.id];
        return next;
      });
      setNoteOpen(false);
    } catch {
      setError("Couldn't save your note. Please try again.");
    } finally {
      setNoteSaving(false);
    }
  }

  if (finished) {
    const correct = score?.correct ?? correctSoFar;
    const total = score?.total ?? questions.length;
    const accuracy = total ? Math.round((100 * correct) / total) : 0;
    const missedAny = correct < total;

    return (
      <Card className="mt-6">
        <CardHeader>
          <CardTitle>Results</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex items-baseline gap-3">
            <p className="text-3xl font-semibold text-primary">{accuracy}%</p>
            <p className="text-sm text-muted-foreground">{correct} of {total} correct</p>
          </div>

          <div className="mt-6 flex flex-wrap gap-2">
            {missedAny ? (
              <>
                <Button render={<Link href="/mistakes">Review mistakes</Link>} nativeButton={false} />
                <Button
                  render={<Link href="/dashboard">Back to Dashboard</Link>}
                  nativeButton={false}
                  variant="outline"
                />
              </>
            ) : (
              <Button render={<Link href="/dashboard">Back to Dashboard</Link>} nativeButton={false} />
            )}
            <Button render={<Link href="/practice">Practice again</Link>} nativeButton={false} variant="ghost" />
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="mt-6">
      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>
          Question {index + 1} of {questions.length}
        </span>
        <span>{correctSoFar} correct so far</span>
      </div>
      <Progress value={((index + 1) / questions.length) * 100} className="mt-2" />

      {error && (
        <p className="mt-3 rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
          {error}
        </p>
      )}

      {/* Two columns on desktop/tablet (question left, solution right); stacked on mobile. */}
      <div className="mt-4 grid grid-cols-1 items-start gap-4 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <div className="flex items-start justify-between gap-3">
              <CardTitle className="text-base font-medium leading-relaxed">
                {question.text}
              </CardTitle>
              <button
                type="button"
                onClick={toggleBookmark}
                disabled={bookmarkPending}
                title={bookmarked.has(question.id) ? "Remove bookmark" : "Bookmark this question"}
                className="shrink-0 text-muted-foreground hover:text-primary"
              >
                <Star
                  className={`size-5 ${bookmarked.has(question.id) ? "fill-primary text-primary" : ""}`}
                />
              </button>
            </div>
          </CardHeader>
          <CardContent>
            <div className="space-y-2.5">
              {question.choices.map((choice) => {
                const isSelected = selectedChoiceId === choice.id;
                const isCorrectChoice = feedback?.correctChoiceIds.includes(choice.id);
                const showResult = feedback !== null;

                return (
                  <button
                    key={choice.id}
                    type="button"
                    disabled={showResult}
                    onClick={() => setSelectedChoiceId(choice.id)}
                    className={`w-full rounded-lg border-2 px-4 py-3.5 text-left text-sm font-medium transition-colors ${
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
                    {choice.text}
                  </button>
                );
              })}
            </div>

            <div className="mt-4 border-t pt-4">
              {noteOpen ? (
                <div className="space-y-2">
                  <textarea
                    value={noteDraft}
                    onChange={(e) => setNoteDraft(e.target.value)}
                    placeholder="Your private reminder for this question…"
                    rows={2}
                    className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
                    autoFocus
                  />
                  <div className="flex gap-2">
                    <Button size="sm" onClick={handleSaveNote} disabled={noteSaving}>
                      {noteSaving ? "Saving…" : "Save note"}
                    </Button>
                    <Button size="sm" variant="outline" onClick={() => setNoteOpen(false)}>
                      Cancel
                    </Button>
                  </div>
                </div>
              ) : (
                <button
                  type="button"
                  onClick={openNote}
                  className="flex items-center gap-1.5 text-xs text-muted-foreground hover:text-foreground hover:underline"
                >
                  <StickyNote className="size-3.5 shrink-0" />
                  {notes[question.id] || "Add a private note"}
                </button>
              )}
            </div>

            <div className="mt-4 flex gap-2">
              {feedback ? (
                <Button onClick={handleNext} disabled={isPending}>
                  {isLast ? "Finish" : "Next question"}
                </Button>
              ) : (
                <>
                  <Button onClick={handleSubmit} disabled={!selectedChoiceId}>
                    Submit answer
                  </Button>
                  <Button variant="outline" onClick={handleNext} disabled={isPending}>
                    Skip
                  </Button>
                </>
              )}
            </div>
          </CardContent>
        </Card>

        {/* Solution panel — independently scrollable/sticky on large screens so it
            stays visible alongside a long question without pushing the page down. */}
        <Card className="lg:sticky lg:top-4 lg:max-h-[calc(100vh-2rem)] lg:overflow-y-auto">
          <CardHeader>
            <CardTitle className="text-sm text-muted-foreground">Solution</CardTitle>
          </CardHeader>
          <CardContent>
            {feedback ? (
              <div className="text-sm">
                <p
                  className={`flex items-center gap-1.5 font-medium ${
                    feedback.isCorrect ? "text-success" : "text-destructive"
                  }`}
                >
                  {feedback.isCorrect ? (
                    <CheckCircle2 className="size-4" />
                  ) : (
                    <XCircle className="size-4" />
                  )}
                  {feedback.isCorrect ? "Correct" : "Incorrect"}
                </p>
                {feedback.explanation && (
                  <div className="mt-2">
                    <ExplanationDisplay text={feedback.explanation} />
                  </div>
                )}
                <TeachMeThis
                  attemptId={attemptId}
                  questionId={question.id}
                  autoStart={!feedback.explanation}
                />
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">Submit an answer to see the explanation here.</p>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
