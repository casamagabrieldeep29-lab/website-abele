"use client";

import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import { Button } from "@/components/ui/button";

const NEW_ORIGIN = "https://www.abelieverofficial.com";
const NEW_HOST = "abelieverofficial.com";
const SECONDS = 15;

/**
 * The one way forward from the announcement: a big button to the same page on
 * the new address, plus a short countdown that takes them there automatically.
 */
export function MovedActions() {
  const [left, setLeft] = useState(SECONDS);
  const [copied, setCopied] = useState(false);

  // Keep the student on the page they were trying to reach (the address bar
  // still shows the old path even though the announcement is what rendered).
  const pathname = usePathname();
  const target = NEW_ORIGIN + (pathname === "/moved" || pathname === "/" ? "" : pathname);

  useEffect(() => {
    if (left <= 0) {
      window.location.href = target;
      return;
    }
    const t = setTimeout(() => setLeft((n) => n - 1), 1000);
    return () => clearTimeout(t);
  }, [left, target]);

  async function copy() {
    try {
      await navigator.clipboard.writeText(NEW_ORIGIN);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      // Clipboard can be blocked; the address is shown on the page anyway.
    }
  }

  return (
    <div className="mt-8 flex flex-col items-center gap-4">
      <Button
        render={<a href={target}>Continue to {NEW_HOST} →</a>}
        nativeButton={false}
        size="lg"
        className="h-12 px-8 text-base"
      />
      <p className="text-sm text-muted-foreground" aria-live="polite">
        Taking you there in {Math.max(left, 0)} second{left === 1 ? "" : "s"}…
      </p>
      <button type="button" onClick={copy} className="text-xs text-muted-foreground underline underline-offset-4">
        {copied ? "Copied!" : "Copy the new address"}
      </button>
    </div>
  );
}
