-- Adds two self-reported fields collected at signup (2026-09-28): which
-- school the student is from, and whether they're still studying or already
-- graduated and reviewing for the ABE licensure exam. Purely informational —
-- nothing else in the app reads these yet beyond the admin user list.
-- Nullable with no default: existing accounts (everyone invited before this
-- shipped) simply have neither set, same as any other historical row.

alter table public.profiles
  add column if not exists school text,
  add column if not exists academic_status text check (academic_status in ('student', 'reviewee'));

comment on column public.profiles.school is 'Self-reported school/institution name, collected at signup. Free text, optional.';
comment on column public.profiles.academic_status is '''student'' = still studying, ''reviewee'' = already graduated and reviewing for the ABE licensure exam. Self-reported at signup, optional.';
