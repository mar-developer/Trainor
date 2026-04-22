import Link from "next/link";
import { FlaskConical } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";
import { getExperiments } from "@/lib/data/repo";

export default async function ExperimentsPage() {
  const experiments = await getExperiments();
  return (
    <div className="flex-1">
      <header className="flex h-16 items-center justify-between border-b px-4 sm:px-6">
        <div>
          <p className="text-xs uppercase tracking-wide text-muted-foreground">
            Experiments
          </p>
          <h1 className="text-sm font-semibold">
            Circuits you designed without a tutorial
          </h1>
        </div>
        <span className="text-xs text-muted-foreground">
          Log new experiments from inside a course.
        </span>
      </header>

      <div className="mx-auto w-full max-w-4xl space-y-4 px-4 py-6 sm:px-6">
        {experiments.length === 0 ? (
          <div className="rounded-xl border border-dashed bg-card p-12 text-center">
            <FlaskConical className="mx-auto size-10 text-muted-foreground/60" />
            <h2 className="mt-3 font-semibold">No experiments yet</h2>
            <p className="mx-auto mt-1 max-w-sm text-sm text-muted-foreground">
              When you wire up a circuit that isn't in the lesson — log it
              here with what you observed. Even the failures are worth
              keeping.
            </p>
          </div>
        ) : (
          experiments.map((e) => (
            <article key={e.id} className="rounded-xl border bg-card p-5">
              <div className="flex items-start gap-3">
                <div className="flex size-10 items-center justify-center rounded-full bg-sensor/15 text-sensor">
                  <FlaskConical className="size-5" />
                </div>
                <div className="flex-1 space-y-1">
                  <div className="flex items-center justify-between gap-2">
                    <h2 className="truncate font-semibold">{e.title}</h2>
                    <time className="shrink-0 text-xs text-muted-foreground">
                      {e.createdAt}
                    </time>
                  </div>
                  {e.courseTitle && e.courseSlug && (
                    <Link
                      href={`/courses/${e.courseSlug}`}
                      className={buttonVariants({
                        variant: "ghost",
                        size: "sm",
                      })
                        .concat(" !h-6 gap-1.5 !px-2 !text-[0.7rem]")}
                    >
                      <span className="size-1.5 rounded-full bg-sensor" />
                      {e.courseTitle}
                    </Link>
                  )}
                  <p className="text-sm text-muted-foreground">
                    {e.observation}
                  </p>
                </div>
              </div>
            </article>
          ))
        )}
      </div>
    </div>
  );
}
