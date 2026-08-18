# Lessons learned — Index

Institutional memory organized by category. Add entries using the `add-lesson-learned` skill.

**Important:** This is NOT auto-loaded into every session (unlike CLAUDE.md). Link to specific
category files from CLAUDE.md or relevant skills/instructions when you need context loaded.

---

## Category files

| Category | File | When to check |
|---|---|---|
| **Database & Schema** | [database-schema.md](database-schema.md) | Adding/modifying columns, migrations, data types, constraints |
| **Testing & QA** | [testing-qa.md](testing-qa.md) | Writing tests, test coverage, mocking, edge cases |
| **Performance** | [performance.md](performance.md) | Query optimization, rendering bottlenecks, memory leaks |
| **Security & Auth** | [security-auth.md](security-auth.md) | Auth flows, PII handling, injection risks, tokens |
| **API & Integration** | [api-integration.md](api-integration.md) | API contracts, third-party integrations, versioning |
| **Frontend & UI** | [frontend-ui.md](frontend-ui.md) | Components, state management, styling, accessibility |
| **Tooling & CI/CD** | [tooling-cicd.md](tooling-cicd.md) | Build issues, deployment, GitHub Actions, environment config |
| **Code Quality** | [code-quality.md](code-quality.md) | Refactoring traps, tool misuse, duplication, architecture |
| **Process & Workflow** | [process-workflow.md](process-workflow.md) | Code review, git workflow, communication, team practices |

---

## How to use

- **Add a lesson:** Use the `add-lesson-learned` skill. Choose 1–3 categories, fill in the
  template, and the skill will guide you to the right file(s).
- **Find a lesson:** Search by category (e.g., "What did we learn about migrations?")
  or use `@` imports in skills/rules to load context when relevant.
- **Prune entries:** Remove a lesson once the pattern is fixed everywhere and unlikely
  to recur. Stale warnings clutter context; current prevention rules work better.

---

## Linking from other files

To surface a lesson in a specific context (e.g., auto-load DB lessons when working on
migrations), add to a relevant skill or instruction:

```markdown
**See also:** [Database & Schema](../.claude/lessons-learned/database-schema.md)
```

Or import directly in CLAUDE.md if the lessons are short enough (under 200 lines total).
