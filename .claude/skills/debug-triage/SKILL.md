---
name: debug-triage
description: Reproduce, diagnose, and bisect a bug in this codebase using the project's actual logging and debug tooling. Use when the user reports a bug, error, or unexpected behavior.
---

# Debug triage

Fill in the bracketed specifics with where logs/traces actually live in this
project — a generic "check the logs" instruction is useless to Claude and to
the next engineer who reads this file.

## Steps

1. **Check for a known pattern first.** Before reproducing, grep
   `LESSONS_LEARNED.md` for keywords from the error message, the affected
   file/feature, or the symptom — e.g. `grep -i "<keyword>" LESSONS_LEARNED.md`.
   If a past entry looks related, treat its root cause and fix as your leading
   hypothesis, but still verify it actually applies rather than assuming a
   keyword match means it's the same bug.
2. **Reproduce first.** Get the exact steps, input, and expected vs. actual
   behavior before changing any code. If you can't reproduce it, say so rather
   than guessing at a fix.
3. **Find the error signal.**
   - Local logs: `[e.g., pnpm dev writes to stdout / logs/app.log]`
   - Production logs/traces: `[e.g., the dashboard at <url>, or `gh` / cloud CLI command]`
   - Error tracking: `[e.g., Sentry project <name>]`
4. **Narrow the blast radius.** Is it one user, one environment, one input
   shape, or everyone? Check recent deploys/migrations around the time it
   started — `git log --oneline --since="<date>"` against the affected paths.
5. **Bisect if the regression is unclear.** Use `git bisect` or compare against
   the last known-good tag/commit rather than reading the whole diff by eye.
6. **Write a failing test that reproduces the bug** before fixing it, so the
   fix is verifiable and the bug can't silently come back.
7. **Fix at the right layer.** Prefer fixing root cause over patching a symptom
   — if the fix is a workaround, say so explicitly and note the real fix as a
   follow-up.
8. **Update `LESSONS_LEARNED.md`.**
   - New, non-obvious bug → add a new entry.
   - Matches an existing entry from step 1 → this is a recurrence despite a
     documented prevention. Don't just re-log it — update that entry's
     "Prevention" section to explain why the original fix didn't hold, and
     consider whether it needs to become a rule or hook instead of a note.

## Escalation

If reproduction requires production data access, credentials, or a system you
don't have access to, stop and ask rather than trying to work around it.
