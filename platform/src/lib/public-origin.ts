/**
 * Canonical public origin for SEO / social-share metadata (og:url, og:image,
 * canonical link, sitemap). Deliberately NOT NEXT_PUBLIC_SITE_URL: that one
 * drives auth redirects and may point at a preview/old host, whereas share
 * cards must always resolve to the real production domain.
 */
export const PUBLIC_ORIGIN =
  process.env.NODE_ENV === "production" ? "https://www.abeliever.dev" : "http://localhost:3000";
