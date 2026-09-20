"use client";

import { useState } from "react";
import { Sparkles } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { renderBlockMath, renderInline } from "@/lib/render-inline";

const SUGGESTIONS = ["Why am I weak in my lowest-mastery area?", "What should I review next?", "How am I doing overall?"];

export function StudyAssistant() {
  const [question, setQuestion] = useState("");
  const [loading, setLoading] = useState(false);
  const [text, setText] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function ask(q: string) {
    if (!q.trim()) return;
    setLoading(true);
    setError(null);
    setText(null);
    try {
      const res = await fetch("/api/ai/study-assistant", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ question: q }),
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

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-1.5 text-base">
          <Sparkles className="size-4 text-primary" /> Study Assistant
        </CardTitle>
        <CardDescription>Ask about your own performance data — mastery, accuracy, weak areas.</CardDescription>
      </CardHeader>
      <CardContent>
        <form
          onSubmit={(e) => {
            e.preventDefault();
            void ask(question);
          }}
          className="flex gap-2"
        >
          <input
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
            placeholder="Ask about your progress…"
            className="flex-1 rounded-md border border-border bg-background px-3 py-2 text-sm"
          />
          <Button type="submit" size="sm" disabled={loading || !question.trim()}>
            Ask
          </Button>
        </form>
        <div className="mt-2 flex flex-wrap gap-1.5">
          {SUGGESTIONS.map((s) => (
            <button
              key={s}
              type="button"
              onClick={() => {
                setQuestion(s);
                void ask(s);
              }}
              className="rounded-full border border-border px-2.5 py-1 text-xs text-muted-foreground hover:border-primary/40 hover:text-primary"
            >
              {s}
            </button>
          ))}
        </div>

        {loading && <p className="mt-3 text-sm text-muted-foreground">Thinking through your data…</p>}
        {error && <p className="mt-3 text-sm text-destructive">{error}</p>}
        {!loading && text && (
          <div className="mt-3 text-sm text-foreground">
            {text.split("\n").map((line, i) => {
              const trimmed = line.trim();
              if (!trimmed) return null;
              const blockMath = trimmed.match(/^\$\$(.+)\$\$$/);
              if (blockMath) return <div key={i}>{renderBlockMath(blockMath[1])}</div>;
              return (
                <p key={i} className="mt-1">
                  {renderInline(line)}
                </p>
              );
            })}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
