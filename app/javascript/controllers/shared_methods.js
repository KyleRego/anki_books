export function parseCSRFTokenFromHTML() {
  return document.querySelector('meta[name="csrf-token"]')?.getAttribute("content") ?? null;
}
