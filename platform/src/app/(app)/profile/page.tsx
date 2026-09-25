import { redirect } from "next/navigation";
import { BookOpen, Layers, Target, Trophy, Flame } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { StatCard } from "@/components/stat-card";
import { SettingsForm } from "@/components/settings-form";
import { computeStudyStats, fetchAllAnsweredRows } from "@/lib/study-stats";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import { updateDisplayName } from "@/app/profile/actions";
import { PageHeader } from "@/components/page-header";

export default async function ProfilePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: profile }, { data: masteryRows }, answeredRows] = await Promise.all([
    supabase.from("profiles").select("display_name, email, created_at").eq("id", user.id).single(),
    supabase.rpc("get_topic_mastery"),
    // Paginated — a plain `.select()` here silently caps at 1000 rows once a
    // student passes 1000 answered questions. See study-stats.ts.
    fetchAllAnsweredRows(supabase, user.id),
  ]);

  const stats = computeStudyStats(masteryRows ?? [], answeredRows ?? []);
  const displayName = profile?.display_name || user.email?.split("@")[0] || "Student";
  const initial = displayName.charAt(0).toUpperCase();
  const accent = getHarmonizedAccent(user.id);

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <PageHeader title="Profile" description="Who you are and how you're doing." />

      <Card>
        <CardContent className="flex items-center gap-4 py-5">
          <Avatar size="lg">
            <AvatarFallback className={accent.badge}>{initial}</AvatarFallback>
          </Avatar>
          <div className="min-w-0">
            <p className="text-lg font-semibold">{displayName}</p>
            <p className="truncate text-sm text-muted-foreground">{profile?.email ?? user.email}</p>
          </div>
        </CardContent>
      </Card>

      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Study Overview</h2>
        <div className="mt-2 grid grid-cols-2 gap-3 sm:grid-cols-5">
          <StatCard icon={BookOpen} label="Questions answered" value={String(stats.questionsAnswered)} accent="primary" />
          <StatCard
            icon={Target}
            label="Accuracy"
            value={stats.overallAccuracy !== null ? `${stats.overallAccuracy}%` : "—"}
            barPercent={stats.overallAccuracy}
            accent="secondary"
          />
          <StatCard icon={Layers} label="Topics studied" value={String(stats.topicsStudied)} accent="secondary" />
          <StatCard icon={Trophy} label="Topics mastered" value={String(stats.topicsMastered)} accent="gold" />
          <StatCard icon={Flame} label="Current streak" value={String(stats.streak)} accent="gold" />
        </div>
        <p className="mt-2 text-xs text-muted-foreground">
          These numbers come from the same data as your Dashboard — nothing here is calculated separately.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Display name</CardTitle>
        </CardHeader>
        <CardContent>
          <SettingsForm action={updateDisplayName}>
            <div className="max-w-sm space-y-2">
              <Label htmlFor="displayName">Display name</Label>
              <Input id="displayName" name="displayName" defaultValue={profile?.display_name ?? ""} maxLength={60} />
            </div>
          </SettingsForm>
        </CardContent>
      </Card>

    </div>
  );
}
