import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { groupByWeek, formatDateTimeManila } from "@/lib/manila-week";
import { approvePaymentRequest, confirmAutoApproval, rejectPaymentRequest, revokeAutoApproval } from "./actions";

type RequestRow = {
  id: string;
  user_id: string;
  method: string;
  reference_number: string;
  payer_name: string | null;
  amount_php: number;
  status: string;
  receipt_path: string | null;
  auto_approved: boolean;
  admin_note: string | null;
  submitted_at: string;
  profiles: { email: string; display_name: string | null } | null;
};

const RECENT_AUTO_APPROVED_LIMIT = 100;

export default async function AdminPaymentsPage() {
  await requireAdmin();
  const admin = createAdminClient();

  // payment_requests has two FKs to profiles (user_id and reviewed_by), so
  // the embed target must be disambiguated with the !constraint-name hint
  // or PostgREST errors with PGRST201 "more than one relationship was
  // found" — which was silently swallowed into an empty list here before
  // this fix, since neither query's error was surfaced on the page.
  const [{ data: pending }, { data: recentAuto }] = await Promise.all([
    admin
      .from("payment_requests")
      .select("*, profiles!payment_requests_user_id_fkey(email, display_name)")
      .eq("status", "pending")
      .order("submitted_at", { ascending: true })
      // Capped, not truly unbounded (2026-09-28 public-launch audit) — a
      // pending backlog this deep would itself be the real problem to fix.
      .limit(500),
    admin
      .from("payment_requests")
      .select("*, profiles!payment_requests_user_id_fkey(email, display_name)")
      .eq("auto_approved", true)
      .eq("status", "approved")
      // Confirming an entry (spot-checked, legit) removes it from this list
      // without touching status/plan — see confirmAutoApproval's doc comment.
      .is("spot_checked_at", null)
      .order("submitted_at", { ascending: false })
      .limit(RECENT_AUTO_APPROVED_LIMIT),
  ]);

  const pendingRows = (pending ?? []) as unknown as RequestRow[];
  const autoRows = (recentAuto ?? []) as unknown as RequestRow[];

  const allPaths = [...pendingRows, ...autoRows].map((r) => r.receipt_path).filter((p): p is string => Boolean(p));
  const signedUrlByPath = new Map<string, string>();
  if (allPaths.length > 0) {
    // Long-lived on purpose (Gabriel's explicit "make the pictures available
    // until declined or approved", 2026-09-28) -- a fresh signed URL is
    // generated on every page load anyway, but this keeps an already-open
    // receipt tab (or a bookmarked link) working across a multi-day review
    // instead of dying after an hour.
    const { data: signed } = await admin.storage.from("payment-receipts").createSignedUrls(allPaths, 60 * 60 * 24 * 30);
    for (const s of signed ?? []) {
      if (s.signedUrl && s.path) signedUrlByPath.set(s.path, s.signedUrl);
    }
  }

  function RequestCard({ r, showActions }: { r: RequestRow; showActions: "pending" | "auto" }) {
    const receiptUrl = r.receipt_path ? signedUrlByPath.get(r.receipt_path) : null;
    return (
      <Card key={r.id}>
        <CardContent className="space-y-2 py-4">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <p className="text-sm font-medium">
              {r.profiles?.display_name || r.profiles?.email || r.user_id}
              {r.profiles?.display_name && (
                <span className="ml-1.5 text-xs font-normal text-muted-foreground">({r.profiles.email})</span>
              )}
            </p>
            <Badge variant="secondary">{r.method.toUpperCase()}</Badge>
          </div>
          <p className="text-sm">
            Reference: <span className="font-mono">{r.reference_number}</span>
            {r.payer_name && <span className="text-muted-foreground"> — paid as &quot;{r.payer_name}&quot;</span>}
          </p>
          <p className="text-xs text-muted-foreground">
            ₱{r.amount_php} · submitted {formatDateTimeManila(r.submitted_at)}
          </p>
          {r.admin_note && <p className="text-xs text-muted-foreground italic">AI note: {r.admin_note}</p>}
          {receiptUrl && (
            <a href={receiptUrl} target="_blank" rel="noopener noreferrer" className="text-xs text-primary hover:underline">
              View receipt →
            </a>
          )}
          <div className="flex gap-2 pt-1">
            {showActions === "pending" ? (
              <>
                <form action={approvePaymentRequest.bind(null, r.id, r.user_id)}>
                  <Button type="submit" size="sm">
                    Approve →
                  </Button>
                </form>
                <form action={rejectPaymentRequest.bind(null, r.id)}>
                  <Button type="submit" size="sm" variant="outline">
                    Reject
                  </Button>
                </form>
              </>
            ) : (
              <>
                <form action={confirmAutoApproval.bind(null, r.id)}>
                  <Button type="submit" size="sm" variant="outline">
                    Confirm
                  </Button>
                </form>
                <form action={revokeAutoApproval.bind(null, r.id, r.user_id)}>
                  <Button type="submit" size="sm" variant="destructive">
                    Revoke (fake)
                  </Button>
                </form>
              </>
            )}
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="mx-auto w-full max-w-4xl space-y-8 px-4 py-10">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Payment Requests</h1>
          <p className="mt-1 text-sm text-muted-foreground">
            Manual GCash/Maya/Landbank payments students submit on /upgrade. A receipt that passes the automatic
            reference + name check is approved instantly — this page is where you review everything else, and where
            you can revoke an auto-approval that turns out to be fake.
          </p>
        </div>
        <Link href="/admin" className="shrink-0 text-sm text-muted-foreground hover:underline">
          ← Back to Admin
        </Link>
      </div>

      <div>
        <h2 className="mb-3 text-sm font-semibold text-muted-foreground">
          Awaiting review ({pendingRows.length})
        </h2>
        {pendingRows.length === 0 ? (
          <p className="text-sm text-muted-foreground">Nothing waiting — you&apos;re all caught up.</p>
        ) : (
          <div className="space-y-3">
            {pendingRows.map((r) => (
              <RequestCard key={r.id} r={r} showActions="pending" />
            ))}
          </div>
        )}
      </div>

      <div>
        <h2 className="mb-1 text-sm font-semibold text-muted-foreground">
          Recently auto-approved ({autoRows.length})
        </h2>
        <p className="mb-3 text-xs text-muted-foreground">
          Worth a quick spot-check — Confirm dismisses a legit one from this list (the student stays a Subscriber
          either way); Revoke is for one that turns out to be fake.
        </p>
        {autoRows.length === 0 ? (
          <p className="text-sm text-muted-foreground">None yet.</p>
        ) : (
          <div className="space-y-2">
            {groupByWeek(autoRows, (r) => r.submitted_at).map((week, i) => (
              <details key={week.weekKey} open={i === 0} className="group rounded-md border border-border/60">
                <summary className="cursor-pointer list-none px-3 py-2 text-xs font-semibold tracking-wide text-muted-foreground uppercase select-none">
                  <span className="mr-1 inline-block transition-transform group-open:rotate-90">›</span>
                  {week.label} <span className="normal-case">({week.items.length})</span>
                </summary>
                <div className="space-y-3 border-t border-border/60 p-3">
                  {week.items.map((r) => (
                    <RequestCard key={r.id} r={r} showActions="auto" />
                  ))}
                </div>
              </details>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
