#!/bin/bash
# Runs tests related to the file Claude just edited, so regressions surface
# immediately instead of at PR time. Registered as a PostToolUse hook.
#
# This is intentionally a *related* test run, not the full suite — running
# everything on every edit is usually too slow to be worth it. Point
# TEST_CMD at whatever your project's "run tests for this file" command is.
# If your test runner can't do this, leave this hook out of settings.json
# and rely on CI instead.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[[ -z "$FILE_PATH" || ! -f "$FILE_PATH" ]] && exit 0

# Example for a JS/TS project using vitest/jest with colocated tests:
# npx vitest related "$FILE_PATH" --run 2>&1 | tail -n 30

# Example for pytest with a mirrored tests/ directory:
# pytest -q "$(echo "$FILE_PATH" | sed 's/^src/tests/; s/\.py$/_test.py/')" 2>&1 | tail -n 30

exit 0
