"use client";

import { useRef, useState } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { saveProfileDetails, dismissProfilePrompt } from "@/app/settings/actions";

type AcademicStatus = "student" | "reviewee";

/**
 * Shown once to any account missing academic_status — every account that
 * existed before the signup redesign shipped (2026-09-28), plus anyone who
 * skipped these optional fields at signup. Dismissing or saving either one
 * sets a flag server-side (see saveProfileDetails/dismissProfilePrompt in
 * settings/actions.ts) so this never becomes a recurring nag.
 */
export function ProfileCompletionModal() {
  const [open, setOpen] = useState(true);
  const [school, setSchool] = useState("");
  const [academicStatus, setAcademicStatus] = useState<AcademicStatus | "">("");
  const [pending, setPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const formRef = useRef<HTMLFormElement>(null);

  async function handleSave() {
    setPending(true);
    setError(null);
    const formData = new FormData(formRef.current ?? undefined);
    const result = await saveProfileDetails(formData);
    setPending(false);
    if (!result.ok) {
      setError(result.error);
      return;
    }
    setOpen(false);
  }

  async function handleDismiss() {
    setOpen(false);
    await dismissProfilePrompt();
  }

  return (
    <Dialog open={open} onOpenChange={(next) => { if (!next) void handleDismiss(); }}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>A couple of quick things</DialogTitle>
          <DialogDescription>
            Optional, and it only takes a second — helps us understand who&apos;s reviewing with ABELIEVER. You can
            also set a password here if you&apos;d rather sign in that way instead of an emailed code.
          </DialogDescription>
        </DialogHeader>

        <form ref={formRef} className="space-y-4" onSubmit={(e) => { e.preventDefault(); void handleSave(); }}>
          <div className="space-y-2">
            <Label htmlFor="pcm-school">School</Label>
            <Input
              id="pcm-school"
              name="school"
              placeholder="e.g. Central Luzon State University"
              value={school}
              onChange={(e) => setSchool(e.target.value)}
              autoComplete="organization"
            />
          </div>

          <div className="space-y-2">
            <Label>Status</Label>
            <div className="grid grid-cols-2 gap-2">
              {(
                [
                  { key: "student", label: "Still studying" },
                  { key: "reviewee", label: "Reviewing for the boards" },
                ] as const
              ).map((opt) => (
                <button
                  key={opt.key}
                  type="button"
                  onClick={() => setAcademicStatus(opt.key)}
                  className={`rounded-lg border px-3 py-2 text-xs font-medium transition-colors ${
                    academicStatus === opt.key
                      ? "border-primary bg-primary/5 text-primary"
                      : "border-border text-muted-foreground hover:bg-muted"
                  }`}
                >
                  {opt.label}
                </button>
              ))}
            </div>
            <input type="hidden" name="academicStatus" value={academicStatus} />
          </div>

          <div className="space-y-2">
            <Label htmlFor="pcm-password">Set a password (optional)</Label>
            <Input
              id="pcm-password"
              name="password"
              type="password"
              placeholder="Leave blank to keep signing in with an emailed code"
              autoComplete="new-password"
              minLength={8}
            />
          </div>

          {error && <p className="text-sm text-destructive">{error}</p>}
        </form>

        <DialogFooter>
          <Button type="button" variant="ghost" onClick={handleDismiss} disabled={pending}>
            Maybe later
          </Button>
          <Button type="button" onClick={handleSave} disabled={pending}>
            {pending ? "Saving…" : "Save"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
