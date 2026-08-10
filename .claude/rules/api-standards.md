---
paths:
  - "app/api/**/*"
---

# API development rules

- Every endpoint validates its input before touching business logic. Use Zod schemas — never trust `request.json()` directly.
- **Path parameters that are UUIDs must be validated** with `z.string().uuid()` at the top of the handler before any DB call. Return 400 `{ error: { code: "INVALID_ID", message: "Invalid user ID" } }` on failure.
- Errors returned to clients use the standard shape: `{ "error": { "code": string, "message": string } }`. Never leak stack traces, Prisma error details, or internal state.
- **All Prisma calls must be wrapped in try/catch.** Map known Prisma error codes to HTTP responses: `P2002` (unique constraint) → 409, `P2025` (record not found) → 404. All other errors → 500 with a generic message.
- Pagination and sorting follow the convention in `app/api/users/route.ts` (`page`, `pageSize`, `sortBy`, `sortDir` query params validated via Zod). Don't invent a different scheme.
- Every new or changed endpoint needs at least one happy-path test and one error-path test colocated as `*.test.ts`.
- Auth checks happen at the handler boundary. If an endpoint is intentionally public (no auth), say so explicitly in a comment.
- `params` in Next.js 15 route handlers is a Promise — always `const { id } = await params` before use.
- Breaking changes to a public API contract require a version bump or deprecation path — flag this rather than doing it silently.
