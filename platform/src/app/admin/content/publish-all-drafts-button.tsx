"use client";

import { useState, useTransition } from "react";
import { Button } from "@/components/ui/button";
import { publishAllDrafts } from "./actions";

export function PublishAllDraftsButton({ draftCount }: { draftCount: number }) {
  const [expanded, setExpanded] = useState(false);
  const [isPending, startTransition] = useTransition();
  const [result, setResult] = useState<number | null>(null);

  if (draftCount === 0) return null;

  if (result !== null) {
    return (
      <p className="rounded-md border border-success/30 bg-success/5 px-3 py-2 text-sm text-success">
        Published {result} question{result === 1 ? "" : "s"}.
      </p>
    );
  }

  if (!expanded) {
    return (
      <Button type="button" variant="outline" size="sm" onClick={() => setExpanded(true)}>
        Publish All Drafts ({draftCount})
      </Button>
    );
  }

  return (
    <div className="space-y-2 rounded-md border border-border bg-muted/30 p-3">
      <p className="text-sm">
        This publishes all <strong>{draftCount}</strong> draft questions across every topic — not just
        one topic. Flagged questions are excluded and won&apos;t be touched; review those separately from
        the Flagged Questions link above. Students will immediately see the rest in Practice, Mock Exams,
        Quiz Builder, and Recalled Questions. You can unpublish individual questions afterward if needed.
      </p>
      <div className="flex gap-2">
        <Button
          type="button"
          size="sm"
          disabled={isPending}
          onClick={() =>
            startTransition(async () => {
              const { published } = await publishAllDrafts();
              setResult(published);
            })
          }
        >
          {isPending ? "Publishing…" : `Yes, publish all ${draftCount}`}
        </Button>
        <Button type="button" variant="outline" size="sm" onClick={() => setExpanded(false)} disabled={isPending}>
          Cancel
        </Button>
      </div>
    </div>
  );
}
