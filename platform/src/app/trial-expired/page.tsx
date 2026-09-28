import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { signOut } from "@/app/dashboard/actions";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { trialLengthDaysFor } from "@/lib/trial";

export default async function TrialExpiredPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // Per-user, not the flat TRIAL_DAYS constant — someone who started their
  // trial before the 14->3 day policy change actually had 14 days, and this
  // page must say so accurately for them, not the new default.
  const { data: profile } = await supabase
    .from("profiles")
    .select("trial_started_at")
    .eq("id", user.id)
    .single();
  const trialDays = profile ? trialLengthDaysFor(profile.trial_started_at) : null;

  return (
    <main className="flex min-h-screen items-center justify-center bg-background px-6">
      <Card className="w-full max-w-sm">
        <CardHeader>
          <CardTitle>Your free trial has ended</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <p className="text-sm text-muted-foreground">
            {trialDays ? `Your ${trialDays}-day free trial` : "Your free trial"} for{" "}
            <span className="font-medium text-foreground">{user.email}</span> has expired. Upgrade your account to
            keep studying.
          </p>
          <Button render={<Link href="/upgrade">Upgrade now →</Link>} nativeButton={false} className="w-full" />
          <form action={signOut}>
            <Button type="submit" variant="outline" className="w-full">
              Sign out
            </Button>
          </form>
        </CardContent>
      </Card>
    </main>
  );
}
