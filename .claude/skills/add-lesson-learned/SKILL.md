---
name: add-lesson-learned
description: Add a new lesson learned entry to LESSONS_LEARNED.md following the team's template and filtering structure. Use when the user wants to document an incident, bug, or process improvement that taught the team something important.
---

# Add a lesson learned

Lesson learned entries preserve institutional memory—bugs that happen once should
not happen again. This skill helps you write a well-structured entry that will be
easy to filter, find, and act on.

## Filtering headers

Before writing, choose one or more category headers. These help future engineers
quickly find relevant lessons:

- **Database & Schema** — migrations, queries, data integrity, ORM issues
- **Testing & QA** — test coverage gaps, edge cases that escaped, test strategy
- **Performance** — bottlenecks found in production, optimization opportunities
- **Security & Auth** — vulnerabilities, PII leaks, auth/permission oversights
- **API & Integration** — versioning, backwards compatibility, third-party surprises
- **Frontend & UI** — component bugs, state management, rendering traps
- **Tooling & CI/CD** — build failures, deployment issues, environment config
- **Code Quality** — refactoring mishaps, architectural debt, naming/clarity issues
- **Process & Workflow** — code review gaps, communication, pair programming wins

Pick 1–3 that best describe the lesson. This makes it findable via `@LESSONS_LEARNED.md`
searches and `grep_search("# [Category]")`.

## Template

Copy this structure and fill in all five sections:

```markdown
### [YYYY-MM-DD] Short title of what happened
**Category:** [list one or more from above]

**Context:** What were you doing? What broke or went wrong? 1–3 sentences.

**Root cause:** The actual underlying reason — not just the symptom. Why did it happen?

**Fix:** What we changed to resolve it. Code examples OK if they help.

**Prevention:** What now stops this from happening again? This is the **most important** part.
- Added a rule to `.claude/rules/`?
- Added/updated a skill step?
- Added a test?
- Updated `.github/workflows/`?
- Changed a process or added docs?

If the answer is "we'll just remember," that's a sign you need a rule, not a lesson learned.

**Related:** Link to PR, incident ticket, GitHub issue, or affected files.
```

## Steps

1. **Gather the facts** — write down what happened, the symptom, and the root
   cause. If you're unsure of the root cause, ask colleagues or dig through logs
   using the `debug-triage` skill.

2. **Choose 1–3 category headers** from the "Filtering headers" section above.
   This determines which category file(s) your entry goes into:
   - **Database & Schema** → `database-schema.md`
   - **Testing & QA** → `testing-qa.md`
   - **Performance** → `performance.md`
   - **Security & Auth** → `security-auth.md`
   - **API & Integration** → `api-integration.md`
   - **Frontend & UI** → `frontend-ui.md`
   - **Tooling & CI/CD** → `tooling-cicd.md`
   - **Code Quality** → `code-quality.md`
   - **Process & Workflow** → `process-workflow.md`

3. **Fill in all five fields:**
   - **Context** — keep it short; future you will remember the context once you
     read the title.
   - **Root cause** — this is where the insight lives. Be specific.
   - **Fix** — what code or process changed. If it's a code change, link to the PR.
   - **Prevention** — the rule, test, hook, or documented process that prevents
     recurrence. If you can't name a prevention, consider whether this is really
     a lesson learned (vs. just a bug that happened once).
   - **Related** — links to the PR(s), tickets, or file paths involved.

4. **Paste the entry into the appropriate category file** (based on your choices
   in step 2). Files live in `.claude/lessons-learned/`. Add your entry after
   the file header and category description.

5. **Review for clarity** — read it back in 2–3 weeks' perspective. Would you
   understand it then?

## Report back

State:
- The date and title of the new entry
- The category file(s) it was added to
- Any prevention step added to rules/skills (link to the change)
