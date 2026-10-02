import "server-only";
import { randomUUID } from "crypto";
import { headers } from "next/headers";
import { createAdminClient } from "@/lib/supabase/admin";

/**
 * Best-effort caller IP for rate-limiting unauthenticated routes (signup,
 * login) — same x-forwarded-for read as getSiteUrl() in site-url.ts, which
 * Vercel usually sets to the real client IP.
 *
 * FIXED 2026-10-02: this used to fall back to the constant "unknown" when
 * the header was missing, reasoning that *a* shared bucket beats bypassing
 * the limit entirely. That was backwards — a shared bucket across every
 * caller the header happens to be missing for is far worse than slightly
 * under-protecting one unidentifiable request: it caused a real production
 * incident where every user got locked out of login together (15-per-15-min
 * budget on `login:unknown`, shared by everyone who hit the fallback,
 * self-clearing only once the window rolled over — exactly the "all users
 * can't sign in... but it's working again now" report this was found from).
 * Now each unresolvable request gets its own one-off key instead, which is
 * never seen again — functionally unlimited for that edge case, matching
 * checkRateLimit's own "fail open beats breaking everyone" philosophy below.
 */
export async function getClientIp(): Promise<string> {
  const h = await headers();
  const forwardedFor = h.get("x-forwarded-for");
  if (forwardedFor) return forwardedFor.split(",")[0].trim();
  return `unknown:${randomUUID()}`;
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
