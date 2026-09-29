-- Adds a self-reported address field collected at signup (2026-09-29),
-- same pattern as school/academic_status in patch 041. Purely informational.
-- Nullable with no default: existing accounts simply have it unset, same as
-- any other historical row.

alter table public.profiles
  add column if not exists address text;

comment on column public.profiles.address is 'Self-reported home/mailing address, collected at signup. Free text, optional.';
