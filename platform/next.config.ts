import type { NextConfig } from "next";

const isDev = process.env.NODE_ENV === "development";

// No nonce-based CSP: that requires every page to render dynamically
// (no static optimization) and risks breaking hydration without a staging
// environment to verify against. 'unsafe-inline' is required for both
// script-src (Next's own inline hydration scripts) and style-src (React
// inline `style={{...}}` used across the app, e.g. progress bar widths).
// The app has no dangerouslySetInnerHTML and no raw HTML rendering, so the
// residual inline-script XSS risk this leaves is low. connect-src allows
// the Supabase REST/Auth API, which client components call directly.
const cspHeader = `
  default-src 'self';
  script-src 'self' 'unsafe-inline'${isDev ? " 'unsafe-eval'" : ""};
  style-src 'self' 'unsafe-inline';
  img-src 'self' blob: data:;
  font-src 'self';
  connect-src 'self' https://*.supabase.co;
  object-src 'none';
  base-uri 'self';
  form-action 'self';
  frame-ancestors 'none';
  upgrade-insecure-requests;
`;

const MAIN_ORIGIN = "https://www.abelieverofficial.com";

const nextConfig: NextConfig = {
  // The bare new domain lands on the main address. Temporary (307) for now so
  // a mistake is undoable; make it permanent once verified. The OLD addresses
  // (abeliever.dev, www.abeliever.dev, abeliever.vercel.app) are not redirected
  // here: src/proxy.ts shows them the "we've moved" announcement instead.
  async redirects() {
    return ["abelieverofficial.com"].map((host) => ({
      source: "/:path*",
      has: [{ type: "host" as const, value: host }],
      destination: `${MAIN_ORIGIN}/:path*`,
      permanent: false,
    }));
  },
  async headers() {
    return [
      {
        source: "/(.*)",
        headers: [
          { key: "Content-Security-Policy", value: cspHeader.replace(/\s{2,}/g, " ").trim() },
          { key: "X-Frame-Options", value: "DENY" },
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
          { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=()" },
          { key: "Strict-Transport-Security", value: "max-age=63072000; includeSubDomains; preload" },
        ],
      },
    ];
  },
};

export default nextConfig;
