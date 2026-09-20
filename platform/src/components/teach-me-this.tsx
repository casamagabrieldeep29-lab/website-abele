"use client";

import { useState } from "react";
import { Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { renderBlockMath, renderInline } from "@/lib/render-inline";

const FOLLOW_UPS = ["Explain simpler", "Give an example", "Quiz me on this concept"];

function renderText(text: string) {
  return text.split("\n").map((line, i) => {
    const trimmed = line.trim();
    if (!trimmed) return null;
    const blockMath = trimmed.match(/^\$\$(.+)\$\$$/);
    if (blockMath) {
      return <div key={i}>{renderBlockMath(blockMath[1])}</div>;
    }
    if (trimmed.startsWith("### ")) {
      return (
        <p key={i} className="mt-3 text-xs font-semibold uppercase tracking-wide text-primary first:mt-0">
          {renderInline(trimmed.slice(4))}
        </p>
      );
    }
    if (trimmed.startsWith("* ") || trimmed.startsWith("- ")) {
      return (
        <li key={i} className="mt-1 ml-4 list-disc text-sm text-foreground">
          {renderInline(trimmed.slice(2))}
        </li>
      );
    }
    return (
      <p key={i} className="mt-1 text-sm text-foreground">
        {renderInline(line)}
      </p>
    );
  });
}

export function TeachMeThis({ attemptId, questionId }: { attemptId: string; questionId: string }) {
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [text, setText] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

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
          <div>{renderText(text)}</div>
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
