-- Free-trial accounts get a stricter DAILY cap on AI usage (Teach Me This +
-- Study Assistant share the same counter) than everyone else — per
-- Gabriel's explicit "limit only the teach me this or ai perks for all
-- free trial users to 15 usage only... that's per day... do not apply that
-- to subscribers. strictly on free trial users" (2026-09-25). Subscribers
-- and admins are completely unaffected — same daily-counter mechanism
-- (public.ai_usage), just a lower cap value when the account is on trial.

-- MUST drop the old 1-arg overload explicitly — CREATE OR REPLACE with a
-- different parameter list creates a SEPARATE overload instead of replacing
-- it, which is exactly what broke every quiz submission app-wide earlier
-- today (see patch 030's hotfix for submit_attempt_answer). Leaving both
-- signatures around would make PostgREST unable to choose between them.
drop function if exists public.check_and_log_ai_usage(int);

create or replace function public.check_and_log_ai_usage(p_daily_limit int, p_trial_daily_limit int default 15)
returns table (allowed boolean, remaining int, limit_reason text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count int;
  v_plan text;
  v_role text;
  v_effective_limit int;
begin
  select plan, role into v_plan, v_role from public.profiles where id = auth.uid();
  v_effective_limit := case when v_plan = 'trial' and v_role <> 'admin' then p_trial_daily_limit else p_daily_limit end;

  insert into public.ai_usage (user_id, usage_date, request_count)
  values (auth.uid(), current_date, 0)
  on conflict (user_id, usage_date) do nothing;

  select request_count into v_count
  from public.ai_usage
  where user_id = auth.uid() and usage_date = current_date
  for update;

  if v_count >= v_effective_limit then
    return query select false, 0, (case when v_plan = 'trial' and v_role <> 'admin' then 'trial_limit' else 'daily_limit' end)::text;
  else
    update public.ai_usage
    set request_count = request_count + 1
    where user_id = auth.uid() and usage_date = current_date;
    return query
      select true, greatest(0, v_effective_limit - v_count - 1),
        (case when v_plan = 'trial' and v_role <> 'admin' then 'trial_limit' else 'daily_limit' end)::text;
  end if;
end;
$$;

grant execute on function public.check_and_log_ai_usage(int, int) to authenticated;
