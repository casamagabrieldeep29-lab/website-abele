import "server-only";
import { headers } from "next/headers";
import { createAdminClient } from "@/lib/supabase/admin";

/**
 * Best-effort caller IP for rate-limiting unauthenticated routes (signup,
 * login) — same x-forwarded-for read as getSiteUrl() in site-url.ts, which
 * Vercel always sets to the real client IP. Falls back to a constant so an
 * unknown-IP request still gets *a* shared bucket instead of bypassing the
 * limit entirely (worse than being slightly too strict for the rare case
 * this header is missing).
 */
export async function getClientIp(): Promise<string> {
  const h = await headers();
  const forwardedFor = h.get("x-forwarded-for");
  if (forwardedFor) return forwardedFor.split(",")[0].trim();
  return "unknown";
}

/**
 * Fixed-window rate limit backed by Postgres (see patch 045_rate_limits.sql)
 * — a shared table is the only reliable counter across Vercel's ephemeral,
 * multi-instance serverless functions. Uses the service-role client since
 * this is infra bookkeeping (not user data), and because unauthenticated
 * callers like signup have no session for an RLS-scoped client to attach
 * to. Fails OPEN (allows the request) if the check itself errors — an
 * outage in this bookkeeping table must never be why a real user can't sign
 * up or pay, it just means that one request went unprotected.
 */
export async function checkRateLimit(key: string, limit: number, windowSeconds: number): Promise<boolean> {
  const admin = createAdminClient();
  const { data, error } = await admin.rpc("check_rate_limit", {
    p_key: key,
    p_limit: limit,
    p_window_seconds: windowSeconds,
  });

  if (error) {
    console.error("[rate-limit] check_rate_limit failed, failing open:", error.message);
    return true;
  }
  return Boolean(data);
}
