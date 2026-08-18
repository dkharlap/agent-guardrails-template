# Code Quality

Lessons about refactoring traps, tool misuse, duplication, architectural debt, and naming/clarity issues.

---

### 2026-08-09 Whole-file rewrites via replace_string_in_file cause duplicate exports

**Context:** When replacing a component file with a substantially different version (e.g. adding sorting, then pagination to `UsersTable.tsx`), `replace_string_in_file` was used with a short `oldString` (e.g. just the first 3 import lines). The tool matched that short string at the top, inserted the new content there, but left the rest of the original file intact below — resulting in two copies of the same exported function/type in a single file.

**Root cause:** `replace_string_in_file` replaces only the exact matched substring, not the whole file. Using a short `oldString` that is a prefix of the file rather than a unique anchor for the section being changed caused the new content to be prepended while the old content remained.

**Fix:** When rewriting a component file wholesale, use `create_file` — it overwrites the entire file. Reserve `replace_string_in_file` for targeted surgical edits (changing one function, fixing one line), where `oldString` uniquely identifies that specific section with sufficient surrounding context.

**Prevention:** Rule of thumb documented in `.claude/reminderInstructions` in the session instructions:
- **Whole-file rewrite → `create_file`**
- **Single-function or single-block edit → `replace_string_in_file`** with at least 3–5 lines of context before and after the target

After any whole-file operation, verify with `grep_search` that exported names appear exactly once.

**Related:** `components/UsersTable.tsx`, `components/UserForm.tsx`, `app/admin/users/page.tsx`, `app/admin/users/[id]/page.tsx`
