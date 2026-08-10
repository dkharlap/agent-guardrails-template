---
name: feature-scaffolding
description: Scaffold a new feature (endpoint, component, or module) following this project's conventions. Use when the user asks to add a new endpoint, page, component, or module.
---

# Feature scaffolding

Follow these steps rather than improvising a structure. Replace the bracketed
specifics with how this project actually organizes code — this file is only
useful once it matches reality.

## Steps

1. **Clarify scope.** Confirm what the feature needs to do, which layer(s) it
   touches (API, UI, background job), and whether it needs a schema/migration.
   If unclear, ask rather than guessing.
2. **Place files where the codebase expects them.**
   - API endpoint: `[e.g., src/api/<resource>/route.ts]`
   - UI component: `[e.g., src/components/<Feature>/<Feature>.tsx]`
   - Business logic: `[e.g., src/lib/<domain>/]`
   - Follow naming conventions already in `CLAUDE.md`.
3. **Add types/schemas first**, then implement, then wire up. Don't write UI
   against untyped data.
4. **Validate inputs** at the boundary (see `.claude/rules/api-standards.md` if
   this touches the API layer).
5. **Write tests** alongside the code — at minimum one happy path and one
   error/edge case. Follow the existing test file naming pattern
   (`[e.g., *.test.ts colocated with the source file]`).
6. **Update docs** if the feature changes setup, adds an env var, or adds a
   public API surface.
7. **Self-review** using `.claude/skills/code-review/SKILL.md` before telling
   the user it's ready.
8. **Report what you built**: files touched, how to try it locally, and
   anything you deliberately left out or assumed.

## Anti-patterns to avoid

- Don't create a new folder structure that doesn't match the existing pattern
  "because it seemed cleaner" — consistency beats local optimization here.
- Don't skip tests "since it's a small feature" — small features are exactly
  what regresses silently later.
