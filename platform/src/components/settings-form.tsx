"use client";

import { useState, useTransition, type ReactNode } from "react";
import { Button } from "@/components/ui/button";

type SaveResult = { ok: true } | { ok: false; error: string };

/**
 * Shared save-status wrapper for Profile/Settings forms: Saving... / Saved ✓
 * / an inline error — never a popup. Inputs stay uncontrolled (defaultValue),
 * so on error the user's typed value is untouched, nothing is discarded.
 */
export function SettingsForm({
  action,
  children,
  submitLabel = "Save",
}: {
  action: (formData: FormData) => Promise<SaveResult>;
  children: ReactNode;
  submitLabel?: string;
}) {
  const [status, setStatus] = useState<"idle" | "saved" | "error">("idle");
  const [error, setError] = useState<string | null>(null);
  const [isPending, startTransition] = useTransition();

  function handleSubmit(formData: FormData) {
    setStatus("idle");
    setError(null);
    startTransition(async () => {
      const result = await action(formData);
      if (result.ok) {
        setStatus("saved");
      } else {
        setStatus("error");
        setError(result.error);
      }
    });
  }

  return (
    <form action={handleSubmit} className="space-y-4">
      {children}
      <div className="flex items-center gap-3">
        <Button type="submit" size="sm" disabled={isPending}>
          {submitLabel}
        </Button>
        <span
          role="status"
          className={
            status === "error"
              ? "text-xs text-destructive"
              : "text-xs text-muted-foreground"
          }
        >
          {isPending ? "Saving…" : status === "saved" ? "Saved ✓" : status === "error" ? error : ""}
        </span>
      </div>
    </form>
  );
}
