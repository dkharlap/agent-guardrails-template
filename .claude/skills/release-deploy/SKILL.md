---
name: release-deploy
description: Cut a release and deploy it, following this project's release checklist and rollback plan. Use when the user asks to release, deploy, ship, or cut a version.
disable-model-invocation: true
---

# Release / deploy

This is invoked explicitly with `/release-deploy` rather than triggered
automatically — deploys shouldn't happen because a description loosely matched.
Fill in the bracketed commands for your actual pipeline.

## Pre-flight checklist

1. Confirm target environment (staging/production) with the user if ambiguous.
2. Confirm the branch is up to date with `main` and CI is green:
   `[e.g., gh pr checks, or gh run list --branch main]`.
3. Confirm no unresolved items in `LESSONS_LEARNED.md` flag this release as risky.
4. Check for pending migrations that need to run as part of this release.

## Release steps

1. Bump version: `[e.g., npm version minor / bump changelog]`.
2. Generate/update the changelog from merged PRs since the last tag.
3. Tag the release: `[e.g., git tag vX.Y.Z && git push --tags]`.
4. Trigger the deploy: `[e.g., gh workflow run deploy.yml -f env=production]`.
5. Watch the deploy until it reports healthy: `[e.g., check the pipeline status / health endpoint]`.
6. Smoke-test the critical paths in the target environment:
   `[e.g., login, checkout, the top 3 user flows]`.

## Rollback plan

State this explicitly before deploying, not after something breaks:

- Rollback command: `[e.g., gh workflow run rollback.yml -f version=<previous>]`.
- If the release included a migration, confirm whether the rollback needs a
  down-migration too, or whether the schema change is backward-compatible.
- Who to notify if a rollback happens: `[e.g., #incidents channel]`.

## After release

- Confirm the deploy in the team's tracking location (changelog, release notes,
  ticket).
- If anything went differently than expected, add an entry to
  `LESSONS_LEARNED.md`.
