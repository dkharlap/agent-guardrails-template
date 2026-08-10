---
name: code-review
description: Review a diff or PR against this project's actual review checklist before it ships. Use when the user asks to review code, check a PR, or self-review before opening one.
---

# Code review

This is the checklist your human reviewers actually apply — turn the
placeholders into your team's real standards, not generic best practices.
For an isolated, unbiased second opinion, prefer delegating to the
`reviewer` subagent (`.claude/agents/reviewer.md`) instead of reviewing in the
same context that wrote the code.

## Checklist

**Correctness**
- Does the diff do what the ticket/description says, and nothing more?
- Are edge cases handled: empty input, null/undefined, concurrent access,
  network failure?

**Consistency**
- Does it follow the conventions in `CLAUDE.md` and the relevant
  `.claude/rules/` file for this path?
- Does it avoid anything listed in `.claude/rules/deprecated-patterns.md`?

**Tests**
- New behavior has a test. Bug fixes have a regression test.
- Tests actually assert something meaningful, not just "doesn't throw."

**Security**
- No secrets, tokens, or PII in code, logs, or test fixtures.
- Input validation present at any boundary the diff touches.
- If the diff touches `.claude/rules/security-sensitive.md` paths, those
  requirements are met.

**Size and clarity**
- Is the diff reviewable (roughly one logical change)? Flag if it should be
  split.
- Are names and comments clear enough that the "why," not just the "what," is
  understandable six months from now.

## Output format

Group findings as **Must fix** / **Should fix** / **Consider** rather than one
flat list — this is what makes a review actionable instead of overwhelming.
