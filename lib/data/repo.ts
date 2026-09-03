// Unified server-side read API. Uses Neon when DATABASE_URL is configured and
// falls back to typed mock data so the app still renders before setup.

import { database, isDatabaseConfigured } from "@/lib/db";
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

type DbModule = {
  slug: string;
  number: string;
  title: string;
  kind: Module["kind"];
  status: string;
  estimated_minutes: number;
  summary: string | null;
};

function dbModuleToMock(row: DbModule): Module {
  return {
    slug: row.slug,
    number: row.number,
    title: row.title,
    kind: row.kind,
    status:
      row.status === "not_started"
        ? "not-started"
        : row.status === "in_progress"
          ? "in-progress"
          : (row.status as Module["status"]),
    estimatedMinutes: row.estimated_minutes ?? 20,
    summary: row.summary ?? "",
  };
}

function mockCourses(): CourseSummary[] {
  const modules = PHASE_ONE_MODULES;
  const complete = modules.filter((module) => module.status === "complete").length;
  const next =
    modules.find((module) => module.status === "in-progress") ??
    modules.find((module) => module.status !== "complete") ??
    null;
  return [{
    slug: "arduino-electronics-trainer",
    title: "Arduino Electronics Trainer",
    description:
      "Zero-to-IoT curriculum for web developers. Learn electronics from scratch with hands-on, measurement-driven tutorials.",
    moduleCount: modules.length,
    completeCount: complete,
    percent: Math.round((complete / modules.length) * 100),
    continueModule: next,
    currentPhaseLabel: next ? "Phase 1 · Foundations" : null,
  }];
}

export async function getModulesForCourse(courseSlug: string): Promise<Module[]> {
  if (!isDatabaseConfigured()) return PHASE_ONE_MODULES;
  try {
    const rows = (await database()`
      select m.slug, m.number, m.title, m.kind, m.status,
             m.estimated_minutes, m.summary
        from public.modules m
        join public.phases p on p.id = m.phase_id
        join public.courses c on c.id = p.course_id
       where c.slug = ${courseSlug}
       order by p."order", m."order"
    `) as unknown as DbModule[];
    return rows.map(dbModuleToMock);
  } catch (error) {
    console.warn("[repo] getModulesForCourse falling back to mock:", error);
    return PHASE_ONE_MODULES;
  }
}

/** @deprecated prefer getModulesForCourse("arduino-electronics-trainer"). */
export async function getPhaseOneModules(): Promise<Module[]> {
  return getModulesForCourse("arduino-electronics-trainer");
}

export async function getModuleBySlug(slug: string): Promise<Module | null> {
  if (!isDatabaseConfigured()) {
    return PHASE_ONE_MODULES.find((module) => module.slug === slug) ?? null;
  }
  try {
    const [row] = (await database()`
      select slug, number, title, kind, status, estimated_minutes, summary
        from public.modules
       where slug = ${slug}
       limit 1
    `) as unknown as DbModule[];
    return row ? dbModuleToMock(row) : null;
  } catch (error) {
    console.warn("[repo] getModuleBySlug falling back to mock:", error);
    return PHASE_ONE_MODULES.find((module) => module.slug === slug) ?? null;
  }
}

type DbComponent = {
  slug: string;
  name: string;
  category: ComponentCategory;
  blurb: string;
  status: string;
};

export async function getComponents(): Promise<ComponentCard[]> {
  if (!isDatabaseConfigured()) return COMPONENTS;
  try {
    const rows = (await database()`
      select slug, name, category, blurb, status from public.components
    `) as unknown as DbComponent[];
    return mapComponents(rows);
  } catch (error) {
    console.warn("[repo] getComponents falling back to mock:", error);
    return COMPONENTS;
  }
}

export async function getComponentBySlug(
  slug: string,
): Promise<ComponentCard | null> {
  const all = await getComponents();
  return all.find((component) => component.slug === slug) ?? null;
}

export async function getComponentsForModule(
  moduleSlug: string,
): Promise<ComponentCard[]> {
  if (!isDatabaseConfigured()) return COMPONENTS;
  try {
    const rows = (await database()`
      select c.slug, c.name, c.category, c.blurb, c.status
        from public.lesson_components lc
        join public.components c on c.slug = lc.component_slug
        join public.lessons l on l.id = lc.lesson_id
        join public.modules m on m.id = l.module_id
       where m.slug = ${moduleSlug}
       order by lc."order"
    `) as unknown as DbComponent[];
    return mapComponents(rows, false);
  } catch (error) {
    console.warn("[repo] getComponentsForModule failed:", error);
    return [];
  }
}

function mapComponents(rows: DbComponent[], sortByMock = true): ComponentCard[] {
  const iconBySlug = new Map(COMPONENTS.map((component) => [component.slug, component.icon]));
  const orderBySlug = new Map(COMPONENTS.map((component, index) => [component.slug, index]));
  const mapped = rows.map<ComponentCard>((row) => ({
    slug: row.slug,
    name: row.name,
    category: row.category,
    blurb: row.blurb,
    status:
      row.status === "complete"
        ? "done"
        : row.status === "not_started"
          ? "remaining"
          : "locked",
    icon: iconBySlug.get(row.slug) ?? COMPONENTS[0].icon,
  }));
  return sortByMock
    ? mapped.sort(
        (a, b) => (orderBySlug.get(a.slug) ?? 99) - (orderBySlug.get(b.slug) ?? 99),
      )
    : mapped;
}

type DbStep = {
  id: string;
  order: number;
  instruction: string;
  expected_measurement: string | null;
  completed_at: Date | string | null;
  self_report: string | null;
};

export async function getLessonForModule(
  moduleSlug: string,
): Promise<(LessonContent & { lessonId?: string }) | null> {
  if (!isDatabaseConfigured()) return LESSONS[moduleSlug] ?? null;
  try {
    const sql = database();
    const [lesson] = (await sql`
      select l.id, l.title, l.body_md
        from public.lessons l
        join public.modules m on m.id = l.module_id
       where m.slug = ${moduleSlug}
       order by l."order"
       limit 1
    `) as unknown as Array<{ id: string; title: string; body_md: string | null }>;
    if (!lesson) return null;

    const userId = await getCurrentUserId();
    const [stepRows, safetyRows] = await Promise.all([
      sql`
        select s.id, s."order", s.instruction, s.expected_measurement,
               p.completed_at, p.self_report ->> 'text' as self_report
          from public.hands_on_steps s
          left join public.progress p
            on p.step_id = s.id
           and p.lesson_id = s.lesson_id
           and p.user_id = ${userId}
         where s.lesson_id = ${lesson.id}
         order by s."order"
      `,
      sql`
        select "order", kind, message
          from public.lesson_safety
         where lesson_id = ${lesson.id}
         order by "order"
      `,
    ]);
    const steps = (stepRows as unknown as DbStep[]).map<HandsOnStep>((step) => ({
      id: step.id,
      order: step.order,
      instruction: step.instruction,
      expected: step.expected_measurement ?? undefined,
      completedAt:
        step.completed_at instanceof Date
          ? step.completed_at.toISOString()
          : step.completed_at,
      selfReport: step.self_report,
    }));
    return {
      lessonId: lesson.id,
      moduleSlug,
      title: lesson.title,
      body: lesson.body_md ?? "",
      handsOn: steps,
      safety: (safetyRows as unknown as Array<{
        kind: "danger" | "caution" | "info";
        message: string;
      }>).map(({ kind, message }) => ({ kind, message })),
    };
  } catch (error) {
    console.warn("[repo] getLessonForModule falling back to mock:", error);
    return LESSONS[moduleSlug] ?? null;
  }
}

export async function getModuleProgressSummary(
  moduleSlug: string,
): Promise<{ totalSteps: number; completedStepOrders: number[] }> {
  if (!isDatabaseConfigured()) return { totalSteps: 0, completedStepOrders: [] };
  try {
    const userId = await getCurrentUserId();
    const rows = (await database()`
      select s."order", p.completed_at is not null as complete
        from public.hands_on_steps s
        join public.lessons l on l.id = s.lesson_id
        join public.modules m on m.id = l.module_id
        left join public.progress p
          on p.step_id = s.id
         and p.lesson_id = s.lesson_id
         and p.user_id = ${userId}
       where m.slug = ${moduleSlug}
       order by s."order"
    `) as unknown as Array<{ order: number; complete: boolean }>;
    return {
      totalSteps: rows.length,
      completedStepOrders: rows.filter((row) => row.complete).map((row) => row.order),
    };
  } catch (error) {
    console.warn("[repo] getModuleProgressSummary failed:", error);
    return { totalSteps: 0, completedStepOrders: [] };
  }
}

export interface CourseSummary {
  slug: string;
  title: string;
  description: string;
  moduleCount: number;
  completeCount: number;
  percent: number;
  continueModule: Module | null;
  currentPhaseLabel: string | null;
}

export async function getCourses(): Promise<CourseSummary[]> {
  if (!isDatabaseConfigured()) return mockCourses();
  try {
    const courses = (await database()`
      select slug, title, description from public.courses order by created_at
    `) as unknown as Array<{ slug: string; title: string; description: string | null }>;
    return Promise.all(
      courses.map(async (course) => {
        const modules = await getModulesForCourse(course.slug);
        const complete = modules.filter((module) => module.status === "complete").length;
        const next =
          modules.find((module) => module.status === "in-progress") ??
          modules.find((module) => module.status !== "complete") ??
          null;
        let continueModule = next;
        if (next) {
          const progress = await getModuleProgressSummary(next.slug);
          if (progress.totalSteps > 0 && isLessonCompleteFromProgress(progress)) {
            const index = modules.findIndex((module) => module.slug === next.slug);
            continueModule =
              modules.slice(index + 1).find((module) => module.status !== "complete") ?? next;
          }
        }
        const moduleCount = modules.length;
        return {
          slug: course.slug,
          title: course.title,
          description: course.description ?? "",
          moduleCount,
          completeCount: complete,
          percent: moduleCount ? Math.round((complete / moduleCount) * 100) : 0,
          continueModule,
          currentPhaseLabel: await getPhaseLabelForModule(continueModule?.slug),
        } satisfies CourseSummary;
      }),
    );
  } catch (error) {
    console.warn("[repo] getCourses falling back to mock:", error);
    return mockCourses();
  }
}

export async function getCourseForModule(
  moduleSlug: string,
): Promise<{ slug: string; title: string } | null> {
  if (!isDatabaseConfigured()) {
    return { slug: "arduino-electronics-trainer", title: "Arduino Electronics Trainer" };
  }
  try {
    const [course] = (await database()`
      select c.slug, c.title
        from public.modules m
        join public.phases p on p.id = m.phase_id
        join public.courses c on c.id = p.course_id
       where m.slug = ${moduleSlug}
       limit 1
    `) as unknown as Array<{ slug: string; title: string }>;
    return course ?? null;
  } catch {
    return null;
  }
}

export async function getCourseBySlug(
  slug: string,
): Promise<{ slug: string; title: string; description: string } | null> {
  if (!isDatabaseConfigured()) {
    return slug === "arduino-electronics-trainer"
      ? {
          slug,
          title: "Arduino Electronics Trainer",
          description:
            "Zero-to-IoT curriculum for web developers. Learn electronics from scratch with hands-on, measurement-driven tutorials.",
        }
      : null;
  }
  const [course] = (await database()`
    select slug, title, coalesce(description, '') as description
      from public.courses
     where slug = ${slug}
     limit 1
  `) as unknown as Array<{ slug: string; title: string; description: string }>;
  return course ?? null;
}

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

type OutlineRow = {
  phase_id: string;
  phase_order: number;
  phase_title: string;
  module_id: string | null;
  slug: string | null;
  number: string | null;
  title: string | null;
  kind: Module["kind"] | null;
  status: string | null;
  estimated_minutes: number | null;
  summary: string | null;
  lesson_title: string | null;
};

export async function getCurriculumOutline(
  courseSlug: string,
): Promise<CurriculumPhase[]> {
  if (!isDatabaseConfigured()) {
    return [{
      id: "phase-1",
      order: 1,
      title: "Foundations",
      locked: false,
      moduleCount: PHASE_ONE_MODULES.length,
      completeCount: PHASE_ONE_MODULES.filter((module) => module.status === "complete").length,
      modules: PHASE_ONE_MODULES.map((module) => ({
        ...module,
        lessonTitles: [],
        complete: module.status === "complete",
        totalSteps: 0,
        completedSteps: 0,
      })),
    }];
  }
  try {
    const rows = (await database()`
      select p.id as phase_id, p."order" as phase_order, p.title as phase_title,
             m.id as module_id, m.slug, m.number, m.title, m.kind, m.status,
             m.estimated_minutes, m.summary, l.title as lesson_title
        from public.phases p
        join public.courses c on c.id = p.course_id
        left join public.modules m on m.phase_id = p.id
        left join public.lessons l on l.module_id = m.id
       where c.slug = ${courseSlug}
       order by p."order", m."order", l."order"
    `) as unknown as OutlineRow[];
    const phases = new Map<
      string,
      {
        id: string;
        order: number;
        title: string;
        modules: Map<string, { row: DbModule; lessons: string[] }>;
      }
    >();
    for (const row of rows) {
      const phase = phases.get(row.phase_id) ?? {
        id: row.phase_id,
        order: row.phase_order,
        title: row.phase_title,
        modules: new Map(),
      };
      phases.set(row.phase_id, phase);
      if (!row.module_id || !row.slug || !row.number || !row.title || !row.kind || !row.status) continue;
      const moduleEntry = phase.modules.get(row.module_id) ?? {
        row: {
          slug: row.slug,
          number: row.number,
          title: row.title,
          kind: row.kind,
          status: row.status,
          estimated_minutes: row.estimated_minutes ?? 20,
          summary: row.summary,
        },
        lessons: [],
      };
      phase.modules.set(row.module_id, moduleEntry);
      if (row.lesson_title) moduleEntry.lessons.push(row.lesson_title);
    }
    const result: CurriculumPhase[] = [];
    for (const phase of phases.values()) {
      const enriched = await Promise.all(
        [...phase.modules.values()].map(async ({ row, lessons }) => {
          const moduleRow = dbModuleToMock(row);
          const progress = await getModuleProgressSummary(moduleRow.slug);
          const complete =
            moduleRow.status === "complete" ||
            (progress.totalSteps > 0 && isLessonCompleteFromProgress(progress));
          return {
            ...moduleRow,
            lessonTitles: lessons,
            complete,
            totalSteps: progress.totalSteps,
            completedSteps: progress.completedStepOrders.length,
          };
        }),
      );
      result.push({
        id: phase.id,
        order: phase.order,
        title: phase.title,
        locked:
          enriched.length > 0 && enriched.every((item) => item.status === "not-started"),
        moduleCount: enriched.length,
        completeCount: enriched.filter((item) => item.complete).length,
        modules: enriched,
      });
    }
    return result;
  } catch (error) {
    console.warn("[repo] getCurriculumOutline failed:", error);
    return [];
  }
}

async function getPhaseLabelForModule(moduleSlug?: string): Promise<string | null> {
  if (!moduleSlug || !isDatabaseConfigured()) return null;
  try {
    const [phase] = (await database()`
      select p."order", p.title
        from public.modules m
        join public.phases p on p.id = m.phase_id
       where m.slug = ${moduleSlug}
       limit 1
    `) as unknown as Array<{ order: number; title: string }>;
    return phase ? `Phase ${phase.order} · ${phase.title}` : null;
  } catch {
    return null;
  }
}

function isLessonCompleteFromProgress(progress: {
  totalSteps: number;
  completedStepOrders: number[];
}): boolean {
  if (progress.totalSteps === 0) return true;
  return progress.completedStepOrders.length / progress.totalSteps >= 0.8;
}

type ExperimentRow = {
  id: string;
  title: string;
  observation: string | null;
  created_at: Date | string;
  course_slug: string | null;
  course_title: string | null;
};

export async function getExperiments(): Promise<Experiment[]> {
  if (!isDatabaseConfigured()) return EXPERIMENTS;
  try {
    const userId = await getCurrentUserId();
    return (await experimentRows(userId)).map(dbExperimentToMock);
  } catch (error) {
    console.warn("[repo] getExperiments falling back to mock:", error);
    return EXPERIMENTS;
  }
}

export async function getExperimentsForCourse(courseSlug: string): Promise<Experiment[]> {
  if (!isDatabaseConfigured()) return EXPERIMENTS;
  try {
    const userId = await getCurrentUserId();
    return (await experimentRows(userId, courseSlug)).map(dbExperimentToMock);
  } catch (error) {
    console.warn("[repo] getExperimentsForCourse failed:", error);
    return [];
  }
}

async function experimentRows(userId: string, courseSlug?: string): Promise<ExperimentRow[]> {
  const sql = database();
  return (courseSlug
    ? await sql`
        select e.id, e.title, e.observation, e.created_at,
               c.slug as course_slug, c.title as course_title
          from public.experiments e
          join public.courses c on c.id = e.course_id
         where e.user_id = ${userId} and c.slug = ${courseSlug}
         order by e.created_at desc
      `
    : await sql`
        select e.id, e.title, e.observation, e.created_at,
               c.slug as course_slug, c.title as course_title
          from public.experiments e
          left join public.courses c on c.id = e.course_id
         where e.user_id = ${userId}
         order by e.created_at desc
      `) as unknown as ExperimentRow[];
}

function dbExperimentToMock(row: ExperimentRow): Experiment {
  const createdAt = row.created_at instanceof Date ? row.created_at : new Date(row.created_at);
  return {
    id: row.id,
    title: row.title,
    observation: row.observation ?? "",
    createdAt: createdAt.toISOString().slice(0, 10),
    courseSlug: row.course_slug ?? undefined,
    courseTitle: row.course_title ?? undefined,
  };
}
