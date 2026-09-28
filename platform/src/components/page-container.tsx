import { cn } from "@/lib/utils";

/**
 * Shared width primitive for every (app) page — replaces each page hand-
 * rolling its own `mx-auto max-w-Nxl` wrapper (Gabriel's explicit "global
 * content space & layout redesign", 2026-09-28: pages were wasting most of
 * the desktop viewport inside an arbitrarily narrow centered column). The
 * fix is per-page INTENTIONAL width, not one universal max-width and not
 * unconditional full-bleed — pick the size that matches what the page
 * actually holds:
 *
 * - "form"    narrow single-column forms (login-style, a lone settings card)
 * - "content" reading-width lists/cards (Saved, Settings, Profile, Notes)
 * - "hub"     card grids and moderate dashboards (PAES hub, Study Plan)
 * - "wide"    configuration-heavy or multi-column workspaces (Custom Quiz)
 * - "full"    no cap at all — the rare page that should truly go edge to edge
 *
 * "hub" and "wide" both widen further at xl/2xl (same idiom the dashboard
 * page already established with its own `2xl:max-w-[1680px]`) so large
 * desktop monitors actually get used instead of the layout freezing at a
 * mid-size cap.
 */
const SIZE_CLASSES = {
  form: "max-w-sm",
  content: "max-w-4xl",
  hub: "max-w-5xl xl:max-w-6xl 2xl:max-w-[1680px]",
  wide: "max-w-6xl xl:max-w-[1500px] 2xl:max-w-[1800px]",
  full: "max-w-none",
} as const;

export type PageContainerSize = keyof typeof SIZE_CLASSES;

export function PageContainer({
  size = "hub",
  className,
  children,
}: {
  size?: PageContainerSize;
  className?: string;
  children: React.ReactNode;
}) {
  return <div className={cn("mx-auto w-full", SIZE_CLASSES[size], className)}>{children}</div>;
}
