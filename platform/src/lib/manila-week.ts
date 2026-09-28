/**
 * Shared "group rows into collapsible per-week sections, Manila time,
 * Monday-start" helpers — first written for /admin/users, reused as-is for
 * /admin/payments' "Recently auto-approved" list (Gabriel's explicit "this
 * section should be similar to user like per week", 2026-09-28) rather than
 * duplicating the same date math in a second admin page.
 */
export const MANILA_TZ = "Asia/Manila";

// YYYY-MM-DD in Philippine time, independent of the server's own timezone.
export function dayKeyManila(iso: string): string {
  return new Intl.DateTimeFormat("en-CA", { timeZone: MANILA_TZ }).format(new Date(iso));
}

// Monday's YYYY-MM-DD (UTC-safe, since dayKeyManila already collapsed away
// the timezone) for the Manila-local week a timestamp falls in.
export function weekKeyManila(iso: string): string {
  const d = new Date(`${dayKeyManila(iso)}T00:00:00Z`);
  const daysSinceMonday = (d.getUTCDay() + 6) % 7; // getUTCDay: 0=Sun..6=Sat
  d.setUTCDate(d.getUTCDate() - daysSinceMonday);
  return d.toISOString().slice(0, 10);
}

/**
 * Date-only formatting in Philippine time — used everywhere a timestamp is
 * shown to a person (Gabriel's explicit "let's use Philippine time all
 * across the website", 2026-09-28, after an admin page's raw
 * `.toLocaleString()` silently rendered in Vercel's own UTC server time
 * instead). Always pass explicit `timeZone: MANILA_TZ` rather than relying
 * on a Server Component's ambient locale, which is never the viewer's.
 */
export function formatDateManila(iso: string, options?: Intl.DateTimeFormatOptions): string {
  return new Date(iso).toLocaleDateString("en-US", {
    timeZone: MANILA_TZ,
    year: "numeric",
    month: "short",
    day: "numeric",
    ...options,
  });
}

/** The current hour of day (0-23) in Philippine time, regardless of the
 * server's own timezone — e.g. for a time-of-day greeting that should never
 * say "Good evening" because the server happens to be running in UTC. */
export function currentHourManila(): number {
  return Number(new Intl.DateTimeFormat("en-US", { timeZone: MANILA_TZ, hour: "numeric", hourCycle: "h23" }).format(new Date()));
}

/** Same as formatDateManila, but with the time of day included. */
export function formatDateTimeManila(iso: string): string {
  return new Date(iso).toLocaleString("en-US", {
    timeZone: MANILA_TZ,
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
    hour12: true,
  });
}

export function weekLabelManila(weekKey: string): string {
  const start = new Date(`${weekKey}T00:00:00Z`);
  const end = new Date(start);
  end.setUTCDate(end.getUTCDate() + 6);
  const fmt = (d: Date) => d.toLocaleDateString("en-US", { timeZone: "UTC", month: "short", day: "numeric" });
  const range = `${fmt(start)} – ${fmt(end)}`;

  const thisWeekKey = weekKeyManila(new Date().toISOString());
  if (weekKey === thisWeekKey) return `This week (${range})`;
  const lastWeekStart = new Date(`${thisWeekKey}T00:00:00Z`);
  lastWeekStart.setUTCDate(lastWeekStart.getUTCDate() - 7);
  if (weekKey === lastWeekStart.toISOString().slice(0, 10)) return `Last week (${range})`;
  return range;
}

/** Groups an already newest-first list into per-week sections (Manila time,
 * Monday-start), newest week first — the input's own order is preserved
 * within each week, so this relies on the caller having already sorted by
 * its timestamp descending. */
export function groupByWeek<T>(
  list: T[],
  getTimestamp: (item: T) => string,
): { weekKey: string; label: string; items: T[] }[] {
  const byWeek = new Map<string, T[]>();
  for (const item of list) {
    const key = weekKeyManila(getTimestamp(item));
    const group = byWeek.get(key) ?? [];
    group.push(item);
    byWeek.set(key, group);
  }
  return [...byWeek.entries()].map(([weekKey, items]) => ({ weekKey, label: weekLabelManila(weekKey), items }));
}
