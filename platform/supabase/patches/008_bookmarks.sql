-- ============================================================================
-- 18. get_my_bookmarks — bookmarked questions with real question text
-- ============================================================================
-- `bookmarks` already exists (Section 5, plain own-row RLS) — toggling a
-- bookmark is a direct insert/delete from the client. Listing them needs the
-- question's text, but `questions` is admin-only for direct SELECT — same
-- fix as get_my_notes() (SECURITY DEFINER + explicit auth.uid() filter).

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
