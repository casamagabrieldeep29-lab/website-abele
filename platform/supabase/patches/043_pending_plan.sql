-- Adds 'pending' to profiles.plan: a self-serve signup now always submits a
-- payment (reference + required receipt) at account creation, landing on
-- 'pending' rather than 'trial' until an admin approves it (or the receipt
-- auto-approves) at /admin/payments. There is no more public "skip payment,
-- start a free trial" path — see src/app/signup/actions.ts.
--
-- The column default stays 'trial' on purpose: that's still the deliberate
-- admin-side override (invite someone with a free trial, or "downgrade to
-- trial" from /admin/users) described in 032_subscriber_plan.sql. Self-serve
-- signup now sets plan='pending' explicitly instead of relying on that
-- default.
-- Drops whatever the existing plan check constraint is actually named
-- (found dynamically rather than assumed, since it was created inline via
-- `add column ... check (...)` in 032_subscriber_plan.sql without an
-- explicit name) before adding the widened one.
do $$
declare
  existing_check text;
begin
  select conname into existing_check
  from pg_constraint
  where conrelid = 'public.profiles'::regclass
    and contype = 'c'
    and pg_get_constraintdef(oid) ilike '%plan%';

  if existing_check is not null then
    execute format('alter table public.profiles drop constraint %I', existing_check);
  end if;
end $$;

alter table public.profiles
  add constraint profiles_plan_check check (plan in ('trial', 'pending', 'subscriber'));
