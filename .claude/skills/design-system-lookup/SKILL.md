---
name: design-system-lookup
description: Look up a component, token, or pattern in this project's design system (an installed package and/or a hosted Storybook) before building new UI. Use when implementing, styling, or reviewing UI that should match an existing design system, or when the user references a Storybook, Figma, or component library as the source of truth for design.
---

# Design system lookup

The design system for this project is defined in
`.claude/rules/design-system.md` — fill in its name, package, and/or Storybook
URL there first; this skill is the *procedure* for consulting it, that file is
the *pointer* to what to consult.

## Steps

1. **Check `components/ui/` first.** The shadcn/ui components for this project
   live there as copied source files — read the relevant file directly rather
   than browsing an external site. The source is always the authoritative version.
2. **Check `app/globals.css` and `tailwind.config.ts`** for the available CSS
   variable tokens (`--background`, `--primary`, etc.) and how they map to
   Tailwind color names.
3. **If a component doesn't exist in `components/ui/` yet**, check
   https://ui.shadcn.com/docs/components to see if shadcn/ui provides one.
   If it does, copy its source into `components/ui/` — don't install it as a
   package.
4. **If shadcn/ui has no component for what's needed**, say so explicitly
   rather than inventing a new pattern — flag the gap so the human can decide
   whether to build a custom component or use a plain HTML element with
   Tailwind classes.
5. **Build using what you found.** Import from `components/ui/`. Use Tailwind
   utility classes and the CSS variables from `globals.css` — never hardcode
   hex colors or raw spacing values.

## Common mistake to avoid

Don't assume Tailwind class names work without the corresponding CSS variable
being defined in `globals.css`. Always confirm a token (e.g. `text-primary`,
`bg-muted`) is actually wired up in `globals.css` before using it.
