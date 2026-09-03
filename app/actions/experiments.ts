"use server";

// Experiment CRUD actions for the logged experiments page.
import { revalidatePath } from "next/cache";
import { z } from "zod";
import { database } from "@/lib/db";
import { getCurrentUserId } from "@/lib/auth";

const createSchema = z.object({
  courseSlug: z.string().min(1),
  title: z.string().min(1).max(200),
  circuitDescription: z.string().max(2000).optional(),
  observation: z.string().min(1).max(2000),
});

export type CreateExperimentInput = z.infer<typeof createSchema>;

export async function createExperiment(input: CreateExperimentInput) {
  const parsed = createSchema.parse(input);
  const userId = await getCurrentUserId();
  const rows = await database()`
    insert into public.experiments
      (user_id, course_id, title, circuit_description, observation)
    select
      ${userId}, id, ${parsed.title},
      ${parsed.circuitDescription ?? null}, ${parsed.observation}
      from public.courses
     where slug = ${parsed.courseSlug}
    returning id
  `;
  if (!rows.length) throw new Error(`Unknown course: ${parsed.courseSlug}`);

  revalidatePath("/experiments");
  revalidatePath(`/courses/${parsed.courseSlug}`);
  revalidatePath("/");
}
