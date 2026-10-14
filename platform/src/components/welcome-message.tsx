"use client";

import { useEffect, useState } from "react";
import { Sparkles } from "lucide-react";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ANNOUNCEMENT, INSPIRATIONS } from "@/lib/welcome-message";

const SEEN_KEY = "abeliever-welcome-seen";

/**
 * Greets the student each time they open the website (once per browser
 * session, so moving between pages doesn't repeat it) with a random
 * inspirational line and the current announcement.
 */
export function WelcomeMessage({ name }: { name: string | null }) {
  const [open, setOpen] = useState(false);
  const [quote, setQuote] = useState("");

  useEffect(() => {
    try {
      if (sessionStorage.getItem(SEEN_KEY)) return;
      sessionStorage.setItem(SEEN_KEY, "1");
    } catch {
      // Storage blocked: still greet, just may repeat on a later page load.
    }
    // Reading sessionStorage is only possible after mount, so the open state has to be set here.
    /* eslint-disable react-hooks/set-state-in-effect */
    setQuote(INSPIRATIONS[Math.floor(Math.random() * INSPIRATIONS.length)]);
    setOpen(true);
    /* eslint-enable react-hooks/set-state-in-effect */
  }, []);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Sparkles className="size-5 text-primary" />
            {name ? `Welcome back, ${name}` : "Welcome back"}
          </DialogTitle>
          <DialogDescription className="pt-1 text-base leading-relaxed text-foreground">&ldquo;{quote}&rdquo;</DialogDescription>
        </DialogHeader>

        <div className="rounded-md border border-primary/30 bg-primary/5 p-3">
          <p className="text-sm font-semibold text-primary">{ANNOUNCEMENT.title}</p>
          <p className="mt-1 text-sm text-muted-foreground">{ANNOUNCEMENT.body}</p>
          <div className="mt-3 flex flex-wrap gap-2">
            <Button render={<a href={ANNOUNCEMENT.facebookUrl} target="_blank" rel="noopener noreferrer" />} nativeButton={false} size="sm" variant="secondary">
              Facebook
            </Button>
            <Button render={<a href={ANNOUNCEMENT.tiktokUrl} target="_blank" rel="noopener noreferrer" />} nativeButton={false} size="sm" variant="secondary">
              TikTok
            </Button>
          </div>
        </div>

        <DialogFooter>
          <Button onClick={() => setOpen(false)}>Let&apos;s study</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
