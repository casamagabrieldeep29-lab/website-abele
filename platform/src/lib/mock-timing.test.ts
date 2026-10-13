import { describe, expect, it } from "vitest";
import { MOCK_EXAM_TIME_LIMIT_MINUTES, formatClock, parseTimestamp, remainingMs } from "./mock-timing";

describe("mock exam timing", () => {
  const started = "2026-10-13T11:50:43.745375+00:00"; // Postgres keeps microseconds

  it("gives a fresh 3-hour attempt about 3 hours, never seconds", () => {
    const now = parseTimestamp(started) + 3_000; // opened 3 seconds after starting
    const left = remainingMs(started, MOCK_EXAM_TIME_LIMIT_MINUTES, now);
    expect(left).toBe(180 * 60_000 - 3_000);
    expect(formatClock(left)).toBe("2:59:57");
  });

  it("parses microsecond timestamps to the same instant as the millisecond form", () => {
    expect(parseTimestamp(started)).toBe(Date.parse("2026-10-13T11:50:43.745Z"));
  });

  it("goes negative once the 3 hours are over and clamps the clock at zero", () => {
    const now = parseTimestamp(started) + 180 * 60_000 + 1_000;
    const left = remainingMs(started, 180, now);
    expect(left).toBe(-1_000);
    expect(formatClock(left)).toBe("0:00:00");
  });

  it("formats whole hours", () => {
    expect(formatClock(180 * 60_000)).toBe("3:00:00");
    expect(formatClock(65_000)).toBe("0:01:05");
  });
});
