import Link from "next/link";
import { redirect } from "next/navigation";
import { CheckCircle2 } from "lucide-react";
import { SignupForm } from "./signup-form";
import { createClient } from "@/lib/supabase/server";
import { UPGRADE_PRICE_PHP } from "@/lib/payment-methods";
import { TRIAL_DAYS } from "@/lib/trial";

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
          <p className="mt-2 text-sm text-muted-foreground">Start your free trial</p>
        </div>

        {/* Pricing shown up front, before signup — same pattern most SaaS
            signup pages use, so there's no surprise once the trial ends.
            Real price/trial length, both read from the same constants the
            rest of the app (trial.ts, payment-methods.ts) already uses. */}
        <div className="mb-6 rounded-lg border border-primary/20 bg-primary/5 p-5">
          <div className="flex items-baseline justify-between">
            <p className="text-sm font-semibold">{TRIAL_DAYS}-day free trial</p>
            <p className="text-sm text-muted-foreground">then ₱{UPGRADE_PRICE_PHP} one-time</p>
          </div>
          <ul className="mt-3 space-y-1.5">
            {["Full access to practice, mock exams, and progress tracking", "No subscription — a single one-time payment after your trial", "Pay via GCash, Maya, or Landbank when you're ready"].map(
              (item) => (
                <li key={item} className="flex items-start gap-2 text-xs leading-relaxed text-muted-foreground">
                  <CheckCircle2 className="mt-0.5 size-3.5 shrink-0 text-primary" />
                  <span>{item}</span>
                </li>
              ),
            )}
          </ul>
        </div>

        <SignupForm />
      </div>
    </main>
  );
}
