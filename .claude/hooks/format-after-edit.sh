#!/bin/bash
# Auto-formats a file after Claude edits it. Registered as a PostToolUse hook.
# Dispatches by extension — wire in your project's real formatters below and
# delete the languages you don't use.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[[ -z "$FILE_PATH" || ! -f "$FILE_PATH" ]] && exit 0

case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md)
    npx --no-install prettier --write "$FILE_PATH" 2>/dev/null
    ;;
  *.py)
    black --quiet "$FILE_PATH" 2>/dev/null
    ;;
  *.go)
    gofmt -w "$FILE_PATH" 2>/dev/null
    ;;
  *.rs)
    rustfmt "$FILE_PATH" 2>/dev/null
    ;;
esac

exit 0
