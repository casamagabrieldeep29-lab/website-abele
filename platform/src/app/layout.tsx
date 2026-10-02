import type { Metadata } from "next";
import { PUBLIC_ORIGIN } from "@/lib/public-origin";
import { Geist, Geist_Mono } from "next/font/google";
import { TooltipProvider } from "@/components/ui/tooltip";
import { ThemeProvider } from "@/components/theme-provider";
import { PresenceHeartbeat } from "@/components/presence-heartbeat";
import "katex/dist/katex.min.css";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const SITE_URL = PUBLIC_ORIGIN;
const TITLE = "ABELIEVER — ABE Licensure Exam Review";
const DESCRIPTION =
  "Practice, mock exams, mistake tracking and AI explanations for the Philippine Agricultural and Biosystems Engineering (ABE) Licensure Examination.";

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: TITLE,
  description: DESCRIPTION,
  applicationName: "ABELIEVER",
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: "/",
    siteName: "ABELIEVER",
    title: TITLE,
    description: DESCRIPTION,
    locale: "en_PH",
  },
  twitter: {
    card: "summary_large_image",
    title: TITLE,
    description: DESCRIPTION,
  },
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="en"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
      suppressHydrationWarning
    >
      <body className="min-h-full flex flex-col">
        <ThemeProvider>
          <TooltipProvider>{children}</TooltipProvider>
        </ThemeProvider>
        <PresenceHeartbeat />
      </body>
    </html>
  );
}
