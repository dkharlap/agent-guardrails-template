<!-- Root CLAUDE.md — loaded into every session for every engineer on this project.
     Keep this under ~180 lines. If a line only matters for one directory, move it to
     .claude/rules/. If it's a multi-step procedure, move it to .claude/skills/.
     Ask of every line: "If I remove this, will Claude make a mistake?" -->


## Tech stack

- Language: TypeScript 5.x (full-stack)
- Framework: Next.js 16 (App Router) — frontend + API routes
- UI library: `shadcn/ui` (Radix UI + Tailwind CSS) — see `.claude/rules/design-system.md`
- Package manager: pnpm — never npm/yarn
- Database: PostgreSQL via Prisma
- Design system reference: https://ui.shadcn.com/docs/components

## Commands

- Install: `pnpm install`
- Dev server: `pnpm dev`
- Build: `pnpm build`
- Test (all): `pnpm test`
- Test (single file): `pnpm test -- src/path/to/file`
- Lint: `pnpm lint`
- Typecheck: `pnpm typecheck`
- Migrations: `pnpm prisma migrate dev`

## Repo structure

```
/app/             Next.js App Router pages and API routes
/components/      Reusable UI components — must use shadcn/ui (see components/ui/)
/lib/             Shared utilities (db client, helpers)
/prisma/          Prisma schema and migrations
```

See `.claude/rules/` for conventions scoped to specific directories (API design,
security-sensitive paths, etc.) — they load automatically when Claude touches
matching files, so don't duplicate them here.

## Conventions that aren't obvious from the code

- **All UI uses `shadcn/ui` components (Radix UI + Tailwind CSS)**.
  Before planning or building any UI feature, read `.claude/rules/design-system.md`.
  Never hardcode colors or spacing — use Tailwind tokens and CSS variables from `app/globals.css`.
- All dates are stored and compared in UTC; convert to local time only at the presentation layer.
- API routes live under `app/api/` — never put DB/Prisma calls in React components or page components directly.

## Environment and secrets

- Local config lives in `.env.local` (never committed — see `.gitignore`).
- Never print, log, or commit secrets, API keys, or tokens. If you need a secret to
  test something, ask the user or use the `.env.local` mock values.
- `.env`, `.env.*`, and anything under `/secrets` are blocked from automated edits
  by a hook — see `.claude/settings.json`.

## Git workflow

- Branch naming: `<type>/<short-description>` (e.g. `feat/users-list-page`, `fix/edit-form-validation`)
- Commit messages: Conventional Commits — `feat:`, `fix:`, `chore:`, `refactor:`
- Never commit directly to `main`. Open a PR.
- PRs must pass CI (frontend lint + typecheck + tests) and be reviewed by one other person.

## Definition of done

Before considering a change complete:

1. Tests pass locally (`npm test`) and cover the new/changed behavior — at minimum one happy path and one error/edge case.
2. Lint and typecheck are clean (`npm run lint && npm run typecheck`).
3. No secrets, debug logging, or commented-out code left behind.
4. Docs/README updated if behavior or setup changed.
5. All applicable `.claude/rules/` files were followed for every path touched:
   - `api-standards.md` — UUID path param validation, Zod input validation, try/catch around all Prisma calls with error code mapping, correct error response shape
   - `security-sensitive.md` — no PII in logs, input validated at boundary, deletions logged or reversible
   - `design-system.md` — shadcn/ui components only, Tailwind tokens only, responsive breakpoints applied, `table-fixed` on paginated tables
   - `deprecated-patterns.md` — no banned libraries or patterns introduced
6. Check `LESSONS_LEARNED.md` for patterns relevant to what was changed and confirm they were avoided.

## When you're unsure

Prefer asking or proposing a plan over guessing on: schema/migration changes,
anything touching auth/payments/PII, deleting data, or changing a public API
contract. Everything else, use your best judgment and note the assumption you made.

<!-- Maintainer note: review changes to this file like code —
     stale or contradictory instructions are worse than none. -->
