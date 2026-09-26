-- Two real bugs found by actually running patch 035's search functions
-- against live data with the spec's own test queries:
--
-- 1. The fuzzy-fallback tier used similarity(query, target), which computes
--    over the WHOLE target string — a short typo like "irrigaton" against a
--    long target like "Irrigation and Drainage Engineering" gets diluted
--    below the 0.3 threshold even though it's a near-perfect match of the
--    first word, so it returned nothing at all (confirmed: "irrigaton" and
--    "enviroment" both failed to surface their obvious intended match).
--    word_similarity(query, target) is pg_trgm's purpose-built answer to
--    this — it finds the best-matching WORD-BOUNDARY substring of target
--    rather than scoring the whole string, so a short query against a long
--    multi-word target isn't unfairly penalized.
--
-- 2. search_suggestions() could return the same name twice (once from
--    subjects, once from topics, when both have a row with that exact
--    name, e.g. "Hydrology") — added a group-by to dedupe.
--
-- CREATE OR REPLACE with the SAME parameter list is a true replace, not a
-- new overload (unlike the CREATE OR REPLACE that added a parameter and
-- broke submit_attempt_answer/check_and_log_ai_usage earlier this project
-- — no drop needed here since the signature is unchanged).

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
        when word_similarity((select norm from q), lower(ea.name)) > 0.3
          then 100.0 + word_similarity((select norm from q), lower(ea.name)) * 100.0
        else 0.0
      end)::real as rank
    from public.exam_areas ea
  )
  select id, name, rank from scored where rank > 0 order by rank desc, name asc limit p_limit;
$$;

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
          when word_similarity((select norm from q), lower(s.name)) > 0.3
            then 100.0 + word_similarity((select norm from q), lower(s.name)) * 100.0
          else 0.0
        end)
        + (case when ea.name is not null and lower(ea.name) like '%' || (select norm from q) || '%' then 15.0 else 0.0 end)
      )::real as rank
    from public.subjects s
    join public.exam_areas ea on ea.id = s.exam_area_id
  )
  select id, name, exam_area_id, exam_area_name, rank from scored where rank > 0 order by rank desc, name asc limit p_limit;
$$;

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
          when word_similarity((select norm from q), lower(t.name)) > 0.3
            then 100.0 + word_similarity((select norm from q), lower(t.name)) * 100.0
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
          when word_similarity((select norm from q), lower(sq.question_text)) > 0.3
            then 100.0 + word_similarity((select norm from q), lower(sq.question_text)) * 100.0
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
          when word_similarity((select norm from q), lower(re.title)) > 0.3
            then 100.0 + word_similarity((select norm from q), lower(re.title)) * 100.0
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
          when word_similarity((select norm from q), lower(f.front)) > 0.3
            then 100.0 + word_similarity((select norm from q), lower(f.front)) * 100.0
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

-- Deduped by name (max similarity kept when both a subject and a topic
-- share the same name, e.g. "Hydrology") and switched to word_similarity
-- for the same long-target-dilution reason as above.
create or replace function public.search_suggestions(p_query text, p_limit int default 3)
returns table (label text, similarity real)
language sql
stable
as $$
  with q as (select public.search_normalize(p_query) as norm),
  candidates as (
    select name, word_similarity((select norm from q), lower(name)) as sim from public.exam_areas
    union all
    select name, word_similarity((select norm from q), lower(name)) from public.subjects
    union all
    select name, word_similarity((select norm from q), lower(name)) from public.topics
  )
  select name, max(sim)::real from candidates where sim > 0.25 group by name order by max(sim) desc limit p_limit;
$$;
