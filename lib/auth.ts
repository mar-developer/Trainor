// Single-user mode. Replace this fixed identity when real authentication ships.

export const DEFAULT_USER_ID = "00000000-0000-0000-0000-000000000001";

export async function getCurrentUserId(): Promise<string> {
  return DEFAULT_USER_ID;
}
