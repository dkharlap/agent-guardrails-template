---
paths:
  - "**/auth/**/*"
  - "**/payments/**/*"
  - "**/billing/**/*"
  - "**/*pii*/**/*"
  - "**/users/**/*"
---

# Security-sensitive path rules

Stricter rules for code that touches authentication, payments, billing, or
personally identifiable information (PII). Adjust the `paths:` globs above to
match your actual auth/payments/PII directories.

- Never log full credentials, tokens, card numbers, or PII. If logging is needed
  for debugging, mask/redact the sensitive fields first.
- All new inputs on these paths get explicit validation and sanitization —
  no exceptions for "internal-only" endpoints.
- Any change to authentication/authorization logic (who can access what) is a
  plan-first change: propose the approach before writing code, and call out the
  security implication explicitly.
- Payment amounts and currency are handled as [e.g., integer cents, never floats].
- Do not add new third-party dependencies on these paths without flagging it —
  the security/compliance review process is heavier here than elsewhere.
- Data deletion (e.g., "delete this user") must be reversible or logged
  (soft-delete / audit trail) unless the user explicitly confirms a hard delete.
- Test coverage on these paths must include negative cases: wrong password,
  expired token, insufficient permissions, malformed payment payload.
