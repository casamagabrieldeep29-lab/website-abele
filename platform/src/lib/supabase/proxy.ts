import { createServerClient } from "@supabase/ssr";
import { isAuthRetryableFetchError } from "@supabase/supabase-js";
import { NextResponse, type NextRequest } from "next/server";

const PROTECTED_PREFIXES = [
  "/dashboard",
  "/practice",
  "/mock",
  "/mistakes",
  "/quick",
  "/quiz-builder",
  "/notes",
  "/progress",
  "/question-bank",
  "/study-plan",
  "/flashcards",
  "/reviewers",
  "/profile",
  "/settings",
  "/admin",
  "/topics",
];

export async function updateSession(request: NextRequest) {
  let response = NextResponse.next({ request });

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseAnonKey) {
    // Supabase isn't configured yet (e.g. fresh local checkout without
    // .env.local). Let public routes render; protected routes below will
    // simply have no `user`, so they redirect to /login as normal.
    console.warn(
      "[proxy] NEXT_PUBLIC_SUPABASE_URL / NEXT_PUBLIC_SUPABASE_ANON_KEY are not set — auth is disabled.",
    );
    const isProtected = PROTECTED_PREFIXES.some((prefix) =>
      request.nextUrl.pathname.startsWith(prefix),
    );
    if (isProtected) {
      return NextResponse.redirect(new URL("/login", request.url));
    }
    return response;
  }

  const supabase = createServerClient(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
          response = NextResponse.next({ request });
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options),
          );
        },
      },
    },
  );

  const { data: { user }, error } = await supabase.auth.getUser();

  // A failed refresh attempt because of a transient network problem talking
  // to Supabase is NOT the same as an actually-invalid session, but without
  // this check both looked identical: `user` comes back null either way, and
  // the request was forced to /login regardless of the reason. This is the
  // likely cause of "closed the browser, came back, got logged out" reports
  // — that's exactly the moment a refresh is due, so any hiccup reaching
  // Supabase's token endpoint got treated as a real logout. Let the request
  // through instead so the session gets another chance next time, rather
  // than forcing a logout the user never actually triggered.
  if (error && isAuthRetryableFetchError(error)) {
    console.warn("[proxy] Transient auth fetch error, not forcing logout:", error.message);
    return response;
  }

  const isProtected = PROTECTED_PREFIXES.some((prefix) =>
    request.nextUrl.pathname.startsWith(prefix),
  );

  if (isProtected && !user) {
    const loginUrl = new URL("/login", request.url);
    loginUrl.searchParams.set("next", request.nextUrl.pathname);
    return NextResponse.redirect(loginUrl);
  }

  return response;
}
