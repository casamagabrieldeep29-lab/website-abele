import type { MetadataRoute } from "next";
import { PUBLIC_ORIGIN } from "@/lib/public-origin";

const SITE_URL = PUBLIC_ORIGIN;

// Keeps crawlers off everything behind login — a bot hitting those is just a
// wasted proxy + function invocation that ends in a redirect. Deliberately a
// disallow-list (not "Disallow: /") so social crawlers can still fetch the
// share image and icons.
export default function robots(): MetadataRoute.Robots {
  return {
    rules: [
      {
        userAgent: "*",
        disallow: [
          "/api/",
          "/auth/",
          "/admin",
          "/dashboard",
          "/practice",
          "/mock",
          "/mistakes",
          "/quick",
          "/quiz-builder",
          "/notes",
          "/progress",
          "/question-bank",
          "/recalled",
          "/study-plan",
          "/flashcards",
          "/reviewers",
          "/paes",
          "/profile",
          "/settings",
          "/topics",
          "/upgrade",
          "/trial-expired",
        ],
      },
    ],
    sitemap: `${SITE_URL}/sitemap.xml`,
  };
}
