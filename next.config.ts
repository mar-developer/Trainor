import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Emit a self-contained .next/standalone build (own minimal server.js + only
  // the traced runtime deps) so the Docker image stays small. See Dockerfile.
  output: "standalone",
};

export default nextConfig;
