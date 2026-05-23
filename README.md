# Trainor — Arduino LMS

Web app for learning Arduino electronics with a RAG-powered AI tutor grounded in
your own curriculum, Arduino docs, and component datasheets.

Stack: **Next.js 16 App Router · React 19 · Tailwind v4 · shadcn · Supabase (Postgres + pgvector) · AI SDK v6 · Vercel AI Gateway**.

## Getting started

### 1. Install deps
```bash
npm install
```

### 2. Start Supabase (local)

Requires Docker Desktop running.

```bash
npm run db:start      # boots Supabase stack (postgres, auth, studio, etc.)
npm run db:reset      # applies migrations + seed.sql
npm run db:types      # regenerate lib/supabase/types.ts
```

Supabase Studio opens at http://127.0.0.1:54323.

Prefer the cloud? Create a project at [supabase.com](https://supabase.com),
paste the migration SQL into the SQL editor, then fill in the cloud URL + anon
key below.

### 3. Environment

```bash
cp .env.example .env.local
```

The defaults in `.env.example` match local Supabase. Add
`AI_GATEWAY_API_KEY` (from the [Vercel AI Gateway dashboard](https://vercel.com/dashboard/ai-gateway))
when you're ready to wire the chat companion.

### 4. Run the app
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

## Project layout

```
app/                 # Next.js App Router pages
  page.tsx             # dashboard
  modules/[slug]/      # lesson pages
  chat/                # tutor chat
  experiments/         # experiments log
components/          # React components (AppShell, ComponentExplorer, etc.)
  ui/                  # shadcn primitives
lib/
  data/mock.ts         # temporary hardcoded data (replaced by Supabase reads)
  supabase/            # browser + server clients, generated types
  rag/                 # ingestion + retrieval helpers (Phase C)
  ai/                  # AI Gateway + prompt helpers (Phase C)
proxy.ts             # Next 16 Proxy (renamed middleware) — refreshes Supabase session
scripts/             # ingestion CLIs
supabase/
  migrations/          # SQL migrations (versioned)
  seed.sql             # deterministic curriculum seed
  config.toml
docs/
  arduino_trainer_spec.md   # canonical curriculum + RAG primary source (../docs/) 
```

## Curriculum seed

The `supabase/seed.sql` file pre-populates:

- One course — *Arduino Electronics Trainer*
- Four phases (Phase 1 active, 2-4 stubbed)
- Phase 1's eight modules with statuses matching the spec (1.1-1.3 complete, 1.4 in progress, 1.5 preview)
- Thirteen core components with done/remaining states (7 done: resistor, LED, transistor, button, pot, buzzer, relay)
- Module 1.4's lesson body, three hands-on steps with expected measurements, and three safety warnings (danger/caution/info)

Richer lesson bodies are populated by the RAG ingestion pipeline that parses
`docs/arduino_trainer_spec.md` (Phase C).

## Ingesting RAG sources

Once Supabase is running and `.env.local` has `AI_GATEWAY_API_KEY`:

```bash
npm run ingest:spec            # curriculum — always the primary source
npm run ingest:arduino-docs    # curated arduino.cc reference pages
npm run ingest:datasheets      # PDFs in ./datasheets/
npm run ingest:all             # runs all three in order
```

Each source is checksum-gated, so re-running is cheap when content hasn't
changed.

## Deploying to Vercel

Project config is in [vercel.ts](./vercel.ts) — typed, replaces `vercel.json`.

```bash
vercel link             # first time only
vercel env pull          # pull env from the Vercel project
vercel deploy            # preview
vercel deploy --prod     # promote to production
```

Required production env vars:
- `NEXT_PUBLIC_SUPABASE_URL` — your cloud Supabase URL
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY` (for ingestion workflows)
- `AI_GATEWAY_API_KEY` (Vercel AI Gateway)

## Verifying Phase A

```bash
npm run db:reset
npm run dev
```

Then:
- Sign up / sign in (or use the Supabase dashboard to create a user)
- Dashboard shows 7/13 components and Module 1.4 as "in progress"
- Open Module 1.4 → three hands-on steps render with expected readings and safety alerts
