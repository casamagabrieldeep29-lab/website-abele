const config = {
  plugins: {
    "@tailwindcss/postcss": {},
    // Tailwind v4 compiles every opacity-modifier utility (bg-primary/10, etc.)
    // to color-mix(), which only Safari 16.2+ supports — iPadOS 15.8.8 (the
    // newest version some older iPads can run) is stuck on Safari 15 and can't
    // render it at all. This adds a static computed-color fallback declaration
    // before each color-mix() line so old Safari gets a close approximation
    // instead of nothing, while modern browsers still use the real color-mix()
    // (cascade: same specificity, later declaration wins).
    "@csstools/postcss-color-mix-function": { preserve: true },
  },
};

export default config;
