-- HOTFIX: 028_confidence_check.sql's CREATE OR REPLACE FUNCTION added a 4th
-- parameter (p_confidence) to submit_attempt_answer, on the wrong assumption
-- that this would extend the existing 3-arg function in place. Postgres does
-- NOT treat a different parameter count as the same function to replace —
-- it created a second, parallel 4-arg overload instead, leaving the original
-- 3-arg version untouched. Every ordinary 3-arg call (every practice/mock
-- quiz submission that isn't using the confidence feature) is now ambiguous
-- between the two overloads and fails with PGRST203 "Could not choose the
-- best candidate function". This drops the stale 3-arg overload so only the
-- 4-arg version (p_confidence defaults to null) remains, resolving both old
-- and new call shapes unambiguously.

drop function if exists public.submit_attempt_answer(uuid, uuid, uuid[]);
