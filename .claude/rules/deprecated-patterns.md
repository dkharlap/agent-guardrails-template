# Deprecated and forbidden patterns

No `paths:` frontmatter — this loads for every session, so keep it short and
prune it. Delete an entry once the old pattern has actually disappeared from
the codebase; a stale "don't do X" costs context for no benefit.

| Don't use | Use instead | Why |
|---|---|---|
| `[e.g., moment.js]` | `[e.g., date-fns / native Temporal]` | [e.g., unmaintained, large bundle size] |
| `[e.g., npm / yarn]` | `[e.g., pnpm]` | [e.g., workspace consistency, lockfile conflicts] |
| `[e.g., raw SQL strings in app code]` | `[e.g., the query builder in src/lib/db.ts]` | [e.g., no injection protection, no type safety] |
| `[e.g., class components in React]` | `[e.g., function components + hooks]` | [e.g., codebase migrated in 2025, mixing styles confuses reviewers] |
| `[e.g., console.log for app logging]` | `[e.g., the logger in src/lib/logger.ts]` | [e.g., no structured fields, not shipped to log aggregator] |

Add a row whenever the team explicitly decides "we don't do that anymore" —
this is the fastest way to stop Claude from resurrecting a pattern a past
teammate already fought to remove. Include the reason; "why" is what keeps
the rule from being re-litigated every few months.
