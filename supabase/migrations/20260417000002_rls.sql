-- Row Level Security policies.
-- Curriculum (courses/phases/modules/lessons/steps/safety/components) is
-- public-readable because it's shared content. Per-user data
-- (progress, experiments, chats, messages) is scoped to auth.uid().
-- Documents/chunks/embeddings are also public-readable so retrieval works
-- without service role from Server Components.

-- ─── Curriculum: readable by everyone (anon + authenticated) ───
alter table public.courses         enable row level security;
alter table public.phases          enable row level security;
alter table public.modules         enable row level security;
alter table public.lessons         enable row level security;
alter table public.hands_on_steps  enable row level security;
alter table public.lesson_safety   enable row level security;
alter table public.components      enable row level security;
alter table public.documents       enable row level security;
alter table public.chunks          enable row level security;
alter table public.embeddings      enable row level security;

create policy "curriculum read" on public.courses
  for select using (true);
create policy "curriculum read" on public.phases
  for select using (true);
create policy "curriculum read" on public.modules
  for select using (true);
create policy "curriculum read" on public.lessons
  for select using (true);
create policy "curriculum read" on public.hands_on_steps
  for select using (true);
create policy "curriculum read" on public.lesson_safety
  for select using (true);
create policy "curriculum read" on public.components
  for select using (true);
create policy "rag read" on public.documents
  for select using (true);
create policy "rag read" on public.chunks
  for select using (true);
create policy "rag read" on public.embeddings
  for select using (true);

-- ─── Profiles ───
alter table public.profiles enable row level security;
create policy "self read"   on public.profiles
  for select using (auth.uid() = id);
create policy "self update" on public.profiles
  for update using (auth.uid() = id) with check (auth.uid() = id);

-- ─── Progress ───
alter table public.progress enable row level security;
create policy "self read"   on public.progress
  for select using (auth.uid() = user_id);
create policy "self insert" on public.progress
  for insert with check (auth.uid() = user_id);
create policy "self update" on public.progress
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "self delete" on public.progress
  for delete using (auth.uid() = user_id);

-- ─── Experiments ───
alter table public.experiments enable row level security;
create policy "self read"   on public.experiments
  for select using (auth.uid() = user_id);
create policy "self insert" on public.experiments
  for insert with check (auth.uid() = user_id);
create policy "self update" on public.experiments
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "self delete" on public.experiments
  for delete using (auth.uid() = user_id);

-- ─── Chats & Messages ───
alter table public.chats    enable row level security;
alter table public.messages enable row level security;

create policy "self read"   on public.chats
  for select using (auth.uid() = user_id);
create policy "self insert" on public.chats
  for insert with check (auth.uid() = user_id);
create policy "self delete" on public.chats
  for delete using (auth.uid() = user_id);

create policy "self read"   on public.messages
  for select using (
    exists (select 1 from public.chats c where c.id = chat_id and c.user_id = auth.uid())
  );
create policy "self insert" on public.messages
  for insert with check (
    exists (select 1 from public.chats c where c.id = chat_id and c.user_id = auth.uid())
  );
