"use client";

import { useState } from "react";
import Link from "next/link";
import { CheckCircle2, ChevronLeft, ChevronRight, Circle, Star, XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { reviewFlashcard, toggleSavedFlashcard } from "@/app/flashcards/actions";

export type StudyCard = {
  id: string;
  front: string;
  back: string;
  topicName: string;
  source: string | null;
  isSaved: boolean;
};

export function FlashcardStudy({ cards }: { cards: StudyCard[] }) {
  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [saved, setSaved] = useState<Set<string>>(new Set(cards.filter((c) => c.isSaved).map((c) => c.id)));
  const [tally, setTally] = useState({ know: 0, learning: 0, dont_know: 0 });
  const [finished, setFinished] = useState(false);

  const card = cards[index];
  const isLast = index === cards.length - 1;

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

  async function handleReview(state: "know" | "learning" | "dont_know") {
    setTally((t) => ({ ...t, [state]: t[state] + 1 }));
    try {
      await reviewFlashcard(card.id, state);
    } catch {
      // Non-fatal — the session still continues even if the progress write fails.
    }
    goNext();
  }

  async function toggleSave() {
    const nextSaved = !saved.has(card.id);
    setSaved((prev) => {
      const next = new Set(prev);
      if (nextSaved) next.add(card.id);
      else next.delete(card.id);
      return next;
    });
    try {
      await toggleSavedFlashcard(card.id, nextSaved);
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
            <p className="mt-1 text-sm text-muted-foreground">{total} cards reviewed</p>
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
            <Button render={<Link href="/flashcards">Back to Flashcards</Link>} nativeButton={false} className="mt-6" />
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-lg">
      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>
          Card {index + 1} of {cards.length}
        </span>
        <Link href="/flashcards" className="hover:underline">
          Exit
        </Link>
      </div>
      <div className="mt-2 h-1 overflow-hidden rounded-full bg-muted">
        <div className="h-full rounded-full bg-primary transition-all" style={{ width: `${((index + 1) / cards.length) * 100}%` }} />
      </div>

      <button
        type="button"
        onClick={() => setFlipped((f) => !f)}
        className="mt-4 flex min-h-56 w-full flex-col justify-center rounded-lg border-2 border-border bg-card p-6 text-center transition-colors hover:border-primary/40"
      >
        <p className="text-xs font-medium uppercase tracking-wide text-muted-foreground">{card.topicName}</p>
        <p className="mt-4 text-lg font-medium leading-relaxed">{flipped ? card.back : card.front}</p>
        <p className="mt-4 text-xs text-muted-foreground">{flipped ? "Tap to see the term" : "Tap to reveal the answer"}</p>
      </button>

      <div className="mt-3 flex items-center justify-between">
        <button
          type="button"
          onClick={toggleSave}
          className="flex items-center gap-1.5 text-sm text-muted-foreground hover:text-foreground"
        >
          <Star className={`size-4 ${saved.has(card.id) ? "fill-primary text-primary" : ""}`} />
          {saved.has(card.id) ? "Saved" : "Save"}
        </button>
        {card.source && <span className="text-xs text-muted-foreground">Source: {card.source}</span>}
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
