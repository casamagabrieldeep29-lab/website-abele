import { describe, expect, it } from "vitest";
import { dayKeyManila, groupByWeek, weekKeyManila } from "./manila-week";

// Regression coverage for the Manila-time, Monday-anchored week grouping
// shared by /admin/users and /admin/payments — the tricky part is that
// Vercel's server clock is UTC while "the day"/"the week" here must always
// mean Philippine local time, including right around midnight where the
// two disagree on the calendar date.
describe("dayKeyManila", () => {
  it("resolves a UTC evening timestamp to the next Manila calendar day", () => {
    // 2026-09-28T20:00:00Z is already 2026-09-29 04:00 in Manila (UTC+8).
    expect(dayKeyManila("2026-09-28T20:00:00Z")).toBe("2026-09-29");
  });

  it("keeps a UTC morning timestamp on the same Manila calendar day", () => {
    // 2026-09-28T01:00:00Z is 2026-09-28 09:00 in Manila — no rollover.
    expect(dayKeyManila("2026-09-28T01:00:00Z")).toBe("2026-09-28");
  });
});

describe("weekKeyManila", () => {
  it("anchors a Tuesday to the Monday that starts its week", () => {
    // 2026-09-29 is a Tuesday; that week's Monday is 2026-09-28.
    expect(weekKeyManila("2026-09-29T04:00:00Z")).toBe("2026-09-28");
  });

  it("keeps a Monday timestamp anchored to itself", () => {
    expect(weekKeyManila("2026-09-28T04:00:00Z")).toBe("2026-09-28");
  });

  it("rolls a Sunday into the Monday six days before it, not the next Monday", () => {
    // 2026-10-04 is a Sunday; its week started Monday 2026-09-28.
    expect(weekKeyManila("2026-10-04T04:00:00Z")).toBe("2026-09-28");
  });
});

describe("groupByWeek", () => {
  it("buckets items by Manila week and preserves each item's own order within its bucket", () => {
    const items = [
      { id: "a", ts: "2026-09-29T04:00:00Z" }, // week of 2026-09-28
      { id: "b", ts: "2026-09-28T04:00:00Z" }, // week of 2026-09-28
      { id: "c", ts: "2026-10-04T04:00:00Z" }, // week of 2026-09-28 (Sunday)
      { id: "d", ts: "2026-10-06T04:00:00Z" }, // week of 2026-10-05
    ];

    const grouped = groupByWeek(items, (item) => item.ts);
    const byKey = new Map(grouped.map((g) => [g.weekKey, g.items.map((i) => i.id)]));

    expect(byKey.get("2026-09-28")).toEqual(["a", "b", "c"]);
    expect(byKey.get("2026-10-05")).toEqual(["d"]);
  });

  it("returns an empty array for an empty list", () => {
    expect(groupByWeek([] as { ts: string }[], (item) => item.ts)).toEqual([]);
  });
});
