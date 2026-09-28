/**
 * Trial length changed from 14 to 3 days on 2026-09-28 — but only for
 * trials that START from that point on. Gabriel's explicit instruction:
 * "do not change the already free trial users ... the existing trial users
 * should enjoy their 14 days first." So this isn't a single flat constant —
 * a profile's actual trial length depends on when its trial_started_at
 * falls relative to the policy change.
 *
 * Never move TRIAL_POLICY_CHANGE_AT backward — that would retroactively
 * shorten trials that already started under the old 14-day policy.
 */
export const TRIAL_DAYS = 3;
export const LEGACY_TRIAL_DAYS = 14;
export const TRIAL_POLICY_CHANGE_AT = new Date("2026-09-28T00:00:00Z");

export function trialLengthDaysFor(trialStartedAt: string | Date): number {
  const started = typeof trialStartedAt === "string" ? new Date(trialStartedAt) : trialStartedAt;
  return started < TRIAL_POLICY_CHANGE_AT ? LEGACY_TRIAL_DAYS : TRIAL_DAYS;
}

export function trialMsFor(trialStartedAt: string | Date): number {
  return trialLengthDaysFor(trialStartedAt) * 24 * 60 * 60 * 1000;
}
