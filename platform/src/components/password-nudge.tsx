"use client";

import { useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { saveNoticeCampaignResponse } from "@/app/settings/notice-campaign-actions";

const DISMISSED_KEY = "abeliever_password_nudge_dismissed";

/**
 * A very obvious, persistent nudge for accounts that never set a password (profiles.has_password = false).
 * - A pop-up on every visit. "Remind me next time" only hides it for the rest of this browser tab, so it
 *   is back on the next visit until a password is set.
 * - A banner at the top of every page that stays until a password is set, and reopens the pop-up.
 * Saving reuses the same action as the notice-campaign pop-up, which also sets has_password.
 */
export function PasswordNudge() {
  const router = useRouter();
  // Server renders closed; on the client the pop-up opens unless it was dismissed in this tab.
  const [open, setOpen] = useState(() => {
    if (typeof window === "undefined") return false;
    try {
      return !sessionStorage.getItem(DISMISSED_KEY);
    } catch {
      return true;
    }
  });
  const [done, setDone] = useState(false);
  const [pending, setPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const formRef = useRef<HTMLFormElement>(null);

  if (done) return null;

  function later() {
    try {
      sessionStorage.setItem(DISMISSED_KEY, "1");
    } catch {
      // Storage can be blocked; the pop-up then simply returns on the next page load.
    }
    setOpen(false);
  }

  async function save() {
    const form = new FormData(formRef.current ?? undefined);
    const password = String(form.get("password") ?? "");
    const confirm = String(form.get("confirm") ?? "");
    if (password.length < 8) return setError("Use at least 8 characters.");
    if (password !== confirm) return setError("The two passwords don't match.");
    setPending(true);
    setError(null);
    const fd = new FormData();
    fd.set("password", password);
    const result = await saveNoticeCampaignResponse(fd);
    setPending(false);
    if (!result.ok) return setError(result.error);
    setDone(true);
    setOpen(false);
    router.refresh();
  }

  return (
    <>
      <div role="alert" className="-mx-4 -mt-4 mb-4 flex flex-wrap items-center justify-between gap-3 bg-amber-500 px-4 py-3 text-amber-950 sm:-mx-6 sm:-mt-6 sm:px-6 lg:-mx-8 lg:px-8 2xl:-mx-10 2xl:px-10">
        <p className="text-sm font-semibold">
          🔐 You haven&apos;t set a password yet. Set one now to sign in instantly, without waiting for an emailed code.
        </p>
        <Button type="button" size="sm" className="bg-amber-950 text-amber-50 hover:bg-amber-900" onClick={() => setOpen(true)}>
          Set my password
        </Button>
      </div>

      <Dialog open={open} onOpenChange={(next) => (next ? setOpen(true) : later())}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle className="text-xl">🔐 Set your password now</DialogTitle>
            <DialogDescription>
              Your account doesn&apos;t have a password yet. With one, you sign in to ABELIEVER in seconds, with no waiting
              for an emailed code, and your account is better protected. It takes about 20 seconds.
            </DialogDescription>
          </DialogHeader>

          <form
            ref={formRef}
            className="space-y-4"
            onSubmit={(e) => {
              e.preventDefault();
              void save();
            }}
          >
            <div className="space-y-2">
              <Label htmlFor="pw-nudge-password">New password (at least 8 characters)</Label>
              <Input id="pw-nudge-password" name="password" type="password" autoComplete="new-password" minLength={8} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="pw-nudge-confirm">Type it again</Label>
              <Input id="pw-nudge-confirm" name="confirm" type="password" autoComplete="new-password" minLength={8} />
            </div>
            {error && <p className="text-sm text-destructive">{error}</p>}
          </form>

          <DialogFooter>
            <Button type="button" variant="ghost" onClick={later} disabled={pending}>
              Remind me next time
            </Button>
            <Button type="button" onClick={save} disabled={pending}>
              {pending ? "Saving…" : "Save my password"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
