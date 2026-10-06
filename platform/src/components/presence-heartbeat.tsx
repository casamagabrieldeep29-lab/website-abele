"use client";

import { useEffect } from "react";
import { createClient } from "@/lib/supabase/client";

const PING_INTERVAL_MS = 60_000;
// Tab-switching fires visibilitychange repeatedly; don't turn each one into a write.
const MIN_GAP_MS = 30_000;

/**
 * Mounted once in the root layout so it runs on every page (including
 * Practice/Mock/PAES Quizzer sessions, which live outside the (app) route
 * group) — pings roughly once a minute while the tab is actually visible,
 * skipping backgrounded/minimized tabs so "online" reflects real activity
 * rather than a forgotten browser tab. Renders nothing.
 *
 * Writes straight from the browser to Supabase (the same own-row update the
 * old server action did, still enforced by RLS) so a ping costs zero Vercel
 * function invocations — it used to be a server action, which also ran the
 * auth proxy first. The local session read makes it a no-op for signed-out
 * visitors without any network call.
 */
export function PresenceHeartbeat() {
  useEffect(() => {
    const supabase = createClient();
    let lastPing = 0;
    let inFlight = false;

    async function ping() {
      if (document.visibilityState !== "visible" || inFlight) return;
      const now = Date.now();
      if (now - lastPing < MIN_GAP_MS) return;
      inFlight = true;
      try {
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!session) return;
        lastPing = now;
        await supabase
          .from("profiles")
          .update({ last_seen_at: new Date().toISOString() })
          .eq("id", session.user.id);
      } catch {
        // Presence is best-effort; never surface a failure.
      } finally {
        inFlight = false;
      }
    }

    void ping();
    const interval = setInterval(ping, PING_INTERVAL_MS);
    document.addEventListener("visibilitychange", ping);

    return () => {
      clearInterval(interval);
      document.removeEventListener("visibilitychange", ping);
    };
  }, []);

  return null;
}
