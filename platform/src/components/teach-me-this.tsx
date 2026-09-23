"use client";

import { useEffect, useRef, useState } from "react";
import { Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { AIMarkdown } from "@/components/ai-markdown";

const FOLLOW_UPS = ["Explain simpler", "Give an example", "Quiz me on this concept"];

/**
 * `autoStart`: skip the manual "Teach me this" click and fetch immediately
 * — used when a question has no admin-authored explanation at all, so the
 * Solution panel would otherwise show nothing. Only fires when there's
 * genuinely no static explanation to fall back on (see practice-session.tsx),
 * not on every question, since each fetch is a real AI call against the
 * shared daily quota.
 */
export function TeachMeThis({
  attemptId,
  questionId,
  autoStart = false,
}: {
  attemptId: string;
  questionId: string;
  autoStart?: boolean;
}) {
  const [open, setOpen] = useState(autoStart);
  const [loading, setLoading] = useState(false);
  const [text, setText] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const autoStarted = useRef(false);

  async function ask(followUp?: string) {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/ai/teach-me", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ attemptId, questionId, followUp }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.error ?? "AI explanation is temporarily unavailable. Please try again.");
        return;
      }
      setText(data.text);
    } catch {
      setError("AI explanation is temporarily unavailable. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    if (autoStart && !autoStarted.current) {
      autoStarted.current = true;
      void ask();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (!open) {
    return (
      <button
        type="button"
        onClick={() => {
          setOpen(true);
          void ask();
        }}
        className="mt-3 flex items-center gap-1.5 text-xs font-medium text-primary hover:underline"
      >
        <Sparkles className="size-3.5" />
        Teach me this
      </button>
    );
  }

  return (
    <div className="mt-3 rounded-md border border-primary/20 bg-primary/5 p-3">
      {loading && <p className="text-sm text-muted-foreground">Thinking through this concept…</p>}
      {error && (
        <div>
          <p className="text-sm text-destructive">{error}</p>
          <Button
            type="button"
            size="sm"
            variant="outline"
            className="mt-2 h-7 text-xs"
            onClick={() => void ask()}
          >
            Retry
          </Button>
        </div>
      )}
      {!loading && text && (
        <>
          <AIMarkdown text={text} />
          <div className="mt-3 flex flex-wrap gap-1.5 border-t border-primary/10 pt-2.5">
            {FOLLOW_UPS.map((f) => (
              <Button
                key={f}
                type="button"
                size="sm"
                variant="outline"
                className="h-7 text-xs"
                onClick={() => {
                  setText(null);
                  void ask(f);
                }}
              >
                {f}
              </Button>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
