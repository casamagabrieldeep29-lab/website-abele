"use client";

/**
 * Client-side counterpart to src/lib/log-error.ts (which is server-only and
 * can't be imported from a Client Component) — used by app/error.tsx and
 * app/global-error.tsx to report a real render crash through
 * /api/log-client-error instead of it only ever reaching the browser
 * console, which nobody is watching.
 *
 * Never throws — a failed report must never compound the crash it's
 * trying to report.
 */
export async function logClientError(context: string, error: Error): Promise<void> {
  console.error(`[${context}]`, error);
  try {
    await fetch("/api/log-client-error", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ context, message: error.message }),
    });
  } catch {
    // Already console.error'd above — nothing more to do.
  }
}
