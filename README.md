# Trainor — Arduino LMS

Web app for learning Arduino electronics with a RAG-powered AI tutor grounded
in the curriculum, Arduino docs, and component datasheets.

Stack: **Next.js 16 App Router · React 19 · Tailwind v4 · shadcn · Neon Postgres + pgvector · AI SDK v6 · Vercel AI Gateway**.

## Getting started

```bash
npm install
cp .env.example .env.local
npm run dev
```

Set `DATABASE_URL` to the pooled connection string for the Trainor Neon
project. Without it, read pages use the built-in mock curriculum.

Open [http://localhost:3000](http://localhost:3000).

## Project layout

```
app/                 # Next.js App Router pages and server actions
components/          # React components
lib/
  data/mock.ts       # local fallback data
  data/repo.ts       # server-side Neon reads
  db.ts              # pooled server-only Postgres connection
  rag/               # ingestion and retrieval helpers
  ai/                # AI Gateway and prompt helpers
scripts/             # ingestion CLIs
supabase/migrations/ # legacy SQL schema history
docs/                # canonical curriculum
```

## Ingesting RAG sources

Once `.env.local` has `DATABASE_URL` and `AI_GATEWAY_API_KEY`:

```bash
npm run ingest:spec
npm run ingest:lessons
npm run ingest:arduino-docs
npm run ingest:datasheets
npm run ingest:all
```

Each source is checksum-gated, so unchanged content is skipped.

## Deploying to Vercel

Project config is in [vercel.ts](./vercel.ts).

```bash
vercel link
vercel env pull
vercel deploy
vercel deploy --prod
```

Required production environment variables:

- `DATABASE_URL` — pooled Trainor Neon connection string
- `AI_GATEWAY_API_KEY` — Vercel AI Gateway

## Verification

```bash
npm run lint
npx tsc --noEmit
npm run build
```
