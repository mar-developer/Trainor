# syntax=docker/dockerfile:1
#
# Multi-stage production image for the Next.js app, built on standalone output.
# Pairs with docker-compose.yml, which wires the container to the local
# `supabase start` stack. See `output: "standalone"` in next.config.ts.

# ---- Base ---------------------------------------------------------------
# Node 24 LTS on Alpine. libc6-compat covers native addons that expect glibc.
FROM node:24-alpine AS base
RUN apk add --no-cache libc6-compat
WORKDIR /app

# ---- Dependencies -------------------------------------------------------
# Separate layer so deps are only re-installed when the lockfile changes.
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# ---- Builder ------------------------------------------------------------
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# NEXT_PUBLIC_* are inlined into the BROWSER bundle at build time, so they must
# be the URL/keys the browser (running on the host) will use — i.e. the
# host-mapped Supabase port. Server-side code re-reads these from the runtime
# env (overridden in compose), so the same names resolve differently at runtime.
ARG NEXT_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
ARG NEXT_PUBLIC_SUPABASE_ANON_KEY
ENV NEXT_PUBLIC_SUPABASE_URL=$NEXT_PUBLIC_SUPABASE_URL
ENV NEXT_PUBLIC_SUPABASE_ANON_KEY=$NEXT_PUBLIC_SUPABASE_ANON_KEY
ENV NEXT_TELEMETRY_DISABLED=1

RUN npm run build

# ---- Runner -------------------------------------------------------------
FROM base AS runner
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Run as an unprivileged user.
RUN addgroup --system --gid 1001 nodejs \
  && adduser --system --uid 1001 nextjs

# Standalone output: server.js + traced node_modules, then the assets it serves.
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
CMD ["node", "server.js"]
