import type { MetadataRoute } from "next";
import { PUBLIC_ORIGIN } from "@/lib/public-origin";

const SITE_URL = PUBLIC_ORIGIN;

export default function sitemap(): MetadataRoute.Sitemap {
  return ["/", "/login", "/signup", "/privacy"].map((path) => ({
    url: `${SITE_URL}${path === "/" ? "" : path}`,
  }));
}
