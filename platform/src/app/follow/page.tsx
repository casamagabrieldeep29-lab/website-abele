import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getSessionUser } from "@/lib/auth/session";
import { FollowGate } from "./follow-gate";

// A full-screen, one-time announcement shown to every signed-in student after the move to the new address.
// The request filter (src/lib/supabase/proxy.ts) sends them here until they pass it.
export const metadata: Metadata = {
  title: "Join the ABELIEVER family",
  robots: { index: false, follow: false },
};

const PERKS = [
  { icon: "📣", text: "Exam announcements and schedule updates" },
  { icon: "🆕", text: "New questions and features, first" },
  { icon: "💡", text: "Study tips and quick reviews" },
];

export default async function FollowPage({ searchParams }: { searchParams: Promise<{ next?: string }> }) {
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
  if (!user) redirect("/login?next=/follow");

  const { next } = await searchParams;
  const safeNext = next && next.startsWith("/") && !next.startsWith("//") && !next.startsWith("/follow") ? next : "/dashboard";

  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-background px-4 py-12 text-center">
      <div className="w-full max-w-lg">
        <p className="text-sm font-semibold tracking-[0.2em] text-primary">ABELIEVER</p>
        <div className="mt-6 text-5xl" aria-hidden="true">
          💚
        </div>
        <h1 className="mt-4 text-3xl font-bold tracking-tight sm:text-4xl">You&apos;re part of the ABELIEVER family!</h1>
        <p className="mx-auto mt-4 max-w-md text-base text-muted-foreground">
          Welcome to our new home. Before you keep reviewing, follow our official page so you never miss an update on
          your road to the board exam.
        </p>

        <ul className="mx-auto mt-6 max-w-sm space-y-2 text-left">
          {PERKS.map((p) => (
            <li key={p.text} className="flex items-center gap-3 rounded-lg border border-border bg-card px-4 py-3 text-sm">
              <span aria-hidden="true">{p.icon}</span>
              <span>{p.text}</span>
            </li>
          ))}
        </ul>

        <p className="mx-auto mt-6 max-w-md text-sm font-medium">
          This is a one-time step. It takes a few seconds, and you only do it once.
        </p>

        <FollowGate next={safeNext} />
      </div>
    </main>
  );
}
