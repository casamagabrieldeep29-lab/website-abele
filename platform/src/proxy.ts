import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { updateSession } from "@/lib/supabase/proxy";

// ABELIEVER moved to www.abelieverofficial.com (2026-10). Anyone who opens one
// of these old addresses sees the "we've moved" announcement instead of the
// site, so continuing to study means switching to the new address. Preview
// deployments and localhost are not in this list, so they keep working.
const MOVED_HOSTS = new Set(["abeliever.dev", "www.abeliever.dev", "abeliever.vercel.app"]);

export function proxy(request: NextRequest) {
  const host = (request.headers.get("host") ?? "").toLowerCase().split(":")[0];

  if (MOVED_HOSTS.has(host)) {
    const response = NextResponse.rewrite(new URL("/moved", request.url));
    response.headers.set("X-Robots-Tag", "noindex, nofollow");
    response.headers.set("Cache-Control", "no-store");
    return response;
  }

  return updateSession(request);
}

export const config = {
  matcher: [
    {
      // Every proxy run is a billed invocation, so skip everything that
      // doesn't need an auth check: build assets, generated metadata/icon
      // routes, crawler files, the anonymous client-error beacon, and image
      // files.
      source:
        "/((?!_next/static|_next/image|favicon.ico|icon|apple-icon|opengraph-image|twitter-image|robots.txt|sitemap.xml|api/log-client-error|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico|txt|xml)$).*)",
      // Link prefetches (one per visible link, per page view) carry no user
      // data worth gating — the real navigation still goes through the proxy
      // and every page re-checks auth itself.
      missing: [
        { type: "header", key: "next-router-prefetch" },
        { type: "header", key: "purpose", value: "prefetch" },
      ],
    },
  ],
};
