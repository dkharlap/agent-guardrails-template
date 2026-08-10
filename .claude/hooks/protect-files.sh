#!/bin/bash
# Blocks Edit/Write to protected paths, regardless of what Claude decides.
# Registered as a PreToolUse hook in .claude/settings.json.
# Customize PROTECTED_PATTERNS for this project.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Normalize Windows backslash separators so the patterns below match.
FILE_PATH="${FILE_PATH//\\//}"

PROTECTED_PATTERNS=(
  ".env"
  ".env."
  "package-lock.json"
  "pnpm-lock.yaml"
  ".git/"
  "secrets/"
  "credentials"
  # Add project-specific protected paths, e.g. "infra/prod/" or "*.pem"
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if [[ "$FILE_PATH" == *"$pattern"* ]]; then
    echo "Blocked: $FILE_PATH matches protected pattern '$pattern'. If this edit is intentional, ask the user to make it directly." >&2
    exit 2
  fi
done

exit 0
