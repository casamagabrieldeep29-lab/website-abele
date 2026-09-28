-- Manual payment verification queue. No payment gateway involved (see
-- 25_DECISION_LOG.md 2026-09-18 and the follow-up conversation on
-- 2026-09-28 confirming this stays manual — Gabriel doesn't hold a valid ID
-- for the KYC a real gateway like PayMongo/Xendit would require). A student
-- pays Gabriel directly via GCash/Maya/Landbank, submits the reference
-- number here, and an admin approves or rejects it by hand from
-- /admin/payments — approval is the one thing that actually flips
-- profiles.plan to 'subscriber'.
create table if not exists public.payment_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  method text not null check (method in ('gcash', 'maya', 'landbank')),
  reference_number text not null,
  payer_name text,
  amount_php numeric(10, 2) not null default 699,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  -- Set when a receipt image was uploaded and passed the AI verification
  -- check (src/lib/receipt-verification.ts) — the request was auto-approved
  -- rather than reviewed by hand. `receipt_path` is the storage object path
  -- either way (the check can still fail and leave status 'pending' for
  -- manual review, with the reason recorded in admin_note).
  receipt_path text,
  auto_approved boolean not null default false,
  admin_note text,
  submitted_at timestamptz not null default now(),
  reviewed_at timestamptz,
  reviewed_by uuid references public.profiles (id)
);

create index if not exists payment_requests_user_id_idx on public.payment_requests (user_id);
create index if not exists payment_requests_status_idx on public.payment_requests (status);

alter table public.payment_requests enable row level security;

-- A student can see and create only their own requests. There is
-- deliberately no update/delete policy for regular users — approving or
-- rejecting a request (and the plan flip that comes with it) only ever
-- happens through /admin/payments' service-role actions, same pattern as
-- every other admin action in this codebase (requireAdmin() +
-- createAdminClient(), which bypasses RLS entirely).
create policy "payment_requests_select_own" on public.payment_requests
  for select using (auth.uid() = user_id);

create policy "payment_requests_insert_own" on public.payment_requests
  for insert with check (auth.uid() = user_id);

-- Receipt screenshots. Private bucket — a student can upload/read only
-- their own (path convention: <user_id>/<filename>), same "own rows only"
-- shape as the table above; the admin review page reads any path via the
-- service-role client, which bypasses storage RLS entirely.
insert into storage.buckets (id, name, public)
values ('payment-receipts', 'payment-receipts', false)
on conflict (id) do nothing;

create policy "payment_receipts_insert_own" on storage.objects
  for insert with check (
    bucket_id = 'payment-receipts' and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "payment_receipts_select_own" on storage.objects
  for select using (
    bucket_id = 'payment-receipts' and (storage.foldername(name))[1] = auth.uid()::text
  );
