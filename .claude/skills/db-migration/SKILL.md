---
name: db-migration
description: Write, test, and roll back a database migration following this project's conventions. Use when the user asks to change the database schema, add a table/column, or write a migration.
---

# Database migration

Replace the bracketed tool-specific details with your actual migration tool
(Prisma, Alembic, Rails migrations, Flyway, raw SQL, etc.).

## Steps

1. **Never edit an already-applied migration file.** Always create a new one.
2. **Generate the migration** using the project's tool: `[e.g., pnpm prisma migrate dev --name <description>]`.
3. **Write the down-migration / rollback path** if the tool supports it. If it
   doesn't, document manually how to reverse the change.
4. **Check for destructive operations** — dropping a column, changing a type,
   removing a constraint. If the migration is destructive:
   - Confirm with the user before running it against anything but a local/dev
     database.
   - Prefer a two-step migration (add new → backfill → remove old in a later
     migration) over a single destructive step on tables with production data.
5. **Backfill data** in a separate step from the schema change when adding a
   required column to an existing table with rows.
6. **Test the migration** by running it up, then down, then up again locally.
7. **Update the ORM models / types** to match the new schema so the rest of the
   codebase doesn't drift out of sync.
8. **Never run migrations directly against production** from this session —
   that goes through `[e.g., the CI/CD pipeline / the release skill]`.

## Report back

State exactly what schema changed, whether it's reversible, and whether a
backfill or a follow-up cleanup migration is needed.
