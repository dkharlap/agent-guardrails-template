<!-- This file is institutional memory, not a changelog. Curate it:
     - Add an entry when a bug or incident taught the team something that isn't
       obvious from the code itself.
     - Prune entries once the pattern is fixed everywhere and unlikely to recur —
       a stale warning is clutter, not safety.
     - This file is NOT auto-loaded into every session (unlike CLAUDE.md). Link to
       it from CLAUDE.md, or `@LESSONS_LEARNED.md`-import it, only if it's short
       enough to stay under the 200-line budget; otherwise let skills/agents Read
       it on demand when relevant (e.g. the debug-triage skill references it). -->

# Lessons learned

### 2026-08-09 Whole-file rewrites via replace_string_in_file cause duplicate exports

**Context:** When replacing a component file with a substantially different version (e.g. adding sorting, then pagination to `UsersTable.tsx`), `replace_string_in_file` was used with a short `oldString` (e.g. just the first 3 import lines). The tool matched that short string at the top, inserted the new content there, but left the rest of the original file intact below — resulting in two copies of the same exported function/type in a single file.

**Root cause:** `replace_string_in_file` replaces only the exact matched substring, not the whole file. Using a short `oldString` that is a prefix of the file rather than a unique anchor for the section being changed caused the new content to be prepended while the old content remained.

**Fix:** When rewriting a component file wholesale, use `create_file` — it overwrites the entire file. Reserve `replace_string_in_file` for targeted surgical edits (changing one function, fixing one line), where `oldString` uniquely identifies that specific section with sufficient surrounding context.

**Prevention:** Rule of thumb now recorded here:
- **Whole-file rewrite → `create_file`**
- **Single-function or single-block edit → `replace_string_in_file`** with at least 3–5 lines of context before and after the target

After any whole-file operation, verify with `grep_search` that exported names appear exactly once.

**Related:** `components/UsersTable.tsx`, `components/UserForm.tsx`, `app/admin/users/page.tsx`, `app/admin/users/[id]/page.tsx`



## Template for a new entry

```
### [YYYY-MM-DD] Short title of what happened

**Context:** What we were doing, what broke or went wrong.

**Root cause:** The actual underlying reason, not just the symptom.

**Fix:** What we changed to resolve it.

**Prevention:** What now stops this from happening again — a rule added to
`.claude/rules/`, a hook, a test, a process change. If the answer is "we'll
just remember," add it as a rule instead; humans and models both forget.

**Related:** Links to the PR/incident/ticket, and affected files.
```

---

### Example entry (delete once you have real ones)

**[2026-01-15] Migration ran against production without a backfill step**

**Context:** Added a required `status` column to `orders`; the migration ran
clean locally (empty table) but failed in production where the table had
rows, because the column had no default.

**Root cause:** The `db-migration` process didn't require a backfill step for
existing rows before adding a `NOT NULL` constraint.

**Fix:** Rolled back, split into two migrations: add nullable column + backfill,
then add the `NOT NULL` constraint in a follow-up migration.

**Prevention:** Added the two-step requirement to
`.claude/skills/db-migration/SKILL.md` step 4.

**Related:** PR #123, incident-045.
