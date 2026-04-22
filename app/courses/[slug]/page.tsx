import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowLeft, ArrowRight, FlaskConical, Sparkles } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { PhaseRoadmap } from "@/components/phase-roadmap";
import { CurriculumOutline } from "@/components/curriculum-outline";
import { ChatCompanion } from "@/components/chat-companion";
import { NewExperimentDialog } from "@/components/new-experiment-dialog";
import {
  getCourseBySlug,
  getCurriculumOutline,
  getExperimentsForCourse,
  getModuleProgressSummary,
  getModulesForCourse,
} from "@/lib/data/repo";
import { isLessonComplete } from "@/lib/progress";

// Arduino-specific widgets stay on the Arduino course page only.
const ARDUINO_SLUG = "arduino-electronics-trainer";

export default async function CoursePage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const course = await getCourseBySlug(slug);
  if (!course) notFound();

  const [modules, outline, experiments] = await Promise.all([
    getModulesForCourse(slug),
    getCurriculumOutline(slug),
    getExperimentsForCourse(slug),
  ]);

  // Apply rule-b for the "Continue" hero.
  const seeded =
    modules.find((m) => m.status === "in-progress") ?? modules[0];
  const seededProgress = seeded
    ? await getModuleProgressSummary(seeded.slug)
    : { totalSteps: 0, completedStepOrders: [] };
  const seededComplete =
    seededProgress.totalSteps > 0 && isLessonComplete(seededProgress);
  const current = seededComplete
    ? (modules.slice(modules.indexOf(seeded) + 1).find(
        (m) => m.status !== "complete",
      ) ?? seeded)
    : seeded;

  const completedInPhase =
    modules.filter((m) => m.status === "complete").length +
    (seededComplete ? 1 : 0);

  return (
    <div className="relative flex-1">
      <header className="sticky top-0 z-10 flex h-16 items-center justify-between border-b bg-background/80 px-4 backdrop-blur sm:px-6">
        <div className="flex items-center gap-3">
          <Link
            href="/"
            className={buttonVariants({ variant: "ghost", size: "sm" })}
          >
            <ArrowLeft className="size-4" />
            Dashboard
          </Link>
          <div className="ml-1 flex flex-col leading-tight">
            <p className="text-xs uppercase tracking-wide text-muted-foreground">
              Course
            </p>
            <h1 className="text-sm font-semibold">{course.title}</h1>
          </div>
        </div>
        <Link
          href="/chat"
          className={buttonVariants({ variant: "outline", size: "sm" })}
        >
          Open tutor chat
        </Link>
      </header>

      <div className="mx-auto w-full max-w-6xl space-y-8 px-4 py-6 sm:px-6">
        {/* Hero / continue */}
        {current && (
          <section className="rounded-2xl border bg-gradient-to-br from-primary/10 via-background to-info/10 p-6 sm:p-8">
            <div className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
              <div className="space-y-2">
                <p className="inline-flex items-center gap-2 text-xs uppercase tracking-wide text-muted-foreground">
                  <Sparkles className="size-3.5 text-info" /> Continue where you
                  left off
                </p>
                <h2 className="text-2xl font-semibold sm:text-3xl">
                  Module {current.number} · {current.title}
                </h2>
                <p className="max-w-xl text-sm text-muted-foreground">
                  {current.summary}
                </p>
              </div>
              <Link
                href={`/modules/${current.slug}`}
                className={cn(buttonVariants({ size: "lg" }), "gap-2")}
              >
                Resume module
                <ArrowRight className="size-4" />
              </Link>
            </div>
          </section>
        )}

        {/* Phase roadmap — for now uses the static Arduino phase mock. */}
        {current && slug === ARDUINO_SLUG && (
          <PhaseRoadmap
            currentModule={`${current.number} · ${current.title}`}
            completedInPhase={completedInPhase}
            totalInPhase={modules.length}
          />
        )}

        {/* Master-plan / curriculum outline */}
        <CurriculumOutline phases={outline} />

        {/* Experiments (course-scoped) */}
        <section className="space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="inline-flex items-center gap-2 text-lg font-semibold">
              <FlaskConical className="size-4 text-sensor" /> Experiments for
              this course
            </h2>
            <NewExperimentDialog courseSlug={slug} />
          </div>
          {experiments.length === 0 ? (
            <div className="rounded-xl border border-dashed bg-card p-6 text-sm text-muted-foreground">
              No experiments yet. When you tweak a circuit from a lesson or
              build one of your own, log it here.
            </div>
          ) : (
            <ol className="grid gap-3 sm:grid-cols-2">
              {experiments.map((e) => (
                <li
                  key={e.id}
                  className="rounded-xl border bg-card p-3 text-sm"
                >
                  <div className="flex items-center justify-between">
                    <p className="font-medium">{e.title}</p>
                    <time className="text-xs text-muted-foreground">
                      {e.createdAt}
                    </time>
                  </div>
                  <p className="mt-1 text-xs text-muted-foreground">
                    {e.observation}
                  </p>
                </li>
              ))}
            </ol>
          )}
        </section>
      </div>

      <ChatCompanion lessonContext={course.title} />
    </div>
  );
}
