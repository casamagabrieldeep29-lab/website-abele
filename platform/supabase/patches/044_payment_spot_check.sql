-- Lets an admin dismiss an auto-approved payment from the "Recently
-- auto-approved" spot-check list on /admin/payments without touching the
-- student's plan (Gabriel's explicit "it should have an option to confirm
-- and once clicked the autoapproved account will be deleted in the list.
-- but not in the users subscriber", 2026-09-28) -- confirming just means
-- "I looked, it's legit," recorded separately from revokeAutoApproval's
-- opposite action (which does change payment_requests.status AND
-- profiles.plan back down).
alter table public.payment_requests
  add column if not exists spot_checked_at timestamptz;
