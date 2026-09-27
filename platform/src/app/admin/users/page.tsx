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

const ERROR_MESSAGES: Record<string, string> = {
  "remove-confirmation": "You must type REMOVE exactly to confirm.",
  "remove-self": "You can't remove your own account here — use Settings > Delete Account instead.",
  "remove-admin": "Another admin's account can't be removed from this panel.",
  "remove-failed": "Couldn't remove that account. Please try again.",
};

const TRIAL_DAYS = 14;

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
  const expiresAt = new Date(trialStartedAt).getTime() + TRIAL_DAYS * 24 * 60 * 60 * 1000;
  return Math.ceil((expiresAt - Date.now()) / (24 * 60 * 60 * 1000));
}

const MANILA_TZ = "Asia/Manila";

// "Joined" always reads in Philippine time regardless of the server's own
// timezone (Vercel runs in UTC) — same reasoning as the exam countdown's
// todayInManila() in src/lib/board-exam.ts.
function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString("en-US", { timeZone: MANILA_TZ, year: "numeric", month: "short", day: "numeric" });
}

// YYYY-MM-DD in Philippine time — used to group users by the calendar day
// they joined, independent of the server's own timezone.
function dayKeyManila(iso: string): string {
  return new Intl.DateTimeFormat("en-CA", { timeZone: MANILA_TZ }).format(new Date(iso));
}

function dayLabelManila(dayKey: string): string {
  const todayKey = new Intl.DateTimeFormat("en-CA", { timeZone: MANILA_TZ }).format(new Date());
  const yesterdayKey = new Intl.DateTimeFormat("en-CA", { timeZone: MANILA_TZ }).format(
    new Date(Date.now() - 24 * 60 * 60 * 1000),
  );
  if (dayKey === todayKey) return "Today";
  if (dayKey === yesterdayKey) return "Yesterday";
  return new Date(`${dayKey}T00:00:00Z`).toLocaleDateString("en-US", {
    timeZone: "UTC",
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

/** Groups an already newest-first list into per-day sections, newest day
 * first — the input's own order is preserved within each day, so this
 * relies on the caller having already sorted by created_at descending. */
function groupByDay(list: Profile[]): { dayKey: string; label: string; items: Profile[] }[] {
  const byDay = new Map<string, Profile[]>();
  for (const p of list) {
    const key = dayKeyManila(p.created_at);
    const group = byDay.get(key) ?? [];
    group.push(p);
    byDay.set(key, group);
  }
  return [...byDay.entries()].map(([dayKey, items]) => ({ dayKey, label: dayLabelManila(dayKey), items }));
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
  const { data } = await supabase
    .from("profiles")
    .select("id, email, display_name, role, created_at, plan, trial_started_at, last_seen_at")
    .order("created_at", { ascending: false });

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
            Access is invite-only. Inviting an email address lets that person sign in with a magic
            link. They won&apos;t be able to request one until you&apos;ve invited them. Free-trial
            accounts are blocked automatically 14 days after the invite is sent unless upgraded.
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
          per-day sections (Philippine time), newest day first — the day
          groups AND the users within each day both inherit the newest-
          first order already established by the created_at desc query. */}
      <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
        <div>
          <h2 className="text-sm font-semibold">
            Subscribers <span className="text-muted-foreground">({subscribers.length})</span>
          </h2>
          <div className="mt-2 space-y-4">
            {groupByDay(subscribers).map((day) => (
              <div key={day.dayKey}>
                <p className="mb-1.5 text-xs font-semibold tracking-wide text-muted-foreground uppercase">
                  {day.label} <span className="normal-case">({day.items.length})</span>
                </p>
                <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
                  {day.items.map((p) => (
                    <UserRow key={p.id} p={p} currentUserId={currentUser.id} showDowngrade />
                  ))}
                </div>
              </div>
            ))}
          </div>
          {subscribers.length === 0 && <p className="mt-2 text-sm text-muted-foreground">No subscribers yet.</p>}
        </div>

        <div>
          <h2 className="text-sm font-semibold">
            Free-Trial Users <span className="text-muted-foreground">({trialUsers.length})</span>
          </h2>
          <div className="mt-2 space-y-4">
            {groupByDay(trialUsers).map((day) => (
              <div key={day.dayKey}>
                <p className="mb-1.5 text-xs font-semibold tracking-wide text-muted-foreground uppercase">
                  {day.label} <span className="normal-case">({day.items.length})</span>
                </p>
                <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
                  {day.items.map((p) => {
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
              </div>
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
