import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { approvePaymentRequest, rejectPaymentRequest, revokeAutoApproval } from "./actions";

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

const RECENT_AUTO_APPROVED_LIMIT = 20;

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
      .order("submitted_at", { ascending: true }),
    admin
      .from("payment_requests")
      .select("*, profiles!payment_requests_user_id_fkey(email, display_name)")
      .eq("auto_approved", true)
      .eq("status", "approved")
      .order("submitted_at", { ascending: false })
      .limit(RECENT_AUTO_APPROVED_LIMIT),
  ]);

  const pendingRows = (pending ?? []) as unknown as RequestRow[];
  const autoRows = (recentAuto ?? []) as unknown as RequestRow[];

  const allPaths = [...pendingRows, ...autoRows].map((r) => r.receipt_path).filter((p): p is string => Boolean(p));
  const signedUrlByPath = new Map<string, string>();
  if (allPaths.length > 0) {
    const { data: signed } = await admin.storage.from("payment-receipts").createSignedUrls(allPaths, 60 * 60);
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
            ₱{r.amount_php} · submitted {new Date(r.submitted_at).toLocaleString()}
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
              <form action={revokeAutoApproval.bind(null, r.id, r.user_id)}>
                <Button type="submit" size="sm" variant="destructive">
                  Revoke (fake)
                </Button>
              </form>
            )}
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="mx-auto w-full max-w-4xl space-y-8 px-4 py-10">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Payment Requests</h1>
        <p className="mt-1 text-sm text-muted-foreground">
          Manual GCash/Maya/Landbank payments students submit on /upgrade. A receipt that passes the automatic
          reference + name check is approved instantly — this page is where you review everything else, and where
          you can revoke an auto-approval that turns out to be fake.
        </p>
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
          Worth a quick spot-check — revoke any that don&apos;t actually check out.
        </p>
        {autoRows.length === 0 ? (
          <p className="text-sm text-muted-foreground">None yet.</p>
        ) : (
          <div className="space-y-3">
            {autoRows.map((r) => (
              <RequestCard key={r.id} r={r} showActions="auto" />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
