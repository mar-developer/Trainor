// Vercel project config (typed, replaces vercel.json).
// Docs: https://vercel.com/docs/project-configuration/vercel-ts
import { routes, type VercelConfig } from "@vercel/config/v1";

export const config: VercelConfig = {
  framework: "nextjs",
  buildCommand: "npm run build",

  // Chat streaming can exceed the default 60s; bump it to the 5-minute
  // Fluid-Compute default so long answers finish cleanly.
  functions: {
    "app/api/chat/route.ts": { maxDuration: 300 },
  },

  headers: [
    routes.cacheControl("/_next/static/(.*)", {
      public: true,
      maxAge: "1 year",
      immutable: true,
    }),
  ],

  // Example: nightly ingest refresh (un-comment + implement when ready).
  // crons: [{ path: "/api/ingest/refresh", schedule: "0 4 * * *" }],
};
