-- ABELIEVER — Initial database schema
--
-- Run this once in the Supabase project's SQL Editor (Database > SQL Editor)
-- for a fresh project. Safe to re-run (uses IF NOT EXISTS / OR REPLACE where
-- practical), but this is not yet split into versioned migrations — see the
-- note at the bottom before making further schema changes.
--
-- Design notes (see 25_DECISION_LOG.md for the full "why"):
--   * Content workflow: questions.status follows the DRAFT -> REVIEW ->
--     APPROVED -> PUBLISHED -> ARCHIVED lifecycle from
--     00_MASTER_PROJECT_INSTRUCTIONS.md Section 21. Only 'published'
--     questions are ever visible to students.
--   * Answer-key protection: students must NEVER be able to read
--     choices.is_correct or a question's explanation/solution before they've
--     answered it. Direct SELECT on `questions`/`choices` is admin-only.
--     Students read through the `student_questions` / `student_choices`
--     views (safe columns only) and submit answers through the
--     `submit_attempt_answer` RPC, which computes correctness server-side
--     and only then returns the answer key + explanation for that question.
--   * Scope: question_type currently supports 'single_choice' and
--     'multi_choice' (both graded via the `choices` table). 'numerical'
--     free-response grading (given values -> formula -> tolerance-checked
--     final answer) is intentionally NOT implemented yet — the ATTRC source
--     materials being transcribed for the pilot are themselves
--     multiple-choice, so this isn't blocking the pilot. Treat any
--     'numerical' question_type as a placeholder for future work, not a
--     working feature.

-- ============================================================================
-- 1. PROFILES (one row per auth.users row, extends it with app-level fields)
-- ============================================================================

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  email text not null,
  display_name text,
  role text not null default 'student' check (role in ('student', 'admin')),
  created_at timestamptz not null default now()
);

comment on table public.profiles is 'App-level profile for each authenticated user. Row is created automatically by the handle_new_user trigger when someone accepts an invite / first signs in.';

-- Auto-create a profile row whenever a new auth.users row appears (i.e. when
-- an invited user completes signup / first logs in via magic link).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Bootstrap note: after you (the admin) sign in for the first time, promote
-- yourself by running, once:
--   update public.profiles set role = 'admin' where email = 'YOUR_EMAIL_HERE';

-- Helper used throughout RLS policies below. SECURITY DEFINER so it can read
-- `profiles` without recursing into the RLS policy that itself calls this
-- function.
create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.profiles where id = auth.uid() and role = 'admin'
  );
$$;

alter table public.profiles enable row level security;

drop policy if exists "profiles_select_own_or_admin" on public.profiles;
create policy "profiles_select_own_or_admin" on public.profiles
  for select to authenticated
  using (auth.uid() = id or public.is_admin());

drop policy if exists "profiles_update_own_or_admin" on public.profiles;
create policy "profiles_update_own_or_admin" on public.profiles
  for update to authenticated
  using (auth.uid() = id or public.is_admin())
  with check (auth.uid() = id or public.is_admin());

-- Belt-and-suspenders: even if a policy is ever misconfigured, a non-admin
-- can never change their own (or anyone else's) role.
create or replace function public.prevent_role_self_escalation()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- auth.uid() is NULL when this runs outside a normal authenticated
  -- request context — e.g. from the SQL Editor, a migration, or any
  -- service-role/direct-Postgres access. Anyone with that level of access
  -- already has full control over the database (they could disable this
  -- trigger entirely), so there's no new privilege escalation in skipping
  -- the check there. This only guards role changes attempted through the
  -- app's normal authenticated (RLS) path.
  if new.role is distinct from old.role and auth.uid() is not null and not public.is_admin() then
    raise exception 'Only admins can change roles.';
  end if;
  return new;
end;
$$;

drop trigger if exists trg_prevent_role_self_escalation on public.profiles;
create trigger trg_prevent_role_self_escalation
  before update on public.profiles
  for each row execute function public.prevent_role_self_escalation();

-- ============================================================================
-- 2. CONTENT TAXONOMY — exam_areas, topics, subtopics
-- ============================================================================

create table if not exists public.exam_areas (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name text not null,
  weight_percent numeric(4, 1),
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

comment on table public.exam_areas is 'The 8 official PRC Table-of-Specifications exam areas. weight_percent is current-as-of-2026 per 00_MASTER_PROJECT_INSTRUCTIONS.md Section 3 — re-verify against official PRC sources if this ever needs updating, do not assume it is permanent.';

create table if not exists public.topics (
  id uuid primary key default gen_random_uuid(),
  exam_area_id uuid not null references public.exam_areas (id) on delete restrict,
  name text not null,
  sort_order int not null default 0,
  -- Which of the THREE real PRC board-exam subject tests this topic
  -- belongs to (distinct from exam_area_id, which is the 8 official TOS
  -- weighting categories) — see Mock Exam, Section 17.
  mock_area text not null default 'area_3' check (mock_area in ('area_1', 'area_2', 'area_3')),
  created_at timestamptz not null default now()
);

create table if not exists public.subtopics (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics (id) on delete restrict,
  name text not null,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.exam_areas enable row level security;
alter table public.topics enable row level security;
alter table public.subtopics enable row level security;

drop policy if exists "exam_areas_select_authenticated" on public.exam_areas;
create policy "exam_areas_select_authenticated" on public.exam_areas
  for select to authenticated using (true);
drop policy if exists "exam_areas_admin_write" on public.exam_areas;
create policy "exam_areas_admin_write" on public.exam_areas
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "topics_select_authenticated" on public.topics;
create policy "topics_select_authenticated" on public.topics
  for select to authenticated using (true);
drop policy if exists "topics_admin_write" on public.topics;
create policy "topics_admin_write" on public.topics
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "subtopics_select_authenticated" on public.subtopics;
create policy "subtopics_select_authenticated" on public.subtopics
  for select to authenticated using (true);
drop policy if exists "subtopics_admin_write" on public.subtopics;
create policy "subtopics_admin_write" on public.subtopics
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Seed the 8 official exam areas (per master instructions Section 3).
insert into public.exam_areas (code, name, weight_percent, sort_order) values
  ('POWER_ENERGY_MACHINERY', 'Agricultural and Biosystems Power, Energy and Machinery Engineering', 18.0, 1),
  ('LAND_WATER', 'Land and Water Resources Engineering', 18.0, 2),
  ('STRUCTURES_ENVIRONMENT', 'Agricultural and Biosystems Structures and Environment Engineering', 18.0, 3),
  ('BIOPROCESS', 'Agricultural and Bioprocess Engineering', 18.0, 4),
  ('PROJECT_MGMT_RDE', 'Project Management, Feasibility Study Preparation/Evaluation, Research, Development and Extension on Agricultural and Biosystems Engineering', 8.0, 5),
  ('FUNDAMENTALS_SCIENCES', 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences', 6.0, 6),
  ('MATH_BASIC_ENGG', 'Mathematics and Basic Engineering Principles', 8.0, 7),
  ('LAWS_ETHICS', 'Laws, Professional Standards, and Ethics', 6.0, 8)
on conflict (code) do nothing;

-- ============================================================================
-- 3. QUESTIONS & CHOICES
-- ============================================================================

create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics (id) on delete restrict,
  subtopic_id uuid references public.subtopics (id) on delete set null,
  question_text text not null,
  question_type text not null default 'single_choice'
    check (question_type in ('single_choice', 'multi_choice', 'numerical')),
  difficulty text check (difficulty in ('easy', 'medium', 'hard')),
  cognitive_level text,
  explanation text,
  -- Numerical-problem fields (see file header note — not yet used by the UI).
  given_values jsonb,
  required_value text,
  formula text,
  solution_steps text,
  final_answer text,
  final_unit text,
  acceptable_rounding text,
  -- Provenance & workflow.
  source text,
  source_reference text,
  status text not null default 'draft'
    check (status in ('draft', 'review', 'approved', 'published', 'archived')),
  -- Admin override: tag this specific question into an ADDITIONAL real
  -- board-exam area beyond its topic's default `mock_area` (e.g. an
  -- Engineering Economy question about machinery costs, also relevant to
  -- Area 1) — a manual curation call, never automatic. See Section 17.
  additional_mock_areas text[] not null default '{}'
    check (additional_mock_areas <@ array['area_1', 'area_2', 'area_3']),
  created_by uuid references public.profiles (id) on delete set null,
  reviewed_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists questions_topic_id_idx on public.questions (topic_id);
create index if not exists questions_status_idx on public.questions (status);

create table if not exists public.choices (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions (id) on delete cascade,
  choice_text text not null,
  is_correct boolean not null default false,
  sort_order int not null default 0
);

create index if not exists choices_question_id_idx on public.choices (question_id);

alter table public.questions enable row level security;
alter table public.choices enable row level security;

-- Direct table access is ADMIN-ONLY. Students never query these tables
-- directly — see the views/RPC below.
drop policy if exists "questions_admin_only" on public.questions;
create policy "questions_admin_only" on public.questions
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "choices_admin_only" on public.choices;
create policy "choices_admin_only" on public.choices
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Student-facing views: safe columns only, published questions only, NEVER
-- includes choices.is_correct or questions.explanation/solution fields.
-- (Views run with the definer's — not caller's — privileges by default in
-- Postgres, so they can see past the admin-only RLS above; the `where
-- status = 'published'` filter below is what actually protects students,
-- not RLS on the view itself.)
create or replace view public.student_questions as
  select
    q.id, q.topic_id, q.subtopic_id, q.question_text, q.question_type, q.difficulty, q.source,
    t.mock_area as topic_mock_area,
    q.additional_mock_areas
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where q.status = 'published';

create or replace view public.student_choices as
  select c.id, c.question_id, c.choice_text, c.sort_order
  from public.choices c
  join public.questions q on q.id = c.question_id
  where q.status = 'published';

grant select on public.student_questions to authenticated;
grant select on public.student_choices to authenticated;

-- ============================================================================
-- 4. ATTEMPTS (practice sessions & mock exams) & ANSWERS
-- ============================================================================

create table if not exists public.attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  mode text not null check (mode in ('practice', 'mock')),
  exam_area_id uuid references public.exam_areas (id) on delete set null,
  topic_id uuid references public.topics (id) on delete set null,
  status text not null default 'in_progress'
    check (status in ('in_progress', 'completed', 'abandoned')),
  config jsonb not null default '{}'::jsonb,
  total_questions int not null default 0,
  correct_count int not null default 0,
  started_at timestamptz not null default now(),
  completed_at timestamptz
);

create index if not exists attempts_user_id_idx on public.attempts (user_id);

create table if not exists public.attempt_answers (
  id uuid primary key default gen_random_uuid(),
  attempt_id uuid not null references public.attempts (id) on delete cascade,
  question_id uuid not null references public.questions (id) on delete restrict,
  selected_choice_ids uuid[] not null default '{}',
  is_correct boolean,
  answered_at timestamptz,
  time_spent_seconds int,
  unique (attempt_id, question_id)
);

create index if not exists attempt_answers_attempt_id_idx on public.attempt_answers (attempt_id);

alter table public.attempts enable row level security;
alter table public.attempt_answers enable row level security;

drop policy if exists "attempts_own_or_admin" on public.attempts;
create policy "attempts_own_or_admin" on public.attempts
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- attempt_answers are only ever written through submit_attempt_answer()
-- below (SECURITY DEFINER), so client-side policy just needs to allow
-- reading your own attempt's answers.
drop policy if exists "attempt_answers_own_or_admin" on public.attempt_answers;
create policy "attempt_answers_own_or_admin" on public.attempt_answers
  for select to authenticated
  using (
    public.is_admin()
    or exists (
      select 1 from public.attempts a
      where a.id = attempt_answers.attempt_id and a.user_id = auth.uid()
    )
  );

-- ============================================================================
-- 5. BOOKMARKS
-- ============================================================================

create table if not exists public.bookmarks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  question_id uuid not null references public.questions (id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, question_id)
);

alter table public.bookmarks enable row level security;

drop policy if exists "bookmarks_own_or_admin" on public.bookmarks;
create policy "bookmarks_own_or_admin" on public.bookmarks
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- ============================================================================
-- 6. submit_attempt_answer RPC — the ONLY way a student's answer gets graded
-- ============================================================================
--
-- Grades server-side against the real `choices` table (bypassing the
-- admin-only RLS above via SECURITY DEFINER), so the correct answer is never
-- sent to the browser until after this call returns. Handles both
-- single_choice and multi_choice (exact-set-match) grading.

create or replace function public.submit_attempt_answer(
  p_attempt_id uuid,
  p_question_id uuid,
  p_selected_choice_ids uuid[]
)
returns table (
  is_correct boolean,
  correct_choice_ids uuid[],
  explanation text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_correct_choice_ids uuid[];
  v_is_correct boolean;
  v_explanation text;
begin
  -- Ownership check: only the attempt's own owner (or admin) may submit.
  if not exists (
    select 1 from public.attempts a
    where a.id = p_attempt_id
      and (a.user_id = auth.uid() or public.is_admin())
      and a.status = 'in_progress'
  ) then
    raise exception 'Attempt not found, not yours, or no longer in progress.';
  end if;

  select array_agg(c.id order by c.id) into v_correct_choice_ids
  from public.choices c
  where c.question_id = p_question_id and c.is_correct = true;

  v_is_correct := (
    array_length(p_selected_choice_ids, 1) is not null
    and (
      select array_agg(x order by x) from unnest(p_selected_choice_ids) x
    ) = v_correct_choice_ids
  );

  select q.explanation into v_explanation
  from public.questions q
  where q.id = p_question_id;

  insert into public.attempt_answers
    (attempt_id, question_id, selected_choice_ids, is_correct, answered_at)
  values
    (p_attempt_id, p_question_id, p_selected_choice_ids, v_is_correct, now())
  on conflict (attempt_id, question_id) do update
    set selected_choice_ids = excluded.selected_choice_ids,
        is_correct = excluded.is_correct,
        answered_at = excluded.answered_at;

  return query select v_is_correct, v_correct_choice_ids, v_explanation;
end;
$$;

grant execute on function public.submit_attempt_answer(uuid, uuid, uuid[]) to authenticated;

-- ============================================================================
-- 7. record_mock_answer RPC — like submit_attempt_answer, but for Mock Exam.
-- ============================================================================
-- Mock Exam does NOT give per-question feedback (that would defeat the point
-- of a timed simulated exam). This grades silently and stores the result;
-- nothing about correctness is returned to the client until the exam is
-- completed and get_attempt_review() is called.

create or replace function public.record_mock_answer(
  p_attempt_id uuid,
  p_question_id uuid,
  p_selected_choice_ids uuid[]
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_correct_choice_ids uuid[];
  v_is_correct boolean;
begin
  if not exists (
    select 1 from public.attempts att
    where att.id = p_attempt_id
      and (att.user_id = auth.uid() or public.is_admin())
      and att.status = 'in_progress'
  ) then
    raise exception 'Attempt not found, not yours, or no longer in progress.';
  end if;

  select array_agg(c.id order by c.id) into v_correct_choice_ids
  from public.choices c
  where c.question_id = p_question_id and c.is_correct = true;

  v_is_correct := (
    array_length(p_selected_choice_ids, 1) is not null
    and (
      select array_agg(x order by x) from unnest(p_selected_choice_ids) x
    ) = v_correct_choice_ids
  );

  insert into public.attempt_answers
    (attempt_id, question_id, selected_choice_ids, is_correct, answered_at)
  values
    (p_attempt_id, p_question_id, p_selected_choice_ids, v_is_correct, now())
  on conflict (attempt_id, question_id) do update
    set selected_choice_ids = excluded.selected_choice_ids,
        is_correct = excluded.is_correct,
        answered_at = excluded.answered_at;
end;
$$;

grant execute on function public.record_mock_answer(uuid, uuid, uuid[]) to authenticated;

-- ============================================================================
-- 8. get_attempt_review RPC — post-completion answer review (Practice or Mock)
-- ============================================================================
-- Only returns data for COMPLETED attempts owned by the caller (or admin).
-- Reveals full choice list with is_correct, the student's own selection, and
-- the explanation — this is the answer-key reveal, gated on the attempt
-- actually being finished so a Mock Exam can't be peeked at mid-run.

create or replace function public.get_attempt_review(p_attempt_id uuid)
returns table (
  question_id uuid,
  question_text text,
  choices jsonb,
  selected_choice_ids uuid[],
  is_correct boolean,
  explanation text
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not exists (
    select 1 from public.attempts att
    where att.id = p_attempt_id
      and (att.user_id = auth.uid() or public.is_admin())
      and att.status = 'completed'
  ) then
    raise exception 'Attempt not found, not yours, or not yet completed.';
  end if;

  return query
    select
      q.id,
      q.question_text,
      (
        select jsonb_agg(
          jsonb_build_object('id', c.id, 'text', c.choice_text, 'is_correct', c.is_correct)
          order by c.sort_order
        )
        from public.choices c
        where c.question_id = q.id
      ),
      aa.selected_choice_ids,
      aa.is_correct,
      q.explanation
    from public.attempt_answers aa
    join public.questions q on q.id = aa.question_id
    where aa.attempt_id = p_attempt_id
    order by aa.answered_at;
end;
$$;

grant execute on function public.get_attempt_review(uuid) to authenticated;

-- ============================================================================
-- 9. get_topic_mastery RPC — per-topic mastery for the calling user
-- ============================================================================
-- mastery = 0.6*recent_accuracy + 0.4*overall_accuracy, where recent_accuracy
-- is over the last min(10, total_attempts) graded answers. Only computed once
-- total_attempts >= 5 for that topic; below that, mastery/status is
-- 'insufficient_data' rather than showing a misleading percentage off 1-2
-- questions. Bands: >=80 strong, 60-79 developing, <60 needs_review.
--
-- SECURITY DEFINER is required here (not because this reveals answer keys —
-- it doesn't) but because `questions` is admin-only for direct SELECT, and
-- this function needs to read questions.topic_id to group attempt_answers by
-- topic. The explicit `att.user_id = auth.uid()` filter below is what keeps
-- this scoped to the caller's own data (same pattern as the RPCs above).

create or replace function public.get_topic_mastery()
returns table (
  topic_id uuid,
  topic_name text,
  exam_area_name text,
  total_attempts int,
  overall_accuracy numeric,
  recent_accuracy numeric,
  mastery int,
  status text,
  last_answered_at timestamptz
)
language sql
security definer
stable
set search_path = public
as $$
  with answers as (
    select
      q.topic_id,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by q.topic_id order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    join public.questions q on q.id = aa.question_id
    where att.user_id = auth.uid() and aa.answered_at is not null
  ),
  agg as (
    select
      topic_id,
      count(*) as total_attempts,
      round(100.0 * avg(is_correct::int), 1) as overall_accuracy,
      round(100.0 * avg(is_correct::int) filter (where rn <= 10), 1) as recent_accuracy,
      max(answered_at) as last_answered_at
    from answers
    group by topic_id
  )
  select
    t.id,
    t.name,
    ea.name,
    coalesce(a.total_attempts, 0),
    a.overall_accuracy,
    a.recent_accuracy,
    case when coalesce(a.total_attempts, 0) >= 5
      then round(0.6 * a.recent_accuracy + 0.4 * a.overall_accuracy)
      else null end,
    case
      when coalesce(a.total_attempts, 0) < 5 then 'insufficient_data'
      when round(0.6 * a.recent_accuracy + 0.4 * a.overall_accuracy) >= 80 then 'strong'
      when round(0.6 * a.recent_accuracy + 0.4 * a.overall_accuracy) >= 60 then 'developing'
      else 'needs_review'
    end,
    a.last_answered_at
  from public.topics t
  join public.exam_areas ea on ea.id = t.exam_area_id
  left join agg a on a.topic_id = t.id
  order by t.name;
$$;

grant execute on function public.get_topic_mastery() to authenticated;

-- ============================================================================
-- 10. get_mistake_bank RPC — questions the caller most recently got wrong
-- ============================================================================
-- "Self-correcting": a question drops off this list as soon as the caller's
-- MOST RECENT answer to it is correct (one clean retry clears it — a
-- simplification of "consistent mastery" documented in 25_DECISION_LOG.md).

create or replace function public.get_mistake_bank()
returns table (
  question_id uuid,
  question_text text,
  topic_id uuid,
  topic_name text,
  times_missed int,
  last_answered_at timestamptz
)
language sql
security definer
stable
set search_path = public
as $$
  with my_answers as (
    select
      aa.question_id,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by aa.question_id order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    where att.user_id = auth.uid() and aa.answered_at is not null
  ),
  latest as (
    select question_id, is_correct, answered_at
    from my_answers where rn = 1
  ),
  miss_counts as (
    select question_id, count(*) filter (where is_correct = false) as times_missed
    from my_answers
    group by question_id
  )
  select
    q.id,
    q.question_text,
    q.topic_id,
    t.name,
    mc.times_missed,
    l.answered_at
  from latest l
  join public.questions q on q.id = l.question_id
  join public.topics t on t.id = q.topic_id
  join miss_counts mc on mc.question_id = l.question_id
  where l.is_correct = false
  order by l.answered_at desc;
$$;

grant execute on function public.get_mistake_bank() to authenticated;

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

-- ============================================================================
-- 12. study_plans — rule-based study schedule (Feature 12)
-- ============================================================================

create table if not exists public.study_plans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  target_exam_date date not null,
  study_days text[] not null, -- e.g. {'mon','wed','fri','sat'}
  minutes_per_day int not null default 60,
  generated_plan jsonb not null, -- see study-plan/actions.ts's generatePlan()
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id) -- one active plan per user; regenerating replaces it
);

alter table public.study_plans enable row level security;

drop policy if exists "study_plans_own_or_admin" on public.study_plans;
create policy "study_plans_own_or_admin" on public.study_plans
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- ============================================================================
-- 13. user_achievements — persisted milestones (Feature 17)
-- ============================================================================
-- Persisted (not computed live) so a threshold-based badge (e.g. "90%
-- accuracy") isn't lost if later performance dips below the threshold again.

create table if not exists public.user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  achievement_code text not null,
  earned_at timestamptz not null default now(),
  unique (user_id, achievement_code)
);

alter table public.user_achievements enable row level security;

drop policy if exists "user_achievements_own_or_admin" on public.user_achievements;
create policy "user_achievements_own_or_admin" on public.user_achievements
  for select to authenticated
  using (user_id = auth.uid() or public.is_admin());

-- Checks the caller's current stats against the fixed achievement
-- thresholds (defined here, not in application code, so they can't drift
-- out of sync with what's actually been awarded) and inserts any newly
-- earned ones. Call after completing an attempt. Idempotent.
create or replace function public.check_and_award_achievements()
returns table (achievement_code text, newly_earned boolean)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_total_answered int;
  v_overall_accuracy numeric;
  v_mock_completed int;
  v_streak int := 0;
  v_check_date date := current_date;
  v_candidate text;
  v_thresholds text[] := array['FIRST_100','FIVE_HUNDRED','ONE_THOUSAND','ACCURACY_90','MOCK_COMPLETE','STREAK_7','STREAK_14'];
begin
  if v_uid is null then
    raise exception 'Not authenticated.';
  end if;

  select count(*), round(100.0 * avg(is_correct::int), 1)
    into v_total_answered, v_overall_accuracy
  from public.attempt_answers aa
  join public.attempts att on att.id = aa.attempt_id
  where att.user_id = v_uid and aa.answered_at is not null;

  select count(*) into v_mock_completed
  from public.attempts
  where user_id = v_uid and mode = 'mock' and status = 'completed';

  -- Streak: consecutive days (today or yesterday backward) with >=1 answer.
  if exists (
    select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
    where att.user_id = v_uid and aa.answered_at::date = v_check_date
  ) or exists (
    select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
    where att.user_id = v_uid and aa.answered_at::date = v_check_date - 1
  ) then
    if not exists (
      select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
      where att.user_id = v_uid and aa.answered_at::date = v_check_date
    ) then
      v_check_date := v_check_date - 1;
    end if;
    while exists (
      select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
      where att.user_id = v_uid and aa.answered_at::date = v_check_date
    ) loop
      v_streak := v_streak + 1;
      v_check_date := v_check_date - 1;
    end loop;
  end if;

  foreach v_candidate in array v_thresholds loop
    if (
      (v_candidate = 'FIRST_100' and v_total_answered >= 100) or
      (v_candidate = 'FIVE_HUNDRED' and v_total_answered >= 500) or
      (v_candidate = 'ONE_THOUSAND' and v_total_answered >= 1000) or
      (v_candidate = 'ACCURACY_90' and v_total_answered >= 50 and v_overall_accuracy >= 90) or
      (v_candidate = 'MOCK_COMPLETE' and v_mock_completed >= 1) or
      (v_candidate = 'STREAK_7' and v_streak >= 7) or
      (v_candidate = 'STREAK_14' and v_streak >= 14)
    ) then
      insert into public.user_achievements (user_id, achievement_code)
      values (v_uid, v_candidate)
      on conflict (user_id, achievement_code) do nothing;
    end if;
  end loop;

  return query
    select ua.achievement_code, (ua.earned_at > now() - interval '5 seconds')
    from public.user_achievements ua
    where ua.user_id = v_uid;
end;
$$;

grant execute on function public.check_and_award_achievements() to authenticated;

-- ============================================================================
-- 14. Question of the Day — deterministic pick, no scheduler/table needed
-- ============================================================================
-- The question itself is picked deterministically in application code
-- (hash of today's date over the published question pool) — no table
-- needed for "which question is today's." This RPC only computes the
-- anonymized aggregate stat, and only reveals it once enough people have
-- actually answered (never fabricated, never exposes individual users).

create or replace function public.get_daily_question_stats(p_question_id uuid, p_since timestamptz)
returns table (total_answers int, correct_count int)
language sql
security definer
stable
set search_path = public
as $$
  select count(*)::int, count(*) filter (where is_correct)::int
  from public.attempt_answers
  where question_id = p_question_id and answered_at >= p_since;
$$;

grant execute on function public.get_daily_question_stats(uuid, timestamptz) to authenticated;

-- ============================================================================
-- 15. Subtopic-scoped adaptive practice support
-- ============================================================================
-- No schema change needed here — student_questions/student_choices views
-- already expose subtopic_id, and startSubtopicPracticeAttempt (app code)
-- reuses the existing weighCandidates()/weightedSample() helpers filtered by
-- subtopic_id instead of topic_id. Noted here only so the "why no new RPC"
-- question doesn't come up later.

-- ============================================================================
-- 16. AI features (Gemini-powered "Teach Me This" / Study Assistant)
-- ============================================================================
-- The AI provider only ever explains verified data already in this schema —
-- it never decides correctness. check_and_log_ai_usage() is the server-side
-- daily rate limit (limit itself lives in the app's AI_DAILY_LIMIT env var,
-- passed in as a parameter, not hardcoded here). get_teach_me_context() is
-- the ONLY way the app fetches a question's real answer key/explanation for
-- an AI prompt, and it only does so for a question the caller has actually
-- already answered in an attempt they own (same ownership pattern as
-- get_attempt_review) — so it can never be used to peek at unanswered
-- questions.

create table if not exists public.ai_usage (
  user_id uuid not null references public.profiles (id) on delete cascade,
  usage_date date not null default current_date,
  request_count int not null default 0,
  primary key (user_id, usage_date)
);

alter table public.ai_usage enable row level security;

drop policy if exists "ai_usage_own_or_admin" on public.ai_usage;
create policy "ai_usage_own_or_admin" on public.ai_usage
  for select to authenticated
  using (user_id = auth.uid() or public.is_admin());

create or replace function public.check_and_log_ai_usage(p_daily_limit int)
returns table (allowed boolean, remaining int)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count int;
begin
  insert into public.ai_usage (user_id, usage_date, request_count)
  values (auth.uid(), current_date, 0)
  on conflict (user_id, usage_date) do nothing;

  select request_count into v_count
  from public.ai_usage
  where user_id = auth.uid() and usage_date = current_date
  for update;

  if v_count >= p_daily_limit then
    return query select false, 0;
  else
    update public.ai_usage
    set request_count = request_count + 1
    where user_id = auth.uid() and usage_date = current_date;
    return query select true, greatest(0, p_daily_limit - v_count - 1);
  end if;
end;
$$;

grant execute on function public.check_and_log_ai_usage(int) to authenticated;

create or replace function public.get_teach_me_context(p_attempt_id uuid, p_question_id uuid)
returns table (
  question_text text,
  choices jsonb,
  explanation text,
  topic_name text,
  subtopic_name text,
  exam_area_name text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_ok boolean;
begin
  select exists (
    select 1
    from public.attempts a
    join public.attempt_answers aa
      on aa.attempt_id = a.id and aa.question_id = p_question_id
    where a.id = p_attempt_id
      and (a.user_id = auth.uid() or public.is_admin())
      and aa.is_correct is not null
  ) into v_ok;

  if not v_ok then
    raise exception 'This question has not been answered in that attempt, or the attempt is not yours.';
  end if;

  return query
    select
      q.question_text,
      coalesce(
        jsonb_agg(
          jsonb_build_object('text', c.choice_text, 'is_correct', c.is_correct)
          order by c.sort_order
        ),
        '[]'::jsonb
      ),
      q.explanation,
      t.name,
      st.name,
      ea.name
    from public.questions q
    join public.topics t on t.id = q.topic_id
    join public.exam_areas ea on ea.id = t.exam_area_id
    left join public.subtopics st on st.id = q.subtopic_id
    left join public.choices c on c.question_id = q.id
    where q.id = p_question_id
    group by q.question_text, q.explanation, t.name, st.name, ea.name;
end;
$$;

grant execute on function public.get_teach_me_context(uuid, uuid) to authenticated;

-- ============================================================================
-- 18. get_my_bookmarks — bookmarked questions with real question text
-- ============================================================================
-- `bookmarks` (Section 5) already exists with plain own-row RLS — toggling a
-- bookmark is a direct insert/delete from the client. Listing them needs the
-- question's text, but `questions` is admin-only for direct SELECT — same
-- fix as get_my_notes() above (SECURITY DEFINER + explicit auth.uid() filter).

create or replace function public.get_my_bookmarks()
returns table (
  bookmark_id uuid,
  question_id uuid,
  question_text text,
  topic_name text,
  created_at timestamptz
)
language sql
security definer
stable
set search_path = public
as $$
  select
    b.id,
    q.id,
    q.question_text,
    t.name,
    b.created_at
  from public.bookmarks b
  join public.questions q on q.id = b.question_id
  join public.topics t on t.id = q.topic_id
  where b.user_id = auth.uid()
  order by b.created_at desc;
$$;

grant execute on function public.get_my_bookmarks() to authenticated;

-- ============================================================================
-- Note on future schema changes
-- ============================================================================
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

-- ============================================================================
-- 21. user_settings — Profile/Settings preferences (Feature: Profile & Settings)
-- ============================================================================
-- One row per user, created lazily on first save (app code upserts by
-- user_id). Deliberately a separate table from `profiles` rather than new
-- columns on it — profiles is the core identity row (referenced by many FKs,
-- guarded by the role-escalation trigger); preferences are a distinct,
-- purely-owned-by-the-user concern, matching the existing pattern for
-- question_notes/bookmarks/study_plans (own small table keyed on user_id).
--
-- target_exam_date here is a general preference the student can set from
-- /profile at any time. It's intentionally separate from
-- study_plans.target_exam_date, which only exists once a full plan has been
-- generated (it's required alongside study_days/minutes_per_day there). The
-- Study Plan page pre-fills its date field from this preference when no plan
-- exists yet, and generating a plan writes the chosen date back here — so
-- the two stay in sync without one table depending on the other's shape.

create table if not exists public.user_settings (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  target_exam_date date,
  default_practice_length int not null default 20
    check (default_practice_length in (10, 20, 30, 50)),
  default_practice_mode text not null default 'mixed'
    check (default_practice_mode in ('mixed', 'weak_areas', 'mistakes', 'unanswered')),
  updated_at timestamptz not null default now()
);

comment on table public.user_settings is 'Per-user Profile/Settings preferences: target exam date, default practice length/mode. See 26_BUILD_CHECKLIST.md.';

alter table public.user_settings enable row level security;

drop policy if exists "user_settings_own_or_admin" on public.user_settings;
create policy "user_settings_own_or_admin" on public.user_settings
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- ============================================================================
-- Note on future schema changes
-- ============================================================================
-- This file is the CURRENT full schema, not a migration history. Once the
-- pilot is live with real data, switch to timestamped migration files
-- (supabase/migrations/<timestamp>_<name>.sql, applied via `supabase db
-- push` or the SQL Editor) instead of re-running/editing this file, so
-- existing data and applied changes aren't clobbered.
