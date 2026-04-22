-- Scope experiments to a course so the dashboard can aggregate cross-course
-- and the course page can filter. `course_id` is nullable so existing rows
-- don't break the constraint; we backfill the Arduino course immediately.

alter table public.experiments
  add column if not exists course_id uuid
  references public.courses(id) on delete set null;

update public.experiments
   set course_id = '00000000-0000-0000-0000-0000000000aa'
 where course_id is null;

create index if not exists experiments_user_course_created_idx
  on public.experiments (user_id, course_id, created_at desc);
