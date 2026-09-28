-- Dashboard Phase 4a (2026-09-28) — Formula Trainer + Number Bank Quiz.
-- Both quiz over the SAME existing `reviewer_entries` table (924 published
-- formulas, 383 constants, 667 tables — all currently passive reference
-- material with no active-recall layer on top), so they share one progress
-- table and one review RPC. This is a mechanical mirror of
-- `flashcard_progress` / `record_flashcard_review()` (patch
-- 009_reviewers_and_flashcards.sql) — same state machine, same upsert
-- shape, same self-grade semantics — just keyed on `entry_id` instead of
-- `flashcard_id`. No new content table, no schema for `reviewer_entries`
-- itself changes.

create table if not exists public.reviewer_entry_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  entry_id uuid not null references public.reviewer_entries (id) on delete cascade,
  state text not null default 'new' check (state in ('new', 'know', 'learning', 'dont_know')),
  times_seen int not null default 0,
  times_known int not null default 0,
  last_reviewed_at timestamptz,
  is_saved boolean not null default false,
  unique (user_id, entry_id)
);

alter table public.reviewer_entry_progress enable row level security;

drop policy if exists "reviewer_entry_progress_own_or_admin" on public.reviewer_entry_progress;
create policy "reviewer_entry_progress_own_or_admin" on public.reviewer_entry_progress
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

create or replace function public.record_reviewer_entry_review(p_entry_id uuid, p_state text)
returns void
language plpgsql
security invoker
set search_path = public
as $$
begin
  if p_state not in ('know', 'learning', 'dont_know') then
    raise exception 'Invalid reviewer entry review state.';
  end if;

  insert into public.reviewer_entry_progress (user_id, entry_id, state, times_seen, times_known, last_reviewed_at)
  values (auth.uid(), p_entry_id, p_state, 1, case when p_state = 'know' then 1 else 0 end, now())
  on conflict (user_id, entry_id) do update
    set state = excluded.state,
        times_seen = reviewer_entry_progress.times_seen + 1,
        times_known = reviewer_entry_progress.times_known + case when p_state = 'know' then 1 else 0 end,
        last_reviewed_at = now();
end;
$$;

grant execute on function public.record_reviewer_entry_review(uuid, text) to authenticated;
