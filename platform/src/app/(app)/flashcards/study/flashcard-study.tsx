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

// Flashcard front/back are stored as plain text (see supabase/seed/content/
// flashcards-*.sql) — no separate "formula" / "variables" fields, so this is
// purely a display-time parse of the equation convention already used
// throughout that content: "<symbol> = <expression>[, where <symbol> is
// <definition>, <symbol> is <definition>[, and <symbol> is <definition>]]."
// Anything that doesn't match falls back to the plain-text rendering.
type ParsedFormula = { formula: string; legend: { symbol: string; definition: string }[]; note: string | null };

function parseFormulaCard(text: string): ParsedFormula | null {
  // The expression side may contain decimals (e.g. "0.02"), so a bare period
  // can't be used as a stop character — only a period NOT followed by a
  // digit ends the equation.
  const eqMatch = text.match(/^([A-Za-z][A-Za-z0-9]*\s*=\s*(?:[^,;.]|\.(?=\d))+)/);
  if (!eqMatch) return null;

  const formula = eqMatch[1].trim();
  const rest = text.slice(eqMatch[0].length);

  const whereMatch = rest.match(/^[,.]?\s*where\s+(.+)$/i);
  if (whereMatch) {
    const segments = whereMatch[1]
      .replace(/\.$/, "")
      .split(/,\s+(?:and\s+)?|\s+and\s+/i)
      .map((s) => s.trim())
      .filter(Boolean);

    const legend: { symbol: string; definition: string }[] = [];
    let allMatched = true;
    for (const segment of segments) {
      const pair = segment.match(/^([A-Za-z][A-Za-z0-9]*)\s+is\s+(?:the\s+|a\s+|an\s+)?(.+)$/i);
      if (!pair) {
        allMatched = false;
        break;
      }
      legend.push({ symbol: pair[1], definition: pair[2] });
    }
    if (allMatched && legend.length > 0) return { formula, legend, note: null };
  }

  const note = rest.replace(/^[;,.]+\s*/, "").trim();
  return { formula, legend: [], note: note.length > 0 ? note : null };
}

// Sentence-initial imperative verbs that would otherwise be mistaken for
// part of a proper formula name (e.g. "Give Hooghoudt's equation" → both
// "Give" and "Hooghoudt's" are capitalized).
const LEADING_VERB = /^(Give|State|Name|Define|Differentiate|Classify|Compute|Find|Determine|Derive|Explain|Describe|Identify|What|Which)\b\s*(the\s+)?/i;

// Card text has no separate "formula name" field, so the heading is derived
// from the prompt side (front) using the same naming convention the content
// already follows: either "<full name> (<ACRONYM>)" or a proper-named
// "<Name> equation/formula/law". Returns null rather than guessing when
// neither pattern is confidently found — no heading beats a wrong one.
function extractFormulaHeading(promptText: string): string | null {
  const withAcronym = promptText.match(/\(([A-Z]{2,6})\)/);
  if (withAcronym) return `${withAcronym[1]} Formula`;

  const cleaned = promptText.replace(LEADING_VERB, "");
  const named = cleaned.match(/^([A-Z][A-Za-z'-]*(?:[\s-][A-Z][A-Za-z'-]*){0,2})\s+(equation|formula|law)\b/);
  if (named) return `${named[1]} ${named[2][0].toUpperCase()}${named[2].slice(1).toLowerCase()}`;

  return null;
}

/** Renders "X_Y" as X with a subscript Y, for the rare card that uses that notation; otherwise renders the text as-is. */
function withSubscripts(text: string) {
  const parts = text.split(/([A-Za-z]+_[A-Za-z0-9]+)/g);
  if (parts.length === 1) return text;
  return parts.map((part, i) => {
    const sub = part.match(/^([A-Za-z]+)_([A-Za-z0-9]+)$/);
    if (!sub) return <span key={i}>{part}</span>;
    return (
      <span key={i}>
        {sub[1]}
        <sub>{sub[2]}</sub>
      </span>
    );
  });
}

export function FlashcardStudy({ cards }: { cards: StudyCard[] }) {
  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [saved, setSaved] = useState<Set<string>>(new Set(cards.filter((c) => c.isSaved).map((c) => c.id)));
  const [tally, setTally] = useState({ know: 0, learning: 0, dont_know: 0 });
  const [finished, setFinished] = useState(false);

  const card = cards[index];
  const isLast = index === cards.length - 1;
  const shownText = flipped ? card.back : card.front;
  const parsedFormula = parseFormulaCard(shownText);
  const formulaHeading = parsedFormula ? extractFormulaHeading(card.front) : null;

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
        className="mt-4 flex min-h-56 w-full flex-col rounded-2xl border border-border/60 bg-card p-6 shadow-sm ring-1 ring-foreground/5 transition-all hover:border-primary/40 hover:shadow-md focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary/50 sm:p-8"
      >
        <p className="text-center text-xs font-semibold uppercase tracking-widest text-primary">{card.topicName}</p>

        <div className="flex flex-1 flex-col items-center justify-center py-6">
          {parsedFormula ? (
            <>
              {formulaHeading && <p className="text-sm font-medium text-muted-foreground">{formulaHeading}</p>}
              <p className="mt-2 break-words text-center font-mono text-xl font-semibold leading-snug sm:text-2xl">
                {withSubscripts(parsedFormula.formula)}
              </p>

              {parsedFormula.legend.length > 0 ? (
                <div className="mt-6 w-full max-w-sm border-t border-border/60 pt-4">
                  <p className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">Where:</p>
                  <dl className="mt-2 space-y-1.5">
                    {parsedFormula.legend.map(({ symbol, definition }) => (
                      <div key={symbol} className="flex items-baseline gap-2 text-sm">
                        <dt className="shrink-0 font-mono font-semibold text-primary">{withSubscripts(symbol)}</dt>
                        <dd className="text-muted-foreground">{definition}</dd>
                      </div>
                    ))}
                  </dl>
                </div>
              ) : (
                parsedFormula.note && (
                  <p className="mt-6 max-w-sm border-t border-border/60 pt-4 text-center text-sm text-muted-foreground">
                    {parsedFormula.note}
                  </p>
                )
              )}
            </>
          ) : (
            <p className="text-center text-lg font-medium leading-relaxed">{shownText}</p>
          )}
        </div>

        <p className="text-center text-xs text-muted-foreground">{flipped ? "Tap to see the term" : "Tap to reveal the answer"}</p>
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
