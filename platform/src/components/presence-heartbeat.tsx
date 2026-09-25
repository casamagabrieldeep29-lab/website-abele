"use client";

import { useEffect } from "react";
import { pingPresence } from "@/lib/presence-actions";

const PING_INTERVAL_MS = 60_000;

/**
 * Mounted once in the root layout so it runs on every page (including
 * Practice/Mock/PAES Quizzer sessions, which live outside the (app) route
 * group) — pings roughly once a minute while the tab is actually visible,
 * skipping backgrounded/minimized tabs so "online" reflects real activity
 * rather than a forgotten browser tab. Renders nothing.
 */
export function PresenceHeartbeat() {
  useEffect(() => {
    function ping() {
      if (document.visibilityState === "visible") {
        void pingPresence();
      }
    }

    ping();
    const interval = setInterval(ping, PING_INTERVAL_MS);
    document.addEventListener("visibilitychange", ping);

    return () => {
      clearInterval(interval);
      document.removeEventListener("visibilitychange", ping);
    };
  }, []);

  return null;
}
