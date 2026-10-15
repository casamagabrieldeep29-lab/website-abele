"use client";

import { useEffect, useState } from "react";
import { FACEBOOK_URL, TIKTOK_URL } from "@/lib/social-links";
import { acknowledgeFollow } from "./actions";

const WAIT_SECONDS = 5;

/**
 * The only way past the announcement: open the official Facebook page, wait a few seconds, then continue.
 * There is deliberately no close button and no skip. (Facebook can't confirm a follow, so this only
 * guarantees the page was opened.)
 */
export function FollowGate({ next }: { next: string }) {
  const [opened, setOpened] = useState(false);
  const [left, setLeft] = useState(WAIT_SECONDS);

  useEffect(() => {
    if (!opened || left <= 0) return;
    const t = setTimeout(() => setLeft((n) => n - 1), 1000);
    return () => clearTimeout(t);
  }, [opened, left]);

  const ready = opened && left <= 0;

  return (
    <div className="mt-8 flex flex-col items-center gap-4">
      <a
        href={FACEBOOK_URL}
        target="_blank"
        rel="noopener noreferrer"
        onClick={() => setOpened(true)}
        className="inline-flex h-12 w-full max-w-sm items-center justify-center rounded-lg bg-[#1877F2] px-6 text-base font-semibold text-white shadow hover:opacity-90"
      >
        Follow ABELIEVER on Facebook
      </a>

      <a
        href={TIKTOK_URL}
        target="_blank"
        rel="noopener noreferrer"
        className="text-sm font-medium text-primary underline underline-offset-4"
      >
        Also follow us on TikTok: @abeliever.official
      </a>

      <form action={acknowledgeFollow} className="mt-2 w-full max-w-sm">
        <input type="hidden" name="next" value={next} />
        <button
          type="submit"
          disabled={!ready}
          className="inline-flex h-12 w-full items-center justify-center rounded-lg bg-primary px-6 text-base font-semibold text-primary-foreground disabled:cursor-not-allowed disabled:opacity-40"
        >
          I&apos;ve followed — continue
        </button>
      </form>

      <p className="text-xs text-muted-foreground" aria-live="polite">
        {!opened
          ? "Tap the Facebook button first to unlock the next step."
          : left > 0
            ? `Almost there… you can continue in ${left} second${left === 1 ? "" : "s"}.`
            : "Thank you! You can continue now."}
      </p>
    </div>
  );
}
