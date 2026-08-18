# Claude team framework

A reusable starter kit of Claude Code context — coding standards, procedures,
guardrails, and reviewers — meant to be copied into every project and then
customized per repo. It implements the 20 items most teams end up needing:
project facts, scoped conventions, repeatable procedures, enforced guardrails,
isolated reviewers, and a place to record lessons learned.

## What's in here and why

| Path | Artifact type | Loads when | Items covered |
|---|---|---|---|
| `CLAUDE.md` | Memory | Every session | Tech stack, commands, repo map, conventions, secrets handling, git workflow, definition of done |
| `CLAUDE.local.md.example` | Memory (personal) | Every session, gitignored | Personal machine-specific preferences |
| `.claude/rules/api-standards.md` | Path-scoped rule | Only when touching `src/api/**` | API design standards |
| `.claude/rules/security-sensitive.md` | Path-scoped rule | Only when touching auth/payments/PII paths | Extra constraints for sensitive code |
| `.claude/rules/deprecated-patterns.md` | Unscoped rule | Every session | Banned libraries/patterns and why |
| `.claude/rules/design-system.md` | Path-scoped rule | Only when touching UI/component/style paths | Configured for Grafana UI (`@grafana/ui` + `@grafana/data` theme tokens, Storybook at developers.grafana.com) and the policy for using it — swap in a different system if this project doesn't use Grafana UI |
| `.claude/skills/design-system-lookup/` | Skill | On request or when relevant | Procedure for consulting `@grafana/ui` source (if installed) or its hosted Storybook before building UI |
| `.claude/skills/feature-scaffolding/` | Skill | On request or when relevant | Add a new endpoint/component/module |
| `.claude/skills/db-migration/` | Skill | On request or when relevant | Write/test/roll back a migration |
| `.claude/skills/add-lesson-learned/` | Skill | On request or when relevant | Add a new lesson learned entry (guides to appropriate category file) |
| `.claude/skills/release-deploy/` | Skill | Only via `/release-deploy` (manual invocation only) | Release checklist + rollback plan |
| `.claude/skills/debug-triage/` | Skill | On request or when relevant | Reproduce/diagnose/bisect a bug |
| `.claude/skills/code-review/` | Skill | On request or when relevant | Self-review checklist before opening a PR |
| `.claude/agents/reviewer.md` | Subagent | Delegated explicitly or proactively after code changes | Independent, isolated code review (checks deprecated patterns and relevant lessons learned) |
| `.claude/agents/research-auditor.md` | Subagent | Delegated for large searches/audits | Dependency audits, log analysis, broad codebase search |
| `.claude/settings.json` + `.claude/hooks/*.sh` | Hooks | Automatically, every matching tool call | Guardrail against editing secrets, auto-format after edits, run related tests |
| `.claude/lessons-learned/INDEX.md` | Reference doc | Read on demand (not auto-loaded) | Index and guide to institutional memory organized by category |
| `.claude/lessons-learned/*.md` | Reference doc (category files) | Read on demand by relevant skills/agent or when investigating | Postmortems and lessons organized by domain (database-schema, testing-qa, performance, security-auth, api-integration, frontend-ui, tooling-cicd, code-quality, process-workflow) |
| `DESIGN_SYSTEM_NOTES.md` | Reference doc (cache) | Read on demand by `design-system-lookup` | Prior lookups of design-system components/tokens, so they aren't re-derived or re-browsed every time |

## Why it's split this way

Every line in `CLAUDE.md` loads into every session for every engineer, whether
it's relevant to their current task or not — so it only holds facts that are
*always* true and cheap to state. Anything that only matters for one part of
the codebase belongs in a path-scoped `.claude/rules/*.md` file instead, which
only loads when Claude actually touches a matching file. Anything that's a
multi-step *procedure* rather than a fact belongs in a skill, which only loads
its full body when invoked. Anything that must happen no matter what the model
decides — blocking a secrets edit, running a formatter — belongs in a hook,
which runs as a deterministic shell command, not a suggestion. And anything
that would flood the main conversation with intermediate output you won't
need later (a full dependency audit, a log dive, an independent review)
belongs in a subagent, which does that work in its own context and hands back
only the summary.

## Adopting this in a new project

1. Copy `CLAUDE.md`, `.claude/`, `CLAUDE.local.md.example`,
   and the `.gitignore` entries into the project root.
2. Open `CLAUDE.md` and replace every `[bracketed placeholder]` — tech stack,
   commands, repo structure, conventions. Delete anything that doesn't apply;
   this file only earns its keep if every line would actually prevent a mistake.
3. Update the `paths:` globs in `.claude/rules/api-standards.md` and
   `security-sensitive.md` to match where this project's API layer and
   sensitive code actually live. If the project has no API layer, delete that
   rule file.
4. Fill in the tool-specific commands in each skill (`feature-scaffolding`,
   `db-migration`, `release-deploy`, `debug-triage`) — the placeholders are
   intentionally generic and need this project's real commands.
5. Wire up `.claude/hooks/format-after-edit.sh` to this project's actual
   formatters, and `.claude/hooks/run-related-tests.sh` to its actual test
   runner (or delete that hook and rely on CI if there's no fast "run related
   tests" command).
6. Adjust `PROTECTED_PATTERNS` in `.claude/hooks/protect-files.sh` for any
   project-specific sensitive paths (infra credentials, prod configs, etc.).
7. Run `chmod +x .claude/hooks/*.sh` if it isn't already executable after copying.
8. `.claude/rules/design-system.md` is currently configured for **Grafana UI**
   (`@grafana/ui`/`@grafana/data`, Storybook at developers.grafana.com). If
   this project uses Grafana UI, just confirm the installed version matches
   what's in `package.json`. If it uses a different design system, replace
   the package/Storybook/source-repo details with that one instead. If this
   project has no design system to follow, delete the rule file and the
   `design-system-lookup` skill.
9. Lessons learned are organized in `.claude/lessons-learned/` by category
   (database-schema, testing-qa, performance, security-auth, api-integration,
   frontend-ui, tooling-cicd, code-quality, process-workflow). Start with
   empty category files; the team will add real entries via the `add-lesson-learned`
   skill as they happen. Customize category names or add new ones to match your
   team's needs.
10. In Claude Code, run `/context` to confirm `CLAUDE.md` loaded, and `/hooks`
    to confirm the hooks registered.

## Keeping it healthy over time

- Give `CLAUDE.md` an owner and review changes to it like code — contradictory
  or stale instructions are worse than no instructions.
- When Claude makes the same mistake twice, that's the signal to add a rule,
  not just a one-off correction in chat.
- Periodically prune `.claude/rules/deprecated-patterns.md` and
  `.claude/lessons-learned/*.md` — remove entries once the underlying pattern
  is gone from the codebase and unlikely to recur. Use the `add-lesson-learned`
  skill to document team insights; each category file stays focused and is only
  loaded when relevant.
- If a `.claude/rules/*.md` file keeps growing, that's usually a sign part of
  it should become a skill instead (a fact vs. a procedure).

## Reference

This structure follows Anthropic's own guidance on when to use CLAUDE.md vs.
rules vs. skills vs. hooks vs. subagents:
<https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more>
and the official Claude Code docs on memory, skills, subagents, and hooks at
<https://code.claude.com/docs/en>.
