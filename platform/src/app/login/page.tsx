import Link from "next/link";
import { LoginForm } from "./login-form";

export default function LoginPage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-background px-4">
      <div className="w-full max-w-sm">
        <div className="mb-8 text-center">
          <Link href="/" className="text-2xl font-bold tracking-tight text-primary">
            ABELIEVER
          </Link>
          <p className="mt-2 text-sm text-muted-foreground">
            Sign in to your review account
          </p>
        </div>
        <LoginForm />
      </div>
    </main>
  );
}
