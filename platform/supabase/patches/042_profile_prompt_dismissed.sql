-- Backs the "complete your profile" popup shown once to existing accounts
-- after the school/academic_status/password-signup features shipped
-- (2026-09-28) — everyone invited before that has neither field set. Lets a
-- student dismiss the prompt without filling anything in, so it never
-- becomes a recurring nag: shown while academic_status is null AND this is
-- null, hidden the moment either becomes true.

alter table public.profiles
  add column if not exists profile_prompt_dismissed_at timestamptz;

comment on column public.profiles.profile_prompt_dismissed_at is 'Set when a student dismisses the "complete your profile" popup (school/academic_status) without filling it in. Never shown again once set, same as filling academic_status in.';
