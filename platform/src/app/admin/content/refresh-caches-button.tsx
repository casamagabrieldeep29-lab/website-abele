"use client";

import { useState, useTransition } from "react";
import { Button } from "@/components/ui/button";
import { refreshQuestionCaches } from "./actions";

/** One click after a bulk import/correction so students see the new questions immediately. */
export function RefreshCachesButton() {
  const [isPending, startTransition] = useTransition();
  const [done, setDone] = useState(false);
  return (
    <div className="flex items-center gap-2">
      <Button
        type="button"
        variant="outline"
        size="sm"
        disabled={isPending}
        onClick={() =>
          startTransition(async () => {
            await refreshQuestionCaches();
            setDone(true);
          })
        }
      >
        {isPending ? "Refreshing…" : "Refresh question lists"}
      </Button>
      {done && <span className="text-xs text-success">Refreshed. Students now see the latest questions.</span>}
    </div>
  );
}
