-- A lesson can require specific components/equipment — the module page
-- uses this to show only the parts relevant to that lesson (not the
-- full kit). Many-to-many so a component can appear in multiple lessons.

create table if not exists public.lesson_components (
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  component_slug text not null references public.components(slug) on delete cascade,
  "order" int not null default 0,
  primary key (lesson_id, component_slug)
);

create index if not exists lesson_components_lesson_idx
  on public.lesson_components (lesson_id, "order");

-- Public read (curriculum data is not user-scoped).
alter table public.lesson_components enable row level security;
create policy "lesson_components readable by everyone"
  on public.lesson_components for select
  using (true);
