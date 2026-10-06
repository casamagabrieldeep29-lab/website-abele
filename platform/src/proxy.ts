import type { NextRequest } from "next/server";
import { updateSession } from "@/lib/supabase/proxy";

export function proxy(request: NextRequest) {
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
