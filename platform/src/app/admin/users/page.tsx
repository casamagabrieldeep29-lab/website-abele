import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { InviteForm } from "../invite-form";
import { RemoveUserForm } from "./remove-user-form";
import { upgradeToSubscriber, downgradeToTrial } from "../actions";
import { AutoRefresh } from "../auto-refresh";
import { TRIAL_DAYS, trialMsFor } from "@/lib/trial";
import { MANILA_TZ, groupByWeek } from "@/lib/manila-week";

const ERROR_MESSAGES: Record<string, string> = {
  "remove-confirmation": "You must type REMOVE exactly to confirm.",
  "remove-self": "You can't remove your own account here — use Settings > Delete Account instead.",
  "remove-admin": "Another admin's account can't be removed from this panel.",
  "remove-failed": "Couldn't remove that account. Please try again.",
};

const ONLINE_THRESHOLD_MS = 2 * 60 * 1000;

type Profile = {
  id: string;
  email: string;
  display_name: string | null;
  role: string;
  created_at: string;
  plan: string;
  trial_started_at: string;
  last_seen_at: string | null;
};

function daysLeft(trialStartedAt: string): number {
  const expiresAt = new Date(trialStartedAt).getTime() + trialMsFor(trialStartedAt);
  return Math.ceil((expiresAt - Date.now()) / (24 * 60 * 60 * 1000));
}

// "Joined" always reads in Philippine time regardless of the server's own
// timezone (Vercel runs in UTC) — same reasoning as the exam countdown's
// todayInManila() in src/lib/board-exam.ts.
function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString("en-US", { timeZone: MANILA_TZ, year: "numeric", month: "short", day: "numeric" });
}

function isOnline(lastSeenAt: string | null): boolean {
  if (!lastSeenAt) return false;
  return Date.now() - new Date(lastSeenAt).getTime() < ONLINE_THRESHOLD_MS;
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
  const online = isOnline(p.last_seen_at);
  return (
    <div className="flex min-w-0 flex-col gap-1.5 rounded-md border border-border p-3">
      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-1.5">
          <span
            className={`inline-block size-2 shrink-0 rounded-full ${online ? "bg-success" : "bg-muted-foreground/30"}`}
            title={online ? "Active in the last 2 minutes" : "Not currently active"}
          />
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
  // Capped rather than truly unbounded (flagged in the 2026-09-28
  // public-launch audit) — 2000 is far above current scale, just a floor
  // against this query growing unboundedly forever; a real "load more" UI
  // is the next step if the user base actually approaches that.
  const { data } = await supabase
    .from("profiles")
    .select("id, email, display_name, role, created_at, plan, trial_started_at, last_seen_at")
    .order("created_at", { ascending: false })
    .limit(2000);

  const profiles = (data ?? []) as Profile[];
  const subscribers = profiles.filter((p) => p.plan === "subscriber" || p.role === "admin");
  const trialUsers = profiles.filter((p) => p.plan === "trial" && p.role !== "admin");
  const onlineCount = profiles.filter((p) => isOnline(p.last_seen_at)).length;

  return (
    <div className="w-full space-y-6 px-6">
      <AutoRefresh />
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold">Users</h1>
          <p className="mt-1 flex items-center gap-1.5 text-sm text-muted-foreground">
            Everyone who has been invited or has an account.
            <span className="inline-flex items-center gap-1">
              <span className="inline-block size-2 rounded-full bg-success" />
              {onlineCount} active now
            </span>
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
            Students can also sign themselves up at /signup — this is for manually granting access
            (e.g. straight to Subscriber) without them going through that flow. Free-trial
            accounts are blocked automatically {TRIAL_DAYS} days after the trial starts unless upgraded.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <InviteForm />
        </CardContent>
      </Card>

      {/* Two main columns (Subscribers | Free-Trial) side by side from tablet
          width up, each with its own 2-column tile grid — 4 tiles across on
          a full desktop/tablet screen. Both collapse to a single stacked
          column on mobile. Within each column, users are grouped into
          collapsible per-week sections (Philippine time, Monday-start),
          newest week first — the week groups AND the users within each week
          both inherit the newest-first order already established by the
          created_at desc query. Only the newest week starts expanded (via
          `open` on the first <details>), keeping a long user list scannable
          instead of one huge unbroken wall. Plain <details>/<summary> since
          this is a server component with no other interactivity — no client
          JS needed for expand/collapse. */}
      <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
        <div>
          <h2 className="text-sm font-semibold">
            Subscribers <span className="text-muted-foreground">({subscribers.length})</span>
          </h2>
          <div className="mt-2 space-y-2">
            {groupByWeek(subscribers, (p) => p.created_at).map((week, i) => (
              <details key={week.weekKey} open={i === 0} className="group rounded-md border border-border/60">
                <summary className="cursor-pointer list-none px-3 py-2 text-xs font-semibold tracking-wide text-muted-foreground uppercase select-none">
                  <span className="mr-1 inline-block transition-transform group-open:rotate-90">›</span>
                  {week.label} <span className="normal-case">({week.items.length})</span>
                </summary>
                <div className="grid grid-cols-1 gap-3 border-t border-border/60 p-3 sm:grid-cols-2">
                  {week.items.map((p) => (
                    <UserRow key={p.id} p={p} currentUserId={currentUser.id} showDowngrade />
                  ))}
                </div>
              </details>
            ))}
          </div>
          {subscribers.length === 0 && <p className="mt-2 text-sm text-muted-foreground">No subscribers yet.</p>}
        </div>

        <div>
          <h2 className="text-sm font-semibold">
            Free-Trial Users <span className="text-muted-foreground">({trialUsers.length})</span>
          </h2>
          <div className="mt-2 space-y-2">
            {groupByWeek(trialUsers, (p) => p.created_at).map((week, i) => (
              <details key={week.weekKey} open={i === 0} className="group rounded-md border border-border/60">
                <summary className="cursor-pointer list-none px-3 py-2 text-xs font-semibold tracking-wide text-muted-foreground uppercase select-none">
                  <span className="mr-1 inline-block transition-transform group-open:rotate-90">›</span>
                  {week.label} <span className="normal-case">({week.items.length})</span>
                </summary>
                <div className="grid grid-cols-1 gap-3 border-t border-border/60 p-3 sm:grid-cols-2">
                  {week.items.map((p) => {
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
              </details>
            ))}
          </div>
          {trialUsers.length === 0 && (
            <p className="mt-2 text-sm text-muted-foreground">No free-trial users right now.</p>
          )}
        </div>
      </div>

      {!profiles.length && <p className="text-sm text-muted-foreground">No users yet.</p>}
    </div>
  );
}
