import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowLeft, ArrowRight, BookOpen, Check, Wrench } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { HandsOnSteps } from "@/components/hands-on-steps";
import { SafetyAlert } from "@/components/safety-alert";
import { ComponentExplorer } from "@/components/component-explorer";
import { ChatCompanion } from "@/components/chat-companion";
import {
  getComponents,
  getLessonForModule,
  getPhaseOneModules,
} from "@/lib/data/repo";
import {
  isLessonComplete,
  lessonProgressPercent,
} from "@/lib/progress";

export default async function ModulePage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const [modules, components, lesson] = await Promise.all([
    getPhaseOneModules(),
    getComponents(),
    getLessonForModule(slug),
  ]);

  const module = modules.find((m) => m.slug === slug);
  if (!module) notFound();

  const currentIdx = modules.findIndex((m) => m.slug === slug);
  const prev = modules[currentIdx - 1];
  const next = modules[currentIdx + 1];

  // Compute completion from hands-on progress (applies rule-b).
  const completedStepOrders =
    lesson?.handsOn.filter((s) => s.completedAt).map((s) => s.order) ?? [];
  const totalSteps = lesson?.handsOn.length ?? 0;
  const progressInput = { totalSteps, completedStepOrders };
  const complete = isLessonComplete(progressInput);
  const percent = lessonProgressPercent(progressInput);

  return (
    <div className="relative flex-1">
      <header className="sticky top-0 z-10 border-b bg-background/80 backdrop-blur">
        <div className="flex h-16 items-center gap-3 px-4 sm:px-6">
          <Link
            href="/"
            className={buttonVariants({ variant: "ghost", size: "sm" })}
          >
            <ArrowLeft className="size-4" />
            Dashboard
          </Link>
          <div className="ml-2 flex items-center gap-2 text-xs text-muted-foreground">
            <span className="font-mono">Module {module.number}</span>
            <span>·</span>
            <span>~{module.estimatedMinutes} min</span>
          </div>
          {totalSteps > 0 && (
            <div className="ml-auto flex items-center gap-3">
              {complete ? (
                <span className="inline-flex items-center gap-1.5 rounded-full bg-sensor/15 px-2.5 py-1 text-xs font-medium text-sensor">
                  <Check className="size-3.5" />
                  Lesson complete
                </span>
              ) : (
                <span className="flex items-center gap-2 text-xs text-muted-foreground">
                  <span className="font-mono tabular-nums">
                    {completedStepOrders.length}/{totalSteps}
                  </span>
                  <span className="h-1.5 w-24 overflow-hidden rounded-full bg-muted">
                    <span
                      className="block h-full rounded-full bg-primary transition-all"
                      style={{ width: `${percent}%` }}
                    />
                  </span>
                </span>
              )}
            </div>
          )}
        </div>
      </header>

      <div className="mx-auto w-full max-w-5xl space-y-6 px-4 py-6 sm:px-6">
        <div className="space-y-2">
          <h1 className="text-3xl font-semibold tracking-tight">
            {module.title}
          </h1>
          <p className="max-w-2xl text-muted-foreground">{module.summary}</p>
        </div>

        <Tabs defaultValue="read">
          <TabsList>
            <TabsTrigger value="read" className="gap-2">
              <BookOpen className="size-3.5" /> Read
            </TabsTrigger>
            <TabsTrigger value="handson" className="gap-2">
              <Wrench className="size-3.5" /> Hands-on
            </TabsTrigger>
            <TabsTrigger value="components">Components</TabsTrigger>
          </TabsList>

          <TabsContent value="read" className="mt-4 space-y-5">
            {lesson ? (
              <>
                <article className="whitespace-pre-wrap rounded-xl border bg-card p-5 text-sm leading-relaxed">
                  {lesson.body}
                </article>

                {lesson.safety.length > 0 && (
                  <section className="space-y-2">
                    <h3 className="text-sm font-semibold text-muted-foreground">
                      Before you begin
                    </h3>
                    <div className="grid gap-2 md:grid-cols-3">
                      {lesson.safety.map((s, i) => (
                        <SafetyAlert
                          key={i}
                          kind={s.kind}
                          message={s.message}
                        />
                      ))}
                    </div>
                  </section>
                )}
              </>
            ) : (
              <div className="rounded-xl border bg-card p-6 text-sm text-muted-foreground">
                Lesson body will be loaded from the seeded database once Phase
                A finishes the schema + seed step. For now only{" "}
                <span className="font-medium text-foreground">
                  core-components
                </span>{" "}
                has mock content.
              </div>
            )}
          </TabsContent>

          <TabsContent value="handson" className="mt-4">
            {lesson ? (
              <HandsOnSteps
                steps={lesson.handsOn}
                lessonId={(lesson as typeof lesson & { lessonId?: string }).lessonId}
                moduleSlug={slug}
              />
            ) : (
              <div className="rounded-xl border bg-card p-6 text-sm text-muted-foreground">
                No hands-on steps seeded for this module yet.
              </div>
            )}
          </TabsContent>

          <TabsContent value="components" className="mt-4">
            <ComponentExplorer components={components} />
          </TabsContent>
        </Tabs>

        <nav className="flex items-center justify-between gap-3 border-t pt-6 text-sm">
          {prev ? (
            <Link
              href={`/modules/${prev.slug}`}
              className={buttonVariants({ variant: "outline" })}
            >
              <ArrowLeft className="size-4" />
              {prev.number} · {prev.title}
            </Link>
          ) : (
            <span />
          )}
          {next && (
            <Link
              href={`/modules/${next.slug}`}
              className={buttonVariants()}
            >
              {next.number} · {next.title}
              <ArrowRight className="size-4" />
            </Link>
          )}
        </nav>
      </div>

      <ChatCompanion
        lessonContext={`Module ${module.number} · ${module.title}`}
      />
    </div>
  );
}
