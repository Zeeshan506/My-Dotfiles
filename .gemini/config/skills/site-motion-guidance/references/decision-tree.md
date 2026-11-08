# Decision Tree & Ambiguity Resolution

This document outlines the step-by-step decision logic when evaluating, recommending, or implementing motion for any component.

---

## 1. Target Evaluation Workflow

When presented with a component or request to add/adjust animation, follow this deterministic decision flow:

```
                  ┌──────────────────────────────┐
                  │   Inspect Target Component   │
                  └──────────────┬───────────────┘
                                 │
         ┌───────────────────────┼────────────────────────┐
         ▼                       ▼                        ▼
  Variant A Path          Variant B Path           Shared / Unknown
  (e.g. variant-a/)       (e.g. variant-b/)        (e.g. shared/, ambiguous)
         │                       │                        │
         ▼                       ▼                        ▼
  Apply Expressive         Apply Calm            Follow Ambiguity Protocol
  Profile (2D Cutout)      Editorial Profile     (Check Context or Ask User)
```

---

## 2. Path 1: Variant A Target

If the component resides in `resources/views/components/variant-a/` or is explicitly designated for Variant A:

1. **Select Profile**: Apply the **Expressive / 2D Cutout** profile.
2. **Assign Semantic Hooks**:
   - Eyebrows, badges, labels: `data-motion="rise"` or `data-motion="fade"`.
   - Main headings: `data-motion="headline"`.
   - Descriptive text: `data-motion="copy"`.
   - Treatment cards, review cards: `data-motion="card"` or `data-motion="review"`.
   - Cutouts, photos, hero visuals: `data-motion="image"`.
   - Buttons, links, CTAs: `data-motion="action" data-motion-interactive`.
   - Dividers or progressive lines: `data-motion="mask"`.
3. **Staggers**: Wrap related collections in `data-motion-stagger="80"`.
4. **Interactive**: Add `data-motion-interactive` to cards and buttons to trigger the expressive hover elevation (`translateY(-2px)`) and press response (`scale(0.985)`).

---

## 3. Path 2: Variant B Target

If the component resides in `resources/views/components/variant-b/` or is explicitly designated for Variant B:

1. **Select Profile**: Apply the **Calm / Editorial** profile.
2. **Assign Semantic Hooks**:
   - Eyebrows, numerals, section counters: `data-motion="rise"` with minimal travel (10px).
   - Editorial headings: `data-motion="headline"` (12px travel, 720ms duration).
   - Editorial text: `data-motion="copy"` (10px travel, 620ms duration).
   - Architectural cards, service rows: `data-motion="card"` (12px travel, no hover elevation).
   - Full-bleed photos, framed images: `data-motion="image"` (clip-path mask + 1.02 scale).
   - Buttons, CTAs: `data-motion="action" data-motion-interactive`.
   - Hairlines, timeline progression: `data-motion="timeline"` or `data-motion="mask"`.
3. **Staggers**: Wrap related collections in `data-motion-stagger="100"`.
4. **Interactive**: Add `data-motion-interactive`. Verify that hover elevation is suppressed (`transform: none`) and only quiet active press (`scale(0.992)`) or border shifts run.

---

## 4. Path 3: Shared or Ambiguous Target

If the component resides in `resources/views/components/shared/`, is shared across variants (e.g. navigation, footer, switcher, modal), or the context is undefined:

### Check 1: Can Contextual CSS Handle It?
Check if the component can rely on existing semantic classes where the motion behavior automatically adapts based on `[data-motion-profile='editorial']` on `<html>`:
- `resources/js/app.js` automatically selects `editorialMotionProfiles` when `document.documentElement.dataset.motionProfile === 'editorial'`.
- `resources/css/app.css` automatically disables hover lift under `[data-motion-profile='editorial'] [data-motion-interactive]:hover { transform: none; }`.

If standard semantic hooks (`data-motion="card"`, `data-motion-interactive`) satisfy both variants through this built-in mechanism, proceed with standard hooks.

### Check 2: Does It Require Distinct Markup or Motion per Variant?
If the component requires fundamentally different choreography, markup structure, or timing for Variant A vs. Variant B that cannot be handled by the existing engine:
- **Do not guess or pick one style arbitrarily.**
- **Halt and prompt the user** using the standard clarification pattern:
  > "The target component `[component-name]` is shared across both Variant A (Expressive) and Variant B (Calm Editorial). Would you like to:
  > 1. Use standard shared semantic hooks that adapt automatically via `data-motion-profile`?
  > 2. Implement variant-specific conditionals/props?
  > 3. Keep motion neutral/static for this shared element?"

### Check 3: External / Greenfield Context
If the skill is executed in a repository without Variant A or Variant B concepts:
- Present neutral, accessible motion guidance (restrained 12px rises, 400–500ms durations, single IntersectionObserver).
- Inquire about the project's preferred brand motion language before implementing.

---

## 5. Conflict & Escalation Handling

When a requested animation violates core project constraints:

| Requested Effect | Conflict | Compliant Alternative |
|---|---|---|
| Continuous loop / pulse / float | Violates "settle into stable state" rule; causes cognitive fatigue. | Animate entrance once on scroll; use subtle micro-interaction on hover/focus only. |
| Endless marquee carousel | Violates manual-first review control and accessibility standards. | Horizontal scroll snap with accessible previous/next buttons and manual drag. |
| Gradient animation | Violates strict "no gradients" design system rule. | Solid warm-stone backgrounds with subtle border or contrast tone shift. |
| Card lift on Variant B | Violates calm editorial planar language. | Border hairline shift, subtle surface tint, or text underline. |
| Heavy animation library | Violates vanilla `motion/mini` centralized architecture. | Leverage existing `resources/js/app.js` observer and `data-motion` tokens. |
