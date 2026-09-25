import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { AppSidebar } from "@/components/app-sidebar";
import { SidebarInset, SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import { signOut } from "@/app/dashboard/actions";

export default async function AppLayout({ children }: { children: React.ReactNode }) {
  const { user, profile } = await getAuthContext();
  if (!user) redirect("/login");

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
          <span className="text-sm font-medium text-muted-foreground">ABELIEVER</span>
        </header>
        <div className="flex-1 p-4 sm:p-6 lg:px-8 2xl:px-10">{children}</div>
      </SidebarInset>
    </SidebarProvider>
  );
}
