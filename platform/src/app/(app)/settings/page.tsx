import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ThemeToggle } from "@/components/theme-toggle";
import { ThemeSelector } from "@/components/theme-selector";
import { SettingsForm } from "@/components/settings-form";
import { DeleteAccountForm } from "@/components/delete-account-form";
import { ResetProgressForm } from "@/components/reset-progress-form";
import { signOut } from "@/app/dashboard/actions";
import { updateDisplayName, updateTargetExamDate, clearTargetExamDate } from "@/app/profile/actions";
import { updateStudyPreferences, deleteAccount } from "@/app/settings/actions";
import { getUserSettings, PRACTICE_LENGTH_OPTIONS, PRACTICE_MODE_OPTIONS } from "@/lib/study-preferences";
import { PageHeader } from "@/components/page-header";

const ERROR_MESSAGES: Record<string, string> = {
  "delete-confirmation": "You must type DELETE exactly to confirm account deletion.",
  "delete-failed": "Couldn't delete your account. Please try again or contact support.",
};

export default async function SettingsPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: profile }, settings] = await Promise.all([
    supabase.from("profiles").select("display_name, email").eq("id", user.id).single(),
    getUserSettings(supabase, user.id),
  ]);

  return (
    <div className="mx-auto w-full max-w-4xl space-y-6">
      <PageHeader title="Settings" description="Account, appearance, and study preferences." />

      {error && ERROR_MESSAGES[error] && (
        <p className="rounded-md border border-destructive/30 bg-destructive/5 px-3 py-2 text-sm text-destructive">
          {ERROR_MESSAGES[error]}
        </p>
      )}

      <Tabs defaultValue="account">
        <TabsList className="flex-wrap">
          <TabsTrigger value="account">Account</TabsTrigger>
          <TabsTrigger value="appearance">Appearance</TabsTrigger>
          <TabsTrigger value="study">Study</TabsTrigger>
          <TabsTrigger value="privacy">Privacy &amp; Data</TabsTrigger>
        </TabsList>

        <TabsContent value="account" className="mt-4 space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Display name</CardTitle>
            </CardHeader>
            <CardContent>
              <SettingsForm action={updateDisplayName}>
                <div className="max-w-sm space-y-2">
                  <Label htmlFor="displayNameSettings">Display name</Label>
                  <Input
                    id="displayNameSettings"
                    name="displayName"
                    defaultValue={profile?.display_name ?? ""}
                    maxLength={60}
                  />
                </div>
              </SettingsForm>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Email</CardTitle>
            </CardHeader>
            <CardContent className="space-y-1.5">
              <p className="text-sm">{profile?.email ?? user.email}</p>
              <p className="text-xs text-muted-foreground">
                Your email is your sign-in identifier and can&apos;t be changed here.
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Avatar</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm text-muted-foreground">
                Your avatar shows the first letter of your display name — there&apos;s no photo upload yet.
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Sign out</CardTitle>
            </CardHeader>
            <CardContent>
              <form action={signOut}>
                <button type="submit" className="text-sm font-medium underline-offset-2 hover:underline">
                  Sign out
                </button>
              </form>
            </CardContent>
          </Card>

          <Card className="border-destructive/30">
            <CardHeader>
              <CardTitle className="text-base text-destructive">Delete account</CardTitle>
            </CardHeader>
            <CardContent>
              <DeleteAccountForm action={deleteAccount} />
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="appearance" className="mt-4 space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Theme</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <ThemeToggle />
              <p className="text-xs text-muted-foreground">
                Applies immediately and is remembered on this device across refreshes, sign-outs, and future visits.
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Themes</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <p className="text-sm text-muted-foreground">Choose the look and feel of ABELIEVER.</p>
              <ThemeSelector />
              <p className="text-xs text-muted-foreground">
                Applies immediately across the whole site and is remembered on this device.
              </p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="study" className="mt-4 space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Target exam date</CardTitle>
            </CardHeader>
            <CardContent>
              <SettingsForm action={updateTargetExamDate}>
                <div className="max-w-sm space-y-2">
                  <Label htmlFor="targetExamDate">Target exam date</Label>
                  <Input id="targetExamDate" name="targetExamDate" type="date" defaultValue={settings.targetExamDate ?? ""} />
                </div>
              </SettingsForm>
              {settings.targetExamDate && (
                <form action={clearTargetExamDate} className="mt-2">
                  <button type="submit" className="text-xs text-muted-foreground underline-offset-2 hover:underline">
                    Clear target exam date
                  </button>
                </form>
              )}
              <p className="mt-2 text-xs text-muted-foreground">
                Used to pre-fill your Study Plan — doesn&apos;t generate a schedule or prediction on its own.
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Default practice settings</CardTitle>
            </CardHeader>
            <CardContent>
              <SettingsForm action={updateStudyPreferences}>
                <fieldset className="space-y-2">
                  <legend className="text-sm font-medium">Default practice length</legend>
                  <div className="flex flex-wrap gap-4">
                    {PRACTICE_LENGTH_OPTIONS.map((n) => (
                      <label key={n} className="flex items-center gap-2 text-sm">
                        <input
                          type="radio"
                          name="defaultPracticeLength"
                          value={n}
                          defaultChecked={settings.defaultPracticeLength === n}
                          className="h-4 w-4"
                        />
                        {n} questions
                      </label>
                    ))}
                  </div>
                  <p className="text-xs text-muted-foreground">
                    Used as the default in Quick Practice — you can still pick a different amount any time you start a session.
                  </p>
                </fieldset>

                <fieldset className="space-y-2">
                  <legend className="text-sm font-medium">Default practice mode</legend>
                  <div className="space-y-1.5">
                    {PRACTICE_MODE_OPTIONS.map((mode) => (
                      <label key={mode.value} className="flex items-start gap-2 text-sm">
                        <input
                          type="radio"
                          name="defaultPracticeMode"
                          value={mode.value}
                          defaultChecked={settings.defaultPracticeMode === mode.value}
                          className="mt-0.5 h-4 w-4"
                        />
                        <span>
                          {mode.label}
                          <span className="ml-1.5 text-xs text-muted-foreground">{mode.description}</span>
                        </span>
                      </label>
                    ))}
                  </div>
                  <p className="text-xs text-muted-foreground">
                    Applies to Quick Practice when you don&apos;t pick a mode manually. Other practice entry points are unaffected.
                  </p>
                </fieldset>
              </SettingsForm>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="privacy" className="mt-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Privacy &amp; data</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <p className="text-sm text-muted-foreground">ABELIEVER stores:</p>
              <ul className="list-inside list-disc space-y-1 text-sm text-muted-foreground">
                <li>Profile information (display name, email)</li>
                <li>Practice and mock exam history</li>
                <li>Submitted answers and whether they were correct</li>
                <li>Your mistake bank and mastery/progress data, computed from that history</li>
                <li>Flashcard review activity</li>
                <li>Saved / bookmarked questions</li>
                <li>Personal notes you write on questions</li>
                <li>Study preferences (default practice length/mode, target exam date, theme)</li>
              </ul>
              <p className="text-sm text-muted-foreground">
                You can permanently delete your account and all of this data from the Account tab above.
              </p>
            </CardContent>
          </Card>

          <Card className="mt-4 border-destructive/30">
            <CardHeader>
              <CardTitle className="text-base text-destructive">Reset progress</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <p className="text-sm text-muted-foreground">
                Wipes your practice/mock history, mastery, and flashcard progress so you can
                start over — your account, saved notes, bookmarks, and day streak are kept.
                Requires a verification code sent to your email.
              </p>
              <ResetProgressForm />
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
