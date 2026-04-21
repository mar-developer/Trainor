-- Trainor LMS initial schema
-- Enables pgvector for RAG and creates LMS, RAG, and chat tables.

-- ─────────────────────────────────────────────────────────────
-- Extensions
-- ─────────────────────────────────────────────────────────────
create extension if not exists "uuid-ossp";
create extension if not exists "vector";

-- ─────────────────────────────────────────────────────────────
-- Profiles (one row per auth.user)
-- ─────────────────────────────────────────────────────────────
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  created_at timestamptz not null default now()
);

-- Auto-create a profile row when a new auth.user is inserted.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)));
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ─────────────────────────────────────────────────────────────
-- Curriculum
-- ─────────────────────────────────────────────────────────────
create table public.courses (
  id uuid primary key default uuid_generate_v4(),
  slug text not null unique,
  title text not null,
  description text,
  created_at timestamptz not null default now()
);

create table public.phases (
  id uuid primary key default uuid_generate_v4(),
  course_id uuid not null references public.courses(id) on delete cascade,
  "order" int not null,
  title text not null,
  unique (course_id, "order")
);

create type public.module_kind as enum ('theory', 'handson', 'code', 'project');
create type public.module_status as enum ('complete', 'in_progress', 'preview', 'not_started');

create table public.modules (
  id uuid primary key default uuid_generate_v4(),
  phase_id uuid not null references public.phases(id) on delete cascade,
  "order" int not null,
  slug text not null unique,
  number text not null,
  title text not null,
  kind public.module_kind not null,
  status public.module_status not null default 'not_started',
  estimated_minutes int not null default 20,
  summary text,
  unique (phase_id, "order")
);

create table public.lessons (
  id uuid primary key default uuid_generate_v4(),
  module_id uuid not null references public.modules(id) on delete cascade,
  "order" int not null,
  title text not null,
  body_md text,
  unique (module_id, "order")
);

create table public.hands_on_steps (
  id uuid primary key default uuid_generate_v4(),
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  "order" int not null,
  instruction text not null,
  expected_measurement text,
  unique (lesson_id, "order")
);

create type public.safety_kind as enum ('danger', 'caution', 'info');

create table public.lesson_safety (
  id uuid primary key default uuid_generate_v4(),
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  "order" int not null,
  kind public.safety_kind not null,
  message text not null
);

create type public.component_category as enum (
  'led','resistor','sensor','motor','display','switch','ic','board','tool','wire'
);

create table public.components (
  id uuid primary key default uuid_generate_v4(),
  slug text not null unique,
  name text not null,
  category public.component_category not null,
  blurb text not null,
  datasheet_url text,
  pinout_svg text,
  status public.module_status not null default 'not_started'
);

-- ─────────────────────────────────────────────────────────────
-- Per-user progress and experiments
-- ─────────────────────────────────────────────────────────────
create table public.progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  step_id uuid references public.hands_on_steps(id) on delete cascade,
  completed_at timestamptz not null default now(),
  self_report jsonb,
  primary key (user_id, lesson_id, step_id)
);

create table public.experiments (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  circuit_description text,
  observation text,
  created_at timestamptz not null default now()
);

-- ─────────────────────────────────────────────────────────────
-- RAG: documents, chunks, embeddings
-- ─────────────────────────────────────────────────────────────
create type public.document_source as enum (
  'spec', 'arduino_docs', 'datasheet', 'obsidian', 'tutorial'
);

create table public.documents (
  id uuid primary key default uuid_generate_v4(),
  source public.document_source not null,
  title text not null,
  url text,
  checksum text not null,
  ingested_at timestamptz not null default now(),
  unique (source, url)
);

create table public.chunks (
  id uuid primary key default uuid_generate_v4(),
  document_id uuid not null references public.documents(id) on delete cascade,
  content text not null,
  token_count int not null,
  heading_path text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table public.embeddings (
  chunk_id uuid primary key references public.chunks(id) on delete cascade,
  embedding vector(1536) not null
);

-- HNSW for fast ANN; cosine distance.
create index embeddings_hnsw
  on public.embeddings
  using hnsw (embedding vector_cosine_ops);

-- Retrieval RPC — stable API to call from the app/server.
create or replace function public.match_chunks(
  query_embedding vector(1536),
  match_count int default 6
)
returns table (
  chunk_id uuid,
  document_id uuid,
  source public.document_source,
  title text,
  url text,
  heading_path text,
  content text,
  similarity float
)
language sql
stable
as $$
  select
    c.id as chunk_id,
    c.document_id,
    d.source,
    d.title,
    d.url,
    c.heading_path,
    c.content,
    1 - (e.embedding <=> query_embedding) as similarity
  from public.embeddings e
  join public.chunks c on c.id = e.chunk_id
  join public.documents d on d.id = c.document_id
  order by e.embedding <=> query_embedding
  limit match_count;
$$;

-- ─────────────────────────────────────────────────────────────
-- Chat
-- ─────────────────────────────────────────────────────────────
create type public.message_role as enum ('user', 'assistant', 'system');

create table public.chats (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text,
  lesson_id uuid references public.lessons(id) on delete set null,
  created_at timestamptz not null default now()
);

create table public.messages (
  id uuid primary key default uuid_generate_v4(),
  chat_id uuid not null references public.chats(id) on delete cascade,
  role public.message_role not null,
  content text not null,
  citations jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

create index messages_chat_id_created_idx
  on public.messages (chat_id, created_at);
