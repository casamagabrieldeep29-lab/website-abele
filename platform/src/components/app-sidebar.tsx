"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useRef, useState } from "react";
import {
  BarChart3,
  BookMarked,
  BookOpen,
  CalendarClock,
  ClipboardList,
  GalleryVerticalEnd,
  Layers,
  LayoutDashboard,
  Library,
  LogOut,
  Settings,
  Sprout,
  StickyNote,
  User,
  XCircle,
} from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ThemeToggle } from "@/components/theme-toggle";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";

// Primary study workflow gets its own (unlabeled, first) group so it reads
// as more important than the secondary study tools below it — Part 5's
// "primary study actions should have more visual priority than secondary
// utilities," adapted to the routes that already exist rather than forcing
// a Dashboard/Practice/Review/Progress structure the app doesn't have.
const MAIN_NAV_ITEMS = [
  { href: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
  { href: "/practice", label: "Practice", icon: BookOpen },
  { href: "/mock", label: "Mock Exams", icon: ClipboardList },
  { href: "/progress", label: "Progress", icon: BarChart3 },
];

const SECRET_UNLOCK_STORAGE_KEY = "abeliever-secret-unlocked";
const SECRET_UNLOCK_CLICKS = 3;
const SECRET_UNLOCK_WINDOW_MS = 900;

const STUDY_TOOLS_NAV_ITEMS = [
  { href: "/mistakes", label: "Mistake Bank", icon: XCircle },
  { href: "/flashcards", label: "Flashcards", icon: GalleryVerticalEnd },
  { href: "/question-bank", label: "Question Bank", icon: Library },
  { href: "/reviewers", label: "Reviewers", icon: BookMarked },
  { href: "/study-plan", label: "Study Plan", icon: CalendarClock },
  { href: "/notes", label: "Saved", icon: StickyNote },
];


export function AppSidebar({
  userEmail,
  displayName,
  isAdmin,
  signOutAction,
}: {
  userEmail: string;
  displayName: string | null;
  isAdmin: boolean;
  signOutAction: () => Promise<void>;
}) {
  const pathname = usePathname();
  const name = displayName || userEmail;
  const initial = name.charAt(0).toUpperCase();
  const accent = getHarmonizedAccent(userEmail);

  const clickCountRef = useRef(0);
  const lastClickAtRef = useRef(0);
  const [justUnlocked, setJustUnlocked] = useState(false);

  function handleLogoClick() {
    const now = Date.now();
    clickCountRef.current = now - lastClickAtRef.current <= SECRET_UNLOCK_WINDOW_MS ? clickCountRef.current + 1 : 1;
    lastClickAtRef.current = now;

    if (clickCountRef.current >= SECRET_UNLOCK_CLICKS) {
      clickCountRef.current = 0;
      try {
        localStorage.setItem(SECRET_UNLOCK_STORAGE_KEY, "true");
      } catch {
        // Ignore — the extra themes just won't stay revealed this session.
      }
      setJustUnlocked(true);
      window.setTimeout(() => setJustUnlocked(false), 700);
    }
  }

  return (
    <Sidebar>
      <SidebarHeader>
        <button
          type="button"
          onClick={handleLogoClick}
          className="flex items-center gap-2 px-2 py-1.5 text-left"
        >
          <Sprout className={`size-5 text-primary transition-transform duration-300 ${justUnlocked ? "scale-125" : ""}`} />
          <span className="text-base font-bold tracking-tight text-primary">ABELIEVER</span>
        </button>
      </SidebarHeader>

      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupContent>
            <SidebarMenu>
              {MAIN_NAV_ITEMS.map((item) => {
                const isActive = pathname === item.href || pathname.startsWith(item.href + "/");
                return (
                  <SidebarMenuItem key={item.href}>
                    <SidebarMenuButton
                      isActive={isActive}
                      render={
                        <Link href={item.href}>
                          <item.icon />
                          <span>{item.label}</span>
                        </Link>
                      }
                    />
                  </SidebarMenuItem>
                );
              })}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        <SidebarGroup>
          <SidebarGroupLabel>Study Tools</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {STUDY_TOOLS_NAV_ITEMS.map((item) => {
                const isActive = pathname === item.href || pathname.startsWith(item.href + "/");
                return (
                  <SidebarMenuItem key={item.href}>
                    <SidebarMenuButton
                      isActive={isActive}
                      render={
                        <Link href={item.href}>
                          <item.icon />
                          <span>{item.label}</span>
                        </Link>
                      }
                    />
                  </SidebarMenuItem>
                );
              })}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        {isAdmin && (
          <SidebarGroup>
            <SidebarGroupLabel>Admin</SidebarGroupLabel>
            <SidebarGroupContent>
              <SidebarMenu>
                <SidebarMenuItem>
                  <SidebarMenuButton
                    isActive={pathname.startsWith("/admin")}
                    render={
                      <Link href="/admin">
                        <Layers />
                        <span>Admin</span>
                      </Link>
                    }
                  />
                </SidebarMenuItem>
              </SidebarMenu>
            </SidebarGroupContent>
          </SidebarGroup>
        )}
      </SidebarContent>

      <SidebarFooter>
        <div className="px-2 pb-1">
          <ThemeToggle />
        </div>
        <DropdownMenu>
          <DropdownMenuTrigger className="flex w-full items-center gap-2 rounded-md p-2 text-left text-sm hover:bg-sidebar-accent">
            <Avatar className="size-7">
              <AvatarFallback className={`text-xs ${accent.badge}`}>{initial}</AvatarFallback>
            </Avatar>
            <span className="truncate text-sidebar-foreground">{name}</span>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="start" className="w-56">
            <DropdownMenuItem
              render={
                <Link href="/profile" className="flex w-full items-center gap-2">
                  <User className="size-4" />
                  Profile
                </Link>
              }
            />
            <DropdownMenuItem
              render={
                <Link href="/settings" className="flex w-full items-center gap-2">
                  <Settings className="size-4" />
                  Settings
                </Link>
              }
            />
            <DropdownMenuItem
              render={
                <form action={signOutAction} className="w-full">
                  <button type="submit" className="flex w-full items-center gap-2">
                    <LogOut className="size-4" />
                    Sign out
                  </button>
                </form>
              }
            />
          </DropdownMenuContent>
        </DropdownMenu>
      </SidebarFooter>
    </Sidebar>
  );
}
