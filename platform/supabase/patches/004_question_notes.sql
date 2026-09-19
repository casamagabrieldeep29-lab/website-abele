-- ============================================================================
-- 11. question_notes — personal, private notes attached to a question
-- ============================================================================
-- Scoped to Practice Mode only (not Mock Exam, which should feel like a real
-- timed test). Plain RLS is enough here (unlike the RPCs above) because this
-- table only ever needs `user_id = auth.uid()`, never a lookup into the
-- admin-only `questions`/`choices` tables for its own access control.

create table if not exists public.question_notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  question_id uuid not null references public.questions (id) on delete cascade,
  note_text text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, question_id)
);

alter table public.question_notes enable row level security;

drop policy if exists "question_notes_own_or_admin" on public.question_notes;
create policy "question_notes_own_or_admin" on public.question_notes
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- Listing notes needs the question's text, but `questions` is admin-only for
-- direct SELECT — same reason as get_topic_mastery()/get_mistake_bank()
-- above, same fix (SECURITY DEFINER + explicit auth.uid() filter).
create or replace function public.get_my_notes()
returns table (
  note_id uuid,
  question_id uuid,
  question_text text,
  topic_name text,
  note_text text,
  updated_at timestamptz
)
language sql
security definer
stable
set search_path = public
as $$
  select
    n.id,
    q.id,
    q.question_text,
    t.name,
    n.note_text,
    n.updated_at
  from public.question_notes n
  join public.questions q on q.id = n.question_id
  join public.topics t on t.id = q.topic_id
  where n.user_id = auth.uid()
  order by n.updated_at desc;
$$;

grant execute on function public.get_my_notes() to authenticated;
