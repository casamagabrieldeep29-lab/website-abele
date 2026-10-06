import { describe, expect, it } from "vitest";
import { countWords } from "./word-count";

describe("countWords", () => {
  it("counts whitespace-separated words, not letters", () => {
    expect(countWords("What is the capital of the Philippines")).toBe(7);
    expect(countWords("sss sss sss")).toBe(3);
  });

  it("ignores extra whitespace and newlines", () => {
    expect(countWords("  one   two\nthree\t four  ")).toBe(4);
  });

  it("treats empty or missing text as a single (empty) token, as before", () => {
    expect(countWords("")).toBe(1);
    expect(countWords(null)).toBe(1);
    expect(countWords(undefined)).toBe(1);
  });

  it("a short fragment stays under the Mock Exam minimum of 8 words", () => {
    expect(countWords("Define evapotranspiration losses seasonally")).toBeLessThan(8);
    expect(countWords("A pump delivers 20 liters per second against a head of 15 meters")).toBeGreaterThanOrEqual(8);
  });
});
