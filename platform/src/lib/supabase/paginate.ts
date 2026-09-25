import "server-only";

type PageResult<T> = { data: T[] | null; error: { message: string } | null };

/**
 * Generic PostgREST pagination helper. Supabase/PostgREST caps any plain
 * `.select()` at 1000 rows by default — a query with no `.range()`/`.limit()`
 * silently drops every row past the 1000th, with no error, on any table/
 * filter combination that can match more than 1000 rows. See
 * `src/lib/study-stats.ts`'s `fetchAllAnsweredRows` for the original,
 * table-specific version of this pattern (attempt_answers); this is the
 * same idea generalized so other tables/selects/filters (student_questions,
 * questions, reviewer_entries, etc.) can reuse it instead of each hand-
 * rolling their own `.range()` loop.
 *
 * `buildPage(from, to)` must return the SAME query (same table, select,
 * filters, order) with `.range(from, to)` applied — a fresh query per page,
 * since a supabase-js query builder can't be re-executed after its first
 * `.then()`. Pages are fetched sequentially (not in parallel) so a short
 * page can end the loop without over-fetching.
 */
export async function fetchAllRows<T>(
  buildPage: (from: number, to: number) => PromiseLike<PageResult<T>>,
  pageSize = 1000,
): Promise<T[]> {
  const all: T[] = [];
  for (let from = 0; ; from += pageSize) {
    const { data, error } = await buildPage(from, from + pageSize - 1);
    if (error) throw new Error(error.message);
    if (!data || data.length === 0) break;
    all.push(...data);
    if (data.length < pageSize) break;
  }
  return all;
}
