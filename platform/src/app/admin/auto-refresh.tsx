"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";

/**
 * Re-fetches this server-rendered page on an interval so admin-facing data
 * that changes without any action of the admin's own (e.g. the "who's
 * active" green dot, driven by students' own heartbeat pings) stays
 * reasonably fresh without a manual reload. Renders nothing.
 */
export function AutoRefresh({ intervalMs = 30_000 }: { intervalMs?: number }) {
  const router = useRouter();

  useEffect(() => {
    const interval = setInterval(() => router.refresh(), intervalMs);
    return () => clearInterval(interval);
  }, [router, intervalMs]);

  return null;
}
