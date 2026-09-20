-- Introduces the official PRC TOS "Subject" level between exam_areas (TOS)
-- and topics. Previously topics.exam_area_id pointed straight at the 8 TOS
-- categories; the app's various subject/topic browsers (Question Bank,
-- Progress, Mock Exam) each need to group topics under the correct one of
-- the 1-4 official subjects per TOS instead of listing them flat under the
-- TOS directly. This is purely an additive grouping layer — no existing
-- topics/subtopics/questions/attempts/mastery data is touched or
-- renumbered; topics.id and every FK pointing at it are untouched.

create table if not exists public.subjects (
  id uuid primary key default gen_random_uuid(),
  exam_area_id uuid not null references public.exam_areas (id) on delete restrict,
  name text not null,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.subjects enable row level security;

drop policy if exists "subjects_select_authenticated" on public.subjects;
create policy "subjects_select_authenticated" on public.subjects
  for select to authenticated using (true);
drop policy if exists "subjects_admin_write" on public.subjects;
create policy "subjects_admin_write" on public.subjects
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- The 17 official TOS subjects, per 00_MASTER_PROJECT_INSTRUCTIONS.md's TOS
-- breakdown. Exact names — do not rename, split, or add to this list
-- without updating the source-of-truth document first.
insert into public.subjects (exam_area_id, name, sort_order)
select ea.id, v.name, v.sort_order
from (values
  ('POWER_ENERGY_MACHINERY', 'Agricultural and Biosystems Power Engineering', 1),
  ('POWER_ENERGY_MACHINERY', 'Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing', 2),
  ('POWER_ENERGY_MACHINERY', 'Agricultural and Biosystems Machinery Specifications, Testing and Evaluation', 3),
  ('POWER_ENERGY_MACHINERY', 'Agricultural and Biosystems Automation, Instrumentation and Control System', 4),
  ('LAND_WATER', 'Hydrology', 1),
  ('LAND_WATER', 'Irrigation and Drainage Engineering', 2),
  ('LAND_WATER', 'Soil and Water Conservation Engineering', 3),
  ('LAND_WATER', 'Aquaculture Engineering', 4),
  ('STRUCTURES_ENVIRONMENT', 'Agricultural Buildings and Structures', 1),
  ('STRUCTURES_ENVIRONMENT', 'Farm Electrification', 2),
  ('STRUCTURES_ENVIRONMENT', 'Environment Engineering', 3),
  ('BIOPROCESS', 'Agricultural and Bioprocess Engineering', 1),
  ('BIOPROCESS', 'Food Engineering', 2),
  ('PROJECT_MGMT_RDE', 'Project Management, Feasibility Study Preparation/Evaluation, Research, Development and Extension, and Information System on Agricultural and Biosystems Engineering', 1),
  ('FUNDAMENTALS_SCIENCES', 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences', 1),
  ('MATH_BASIC_ENGG', 'Mathematics and Basic Engineering', 1),
  ('LAWS_ETHICS', 'Laws, Professional Standards and Ethics', 1)
) as v(code, name, sort_order)
join public.exam_areas ea on ea.code = v.code
where not exists (
  select 1 from public.subjects s where s.exam_area_id = ea.id and s.name = v.name
);

alter table public.topics add column if not exists subject_id uuid references public.subjects (id);

-- get_topic_mastery() now also returns exam_area_id and subject_id/name so
-- callers can group per-topic mastery under the correct TOS and official
-- subject without a second round-trip. The mastery calculation itself is
-- byte-for-byte unchanged — only extra passthrough columns were added.
drop function if exists public.get_topic_mastery();

create function public.get_topic_mastery()
returns table (
  topic_id uuid,
  topic_name text,
  exam_area_id uuid,
  exam_area_name text,
  subject_id uuid,
  subject_name text,
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
    ea.id,
    ea.name,
    s.id,
    s.name,
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
  left join public.subjects s on s.id = t.subject_id
  left join agg a on a.topic_id = t.id
  order by t.name;
$$;

-- Backfill subject_id for every topic that currently exists (reconstructed
-- from the full SQL seed/migration history — see PR discussion). Scoped by
-- exam_area_code + exact name so this can't cross-match a same-named topic
-- under a different TOS (topics.name has no unique constraint). Deliberately
-- does NOT move any topic to a different exam_area_id/TOS than it already
-- has — only assigns it a subject within its existing TOS, even where a
-- topic's content might arguably fit a subject under a different TOS.
--
-- Intentionally left unmapped (subject_id stays null, surfaced in the app
-- as an "Other Topics" bucket rather than force-fit into a wrong subject):
--   - "Geographic Information System" (LAND_WATER) — none of that TOS's 4
--     official subjects (Hydrology / Irrigation and Drainage Engineering /
--     Soil and Water Conservation Engineering / Aquaculture Engineering) is
--     an honest fit.
--   - The "Area 1"/"Area 2"/"Area 3" topics — flashcards-only umbrella
--     containers created solely to satisfy flashcards.topic_id's NOT NULL
--     FK (see seed/content/flashcards-by-area-pilot.sql), holding zero MCQ
--     questions and no real subject-matter identity of their own.
-- If a topic was renamed/added through /admin/topics since this was
-- written and isn't in the list below, it will simply stay unmapped rather
-- than error — re-run this block after adding a matching row here.
with mapping(exam_area_code, topic_name, subject_name) as (
  values
    -- TOS 1 — Agricultural and Biosystems Power, Energy and Machinery Engineering
    ('POWER_ENERGY_MACHINERY', 'Internal Combustion Engine', 'Agricultural and Biosystems Power Engineering'),
    ('POWER_ENERGY_MACHINERY', 'Fuels and Lubricants', 'Agricultural and Biosystems Power Engineering'),
    ('POWER_ENERGY_MACHINERY', 'Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment', 'Agricultural and Biosystems Power Engineering'),
    ('POWER_ENERGY_MACHINERY', 'Agricultural Power and Tractor Operation', 'Agricultural and Biosystems Power Engineering'),
    ('POWER_ENERGY_MACHINERY', 'Agricultural Machinery, Power Units, and Workshop Management', 'Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing'),
    ('POWER_ENERGY_MACHINERY', 'Farm Machinery and Mechanization, Economics, Management, and Marketing', 'Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing'),
    ('POWER_ENERGY_MACHINERY', 'Operator''s Manual for AB Power and Machinery', 'Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing'),
    ('POWER_ENERGY_MACHINERY', 'Agricultural Machinery Design, Fabrication/Manufacturing and Testing', 'Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing'),
    ('POWER_ENERGY_MACHINERY', 'Selection of Tractor Size, Implements, and Other Specifications', 'Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing'),
    ('POWER_ENERGY_MACHINERY', 'Four-Wheel Tractors Methods of Test', 'Agricultural and Biosystems Machinery Specifications, Testing and Evaluation'),
    ('POWER_ENERGY_MACHINERY', 'Philippine National Standards on After-Sales Service and Methods of Sampling', 'Agricultural and Biosystems Machinery Specifications, Testing and Evaluation'),
    ('POWER_ENERGY_MACHINERY', 'Philippine National Standards on Technical Means for Ensuring Safety', 'Agricultural and Biosystems Machinery Specifications, Testing and Evaluation'),
    -- TOS 2 — Land and Water Resources Engineering (exact-name matches)
    ('LAND_WATER', 'Hydrology', 'Hydrology'),
    ('LAND_WATER', 'Irrigation and Drainage Engineering', 'Irrigation and Drainage Engineering'),
    ('LAND_WATER', 'Soil and Water Conservation Engineering', 'Soil and Water Conservation Engineering'),
    ('LAND_WATER', 'Aquaculture Engineering', 'Aquaculture Engineering'),
    -- TOS 3 — Agricultural and Biosystems Structures and Environment Engineering
    ('STRUCTURES_ENVIRONMENT', 'Agricultural Building and Structures', 'Agricultural Buildings and Structures'),
    ('STRUCTURES_ENVIRONMENT', 'Design and Specifications of Coffee Processing Facility', 'Agricultural Buildings and Structures'),
    ('STRUCTURES_ENVIRONMENT', 'Rural Electrification', 'Farm Electrification'),
    ('STRUCTURES_ENVIRONMENT', 'Environmental Engineering and Science', 'Environment Engineering'),
    -- TOS 4 — Agricultural and Bioprocess Engineering
    ('BIOPROCESS', 'Agricultural and Bioprocess Engineering', 'Agricultural and Bioprocess Engineering'),
    ('BIOPROCESS', 'Design and Management of AB Processing System', 'Agricultural and Bioprocess Engineering'),
    ('BIOPROCESS', 'Process Control in Agricultural Process Engineering', 'Agricultural and Bioprocess Engineering'),
    ('BIOPROCESS', 'Elements of Food Processing and Process Design', 'Food Engineering'),
    ('BIOPROCESS', 'Food Process Evaluation and Modelling', 'Food Engineering'),
    -- TOS 5 — only one official subject, so every existing topic maps to it
    ('PROJECT_MGMT_RDE', 'Engineering Economy and Project Feasibility Analysis', 'Project Management, Feasibility Study Preparation/Evaluation, Research, Development and Extension, and Information System on Agricultural and Biosystems Engineering'),
    ('PROJECT_MGMT_RDE', 'Agricultural Project Planning and Analysis', 'Project Management, Feasibility Study Preparation/Evaluation, Research, Development and Extension, and Information System on Agricultural and Biosystems Engineering'),
    -- TOS 6 — only one official subject
    ('FUNDAMENTALS_SCIENCES', 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences', 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences'),
    -- TOS 7 — only one official subject
    ('MATH_BASIC_ENGG', 'Mathematics and Basic Engineering', 'Mathematics and Basic Engineering'),
    ('MATH_BASIC_ENGG', 'Engineering Metrology and Equipment', 'Mathematics and Basic Engineering'),
    -- TOS 8 — only one official subject
    ('LAWS_ETHICS', 'Laws, Professional Standards, and Ethics', 'Laws, Professional Standards and Ethics')
)
update public.topics t
set subject_id = s.id
from mapping m
join public.exam_areas ea on ea.code = m.exam_area_code
join public.subjects s on s.exam_area_id = ea.id and s.name = m.subject_name
where t.exam_area_id = ea.id
  and t.name = m.topic_name
  and t.subject_id is distinct from s.id;
