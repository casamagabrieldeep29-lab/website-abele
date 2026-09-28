import Link from "next/link";
import { Button } from "@/components/ui/button";

export default function NotFound() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-background px-4 text-center">
      <p className="text-sm font-medium text-primary">404</p>
      <h1 className="mt-2 text-2xl font-bold tracking-tight">Page not found</h1>
      <p className="mt-2 max-w-sm text-sm text-muted-foreground">
        That page doesn&apos;t exist, or may have moved.
      </p>
      <Button render={<Link href="/dashboard">Back to dashboard</Link>} nativeButton={false} className="mt-6" />
    </main>
  );
}
