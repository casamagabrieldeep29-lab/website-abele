import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { formatDateTimeManila } from "@/lib/manila-week";
import { setNoticeCampaignActive } from "./actions";
import { CreateCampaignForm } from "./create-campaign-form";

type CampaignRow = {
  id: string;
  title: string;
  message: string;
  target_fields: string[];
  starts_at: string;
  ends_at: string;
  times_per_day: number;
  active: boolean;
  created_at: string;
};

function isCampaignLive(c: CampaignRow): boolean {
  const now = Date.now();
  return c.active && now >= new Date(c.starts_at).getTime() && now <= new Date(c.ends_at).getTime();
}

export default async function AdminAnnouncementsPage() {
  await requireAdmin();
  const admin = createAdminClient();

  const [{ data: campaigns }, { data: viewRows }] = await Promise.all([
    admin.from("notice_campaigns").select("*").order("created_at", { ascending: false }),
    admin.from("notice_campaign_views").select("campaign_id"),
  ]);

  const viewCountByCampaign = new Map<string, number>();
  for (const v of viewRows ?? []) {
    viewCountByCampaign.set(v.campaign_id, (viewCountByCampaign.get(v.campaign_id) ?? 0) + 1);
  }

  const rows = (campaigns ?? []) as CampaignRow[];

  return (
    <div className="mx-auto w-full max-w-4xl space-y-8 px-4 py-10">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Notice Campaigns</h1>
          <p className="mt-1 text-sm text-muted-foreground">
            Recurring popups shown to signed-in users on login/page-load, asking them to fill in whichever profile
            fields they&apos;re still missing. Runs for a fixed window at up to N times a day per user, then stops on
            its own.
          </p>
        </div>
        <Link href="/admin" className="shrink-0 text-sm text-muted-foreground hover:underline">
          ← Back to Admin
        </Link>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">New campaign</CardTitle>
        </CardHeader>
        <CardContent>
          <CreateCampaignForm />
        </CardContent>
      </Card>

      <div>
        <h2 className="mb-3 text-sm font-semibold text-muted-foreground">All campaigns ({rows.length})</h2>
        {rows.length === 0 ? (
          <p className="text-sm text-muted-foreground">None created yet.</p>
        ) : (
          <div className="space-y-3">
            {rows.map((c) => {
              const inWindow = isCampaignLive(c);
              return (
                <Card key={c.id}>
                  <CardContent className="space-y-2 py-4">
                    <div className="flex flex-wrap items-center justify-between gap-2">
                      <p className="text-sm font-medium">{c.title}</p>
                      <div className="flex items-center gap-1.5">
                        {c.target_fields.map((f) => (
                          <Badge key={f} variant="secondary">
                            {f}
                          </Badge>
                        ))}
                        <Badge variant={inWindow ? "default" : "outline"}>
                          {inWindow ? "Live" : c.active ? "Scheduled/Ended" : "Disabled"}
                        </Badge>
                      </div>
                    </div>
                    <p className="text-sm text-muted-foreground">{c.message}</p>
                    <p className="text-xs text-muted-foreground">
                      {formatDateTimeManila(c.starts_at)} → {formatDateTimeManila(c.ends_at)} · {c.times_per_day}×/day ·{" "}
                      {viewCountByCampaign.get(c.id) ?? 0} views logged
                    </p>
                    <form action={setNoticeCampaignActive.bind(null, c.id, !c.active)}>
                      <Button type="submit" size="sm" variant="outline">
                        {c.active ? "Disable" : "Re-enable"}
                      </Button>
                    </form>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
