"use client";

import { useRef, useState } from "react";
import { Button } from "@/components/ui/button";
import { autoCategorizeBatch } from "./actions";

export function AutoCategorizePanel({ initialUncategorized }: { initialUncategorized: number }) {
  const [remaining, setRemaining] = useState(initialUncategorized);
  const [processed, setProcessed] = useState(0);
  const [running, setRunning] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const stopRef = useRef(false);

  if (initialUncategorized === 0 && remaining === 0 && processed === 0) {
    return null;
  }

  async function run() {
    stopRef.current = false;
    setRunning(true);
    setError(null);
    for (;;) {
      if (stopRef.current) break;
      const result = await autoCategorizeBatch();
      if (result.error) {
        setError(result.error);
        break;
      }
      setProcessed((n) => n + result.processed);
      setRemaining(result.remaining);
      if (result.remaining === 0 || result.processed === 0) break;
    }
    setRunning(false);
  }

  return (
    <div className="mb-6 rounded-lg border border-primary/30 bg-primary/5 p-4">
      <p className="text-sm font-medium">Auto-categorize questions (Term / Solving) with AI</p>
      <p className="mt-1 text-xs text-muted-foreground">
        {remaining > 0
          ? `${remaining} question${remaining === 1 ? "" : "s"} not yet categorized.`
          : "All questions are categorized."}
        {processed > 0 && ` ${processed} categorized this session.`}
      </p>

      {error && <p className="mt-2 text-xs text-destructive">{error}</p>}

      <div className="mt-3 flex gap-2">
        {remaining > 0 && (
          <Button type="button" size="sm" onClick={run} disabled={running}>
            {running ? "Categorizing…" : "Auto-categorize all with AI"}
          </Button>
        )}
        {running && (
          <Button type="button" size="sm" variant="outline" onClick={() => (stopRef.current = true)}>
            Stop
          </Button>
        )}
      </div>

      <p className="mt-2 text-[11px] text-muted-foreground">
        AI classification is a best guess, not verified fact — spot-check and adjust individual questions
        afterward via each question&apos;s Category dropdown.
      </p>
    </div>
  );
}
