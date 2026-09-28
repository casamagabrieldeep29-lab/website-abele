/**
 * Trial length has changed twice, both times non-retroactively — Gabriel's
 * standing rule since the first change: "do not change the already free
 * trial users ... the existing trial users should enjoy their [prior] days
 * first." So this isn't a single flat constant — a profile's actual trial
 * length depends on when its trial_started_at falls relative to each policy
 * change, in order:
 *
 *   before 2026-09-28T00:00:00Z            -> 14 days (original policy)
 *   2026-09-28T00:00:00Z .. SECOND cutover -> 3 days (first shortening,
 *                                             the self-signup launch)
 *   SECOND_TRIAL_POLICY_CHANGE_AT onward   -> 1 day (second shortening,
 *                                             "1 day free trial for new
 *                                             users", same day as the first)
 *
 * Never move either cutover backward — that would retroactively shorten
 * trials that already started under the policy before it.
 */
export const TRIAL_DAYS = 1;
export const MID_TRIAL_DAYS = 3;
export const LEGACY_TRIAL_DAYS = 14;
export const TRIAL_POLICY_CHANGE_AT = new Date("2026-09-28T00:00:00Z");
export const SECOND_TRIAL_POLICY_CHANGE_AT = new Date("2026-09-28T10:40:00Z");

export function trialLengthDaysFor(trialStartedAt: string | Date): number {
  const started = typeof trialStartedAt === "string" ? new Date(trialStartedAt) : trialStartedAt;
  if (started < TRIAL_POLICY_CHANGE_AT) return LEGACY_TRIAL_DAYS;
  if (started < SECOND_TRIAL_POLICY_CHANGE_AT) return MID_TRIAL_DAYS;
  return TRIAL_DAYS;
}

export function trialMsFor(trialStartedAt: string | Date): number {
  return trialLengthDaysFor(trialStartedAt) * 24 * 60 * 60 * 1000;
}
