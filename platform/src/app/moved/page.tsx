import type { Metadata } from "next";
import { MovedActions } from "./moved-actions";

// Shown to everyone who opens an old address (see src/proxy.ts). Not indexed:
// the new address is the only one that should appear in search and share cards.
export const metadata: Metadata = {
  title: "We've moved — ABELIEVER",
  robots: { index: false, follow: false },
};

const STEPS = [
  { n: "1", title: "Tap the button", body: "It opens ABELIEVER at our new official address." },
  { n: "2", title: "Sign in once", body: "Use the same email and password (or emailed code) as always." },
  { n: "3", title: "Keep studying", body: "Your progress, mistakes and notes are right where you left them." },
];

export default function MovedPage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-background px-4 py-12 text-center">
      <div className="w-full max-w-xl">
        <p className="text-sm font-semibold tracking-[0.2em] text-primary">ABELIEVER</p>

        <div className="mt-6 text-5xl" aria-hidden="true">
          🎉
        </div>
        <h1 className="mt-4 text-3xl font-bold tracking-tight sm:text-4xl">We have a new home!</h1>
        <p className="mx-auto mt-4 max-w-md text-base text-muted-foreground">
          A big milestone for our community: ABELIEVER now lives at its own official address, built for the future
          engineers we are growing with.
        </p>

        <div className="mt-6 inline-block rounded-xl border border-primary/30 bg-primary/5 px-5 py-3">
          <p className="text-xs uppercase tracking-wide text-muted-foreground">Our new address</p>
          <p className="mt-1 text-xl font-semibold text-primary">www.abelieverofficial.com</p>
        </div>

        <p className="mx-auto mt-6 max-w-md text-sm font-medium">
          To keep reviewing, you need to continue at the new address. This old link no longer opens the platform.
        </p>

        <MovedActions />

        <ol className="mx-auto mt-10 grid max-w-xl gap-3 text-left sm:grid-cols-3">
          {STEPS.map((s) => (
            <li key={s.n} className="rounded-lg border border-border bg-card p-4">
              <span className="flex h-7 w-7 items-center justify-center rounded-full bg-primary text-sm font-bold text-primary-foreground">
                {s.n}
              </span>
              <p className="mt-3 text-sm font-semibold">{s.title}</p>
              <p className="mt-1 text-xs text-muted-foreground">{s.body}</p>
            </li>
          ))}
        </ol>

        <p className="mx-auto mt-8 max-w-md text-xs text-muted-foreground">
          Why sign in again? Your browser keeps logins separate for each web address, so the move asks for one fresh
          sign-in. Nothing in your account was lost. Tip: bookmark the new address or add it to your phone&apos;s home
          screen.
        </p>
      </div>
    </main>
  );
}
