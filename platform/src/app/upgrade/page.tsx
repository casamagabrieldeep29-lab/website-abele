import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { PageHeader } from "@/components/page-header";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { FASTER_APPROVAL_CONTACT, getPaymentMethods, UPGRADE_PRICE_PHP, type PaymentMethodKey } from "@/lib/payment-methods";
import { UpgradeForm } from "./upgrade-form";

const VALID_METHODS: PaymentMethodKey[] = ["gcash", "maya", "landbank"];

export default async function UpgradePage({
  searchParams,
}: {
  searchParams: Promise<{ submitted?: string; approved?: string; error?: string; method?: string }>;
}) {
  const { submitted, approved, error, method } = await searchParams;
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: profile }, { data: requests }] = await Promise.all([
    supabase.from("profiles").select("plan").eq("id", user.id).single(),
    supabase
      .from("payment_requests")
      .select("id, status")
      .eq("user_id", user.id)
      .order("submitted_at", { ascending: false }),
  ]);

  const hasPending = (requests ?? []).some((r) => r.status === "pending");
  const methods = getPaymentMethods();
  const preselectedMethod = VALID_METHODS.includes(method as PaymentMethodKey) ? (method as PaymentMethodKey) : methods[0].key;

  return (
    <div className="mx-auto w-full max-w-2xl space-y-6 px-4 py-10">
      <PageHeader
        title="Upgrade to Subscriber"
        description={`One-time payment of ₱${UPGRADE_PRICE_PHP} — no subscription, keep full access for good.`}
      />

      {profile?.plan === "subscriber" ? (
        <Card className={approved ? "border-success/30 bg-success/5" : undefined}>
          <CardContent className="py-6 text-center">
            <p className="text-sm font-medium">
              {approved ? "Payment verified — you're a Subscriber now. Enjoy!" : "You're already a Subscriber — thanks!"}
            </p>
            <Button
              render={<Link href="/dashboard">{approved ? "Explore ABELIEVER now" : "Back to dashboard"}</Link>}
              nativeButton={false}
              className="mt-4"
            />
          </CardContent>
        </Card>
      ) : (
        <>
          {submitted && (
            <p className="rounded-md border border-border bg-secondary/40 px-3 py-2 text-sm">
              Got it — we&apos;ll verify this and upgrade your account, usually within a day.
            </p>
          )}
          {error === "missing-fields" && (
            <p className="rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
              Pick a payment method and enter your reference number.
            </p>
          )}
          {error === "submit-failed" && (
            <p className="rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
              Couldn&apos;t submit that — please try again.
            </p>
          )}

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Step 1 — Pay ₱{UPGRADE_PRICE_PHP}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              {methods.map((m) => (
                <div key={m.key} className="rounded-md border border-border/60 px-3 py-2">
                  <p className="text-sm font-semibold">{m.label}</p>
                  <p className="text-sm">{m.accountName}</p>
                  <p className="font-mono text-sm">{m.accountNumber}</p>
                </div>
              ))}
            </CardContent>
          </Card>

          {hasPending ? (
            <Card>
              <CardContent className="space-y-3 py-6 text-center text-sm text-muted-foreground">
                <p>We&apos;ve received your submission and it&apos;s waiting for review. Check back soon.</p>
                <p>
                  Want it faster?{" "}
                  <a
                    href={FASTER_APPROVAL_CONTACT.facebookUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-primary hover:underline"
                  >
                    Message us on Facebook
                  </a>{" "}
                  or text{" "}
                  <span className="font-mono text-foreground">{FASTER_APPROVAL_CONTACT.phoneNumber}</span>.
                </p>
              </CardContent>
            </Card>
          ) : (
            <div>
              <h2 className="mb-2 text-sm font-semibold">Step 2 — Tell us you paid</h2>
              <UpgradeForm defaultMethod={preselectedMethod} />
            </div>
          )}
        </>
      )}
    </div>
  );
}
