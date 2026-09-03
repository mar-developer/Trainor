import Link from "next/link";
import { ArrowRight, FlaskConical, Plus, Sparkles } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { CourseCard } from "@/components/course-card";
import { ChatCompanion } from "@/components/chat-companion";
import { getCourses, getExperiments } from "@/lib/data/repo";
import type { CourseSummary } from "@/lib/data/repo";

export const dynamic = "force-dynamic";

export default async function DashboardPage() {
  const [courses, experiments] = await Promise.all([
    getCourses(),
    getExperiments(),
  ]);

  const continueCourse = pickContinueCourse(courses);

  return (
    <div className="relative flex-1">
      <header className="sticky top-0 z-10 flex h-16 items-center justify-between border-b bg-background/80 px-4 backdrop-blur sm:px-6">
        <div>
          <p className="text-xs uppercase tracking-wide text-muted-foreground">
            Dashboard
          </p>
          <h1 className="text-sm font-semibold">
            Welcome back, Reymar. Pick up where you left off.
          </h1>
        </div>
        <Link
          href="/chat"
          className={buttonVariants({ variant: "outline", size: "sm" })}
        >
          Open tutor chat
        </Link>
      </header>

      <div className="mx-auto w-full max-w-6xl space-y-8 px-4 py-6 sm:px-6">
        {continueCourse && (
          <ContinueHero course={continueCourse} />
        )}

        {/* Courses catalog */}
        <section className="space-y-4">
          <div className="flex items-baseline justify-between">
            <h2 className="text-lg font-semibold">Your courses</h2>
            <p className="text-xs text-muted-foreground">
              {courses.length} subject{courses.length === 1 ? "" : "s"}
            </p>
          </div>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {courses.map((course) => (
              <CourseCard key={course.slug} course={course} />
            ))}
            <NewCoursePlaceholder />
          </div>
        </section>

        {/* Cross-course experiments feed */}
        <section className="space-y-4">
          <div className="flex items-baseline justify-between">
            <h2 className="inline-flex items-center gap-2 text-lg font-semibold">
              <FlaskConical className="size-4 text-sensor" /> Recent experiments
            </h2>
            <Link
              href="/experiments"
              className={buttonVariants({ variant: "ghost", size: "sm" })}
            >
              View all <ArrowRight className="size-3.5" />
            </Link>
          </div>
          {experiments.length === 0 ? (
            <div className="rounded-xl border border-dashed bg-card p-6 text-sm text-muted-foreground">
              No experiments logged yet. Wire something up, then log it from
              inside a course.
            </div>
          ) : (
            <ol className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
              {experiments.slice(0, 6).map((e) => (
                <li key={e.id} className="rounded-xl border bg-card p-3 text-sm">
                  <div className="flex items-center justify-between gap-2">
                    <p className="truncate font-medium">{e.title}</p>
                    <time className="shrink-0 text-xs text-muted-foreground">
                      {e.createdAt}
                    </time>
                  </div>
                  {e.courseTitle && e.courseSlug && (
                    <Link
                      href={`/courses/${e.courseSlug}`}
                      className="mt-1 inline-flex items-center gap-1.5 text-[0.7rem] text-muted-foreground hover:text-foreground"
                    >
                      <span className="size-1.5 rounded-full bg-sensor" />
                      {e.courseTitle}
                    </Link>
                  )}
                  <p className="mt-1 line-clamp-2 text-xs text-muted-foreground">
                    {e.observation}
                  </p>
                </li>
              ))}
            </ol>
          )}
        </section>
      </div>

      <ChatCompanion />
    </div>
  );
}

function ContinueHero({ course }: { course: CourseSummary }) {
  const m = course.continueModule;
  if (!m) return null;
  return (
    <section className="rounded-2xl border bg-gradient-to-br from-primary/10 via-background to-info/10 p-6 sm:p-8">
      <div className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
        <div className="space-y-2">
          <p className="inline-flex items-center gap-2 text-xs uppercase tracking-wide text-muted-foreground">
            <Sparkles className="size-3.5 text-info" /> Continue where you left
            off
          </p>
          <h2 className="text-2xl font-semibold sm:text-3xl">
            Module {m.number} · {m.title}
          </h2>
          <p className="text-sm text-muted-foreground">
            <span className="font-medium text-foreground">{course.title}</span>
            {course.currentPhaseLabel
              ? ` · ${course.currentPhaseLabel}`
              : ""}
          </p>
          <p className="max-w-xl text-sm text-muted-foreground">{m.summary}</p>
        </div>
        <Link
          href={`/modules/${m.slug}`}
          className={cn(buttonVariants({ size: "lg" }), "gap-2")}
        >
          Resume module
          <ArrowRight className="size-4" />
        </Link>
      </div>
    </section>
  );
}

function NewCoursePlaceholder() {
  return (
    <div
      className="flex min-h-44 flex-col items-center justify-center gap-2 rounded-2xl border border-dashed bg-background/60 p-5 text-center text-sm text-muted-foreground"
      role="note"
    >
      <span className="flex size-10 items-center justify-center rounded-xl bg-muted">
        <Plus className="size-5" />
      </span>
      <p className="font-medium text-foreground">Add another subject</p>
      <p className="text-xs">
        Python, guitar, cooking — any new course lives here once you seed it.
      </p>
    </div>
  );
}

/** Pick the course whose "Next up" module we feature in the hero. */
function pickContinueCourse(courses: CourseSummary[]): CourseSummary | null {
  // Prefer in-flight courses (0 < percent < 100); fall back to first started.
  const started = courses.filter(
    (c) => c.continueModule && c.percent < 100,
  );
  if (started.length === 0) return courses[0] ?? null;
  started.sort((a, b) => b.percent - a.percent); // most advanced first
  return started[0];
}
