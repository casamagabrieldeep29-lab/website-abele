import { describe, expect, it } from "vitest";
import {
  LEGACY_TRIAL_DAYS,
  MID_TRIAL_DAYS,
  SECOND_TRIAL_POLICY_CHANGE_AT,
  TRIAL_DAYS,
  TRIAL_POLICY_CHANGE_AT,
  trialLengthDaysFor,
  trialMsFor,
} from "./trial";

// Regression coverage for the non-retroactive trial-length policy: an
// account's trial length depends on WHEN it started relative to two policy
// cutovers, and must never change for accounts that already started under
// an earlier policy. Bugs here (e.g. an off-by-one on a cutover boundary)
// silently over- or under-grant real students' access, so this is exactly
// the kind of pure logic worth pinning down with tests.
describe("trialLengthDaysFor", () => {
  it("gives the legacy 14 days to a trial that started before the first cutover", () => {
    const before = new Date(TRIAL_POLICY_CHANGE_AT.getTime() - 1);
    expect(trialLengthDaysFor(before)).toBe(LEGACY_TRIAL_DAYS);
  });

  it("gives the mid-policy 3 days to a trial starting exactly at the first cutover", () => {
    expect(trialLengthDaysFor(TRIAL_POLICY_CHANGE_AT)).toBe(MID_TRIAL_DAYS);
  });

  it("gives the mid-policy 3 days to a trial between the two cutovers", () => {
    const between = new Date(SECOND_TRIAL_POLICY_CHANGE_AT.getTime() - 1);
    expect(trialLengthDaysFor(between)).toBe(MID_TRIAL_DAYS);
  });

  it("gives the current 1 day to a trial starting exactly at the second cutover", () => {
    expect(trialLengthDaysFor(SECOND_TRIAL_POLICY_CHANGE_AT)).toBe(TRIAL_DAYS);
  });

  it("gives the current 1 day to a trial well after the second cutover", () => {
    const after = new Date(SECOND_TRIAL_POLICY_CHANGE_AT.getTime() + 1000 * 60 * 60 * 24 * 30);
    expect(trialLengthDaysFor(after)).toBe(TRIAL_DAYS);
  });

  it("accepts an ISO string the same way it accepts a Date", () => {
    expect(trialLengthDaysFor(TRIAL_POLICY_CHANGE_AT.toISOString())).toBe(MID_TRIAL_DAYS);
  });
});

describe("trialMsFor", () => {
  it("converts the resolved day count to milliseconds", () => {
    expect(trialMsFor(SECOND_TRIAL_POLICY_CHANGE_AT)).toBe(TRIAL_DAYS * 24 * 60 * 60 * 1000);
  });
});
