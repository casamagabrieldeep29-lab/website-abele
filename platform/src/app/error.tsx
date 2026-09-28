"use client";

import { useEffect } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { logClientError } from "@/lib/log-client-error";

// Error boundaries must be Client Components in this Next.js version, and
// the retry callback is named `retry` here (not the `reset` this app's
// training data would expect) — confirmed against
// node_modules/next/dist/docs/01-app/01-getting-started/10-error-handling.md
// per AGENTS.md's "this is not the Next.js you know" warning.
export default function ErrorPage({
  error,
  retry,
}: {
  error: Error & { digest?: string };
  retry: () => void;
}) {
  useEffect(() => {
    void logClientError("app/error.tsx", error);
  }, [error]);

  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-background px-4 text-center">
      <p className="text-sm font-medium text-destructive">Something went wrong</p>
      <h1 className="mt-2 text-2xl font-bold tracking-tight">This page hit an error</h1>
      <p className="mt-2 max-w-sm text-sm text-muted-foreground">
        Try again, or head back to your dashboard. If it keeps happening, let us know.
      </p>
      <div className="mt-6 flex gap-2">
        <Button variant="outline" onClick={() => retry()}>
          Try again
        </Button>
        <Button render={<Link href="/dashboard">Back to dashboard</Link>} nativeButton={false} />
      </div>
    </main>
  );
}
