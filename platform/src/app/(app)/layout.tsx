import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { AppSidebar } from "@/components/app-sidebar";
import { SidebarInset, SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import { GlobalSearch } from "@/components/global-search/global-search";
import { ProfileCompletionModal } from "@/components/profile-completion-modal";
import { signOut } from "@/app/dashboard/actions";

export default async function AppLayout({ children }: { children: React.ReactNode }) {
  const { supabase, user, profile } = await getAuthContext();
  if (!user) redirect("/login");

  // Deliberately a separate, isolated query rather than folded into
  // getAuthContext's shared select — that one is cached and used by nearly
  // every page (sidebar name, admin gate, streak), so if these two columns
  // aren't migrated in yet on some deploy, a query error there would break
  // the whole app shell. Here, a failure just means the popup doesn't show.
  let showProfilePrompt = false;
  try {
    const { data } = await supabase
      .from("profiles")
      .select("academic_status, profile_prompt_dismissed_at")
      .eq("id", user.id)
      .single();
    showProfilePrompt = Boolean(data && !data.academic_status && !data.profile_prompt_dismissed_at);
  } catch {
    // Migration not applied yet, or some other read failure — just skip the popup.
  }

  return (
    <SidebarProvider>
      <AppSidebar
        userEmail={user.email ?? ""}
        displayName={profile?.display_name ?? null}
        isAdmin={profile?.role === "admin"}
        signOutAction={signOut}
      />
      <SidebarInset>
        <header className="flex h-14 shrink-0 items-center gap-2 border-b px-4 sm:px-6 lg:px-8 2xl:px-10">
          <SidebarTrigger className="-ml-1" />
          <Separator orientation="vertical" className="mr-2 h-4" />
          <span className="hidden text-sm font-medium text-muted-foreground sm:inline">ABELIEVER</span>
          <div className="ml-auto flex min-w-0 items-center sm:ml-4">
            <GlobalSearch />
          </div>
        </header>
        <div className="flex-1 p-4 sm:p-6 lg:px-8 2xl:px-10">{children}</div>
      </SidebarInset>
      {showProfilePrompt && <ProfileCompletionModal />}
    </SidebarProvider>
  );
}
