import path from "node:path";
import { defineConfig } from "vitest/config";

// Lets tests import app modules through the same "@/..." alias as tsconfig.json.
export default defineConfig({
  resolve: { alias: { "@": path.resolve(__dirname, "src") } },
});
