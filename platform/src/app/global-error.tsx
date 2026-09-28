"use client";

import { useEffect } from "react";
import { logClientError } from "@/lib/log-client-error";

// Catches a crash in the root layout itself — rare, but if it happens
// app/error.tsx (which lives inside that layout) can't render either, so
// this must supply its own <html>/<body> and stay deliberately minimal:
// no fonts, no providers, nothing that could itself be what crashed.
export default function GlobalError({
  error,
  retry,
}: {
  error: Error & { digest?: string };
  retry: () => void;
}) {
  useEffect(() => {
    void logClientError("app/global-error.tsx", error);
  }, [error]);

  return (
    <html>
      <body style={{ display: "flex", minHeight: "100vh", alignItems: "center", justifyContent: "center", fontFamily: "sans-serif", textAlign: "center", padding: "1rem" }}>
        <div>
          <h1 style={{ fontSize: "1.25rem", fontWeight: 700 }}>Something went wrong</h1>
          <p style={{ marginTop: "0.5rem", color: "#888" }}>Please try again.</p>
          <button
            onClick={() => retry()}
            style={{ marginTop: "1rem", padding: "0.5rem 1rem", borderRadius: "0.375rem", border: "1px solid #ccc", cursor: "pointer" }}
          >
            Try again
          </button>
        </div>
      </body>
    </html>
  );
}
