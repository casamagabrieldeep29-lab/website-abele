"use client";

import { useEffect, useState } from "react";
import { Sparkles } from "lucide-react";
import { Playfair_Display } from "next/font/google";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ANNOUNCEMENT, INSPIRATIONS } from "@/lib/welcome-message";

// Elegant italic serif for the quote only; loaded once and scoped to this component.
const quoteFont = Playfair_Display({ subsets: ["latin"], style: "italic", weight: ["400", "500"], display: "swap" });

const LAST_SHOWN_KEY = "abeliever-welcome-last-shown";
const LAST_QUOTE_KEY = "abeliever-welcome-last-quote";
// Opening the site again after this long counts as a new visit and greets again;
// clicking around inside the app does not.
const NEW_VISIT_AFTER_MS = 30 * 60 * 1000;

/**
 * Greets the student each time they open the website with a different
 * inspirational line (never the same one twice in a row) plus the current
 * announcement. Moving between pages during one visit does not repeat it.
 */
export function WelcomeMessage({ name }: { name: string | null }) {
  const [open, setOpen] = useState(false);
  const [quote, setQuote] = useState("");

  useEffect(() => {
    let lastQuote = -1;
    try {
      const lastShown = Number(localStorage.getItem(LAST_SHOWN_KEY) ?? 0);
      if (Date.now() - lastShown < NEW_VISIT_AFTER_MS) return;
      lastQuote = Number(localStorage.getItem(LAST_QUOTE_KEY) ?? -1);
    } catch {
      // Storage blocked: still greet, just may repeat on a later page load.
    }
    let next = Math.floor(Math.random() * INSPIRATIONS.length);
    if (INSPIRATIONS.length > 1 && next === lastQuote) next = (next + 1) % INSPIRATIONS.length;
    try {
      localStorage.setItem(LAST_SHOWN_KEY, String(Date.now()));
      localStorage.setItem(LAST_QUOTE_KEY, String(next));
    } catch {
      // ignore
    }
    // Reading storage is only possible after mount, so the open state has to be set here.
    /* eslint-disable react-hooks/set-state-in-effect */
    setQuote(INSPIRATIONS[next]);
    setOpen(true);
    /* eslint-enable react-hooks/set-state-in-effect */
  }, []);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogContent className="gap-4 p-5 sm:max-w-md">
        <DialogHeader className="gap-3 pr-8">
          <DialogTitle className="flex items-center gap-2 text-lg leading-tight font-semibold tracking-tight">
            <Sparkles className="size-4 shrink-0 text-primary" />
            <span className="min-w-0 truncate">{name ? `Welcome back, ${name}` : "Welcome back"}</span>
          </DialogTitle>
          <DialogDescription className={`border-l-2 border-primary/70 pl-3 text-lg leading-relaxed text-foreground ${quoteFont.className}`}>
            {quote}
          </DialogDescription>
        </DialogHeader>

        <div className="flex flex-col gap-2 rounded-lg border border-border/70 bg-background/30 px-3 py-2.5 sm:flex-row sm:items-center sm:justify-between sm:gap-3">
          <div className="min-w-0">
            <p className="text-sm font-medium text-foreground">{ANNOUNCEMENT.title}</p>
            <p className="mt-0.5 text-xs leading-snug text-foreground/70">{ANNOUNCEMENT.body}</p>
          </div>
          <div className="flex shrink-0 gap-1.5">
            <Button render={<a href={ANNOUNCEMENT.facebookUrl} target="_blank" rel="noopener noreferrer" />} nativeButton={false} size="sm" variant="outline" className="border-foreground/25 text-foreground hover:bg-foreground/10">
              Facebook
            </Button>
            <Button render={<a href={ANNOUNCEMENT.tiktokUrl} target="_blank" rel="noopener noreferrer" />} nativeButton={false} size="sm" variant="outline" className="border-foreground/25 text-foreground hover:bg-foreground/10">
              TikTok
            </Button>
          </div>
        </div>

        <Button size="lg" className="h-10 w-full text-sm font-semibold" onClick={() => setOpen(false)}>
          Let&apos;s study
        </Button>
      </DialogContent>
    </Dialog>
  );
}
