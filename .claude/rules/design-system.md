---
paths:
  - "components/**/*"
  - "app/**/*.css"
  - "app/**/*.scss"
---

# Design system: shadcn/ui

This project uses **shadcn/ui** — Radix UI primitives styled with Tailwind CSS.

- **Components live in `components/ui/`** — copied from https://ui.shadcn.com/docs/components, not installed as a package.
- **Tailwind tokens only** — never hardcode hex colors, px values, or spacing. Use Tailwind utility classes and the CSS variables defined in `app/globals.css`.
- **CSS variables** for theme tokens (`--background`, `--foreground`, `--primary`, etc.) are defined in `app/globals.css` and map to Tailwind color names via `tailwind.config.ts`.
- **Before building new UI**, check https://ui.shadcn.com/docs/components to see if a component already exists. Copy the source into `components/ui/` rather than installing `@shadcn/ui` directly.
- **Radix UI** handles accessibility and headless behavior — don't replace Radix primitives with plain HTML unless the component genuinely has no interaction.
- **Dark mode** is supported via the `.dark` class on `<html>` — toggle it at the layout level if needed.
- If a component or token doesn't exist in shadcn/ui, note it explicitly rather than inventing a new pattern.

- **Tables with paginated data** must use `table-fixed` with explicit column widths set on `<th>` elements. Without this, the browser recalculates column widths per page based on cell content, causing layout shift on every page change.
- **All UI must be responsive** using Tailwind breakpoint prefixes (`sm:`, `md:`, etc.). Follow this pattern for data-heavy tables: hide lower-priority columns on small screens (`hidden sm:table-cell`, `hidden md:table-cell`), use `overflow-x-auto` on the table wrapper, set a `min-w-*` on the table itself, and use `truncate` on cells with variable-length text. Pagination controls and other multi-element rows should stack with `flex-col` on mobile and `sm:flex-row` on larger screens. Page padding should use `p-4 sm:p-6`.

