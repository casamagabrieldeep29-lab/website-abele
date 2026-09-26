-- Global Search relevance upgrade — the search bar (src/components/global-
-- search/) previously did a plain multi-word ILIKE AND filter with no
-- ranking: matches came back in whatever order Postgres felt like, exact
-- matches didn't outrank incidental substring hits, and a typo ("hydrolgy")
-- returned nothing. This replaces that with one ranked, SECURITY INVOKER
-- Postgres function per searchable table, each doing the actual matching +
-- scoring server-side (cheap even at 2000+ questions once trigram-indexed),
-- so the TS action layer just calls these and shapes the same SearchResult
-- objects it already did — no UI change, same real tables, no new source of
-- truth.
--
-- SECURITY INVOKER (the default — none of these are `security definer`) is
-- deliberate: every one of these tables already has a "published or admin"
-- (or "authenticated can read") RLS policy, the exact same one the old
-- plain `.select()` calls relied on. Running as the caller keeps that
-- guarantee intact rather than re-implementing it in SQL here.
--
-- Relevance is a tiered CASE, not a raw sum — this is what keeps a fuzzy
-- (typo) match from ever outranking a real substring/prefix/exact match,
-- per the "exact matches must ALWAYS outrank fuzzy matches" requirement:
--   1000  exact match (normalized)
--    800  prefix match
--    600  every query word present (multi-word AND, any order)
--  300+   some query words present (scaled by how many)
--  100+   fuzzy fallback ONLY — no query word matched at all, but trigram
--         similarity clears a threshold (typo tolerance)
--    0    excluded entirely (row not returned)
-- A small metadata bonus (query words found in the parent topic/subject/
-- exam-area name) is added on top, capped well below the next tier up so
-- it can nudge ordering within a tier but never jump a row into one it
-- didn't actually earn.

create extension if not exists pg_trgm;

create index if not exists exam_areas_name_trgm_idx on public.exam_areas using gin (name gin_trgm_ops);
create index if not exists subjects_name_trgm_idx on public.subjects using gin (name gin_trgm_ops);
create index if not exists topics_name_trgm_idx on public.topics using gin (name gin_trgm_ops);
create index if not exists questions_text_trgm_idx on public.questions using gin (question_text gin_trgm_ops);
create index if not exists reviewer_entries_title_trgm_idx on public.reviewer_entries using gin (title gin_trgm_ops);
create index if not exists flashcards_front_trgm_idx on public.flashcards using gin (front gin_trgm_ops);

-- Shared normalization: trim, collapse repeated whitespace, lowercase. Kept
-- as one immutable SQL function so every search function agrees on what
-- "the same query" means (section 11 of the spec).
create or replace function public.search_normalize(p_text text)
returns text
language sql
immutable
as $$
  select regexp_replace(lower(trim(coalesce(p_text, ''))), '\s+', ' ', 'g');
$$;

-- Query words, deduplicated and empty-string-filtered — used for the
-- "all/some words present" tiers. Order-independent by construction
-- (each word is tested for substring presence individually), which is what
-- makes "water soil" still find "Soil and Water Conservation Engineering".
create or replace function public.search_words(p_query text)
returns text[]
language sql
immutable
as $$
  select coalesce(array_agg(distinct w) filter (where w <> ''), '{}')
  from unnest(regexp_split_to_array(public.search_normalize(p_query), ' ')) as w;
$$;

-- ============================================================================
-- exam_areas (TOS)
-- ============================================================================
create or replace function public.search_exam_areas(p_query text, p_limit int default 5)
returns table (id uuid, name text, rank real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm, public.search_words(p_query) as words),
  scored as (
    select
      ea.id, ea.name,
      (case
        when lower(ea.name) = (select norm from q) then 1000.0
        when lower(ea.name) like (select norm from q) || '%' then 800.0
        when (select count(*) from unnest((select words from q)) w where lower(ea.name) like '%' || w || '%')
             = array_length((select words from q), 1)
          then 600.0
        when (select count(*) from unnest((select words from q)) w where lower(ea.name) like '%' || w || '%') > 0
          then 300.0 + (select count(*) from unnest((select words from q)) w where lower(ea.name) like '%' || w || '%') * 20.0
        when similarity(lower(ea.name), (select norm from q)) > 0.3
          then 100.0 + similarity(lower(ea.name), (select norm from q)) * 100.0
        else 0.0
      end)::real as rank
    from public.exam_areas ea
  )
  select id, name, rank from scored where rank > 0 order by rank desc, name asc limit p_limit;
$$;

-- ============================================================================
-- subjects (with parent exam_area name as metadata bonus)
-- ============================================================================
create or replace function public.search_subjects(p_query text, p_limit int default 5)
returns table (id uuid, name text, exam_area_id uuid, exam_area_name text, rank real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm, public.search_words(p_query) as words),
  scored as (
    select
      s.id, s.name, s.exam_area_id, ea.name as exam_area_name,
      (
        (case
          when lower(s.name) = (select norm from q) then 1000.0
          when lower(s.name) like (select norm from q) || '%' then 800.0
          when (select count(*) from unnest((select words from q)) w where lower(s.name) like '%' || w || '%')
               = array_length((select words from q), 1)
            then 600.0
          when (select count(*) from unnest((select words from q)) w where lower(s.name) like '%' || w || '%') > 0
            then 300.0 + (select count(*) from unnest((select words from q)) w where lower(s.name) like '%' || w || '%') * 20.0
          when similarity(lower(s.name), (select norm from q)) > 0.3
            then 100.0 + similarity(lower(s.name), (select norm from q)) * 100.0
          else 0.0
        end)
        + (case when ea.name is not null and lower(ea.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
      )::real as rank
    from public.subjects s
    join public.exam_areas ea on ea.id = s.exam_area_id
  )
  select id, name, exam_area_id, exam_area_name, rank from scored where rank > 0 order by rank desc, name asc limit p_limit;
$$;

-- ============================================================================
-- topics (with parent subject/exam_area names as metadata bonus)
-- ============================================================================
create or replace function public.search_topics(p_query text, p_limit int default 5)
returns table (id uuid, name text, exam_area_id uuid, subject_id uuid, exam_area_name text, rank real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm, public.search_words(p_query) as words),
  scored as (
    select
      t.id, t.name, t.exam_area_id, t.subject_id, ea.name as exam_area_name,
      (
        (case
          when lower(t.name) = (select norm from q) then 1000.0
          when lower(t.name) like (select norm from q) || '%' then 800.0
          when (select count(*) from unnest((select words from q)) w where lower(t.name) like '%' || w || '%')
               = array_length((select words from q), 1)
            then 600.0
          when (select count(*) from unnest((select words from q)) w where lower(t.name) like '%' || w || '%') > 0
            then 300.0 + (select count(*) from unnest((select words from q)) w where lower(t.name) like '%' || w || '%') * 20.0
          when similarity(lower(t.name), (select norm from q)) > 0.3
            then 100.0 + similarity(lower(t.name), (select norm from q)) * 100.0
          else 0.0
        end)
        + (case when ea.name is not null and lower(ea.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
        + (case when s.name is not null and lower(s.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
      )::real as rank
    from public.topics t
    join public.exam_areas ea on ea.id = t.exam_area_id
    left join public.subjects s on s.id = t.subject_id
  )
  select id, name, exam_area_id, subject_id, exam_area_name, rank from scored where rank > 0 order by rank desc, name asc limit p_limit;
$$;

-- ============================================================================
-- questions (student_questions view — published-only, no source column,
-- same access this feature already relied on before this migration)
-- ============================================================================
create or replace function public.search_questions(p_query text, p_limit int default 5)
returns table (id uuid, question_text text, topic_id uuid, subtopic_id uuid, topic_name text, exam_area_name text, rank real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm, public.search_words(p_query) as words),
  scored as (
    select
      sq.id, sq.question_text, sq.topic_id, sq.subtopic_id, t.name as topic_name, ea.name as exam_area_name,
      (
        (case
          when lower(sq.question_text) = (select norm from q) then 1000.0
          when lower(sq.question_text) like (select norm from q) || '%' then 800.0
          when (select count(*) from unnest((select words from q)) w where lower(sq.question_text) like '%' || w || '%')
               = array_length((select words from q), 1)
            then 600.0
          when (select count(*) from unnest((select words from q)) w where lower(sq.question_text) like '%' || w || '%') > 0
            then 300.0 + (select count(*) from unnest((select words from q)) w where lower(sq.question_text) like '%' || w || '%') * 20.0
          when similarity(lower(sq.question_text), (select norm from q)) > 0.3
            then 100.0 + similarity(lower(sq.question_text), (select norm from q)) * 100.0
          else 0.0
        end)
        + (case when t.name is not null and lower(t.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
        + (case when ea.name is not null and lower(ea.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
      )::real as rank
    from public.student_questions sq
    join public.topics t on t.id = sq.topic_id
    join public.exam_areas ea on ea.id = t.exam_area_id
  )
  select id, question_text, topic_id, subtopic_id, topic_name, exam_area_name, rank
  from scored where rank > 0 order by rank desc limit p_limit;
$$;

-- ============================================================================
-- reviewer_entries (Materials) — published only
-- ============================================================================
create or replace function public.search_materials(p_query text, p_limit int default 5)
returns table (id uuid, title text, kind text, topic_id uuid, topic_name text, rank real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm, public.search_words(p_query) as words),
  scored as (
    select
      re.id, re.title, re.kind, re.topic_id, t.name as topic_name,
      (
        (case
          when lower(re.title) = (select norm from q) then 1000.0
          when lower(re.title) like (select norm from q) || '%' then 800.0
          when (select count(*) from unnest((select words from q)) w where lower(re.title) like '%' || w || '%')
               = array_length((select words from q), 1)
            then 600.0
          when (select count(*) from unnest((select words from q)) w where lower(re.title) like '%' || w || '%') > 0
            then 300.0 + (select count(*) from unnest((select words from q)) w where lower(re.title) like '%' || w || '%') * 20.0
          when similarity(lower(re.title), (select norm from q)) > 0.3
            then 100.0 + similarity(lower(re.title), (select norm from q)) * 100.0
          else 0.0
        end)
        + (case when t.name is not null and lower(t.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
      )::real as rank
    from public.reviewer_entries re
    join public.topics t on t.id = re.topic_id
    where re.status = 'published'
  )
  select id, title, kind, topic_id, topic_name, rank from scored where rank > 0 order by rank desc limit p_limit;
$$;

-- ============================================================================
-- flashcards — published only
-- ============================================================================
create or replace function public.search_flashcards(p_query text, p_limit int default 5)
returns table (id uuid, front text, topic_id uuid, topic_name text, rank real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm, public.search_words(p_query) as words),
  scored as (
    select
      f.id, f.front, f.topic_id, t.name as topic_name,
      (
        (case
          when lower(f.front) = (select norm from q) then 1000.0
          when lower(f.front) like (select norm from q) || '%' then 800.0
          when (select count(*) from unnest((select words from q)) w where lower(f.front) like '%' || w || '%')
               = array_length((select words from q), 1)
            then 600.0
          when (select count(*) from unnest((select words from q)) w where lower(f.front) like '%' || w || '%') > 0
            then 300.0 + (select count(*) from unnest((select words from q)) w where lower(f.front) like '%' || w || '%') * 20.0
          when similarity(lower(f.front), (select norm from q)) > 0.3
            then 100.0 + similarity(lower(f.front), (select norm from q)) * 100.0
          else 0.0
        end)
        + (case when t.name is not null and lower(t.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
      )::real as rank
    from public.flashcards f
    join public.topics t on t.id = f.topic_id
    where f.status = 'published'
  )
  select id, front, topic_id, topic_name, rank from scored where rank > 0 order by rank desc limit p_limit;
$$;

-- ============================================================================
-- "Did you mean" fallback — only called client-side when every category
-- above comes back empty. Cheap (exam_areas/subjects/topics are small
-- tables), fuzzy-only by design, and only ever suggests names that actually
-- exist — never fabricated.
-- ============================================================================
create or replace function public.search_suggestions(p_query text, p_limit int default 3)
returns table (label text, similarity real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm),
  candidates as (
    select name, similarity(lower(name), (select norm from q)) as sim from public.exam_areas
    union all
    select name, similarity(lower(name), (select norm from q)) from public.subjects
    union all
    select name, similarity(lower(name), (select norm from q)) from public.topics
  )
  select name, sim::real from candidates where sim > 0.25 order by sim desc limit p_limit;
$$;

grant execute on function public.search_normalize(text) to authenticated;
grant execute on function public.search_words(text) to authenticated;
grant execute on function public.search_exam_areas(text, int) to authenticated;
grant execute on function public.search_subjects(text, int) to authenticated;
grant execute on function public.search_topics(text, int) to authenticated;
grant execute on function public.search_questions(text, int) to authenticated;
grant execute on function public.search_materials(text, int) to authenticated;
grant execute on function public.search_flashcards(text, int) to authenticated;
grant execute on function public.search_suggestions(text, int) to authenticated;
