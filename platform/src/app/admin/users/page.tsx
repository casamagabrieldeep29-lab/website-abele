import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { InviteForm } from "../invite-form";
import { RemoveUserForm } from "./remove-user-form";

const ERROR_MESSAGES: Record<string, string> = {
  "remove-confirmation": "You must type REMOVE exactly to confirm.",
  "remove-self": "You can't remove your own account here — use Settings > Delete Account instead.",
  "remove-admin": "Another admin's account can't be removed from this panel.",
  "remove-failed": "Couldn't remove that account. Please try again.",
};

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
  const { data: profiles } = await supabase
    .from("profiles")
    .select("id, email, display_name, role, created_at")
    .order("created_at", { ascending: false });

  return (
    <div className="mx-auto max-w-3xl space-y-6">
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

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Invite a reviewee</CardTitle>
          <CardDescription>
            Access is invite-only. Inviting an email address lets that person sign in with a magic
            link. They won&apos;t be able to request one until you&apos;ve invited them.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <InviteForm />
        </CardContent>
      </Card>

      <div className="space-y-2">
        {(profiles ?? []).map((p) => (
          <Card key={p.id}>
            <CardContent className="flex flex-wrap items-center justify-between gap-3 py-4">
              <div className="min-w-0">
                <div className="flex items-center gap-2">
                  <p className="truncate text-sm font-medium">{p.display_name || "(no name set)"}</p>
                  {p.role === "admin" && <Badge variant="secondary">Admin</Badge>}
                </div>
                <p className="truncate text-xs text-muted-foreground">{p.email}</p>
                <p className="text-xs text-muted-foreground">
                  Joined {new Date(p.created_at).toLocaleDateString(undefined, { year: "numeric", month: "short", day: "numeric" })}
                </p>
              </div>
              {p.id !== currentUser.id && p.role !== "admin" && (
                <RemoveUserForm userId={p.id} name={p.display_name || p.email} />
              )}
            </CardContent>
          </Card>
        ))}

        {!profiles?.length && (
          <p className="text-sm text-muted-foreground">No users yet.</p>
        )}
      </div>
    </div>
  );
}
