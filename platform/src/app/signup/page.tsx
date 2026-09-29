import Link from "next/link";
import { redirect } from "next/navigation";
import { CheckCircle2 } from "lucide-react";
import { SignupForm } from "./signup-form";
import { createClient } from "@/lib/supabase/server";
import { FASTER_APPROVAL_CONTACT, getPaymentMethods, UPGRADE_PRICE_PHP } from "@/lib/payment-methods";

export default async function SignupPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (user) redirect("/dashboard");

  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-background px-4 py-12">
      <div className="w-full max-w-sm">
        <div className="mb-8 text-center">
          <Link href="/" className="text-2xl font-bold tracking-tight text-primary">
            ABELIEVER
          </Link>
          <p className="mt-2 text-sm text-muted-foreground">Be an ABELIEVER</p>
        </div>

        {/* Real price, read from the same constant /upgrade already uses —
            every signup pays this before getting access, no free trial. */}
        <div className="mb-6 rounded-lg border border-primary/20 bg-primary/5 p-5">
          <p className="text-sm font-semibold">₱{UPGRADE_PRICE_PHP} one-time — no subscription</p>
          <ul className="mt-3 space-y-1.5">
            {["Full access to practice, mock exams, and progress tracking", "Pay once, keep access for good — no recurring fees"].map(
              (item) => (
                <li key={item} className="flex items-start gap-2 text-xs leading-relaxed text-muted-foreground">
                  <CheckCircle2 className="mt-0.5 size-3.5 shrink-0 text-primary" />
                  <span>{item}</span>
                </li>
              ),
            )}
          </ul>
        </div>

        <SignupForm paymentMethods={getPaymentMethods()} />

        <p className="mt-6 text-center text-xs text-muted-foreground">
          Need help or want faster approval? Message us on{" "}
          <a
            href={FASTER_APPROVAL_CONTACT.facebookUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-primary hover:underline"
          >
            Facebook
          </a>{" "}
          or{" "}
          <a
            href={FASTER_APPROVAL_CONTACT.tiktokUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-primary hover:underline"
          >
            TikTok
          </a>
          , or text <span className="font-mono text-foreground">{FASTER_APPROVAL_CONTACT.phoneNumber}</span>.
        </p>
      </div>
    </main>
  );
}
