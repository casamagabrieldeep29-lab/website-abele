-- ============================================================================
-- 19. Reviewer / Reference materials (Tables / Formulas / Constants)
-- ============================================================================
-- Reuses the EXISTING taxonomy (topics -> exam_areas, optional subtopics) —
-- no parallel "subject" hierarchy. A single flexible table with a `kind`
-- discriminator instead of three near-duplicate tables, since a formula,
-- table, and constant share most fields (title, description, notes,
-- source, topic/subtopic, status). Unlike `questions`, there is no secret
-- "answer key" to protect here, so RLS is simpler: admin-only write,
-- published-only read for students — no separate safe view needed.

create table if not exists public.reviewer_entries (
  id uuid primary key default gen_random_uuid(),
  kind text not null check (kind in ('formula', 'table', 'constant')),
  title text not null,
  topic_id uuid not null references public.topics (id) on delete restrict,
  subtopic_id uuid references public.subtopics (id) on delete set null,

  -- Formula-specific (nullable — only used when kind = 'formula')
  formula text,
  variables text,

  -- Constant-specific (nullable — only used when kind = 'constant')
  symbol text,
  value text,
  unit text,

  -- Table-specific (nullable — only used when kind = 'table')
  table_content text,

  -- Shared
  description text,
  notes text,
  source text,
  status text not null default 'draft' check (status in ('draft', 'published')),
  created_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists reviewer_entries_topic_id_idx on public.reviewer_entries (topic_id);
create index if not exists reviewer_entries_kind_idx on public.reviewer_entries (kind);

alter table public.reviewer_entries enable row level security;

drop policy if exists "reviewer_entries_admin_write" on public.reviewer_entries;
create policy "reviewer_entries_admin_write" on public.reviewer_entries
  for all to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "reviewer_entries_published_read" on public.reviewer_entries;
create policy "reviewer_entries_published_read" on public.reviewer_entries
  for select to authenticated
  using (status = 'published' or public.is_admin());

-- ============================================================================
-- 20. Flashcards + per-user progress
-- ============================================================================
-- Same reasoning as reviewer_entries: no secret to protect (front AND back
-- are meant to be readable once published — the whole point of a
-- flashcard), so plain RLS is enough, no safe view needed.

create table if not exists public.flashcards (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics (id) on delete restrict,
  subtopic_id uuid references public.subtopics (id) on delete set null,
  front text not null,
  back text not null,
  source text,
  status text not null default 'draft' check (status in ('draft', 'published')),
  created_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists flashcards_topic_id_idx on public.flashcards (topic_id);

alter table public.flashcards enable row level security;

drop policy if exists "flashcards_admin_write" on public.flashcards;
create policy "flashcards_admin_write" on public.flashcards
  for all to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "flashcards_published_read" on public.flashcards;
create policy "flashcards_published_read" on public.flashcards
  for select to authenticated
  using (status = 'published' or public.is_admin());

-- Per-user study state. `state` mirrors the "Know it / Still learning /
-- Don't know" actions from the study UI. Real, minimal tracking — no
-- fabricated mastery number; weak-area flashcard selection uses the
-- EXISTING get_topic_mastery() RPC, not anything computed here.
create table if not exists public.flashcard_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  flashcard_id uuid not null references public.flashcards (id) on delete cascade,
  state text not null default 'new' check (state in ('new', 'know', 'learning', 'dont_know')),
  times_seen int not null default 0,
  times_known int not null default 0,
  last_reviewed_at timestamptz,
  is_saved boolean not null default false,
  unique (user_id, flashcard_id)
);

alter table public.flashcard_progress enable row level security;

drop policy if exists "flashcard_progress_own_or_admin" on public.flashcard_progress;
create policy "flashcard_progress_own_or_admin" on public.flashcard_progress
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- Records a review action (flip -> Know it / Still learning / Don't know)
-- and upserts progress. Plain client-side upsert would also work given the
-- RLS above, but doing the seen/known increment server-side (SECURITY
-- DEFINER not required here, just a convenience RPC) avoids a read-then-
-- write race between two tabs.
create or replace function public.record_flashcard_review(p_flashcard_id uuid, p_state text)
returns void
language plpgsql
security invoker
set search_path = public
as $$
begin
  if p_state not in ('know', 'learning', 'dont_know') then
    raise exception 'Invalid flashcard review state.';
  end if;

  insert into public.flashcard_progress (user_id, flashcard_id, state, times_seen, times_known, last_reviewed_at)
  values (auth.uid(), p_flashcard_id, p_state, 1, case when p_state = 'know' then 1 else 0 end, now())
  on conflict (user_id, flashcard_id) do update
    set state = excluded.state,
        times_seen = flashcard_progress.times_seen + 1,
        times_known = flashcard_progress.times_known + case when p_state = 'know' then 1 else 0 end,
        last_reviewed_at = now();
end;
$$;

grant execute on function public.record_flashcard_review(uuid, text) to authenticated;
