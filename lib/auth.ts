// Single-user local-dev mode: the UUID of the seeded dev row in auth.users
// (see supabase/seed.sql). When real Supabase Auth ships, replace
// `getCurrentUserId()` with `(await supabase.auth.getUser()).data.user?.id`.

export const DEFAULT_USER_ID = "00000000-0000-0000-0000-000000000001";

export async function getCurrentUserId(): Promise<string> {
  return DEFAULT_USER_ID;
}
