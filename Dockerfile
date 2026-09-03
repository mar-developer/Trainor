# syntax=docker/dockerfile:1
#
# Multi-stage production image for the Next.js app, built on standalone output.
# Pairs with docker-compose.yml. See `output: "standalone"` in next.config.ts.

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
