import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { InviteForm } from "../invite-form";
import { RemoveUserForm } from "./remove-user-form";
import { upgradeToSubscriber, downgradeToTrial } from "../actions";

const ERROR_MESSAGES: Record<string, string> = {
  "remove-confirmation": "You must type REMOVE exactly to confirm.",
  "remove-self": "You can't remove your own account here — use Settings > Delete Account instead.",
  "remove-admin": "Another admin's account can't be removed from this panel.",
  "remove-failed": "Couldn't remove that account. Please try again.",
};

const TRIAL_DAYS = 14;

type Profile = {
  id: string;
  email: string;
  display_name: string | null;
  role: string;
  created_at: string;
  plan: string;
  trial_started_at: string;
};

function daysLeft(trialStartedAt: string): number {
  const expiresAt = new Date(trialStartedAt).getTime() + TRIAL_DAYS * 24 * 60 * 60 * 1000;
  return Math.ceil((expiresAt - Date.now()) / (24 * 60 * 60 * 1000));
}

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString(undefined, { year: "numeric", month: "short", day: "numeric" });
}

function UserRow({
  p,
  currentUserId,
  trialBadge,
  showDowngrade,
}: {
  p: Profile;
  currentUserId: string;
  trialBadge?: React.ReactNode;
  showDowngrade?: boolean;
}) {
  return (
    <div className="flex min-w-0 flex-col gap-1.5 rounded-md border border-border p-3">
      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-1.5">
          <p className="truncate text-sm font-medium">{p.display_name || "(no name set)"}</p>
          {p.role === "admin" && <Badge variant="secondary">Admin</Badge>}
          {trialBadge}
        </div>
        <p className="truncate text-xs text-muted-foreground">{p.email}</p>
        <p className="text-xs text-muted-foreground">Joined {formatDate(p.created_at)}</p>
      </div>
      <div className="flex flex-wrap items-center gap-1.5 pt-1">
        {p.role !== "admin" && p.plan === "trial" && (
          <form action={upgradeToSubscriber.bind(null, p.id)}>
            <Button type="submit" size="sm" variant="outline">
              Make Subscriber
            </Button>
          </form>
        )}
        {showDowngrade && p.role !== "admin" && p.plan === "subscriber" && (
          <form action={downgradeToTrial.bind(null, p.id)}>
            <Button type="submit" size="sm" variant="outline">
              Move to Free Trial
            </Button>
          </form>
        )}
        {p.id !== currentUserId && p.role !== "admin" && (
          <RemoveUserForm userId={p.id} name={p.display_name || p.email} />
        )}
      </div>
    </div>
  );
}

export default async function AdminUsersPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
  const { user: currentUser } = await requireAdmin();
  const supabase = await createClient();

  // RLS's profiles_select_own_or_admin policy already lets an admin read
  // every row here — no service-role client needed just to list users.
  const { data } = await supabase
    .from("profiles")
    .select("id, email, display_name, role, created_at, plan, trial_started_at")
    .order("created_at", { ascending: false });

  const profiles = (data ?? []) as Profile[];
  const subscribers = profiles.filter((p) => p.plan === "subscriber" || p.role === "admin");
  const trialUsers = profiles.filter((p) => p.plan === "trial" && p.role !== "admin");

  return (
    <div className="mx-auto max-w-[1800px] space-y-6 px-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold">Users</h1>
          <p className="mt-1 text-sm text-muted-foreground">
            Everyone who has been invited or has an account.
          </p>
        </div>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          ← Back to Admin
        </Link>
      </div>

      {error && ERROR_MESSAGES[error] && (
        <p className="rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
          {ERROR_MESSAGES[error]}
        </p>
      )}

      <Card className="max-w-2xl">
        <CardHeader>
          <CardTitle className="text-base">Invite a reviewee</CardTitle>
          <CardDescription>
            Access is invite-only. Inviting an email address lets that person sign in with a magic
            link. They won&apos;t be able to request one until you&apos;ve invited them. Free-trial
            accounts are blocked automatically 14 days after the invite is sent unless upgraded.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <InviteForm />
        </CardContent>
      </Card>

      <div>
        <h2 className="text-sm font-semibold">
          Subscribers <span className="text-muted-foreground">({subscribers.length})</span>
        </h2>
        <div className="mt-2 grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-4">
          {subscribers.map((p) => (
            <UserRow key={p.id} p={p} currentUserId={currentUser.id} showDowngrade />
          ))}
        </div>
        {subscribers.length === 0 && <p className="mt-2 text-sm text-muted-foreground">No subscribers yet.</p>}
      </div>

      <div>
        <h2 className="text-sm font-semibold">
          Free-Trial Users <span className="text-muted-foreground">({trialUsers.length})</span>
        </h2>
        <div className="mt-2 grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-4">
          {trialUsers.map((p) => {
            const left = daysLeft(p.trial_started_at);
            const badge =
              left <= 0 ? (
                <Badge variant="destructive">Expired</Badge>
              ) : (
                <Badge variant={left <= 3 ? "destructive" : "outline"}>
                  {left} {left === 1 ? "day" : "days"} left
                </Badge>
              );
            return <UserRow key={p.id} p={p} currentUserId={currentUser.id} trialBadge={badge} />;
          })}
        </div>
        {trialUsers.length === 0 && (
          <p className="mt-2 text-sm text-muted-foreground">No free-trial users right now.</p>
        )}
      </div>

      {!profiles.length && <p className="text-sm text-muted-foreground">No users yet.</p>}
    </div>
  );
}
