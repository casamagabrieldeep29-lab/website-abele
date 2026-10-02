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
  const chips = ["7,000+ Questions", "Mock Exams", "Mistake Bank", "AI Explanations"];
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          background: `radial-gradient(circle at 24% 50%, ${BG_GLOW} 0%, ${BG} 62%)`,
          padding: "0 64px",
          position: "relative",
        }}
      >
        <div style={{ display: "flex", flexShrink: 0 }}>
          <LogoBadge size={410} />
        </div>

        <div style={{ display: "flex", flexDirection: "column", marginLeft: 64, flex: 1 }}>
          <div
            style={{
              fontSize: 22,
              letterSpacing: 3,
              color: GREEN,
              textTransform: "uppercase",
              display: "flex",
            }}
          >
            ABE Licensure Exam Review
          </div>

          <div
            style={{
              display: "flex",
              flexDirection: "column",
              marginTop: 22,
              fontSize: 64,
              lineHeight: 1.04,
              color: "#eef9e4",
              WebkitTextStroke: "2px #eef9e4",
            }}
          >
            <span>Ready to get your</span>
            <span>shit together,</span>
            <span style={{ color: GREEN_LIGHT, WebkitTextStroke: `2px ${GREEN_LIGHT}` }}>BAYAW?</span>
          </div>

          <div style={{ display: "flex", flexWrap: "wrap", marginTop: 34 }}>
            {chips.map((c) => (
              <div
                key={c}
                style={{
                  display: "flex",
                  fontSize: 22,
                  color: "#d6efc4",
                  border: `2px solid ${GREEN}88`,
                  background: "#0e2d1966",
                  borderRadius: 999,
                  padding: "8px 20px",
                  marginRight: 12,
                  marginBottom: 12,
                }}
              >
                {c}
              </div>
            ))}
          </div>

          <div style={{ display: "flex", fontSize: 28, color: GREEN, marginTop: 10 }}>www.abeliever.dev</div>
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
