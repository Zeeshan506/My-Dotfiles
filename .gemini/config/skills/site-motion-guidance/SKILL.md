---
name: site-motion-guidance
description: Inspect and guide website animation and motion choreography. Recommends or implements the correct expressive (Variant A) or calm editorial (Variant B) motion profile while enforcing centralized architecture, progressive enhancement, reduced-motion accessibility, and zero-looping constraints.
metadata:
  short-description: Guide website animation and motion choreography
---

# Site Motion Guidance

A durable, inspect-first skill for designing, implementing, and reviewing website animations. It enforces architectural discipline: inspecting existing systems before proposing changes, choosing the correct semantic motion profile, and protecting accessibility.

## 1. Inspect First Workflow

Before proposing or modifying any animation, inspect the target project and component:

1. **Centralized Engine Check**: Verify the centralized motion script (e.g. `resources/js/app.js`) and CSS primitives (e.g. `resources/css/app.css`). Do not introduce separate animation libraries or decentralized inline scripts.
2. **Target Component Context**: Locate the component in the file tree:
   - `resources/views/components/variant-a/` &rarr; Expressive / 2D Cutout profile.
   - `resources/views/components/variant-b/` &rarr; Calm / Editorial profile.
   - `resources/views/components/shared/` or ambiguous &rarr; Follow the [Ambiguity Protocol](#2-profile-selection--ambiguity-protocol).
3. **Existing Hooks Inspection**: Check if the element already contains `data-motion`, `data-motion-delay`, or `data-motion-stagger`. Never attach redundant observers or conflicting styles.
4. **Active Variant & State**: Check `data-motion-profile` on `<html>` or parent containers (`editorial` vs default expressive).

## 2. Profile Selection & Ambiguity Protocol

Never guess or arbitrarily pick an animation style:

- **Variant A Target**: Apply the **Expressive / 2D Cutout** profile. Tactile, layered, directional reveals with short staggers.
- **Variant B Target**: Apply the **Calm / Editorial** profile. Slower, restrained, quiet hierarchy, hairline reveals, soft masks. Never apply card-style elevation.
- **Shared / Ambiguous Target**: If a component is shared between variants (e.g. switcher, shared header/footer, modal):
  1. Check if the element adapts dynamically via `[data-motion-profile='editorial']` in CSS.
  2. If the component requires new variant-specific motion, **halt and ask the user** for direction rather than selecting one arbitrarily.
  3. If used in a neutral context without variants, apply neutral shared guidance and request clarification.

See [Decision Tree](references/decision-tree.md) for detailed routing.

## 3. Semantic Motion Profiles Summary

Detailed token, timing, and easing values are specified in [Motion Profiles](references/profiles.md).

| Attribute | Expressive Profile (Variant A) | Calm Editorial Profile (Variant B) |
|---|---|---|
| **Pacing / Durations** | Fast to standard: 360ms–640ms | Slower, softer: 500ms–820ms |
| **Distances** | 12px–28px directional movement | 8px–12px minimal rise |
| **Easing** | `cubic-bezier(0.16, 1, 0.3, 1)` | `cubic-bezier(0.22, 1, 0.36, 1)` |
| **Stagger (Desktop)** | 50ms–120ms (standard: 80ms) | 60ms–140ms (standard: 100ms) |
| **Stagger (Mobile)** | 0ms (disabled to prevent lag) | 0ms (disabled to prevent lag) |
| **Image Reveals** | Layered tactile rise (28px), settle | Restrained mask (`inset`), scale 1.02 &rarr; 1 |
| **Card / Surface** | 20px rise, hover `translateY(-2px)` | 12px rise, hover `transform: none` |
| **Active Press** | `scale(0.985)` | `scale(0.992)` |
| **Hierarchy Order** | Label &rarr; Heading &rarr; Copy &rarr; Group &rarr; Action | Eyebrow &rarr; Hairline &rarr; Title &rarr; Copy &rarr; Action |

## 4. Mandatory Architectural Safeguards

Every motion change must strictly observe these constraints (details in [Architecture & Safeguards](references/architecture-and-safeguards.md)):

1. **Centralized Ownership**: All motion logic belongs in `resources/js/app.js` using `motion/mini`. Never create inline `<script>` tags, scroll listeners, or secondary observers in templates.
2. **Progressive Enhancement & No-JS Safety**: Content must remain 100% visible and accessible if JavaScript fails or is disabled. Initial hidden states (`motion-pending`) may only take effect after `.motion-ready` is set by JavaScript.
3. **Strict Reduced-Motion Support**: Respect `prefers-reduced-motion: reduce`. All transforms, masks, line-drawing, and stagger delays must be disabled immediately (duration: 0.01ms).
4. **Prohibited Effects**:
   - No continuous loops, floating effects, or marquees.
   - No gradients.
   - No card-elevation hover in Variant B.
   - No layout-shifting transforms or scroll hijacking.
5. **Accessibility & Modularity**:
   - Touch targets must remain &ge; 44x44px.
   - Focus rings (`:focus-visible`) must remain high-contrast and unobstructed.
   - All source and documentation files must remain &le; 300 lines.

## 5. Verification & Review Protocol

When validating or reviewing any motion implementation:

1. **Automated Hygiene**:
   - Run `pnpm check:line-counts` to ensure files stay &le; 300 lines.
   - Run relevant test suites: `php artisan test --compact`.
2. **Playwright Interaction Checks**:
   - **Desktop**: Scroll full page; verify one-time triggers, no repeat flashing, correct easing.
   - **Mobile (375px)**: Confirm staggers are disabled, no horizontal overflow, touch targets &ge; 44px.
   - **Reduced Motion**: Emulate `prefers-reduced-motion: reduce`; verify instant visibility without movement.
   - **No-JS**: Verify full layout and copy visibility with JavaScript disabled.
