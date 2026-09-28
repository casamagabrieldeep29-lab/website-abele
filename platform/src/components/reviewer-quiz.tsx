"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { CheckCircle2, ChevronLeft, ChevronRight, Circle, Star, XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { FormulaCard, ConstantCard, TableEntryCard, type ReviewerEntry } from "@/app/(app)/reviewers/reviewers-browser";
import { reviewReviewerEntry, toggleSavedReviewerEntry } from "@/app/reviewers/quiz-actions";

export type QuizEntry = ReviewerEntry & { isSaved: boolean };

const KIND_PROMPT: Record<ReviewerEntry["kind"], string> = {
  formula: "What's the formula?",
  constant: "What's the value?",
  table: "What's in this reference table?",
};

/** Same self-grade flip-card loop as FlashcardStudy (know / learning / don't know, progress persisted per entry), generalized to quiz over reviewer_entries instead of the separate flashcards table — reuses the exact same card renderers (FormulaCard/ConstantCard/TableEntryCard) already used on /reviewers and /paes/numbers for the reveal side, so a quizzed formula or constant looks identical to its reference-page card. */
export function ReviewerQuiz({ entries, backHref, backLabel }: { entries: QuizEntry[]; backHref: string; backLabel: string }) {
  const router = useRouter();
  const searchParams = useSearchParams();

  const initialAt = Number(searchParams.get("at") ?? "0");
  const [index, setIndexState] = useState(
    Number.isInteger(initialAt) && initialAt >= 0 && initialAt < entries.length ? initialAt : 0,
  );

  function setIndex(next: number | ((i: number) => number)) {
    setIndexState((prev) => {
      const resolved = typeof next === "function" ? next(prev) : next;
      const params = new URLSearchParams(searchParams);
      params.set("at", String(resolved));
      router.replace(`?${params.toString()}`, { scroll: false });
      return resolved;
    });
  }

  const [flipped, setFlipped] = useState(false);
  const [saved, setSaved] = useState<Set<string>>(new Set(entries.filter((e) => e.isSaved).map((e) => e.id)));
  const [tally, setTally] = useState({ know: 0, learning: 0, dont_know: 0 });
  const [finished, setFinished] = useState(false);

  const entry = entries[index];
  const isLast = index === entries.length - 1;

  function goNext() {
    if (isLast) {
      setFinished(true);
      return;
    }
    setIndex((i) => i + 1);
    setFlipped(false);
  }

  function goPrev() {
    if (index === 0) return;
    setIndex((i) => i - 1);
    setFlipped(false);
  }

  function handleReview(state: "know" | "learning" | "dont_know") {
    setTally((t) => ({ ...t, [state]: t[state] + 1 }));
    // Advance immediately — the progress write happens in the background so
    // a slow network never makes the next card feel like it needs a second tap.
    void reviewReviewerEntry(entry.id, state).catch(() => {
      // Non-fatal — the session still continues even if the progress write fails.
    });
    goNext();
  }

  async function toggleSave() {
    const nextSaved = !saved.has(entry.id);
    setSaved((prev) => {
      const next = new Set(prev);
      if (nextSaved) next.add(entry.id);
      else next.delete(entry.id);
      return next;
    });
    try {
      await toggleSavedReviewerEntry(entry.id, nextSaved);
    } catch {
      // Ignore — worst case the star reverts on next load.
    }
  }

  if (finished) {
    const total = tally.know + tally.learning + tally.dont_know;
    return (
      <div className="mx-auto max-w-lg">
        <Card>
          <CardContent className="py-6 text-center">
            <p className="text-lg font-semibold">Session complete</p>
            <p className="mt-1 text-sm text-muted-foreground">{total} reviewed</p>
            <div className="mt-4 flex justify-center gap-4 text-sm">
              <span className="flex items-center gap-1.5 text-success">
                <CheckCircle2 className="size-4" /> {tally.know} know it
              </span>
              <span className="flex items-center gap-1.5 text-gold">
                <Circle className="size-4" /> {tally.learning} still learning
              </span>
              <span className="flex items-center gap-1.5 text-destructive">
                <XCircle className="size-4" /> {tally.dont_know} don&apos;t know
              </span>
            </div>
            <Button render={<Link href={backHref}>{backLabel}</Link>} nativeButton={false} className="mt-6" />
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-lg">
      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>
          {index + 1} of {entries.length}
        </span>
        <Link href={backHref} className="hover:underline">
          Exit
        </Link>
      </div>
      <div className="mt-2 h-1 overflow-hidden rounded-full bg-muted">
        <div className="h-full rounded-full bg-primary transition-all" style={{ width: `${((index + 1) / entries.length) * 100}%` }} />
      </div>

      {/* A div, not a button: the flipped side reuses FormulaCard/ConstantCard/TableEntryCard, which contain their own Copy <button> — nesting a button inside a button is invalid HTML and throws a hydration error. role="button" + a key handler keep it keyboard-accessible. */}
      <div
        role="button"
        tabIndex={0}
        onClick={() => setFlipped((f) => !f)}
        onKeyDown={(e) => {
          if (e.key === "Enter" || e.key === " ") {
            e.preventDefault();
            setFlipped((f) => !f);
          }
        }}
        className="mt-4 flex min-h-56 w-full cursor-pointer flex-col rounded-2xl border border-border/60 bg-card p-6 shadow-sm ring-1 ring-foreground/5 transition-all hover:border-primary/40 hover:shadow-md focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary/50 sm:p-8"
      >
        <p className="text-center text-xs font-semibold uppercase tracking-widest text-primary">
          {entry.topic_name}
          {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
        </p>

        <div className="flex flex-1 flex-col items-center justify-center gap-4 py-6">
          {!flipped ? (
            <>
              <p className="text-center text-lg font-semibold leading-relaxed">{entry.title}</p>
              <p className="text-center text-sm text-muted-foreground">{KIND_PROMPT[entry.kind]}</p>
            </>
          ) : entry.kind === "formula" ? (
            <FormulaCard entry={entry} />
          ) : entry.kind === "constant" ? (
            <ConstantCard entry={entry} />
          ) : (
            <TableEntryCard entry={entry} />
          )}
        </div>

        <p className="text-center text-xs text-muted-foreground">{flipped ? "Tap to see the prompt" : "Tap to reveal the answer"}</p>
      </div>

      <div className="mt-3 flex items-center justify-between">
        <button
          type="button"
          onClick={toggleSave}
          className="flex items-center gap-1.5 text-sm text-muted-foreground hover:text-foreground"
        >
          <Star className={`size-4 ${saved.has(entry.id) ? "fill-primary text-primary" : ""}`} />
          {saved.has(entry.id) ? "Saved" : "Save"}
        </button>
      </div>

      {flipped ? (
        <div className="mt-4 grid grid-cols-3 gap-2">
          <Button variant="outline" className="border-destructive/40 text-destructive hover:bg-destructive/10" onClick={() => handleReview("dont_know")}>
            Don&apos;t know
          </Button>
          <Button variant="outline" className="border-gold/40 text-gold hover:bg-gold/10" onClick={() => handleReview("learning")}>
            Still learning
          </Button>
          <Button className="bg-success text-success-foreground hover:bg-success/90" onClick={() => handleReview("know")}>
            Know it
          </Button>
        </div>
      ) : (
        <div className="mt-4 flex justify-between gap-2">
          <Button variant="outline" onClick={goPrev} disabled={index === 0}>
            <ChevronLeft className="size-4" /> Previous
          </Button>
          <Button variant="outline" onClick={goNext}>
            Skip <ChevronRight className="size-4" />
          </Button>
        </div>
      )}
    </div>
  );
}
