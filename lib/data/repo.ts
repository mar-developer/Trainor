// Unified read API. Tries Supabase when env is configured, falls back to the
// typed mock data in ./mock so the app still renders locally without a DB.
// All functions are server-side (await cookies() inside the Supabase client).

import { createClient } from "@/lib/supabase/server";
import { createServiceClient } from "@/lib/supabase/service";
import { getCurrentUserId } from "@/lib/auth";
import {
  COMPONENTS,
  EXPERIMENTS,
  LESSONS,
  PHASE_ONE_MODULES,
  type ComponentCard,
  type ComponentCategory,
  type Experiment,
  type HandsOnStep,
  type LessonContent,
  type Module,
} from "@/lib/data/mock";

export type {
  ComponentCard,
  ComponentCategory,
  Experiment,
  HandsOnStep,
  LessonContent,
  Module,
};

function isSupabaseConfigured() {
  return Boolean(
    process.env.NEXT_PUBLIC_SUPABASE_URL &&
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  );
}

// ─── Modules ──────────────────────────────────────────────────────────
export async function getModulesForCourse(courseSlug: string): Promise<Module[]> {
  if (!isSupabaseConfigured()) return PHASE_ONE_MODULES;

  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("modules")
      .select(
        `
          slug, number, title, kind, status, estimated_minutes, summary,
          phases!inner ( "order", courses!inner ( slug ) )
        `,
      )
      .eq("phases.courses.slug", courseSlug);
    if (error || !data) throw error ?? new Error("no data");
    return data
      .map(dbModuleToMock)
      .sort((a, b) =>
        a.number.localeCompare(b.number, undefined, { numeric: true }),
      );
  } catch (err) {
    console.warn("[repo] getModulesForCourse falling back to mock:", err);
    return PHASE_ONE_MODULES;
  }
}

/** @deprecated prefer getModulesForCourse("arduino-electronics-trainer"). */
export async function getPhaseOneModules(): Promise<Module[]> {
  return getModulesForCourse("arduino-electronics-trainer");
}

export async function getModuleBySlug(slug: string): Promise<Module | null> {
  if (!isSupabaseConfigured()) {
    return PHASE_ONE_MODULES.find((m) => m.slug === slug) ?? null;
  }

  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("modules")
      .select("slug, number, title, kind, status, estimated_minutes, summary")
      .eq("slug", slug)
      .maybeSingle();
    if (error) throw error;
    if (!data) return null;
    return dbModuleToMock(data);
  } catch (err) {
    console.warn("[repo] getModuleBySlug falling back to mock:", err);
    return PHASE_ONE_MODULES.find((m) => m.slug === slug) ?? null;
  }
}

function dbModuleToMock(row: Record<string, unknown>): Module {
  const statusRaw = row.status as string;
  return {
    slug: row.slug as string,
    number: row.number as string,
    title: row.title as string,
    kind: row.kind as Module["kind"],
    // DB uses snake_case enum; mock uses kebab-case strings.
    status:
      statusRaw === "not_started"
        ? "not-started"
        : statusRaw === "in_progress"
          ? "in-progress"
          : (statusRaw as Module["status"]),
    estimatedMinutes: (row.estimated_minutes as number) ?? 20,
    summary: (row.summary as string) ?? "",
  };
}

// ─── Components ───────────────────────────────────────────────────────
export async function getComponents(): Promise<ComponentCard[]> {
  if (!isSupabaseConfigured()) return COMPONENTS;

  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("components")
      .select("slug, name, category, blurb, status");
    if (error || !data) throw error ?? new Error("no data");

    // Merge with mock to preserve icon mapping — icons live in the client bundle.
    // Mock also defines the intended display order; we sort by it below.
    const iconBySlug = new Map(COMPONENTS.map((c) => [c.slug, c.icon]));
    const orderBySlug = new Map(COMPONENTS.map((c, i) => [c.slug, i]));

    return data
      .map<ComponentCard>((row) => ({
        slug: row.slug as string,
        name: row.name as string,
        category: row.category as ComponentCategory,
        blurb: row.blurb as string,
        status:
          row.status === "complete"
            ? "done"
            : row.status === "not_started"
              ? "remaining"
              : "locked",
        icon: iconBySlug.get(row.slug as string) ?? COMPONENTS[0].icon,
      }))
      .sort((a, b) => {
        const ao = orderBySlug.get(a.slug) ?? 99;
        const bo = orderBySlug.get(b.slug) ?? 99;
        return ao - bo;
      });
  } catch (err) {
    console.warn("[repo] getComponents falling back to mock:", err);
    return COMPONENTS;
  }
}

export async function getComponentBySlug(
  slug: string,
): Promise<ComponentCard | null> {
  const all = await getComponents();
  return all.find((c) => c.slug === slug) ?? null;
}

/**
 * Components/equipment a specific module actually uses. Returns [] when
 * the lesson has no mapping seeded yet. Ordering comes from
 * `lesson_components.order` so we can list equipment first, parts second.
 */
export async function getComponentsForModule(
  moduleSlug: string,
): Promise<ComponentCard[]> {
  if (!isSupabaseConfigured()) return COMPONENTS;
  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("lesson_components")
      .select(
        `
          "order",
          components!inner ( slug, name, category, blurb, status ),
          lessons!inner ( modules!inner ( slug ) )
        `,
      )
      .eq("lessons.modules.slug", moduleSlug);
    if (error || !data) throw error ?? new Error("no data");

    const iconBySlug = new Map(COMPONENTS.map((c) => [c.slug, c.icon]));
    return data
      .slice()
      .sort(
        (a, b) =>
          ((a.order as number) ?? 0) - ((b.order as number) ?? 0),
      )
      .map((row) => {
        const c = row.components as {
          slug: string;
          name: string;
          category: ComponentCategory;
          blurb: string;
          status: string;
        };
        return {
          slug: c.slug,
          name: c.name,
          category: c.category,
          blurb: c.blurb,
          status:
            c.status === "complete"
              ? "done"
              : c.status === "not_started"
                ? "remaining"
                : "locked",
          icon: iconBySlug.get(c.slug) ?? COMPONENTS[0].icon,
        } satisfies ComponentCard;
      });
  } catch (err) {
    console.warn("[repo] getComponentsForModule failed:", err);
    return [];
  }
}

// ─── Lesson (by module slug) ──────────────────────────────────────────
export async function getLessonForModule(
  moduleSlug: string,
): Promise<(LessonContent & { lessonId?: string }) | null> {
  if (!isSupabaseConfigured()) return LESSONS[moduleSlug] ?? null;

  try {
    const supabase = await createClient();
    const { data: lessons, error } = await supabase
      .from("lessons")
      .select(
        `
          id,
          title,
          body_md,
          modules!inner (slug),
          hands_on_steps!hands_on_steps_lesson_id_fkey ( id, "order", instruction, expected_measurement ),
          lesson_safety ( "order", kind, message )
        `,
      )
      .eq("modules.slug", moduleSlug)
      .limit(1)
      .maybeSingle();

    if (error) throw error;
    if (!lessons) return null;

    const row = lessons as {
      id: string;
      title: string;
      body_md: string | null;
      hands_on_steps: Array<{
        id: string;
        order: number;
        instruction: string;
        expected_measurement: string | null;
      }>;
      lesson_safety: Array<{
        order: number;
        kind: "danger" | "caution" | "info";
        message: string;
      }>;
    };

    const steps: HandsOnStep[] = (row.hands_on_steps ?? [])
      .slice()
      .sort((a, b) => a.order - b.order)
      .map((s) => ({
        id: s.id,
        order: s.order,
        instruction: s.instruction,
        expected: s.expected_measurement ?? undefined,
      }));

    // Hydrate progress for each step (single user mode).
    // Uses the service-role client to bypass RLS — same trust model as the
    // server actions that write these rows. Flip to supabase.auth.getUser()
    // when real Supabase Auth ships.
    const userId = await getCurrentUserId();
    const stepIds = steps.map((s) => s.id).filter((id): id is string => Boolean(id));
    if (stepIds.length) {
      const admin = createServiceClient();
      const { data: progRows } = await admin
        .from("progress")
        .select("step_id, completed_at, self_report")
        .eq("user_id", userId)
        .in("step_id", stepIds);
      const byStep = new Map(
        (progRows ?? []).map((r) => [
          r.step_id as string,
          r as { completed_at: string; self_report: { text?: string } | null },
        ]),
      );
      steps.forEach((s) => {
        const p = s.id ? byStep.get(s.id) : undefined;
        s.completedAt = p?.completed_at ?? null;
        s.selfReport = p?.self_report?.text ?? null;
      });
    }

    return {
      lessonId: row.id,
      moduleSlug,
      title: row.title,
      body: row.body_md ?? "",
      handsOn: steps,
      safety: (row.lesson_safety ?? [])
        .slice()
        .sort((a, b) => a.order - b.order)
        .map((s) => ({ kind: s.kind, message: s.message })),
    };
  } catch (err) {
    console.warn("[repo] getLessonForModule falling back to mock:", err);
    return LESSONS[moduleSlug] ?? null;
  }
}

// ─── Lesson progress summary (for completion badges / auto-advance) ──
export async function getModuleProgressSummary(
  moduleSlug: string,
): Promise<{ totalSteps: number; completedStepOrders: number[] }> {
  if (!isSupabaseConfigured()) return { totalSteps: 0, completedStepOrders: [] };

  try {
    const supabase = await createClient();
    const admin = createServiceClient();
    const userId = await getCurrentUserId();

    // First fetch the lesson's steps (anon client is fine for curriculum).
    const { data: lesson } = await supabase
      .from("lessons")
      .select(
        `
          id,
          hands_on_steps!hands_on_steps_lesson_id_fkey ( id, "order" ),
          modules!inner (slug)
        `,
      )
      .eq("modules.slug", moduleSlug)
      .maybeSingle();

    if (!lesson) return { totalSteps: 0, completedStepOrders: [] };
    const steps = (lesson as { hands_on_steps?: Array<{ id: string; order: number }> })
      .hands_on_steps ?? [];
    const stepIds = steps.map((s) => s.id);
    if (!stepIds.length) return { totalSteps: 0, completedStepOrders: [] };

    // Progress requires service client to bypass RLS in single-user mode.
    const { data: done } = await admin
      .from("progress")
      .select("step_id")
      .eq("user_id", userId)
      .in("step_id", stepIds)
      .not("completed_at", "is", null);

    const doneSet = new Set((done ?? []).map((r) => r.step_id as string));
    return {
      totalSteps: steps.length,
      completedStepOrders: steps
        .filter((s) => doneSet.has(s.id))
        .map((s) => s.order),
    };
  } catch (err) {
    console.warn("[repo] getModuleProgressSummary failed:", err);
    return { totalSteps: 0, completedStepOrders: [] };
  }
}

// ─── Courses (catalog + detail) ──────────────────────────────────────
export interface CourseSummary {
  slug: string;
  title: string;
  description: string;
  moduleCount: number;
  completeCount: number;
  /** Derived: rounded to 0–100. */
  percent: number;
  /** Next module the learner should open. Null when everything is done. */
  continueModule: Module | null;
  /** Short Phase N label for the current module, e.g. "Phase 1 · Foundations". */
  currentPhaseLabel: string | null;
}

/** Catalog used by the dashboard. One row per course row in public.courses. */
export async function getCourses(): Promise<CourseSummary[]> {
  if (!isSupabaseConfigured()) {
    // Mock fallback: single Arduino card.
    const modules = PHASE_ONE_MODULES;
    const complete = modules.filter((m) => m.status === "complete").length;
    const next =
      modules.find((m) => m.status === "in-progress") ??
      modules.find((m) => m.status !== "complete") ??
      null;
    return [
      {
        slug: "arduino-electronics-trainer",
        title: "Arduino Electronics Trainer",
        description:
          "Zero-to-IoT curriculum for web developers. Learn electronics from scratch with hands-on, measurement-driven tutorials.",
        moduleCount: modules.length,
        completeCount: complete,
        percent: Math.round((complete / modules.length) * 100),
        continueModule: next,
        currentPhaseLabel: next ? "Phase 1 · Foundations" : null,
      },
    ];
  }

  const supabase = await createClient();
  const { data: courses, error } = await supabase
    .from("courses")
    .select("slug, title, description");
  if (error || !courses) {
    console.warn("[repo] getCourses falling back to mock:", error);
    return getCourses.call(undefined); // retry with mock branch
  }

  const summaries = await Promise.all(
    courses.map(async (c) => {
      const modules = await getModulesForCourse(c.slug as string);
      const complete = modules.filter((m) => m.status === "complete").length;
      const next =
        modules.find((m) => m.status === "in-progress") ??
        modules.find((m) => m.status !== "complete") ??
        null;

      // Apply rule-b across modules — if the seeded in-progress module is
      // actually complete via hands-on progress, advance past it.
      let continueModule = next;
      if (next) {
        const prog = await getModuleProgressSummary(next.slug);
        if (prog.totalSteps > 0 && isLessonCompleteFromProgress(prog)) {
          const seededIdx = modules.findIndex((m) => m.slug === next.slug);
          continueModule =
            modules
              .slice(seededIdx + 1)
              .find((m) => m.status !== "complete") ?? next;
        }
      }

      const phaseLabel = await getPhaseLabelForModule(continueModule?.slug);
      const moduleCount = modules.length;
      return {
        slug: c.slug as string,
        title: c.title as string,
        description: (c.description as string) ?? "",
        moduleCount,
        completeCount: complete,
        percent: moduleCount
          ? Math.round((complete / moduleCount) * 100)
          : 0,
        continueModule,
        currentPhaseLabel: phaseLabel,
      } satisfies CourseSummary;
    }),
  );

  return summaries;
}

/** The course a given module belongs to. Used for breadcrumb back-links. */
export async function getCourseForModule(
  moduleSlug: string,
): Promise<{ slug: string; title: string } | null> {
  if (!isSupabaseConfigured()) {
    return { slug: "arduino-electronics-trainer", title: "Arduino Electronics Trainer" };
  }
  try {
    const supabase = await createClient();
    const { data } = await supabase
      .from("modules")
      .select(`phases ( courses ( slug, title ) )`)
      .eq("slug", moduleSlug)
      .maybeSingle();
    const course = (data as {
      phases?: { courses?: { slug: string; title: string } };
    } | null)?.phases?.courses;
    return course ?? null;
  } catch {
    return null;
  }
}

export async function getCourseBySlug(
  slug: string,
): Promise<{ slug: string; title: string; description: string } | null> {
  if (!isSupabaseConfigured()) {
    if (slug === "arduino-electronics-trainer") {
      return {
        slug,
        title: "Arduino Electronics Trainer",
        description:
          "Zero-to-IoT curriculum for web developers. Learn electronics from scratch with hands-on, measurement-driven tutorials.",
      };
    }
    return null;
  }
  const supabase = await createClient();
  const { data } = await supabase
    .from("courses")
    .select("slug, title, description")
    .eq("slug", slug)
    .maybeSingle();
  if (!data) return null;
  return {
    slug: data.slug as string,
    title: data.title as string,
    description: (data.description as string) ?? "",
  };
}

// ─── Curriculum outline (master-plan accordion) ──────────────────────
export interface CurriculumPhase {
  id: string;
  order: number;
  title: string;
  locked: boolean;
  moduleCount: number;
  completeCount: number;
  modules: Array<
    Module & {
      lessonTitles: string[];
      complete: boolean;
      totalSteps: number;
      completedSteps: number;
    }
  >;
}

export async function getCurriculumOutline(
  courseSlug: string,
): Promise<CurriculumPhase[]> {
  if (!isSupabaseConfigured()) {
    // Minimal mock: one phase with the 8 seeded modules.
    return [
      {
        id: "phase-1",
        order: 1,
        title: "Foundations",
        locked: false,
        moduleCount: PHASE_ONE_MODULES.length,
        completeCount: PHASE_ONE_MODULES.filter((m) => m.status === "complete")
          .length,
        modules: PHASE_ONE_MODULES.map((m) => ({
          ...m,
          lessonTitles: [],
          complete: m.status === "complete",
          totalSteps: 0,
          completedSteps: 0,
        })),
      },
    ];
  }

  const supabase = await createClient();
  const { data, error } = await supabase
    .from("phases")
    .select(
      `
        id, "order", title,
        courses!inner ( slug ),
        modules (
          id, slug, number, title, kind, status, estimated_minutes, summary,
          lessons ( title )
        )
      `,
    )
    .eq("courses.slug", courseSlug);

  if (error || !data) {
    console.warn("[repo] getCurriculumOutline failed:", error);
    return [];
  }

  // Fetch all progress summaries in parallel per module to decide ticks.
  const phases = data
    .slice()
    .sort((a, b) => (a.order as number) - (b.order as number));
  const result: CurriculumPhase[] = [];

  for (const phase of phases) {
    const mods = ((phase as unknown as { modules: Array<Record<string, unknown>> })
      .modules ?? []) as Array<Record<string, unknown>>;
    const enriched = await Promise.all(
      mods
        .slice()
        .sort((a, b) => {
          const an = String(a.number ?? "");
          const bn = String(b.number ?? "");
          return an.localeCompare(bn, undefined, { numeric: true });
        })
        .map(async (m) => {
          const base = dbModuleToMock(m);
          const prog = await getModuleProgressSummary(base.slug);
          const lessons = (m.lessons as Array<{ title: string }> | null) ?? [];
          const isComplete =
            base.status === "complete" ||
            (prog.totalSteps > 0 &&
              isLessonCompleteFromProgress(prog));
          return {
            ...base,
            lessonTitles: lessons.map((l) => l.title),
            complete: isComplete,
            totalSteps: prog.totalSteps,
            completedSteps: prog.completedStepOrders.length,
          };
        }),
    );

    const completeCount = enriched.filter((m) => m.complete).length;
    result.push({
      id: phase.id as string,
      order: phase.order as number,
      title: phase.title as string,
      locked:
        enriched.length > 0 && enriched.every((m) => m.status === "not-started"),
      moduleCount: enriched.length,
      completeCount,
      modules: enriched,
    });
  }
  return result;
}

async function getPhaseLabelForModule(
  moduleSlug?: string,
): Promise<string | null> {
  if (!moduleSlug || !isSupabaseConfigured()) return null;
  try {
    const supabase = await createClient();
    const { data } = await supabase
      .from("modules")
      .select(`phases ( "order", title )`)
      .eq("slug", moduleSlug)
      .maybeSingle();
    const phase = (data as { phases?: { order: number; title: string } } | null)
      ?.phases;
    if (!phase) return null;
    return `Phase ${phase.order} · ${phase.title}`;
  } catch {
    return null;
  }
}

// Keep this helper inline to avoid circular imports with lib/progress.ts.
function isLessonCompleteFromProgress(p: {
  totalSteps: number;
  completedStepOrders: number[];
}): boolean {
  if (p.totalSteps === 0) return true;
  return p.completedStepOrders.length / p.totalSteps >= 0.8;
}

// ─── Experiments (per-user) ──────────────────────────────────────────
// Uses the service-role client (RLS bypass) because single-user mode has no
// session. Scope-by-user is enforced explicitly with .eq('user_id', ...).
export async function getExperiments(): Promise<Experiment[]> {
  if (!isSupabaseConfigured()) return EXPERIMENTS;

  try {
    const admin = createServiceClient();
    const userId = await getCurrentUserId();
    const { data, error } = await admin
      .from("experiments")
      .select(
        `id, title, observation, created_at, courses ( slug, title )`,
      )
      .eq("user_id", userId)
      .order("created_at", { ascending: false });
    if (error) throw error;
    if (!data || data.length === 0) return []; // empty state
    return data.map((row) =>
      dbExperimentToMock(row as Record<string, unknown>),
    );
  } catch (err) {
    console.warn("[repo] getExperiments falling back to mock:", err);
    return EXPERIMENTS;
  }
}

/** Course-scoped experiments for the course page feed. */
export async function getExperimentsForCourse(
  courseSlug: string,
): Promise<Experiment[]> {
  if (!isSupabaseConfigured()) return EXPERIMENTS;
  try {
    const admin = createServiceClient();
    const userId = await getCurrentUserId();
    const { data, error } = await admin
      .from("experiments")
      .select(
        `id, title, observation, created_at, courses!inner ( slug, title )`,
      )
      .eq("user_id", userId)
      .eq("courses.slug", courseSlug)
      .order("created_at", { ascending: false });
    if (error) throw error;
    if (!data) return [];
    return data.map((row) =>
      dbExperimentToMock(row as Record<string, unknown>),
    );
  } catch (err) {
    console.warn("[repo] getExperimentsForCourse failed:", err);
    return [];
  }
}

function dbExperimentToMock(row: Record<string, unknown>): Experiment {
  const course = row.courses as { slug?: string; title?: string } | null;
  return {
    id: row.id as string,
    title: row.title as string,
    observation: (row.observation as string) ?? "",
    createdAt: new Date(row.created_at as string).toISOString().slice(0, 10),
    courseSlug: course?.slug,
    courseTitle: course?.title,
  };
}
