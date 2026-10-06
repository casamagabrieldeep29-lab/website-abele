import { describe, expect, it } from "vitest";
import { isStandardsItem, pickSubjectItems, type MockCandidate } from "./mock-selection";

function seeded(seed: number) {
  let s = seed;
  return () => {
    s = (s * 1664525 + 1013904223) % 4294967296;
    return s / 4294967296;
  };
}

const board = (i: number, recalled = false): MockCandidate => ({ id: `b${i}`, question_text: "A board style problem", is_recalled: recalled });
const std = (i: number): MockCandidate => ({ id: `s${i}`, question_text: "A standards item", is_paes: true });
const units = (items: MockCandidate[]) => items.map((m) => [m]);

describe("isStandardsItem", () => {
  it("flags tagged, referenced and text-mentioned standards items", () => {
    expect(isStandardsItem({ id: "1", question_text: "x", is_paes: true })).toBe(true);
    expect(isStandardsItem({ id: "2", question_text: "x", paes_reference: "PAES 118" })).toBe(true);
    expect(isStandardsItem({ id: "3", question_text: "Under PAES 413, the pump..." })).toBe(true);
    expect(isStandardsItem({ id: "4", question_text: "A tractor pulls a plow" })).toBe(false);
  });
});

describe("pickSubjectItems", () => {
  it("limits standards items to the share and still hits the target", () => {
    const pool = units([...Array.from({ length: 100 }, (_, i) => board(i)), ...Array.from({ length: 100 }, (_, i) => std(i))]);
    const picked = pickSubjectItems(pool, 25, 0.15, seeded(1));
    expect(picked).toHaveLength(25);
    expect(picked.filter(isStandardsItem)).toHaveLength(3);
  });

  it("fills the target from standards items when board-style items run short", () => {
    const pool = units([...Array.from({ length: 5 }, (_, i) => board(i)), ...Array.from({ length: 50 }, (_, i) => std(i))]);
    const picked = pickSubjectItems(pool, 25, 0.15, seeded(2));
    expect(picked).toHaveLength(25);
    expect(picked.filter((p) => !isStandardsItem(p))).toHaveLength(5);
  });

  it("uses no standards items when the share is zero and board items suffice", () => {
    const pool = units([...Array.from({ length: 30 }, (_, i) => board(i)), ...Array.from({ length: 30 }, (_, i) => std(i))]);
    expect(pickSubjectItems(pool, 12, 0, seeded(3)).filter(isStandardsItem)).toHaveLength(0);
  });

  it("never splits a connected series", () => {
    const series = [board(1), board(2), board(3)];
    const pool = [series, ...units(Array.from({ length: 40 }, (_, i) => board(100 + i)))];
    for (let seed = 1; seed <= 20; seed++) {
      const ids = new Set(pickSubjectItems(pool, 10, 0.15, seeded(seed)).map((p) => p.id));
      const inSeries = series.filter((s) => ids.has(s.id)).length;
      expect(inSeries === 0 || inSeries === 3).toBe(true);
    }
  });

  it("draws recalled board questions ahead of ordinary ones", () => {
    const pool = units([...Array.from({ length: 50 }, (_, i) => board(i, true)), ...Array.from({ length: 50 }, (_, i) => board(100 + i))]);
    let recalled = 0;
    for (let seed = 1; seed <= 30; seed++) {
      recalled += pickSubjectItems(pool, 10, 0, seeded(seed)).filter((p) => p.is_recalled).length;
    }
    expect(recalled / 30).toBeGreaterThan(6);
  });
});
