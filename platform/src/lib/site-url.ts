import { headers } from "next/headers";

/**
 * Absolute origin for building auth redirect/callback URLs (invite emails,
 * magic links). NEXT_PUBLIC_SITE_URL is an explicit override for when the
 * incoming request's own host isn't the public one (e.g. behind a proxy
 * that doesn't forward it) — normally left unset. Without it, this derives
 * the origin from the actual request instead of hardcoding a guess: on
 * Vercel that's always the real deployed domain, so an invite/magic-link
 * email links back to production even if the env var was never
 * configured, rather than silently defaulting to localhost.
 */
export async function getSiteUrl(): Promise<string> {
  if (process.env.NEXT_PUBLIC_SITE_URL) return process.env.NEXT_PUBLIC_SITE_URL;

  const h = await headers();
  const host = h.get("x-forwarded-host") ?? h.get("host");
  if (host) {
    const proto = h.get("x-forwarded-proto") ?? "https";
    return `${proto}://${host}`;
  }

  return "http://localhost:3000";
}
