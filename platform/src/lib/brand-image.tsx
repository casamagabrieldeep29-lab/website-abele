import { ImageResponse } from "next/og";

// Brand palette sampled from the ABELIEVER logo (dark forest green field,
// light-green ring/sprout/wordmark). Kept as plain hex — ImageResponse (satori)
// can't resolve CSS variables or Tailwind classes.
const BG = "#06170c";
const BG_GLOW = "#0e2d19";
const GREEN = "#7cc24f";
const GREEN_LIGHT = "#93d364";

export const SITE_NAME = "ABELIEVER";
export const SITE_TAGLINE = "ABE Licensure Exam Review";

function Sprout({ size }: { size: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 100 100" fill="none">
      <path d="M50 80 V58" stroke={GREEN} strokeWidth="6" strokeLinecap="round" />
      <path d="M31 80 H69" stroke={GREEN} strokeWidth="6" strokeLinecap="round" />
      <path
        d="M50 58 C33 60 22 50 23 37 C38 36 48 43 50 58 Z"
        stroke={GREEN_LIGHT}
        strokeWidth="6"
        strokeLinejoin="round"
      />
      <path
        d="M50 58 C47 40 56 25 77 21 C79 40 68 54 50 58 Z"
        stroke={GREEN_LIGHT}
        strokeWidth="6"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function LogoBadge({ size }: { size: number }) {
  const ring = Math.max(4, Math.round(size * 0.022));
  return (
    <div
      style={{
        width: size,
        height: size,
        borderRadius: size,
        border: `${ring}px solid ${GREEN}`,
        background: BG,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        boxShadow: `0 0 ${Math.round(size * 0.12)}px ${GREEN}55`,
      }}
    >
      <Sprout size={Math.round(size * 0.56)} />
      <div
        style={{
          marginTop: -Math.round(size * 0.02),
          fontSize: Math.round(size * 0.115),
          letterSpacing: Math.round(size * 0.008),
          color: GREEN,
          WebkitTextStroke: `${Math.max(1, Math.round(size * 0.006))}px ${GREEN}`,
        }}
      >
        {SITE_NAME}
      </div>
    </div>
  );
}

export function renderShareImage(width: number, height: number) {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          background: `radial-gradient(circle at 28% 50%, ${BG_GLOW} 0%, ${BG} 70%)`,
          padding: "0 70px",
        }}
      >
        <LogoBadge size={470} />
        <div style={{ display: "flex", flexDirection: "column", marginLeft: 70, flex: 1 }}>
          <div
            style={{
              fontSize: 92,
              lineHeight: 1,
              color: GREEN_LIGHT,
              letterSpacing: 2,
              WebkitTextStroke: `2px ${GREEN_LIGHT}`,
            }}
          >
            {SITE_NAME}
          </div>
          <div style={{ fontSize: 44, color: "#d6efc4", marginTop: 22, lineHeight: 1.15 }}>
            Prepare smarter for the PRC ABE Board Exam
          </div>
          <div style={{ fontSize: 30, color: GREEN, marginTop: 30 }}>www.abeliever.dev</div>
        </div>
      </div>
    ),
    { width, height },
  );
}

export function renderIcon(size: number) {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          background: BG,
          borderRadius: size,
        }}
      >
        <Sprout size={Math.round(size * 0.82)} />
      </div>
    ),
    { width: size, height: size },
  );
}
