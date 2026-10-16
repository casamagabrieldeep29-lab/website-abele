-- 049: has_password must mean "has a REAL password".
--
-- Patch 047 filled profiles.has_password from "auth.users.encrypted_password IS NOT NULL". Accounts created
-- by an emailed code or an invite can carry an EMPTY string there instead of NULL, so every account looked
-- like it already had a password and the "set your password" pop-up reached nobody.
--
-- Run once in the Supabase SQL Editor. Safe to re-run. It only changes the has_password flag.

-- 1) Recompute the flag for every existing account from the real data.
update public.profiles p
set has_password = (coalesce(u.encrypted_password, '') <> '')
from auth.users u
where u.id = p.id
  and p.has_password is distinct from (coalesce(u.encrypted_password, '') <> '');

-- 2) New accounts get the same correct rule.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, has_password)
  values (new.id, new.email, coalesce(new.encrypted_password, '') <> '')
  on conflict (id) do nothing;
  return new;
end;
$$;

-- 3) How many students will now see the pop-up (read-only check).
select
  count(*) filter (where has_password) as with_password,
  count(*) filter (where not has_password) as without_password
from public.profiles;
