# Architecture, Constraints & Safeguards

This document defines the architectural boundaries, accessibility mandates, and validation contracts required for all motion and animation work.

---

## 1. Centralized Motion Engine Contract

All animation logic is centralized in `resources/js/app.js` and `resources/css/app.css`. Never scatter inline `<script>` tags, independent observers, or per-component scroll listeners in Blade templates.

### Semantic Hook System

Components declare motion declaratively using HTML data attributes:

| Attribute | Purpose | Accepted Values / Example |
|---|---|---|
| `data-motion` | Defines the semantic motion token. | `headline`, `copy`, `card`, `image`, `action`, `group`, `rise`, `review`, `fade`, `mask`, `timeline` |
| `data-motion-delay` | Static entrance delay in milliseconds. | `"100"`, `"200"` |
| `data-motion-stagger` | Stagger interval applied to child `[data-motion]` elements. | `"80"`, `"100"` |
| `data-motion-interactive` | Marks interactive elements for hover/press micro-interactions. | Boolean attribute (present or absent) |

### Observer Mechanics

- **Single Observer**: One global `IntersectionObserver` handles all entering content.
- **Pre-viewport Trigger**: Configured with `rootMargin: '0px 0px 12% 0px'` and `threshold: 0.08` so reveals start just before entering view, preventing jarring late pops.
- **Once-Only Execution**: Elements unobserve immediately upon reveal (`observer.unobserve(entry.target)`). Animations never re-trigger on reverse scroll.
- **Cleanup**: In-flight animations cancel and observers disconnect on `pagehide`.

---

## 2. Progressive Enhancement & No-JS Safety

Content must remain 100% visible and accessible if JavaScript is disabled, slow to load, or encounters an unhandled exception:

1. **Default Visibility**: Blade templates render all elements in their standard static styles without hiding them with inline CSS or utility classes like `opacity-0`.
2. **Dynamic Arming**: In `resources/js/app.js`, elements receive the `motion-pending` class only after JavaScript confirms browser support and reduced-motion status.
3. **CSS Scoping**: CSS hides pending elements only under the `.motion-ready` root class:
   ```css
   .motion-ready [data-motion].motion-pending {
       opacity: 0;
       will-change: opacity, transform;
   }
   ```
4. If JavaScript fails or is absent, `.motion-ready` is never attached, and all content displays normally.

---

## 3. Strict Reduced-Motion Behavior

All motion implementations must honor `prefers-reduced-motion: reduce`:

```css
@media (prefers-reduced-motion: reduce) {
    *, ::before, ::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
        scroll-behavior: auto !important;
    }
    .animate-cutout-settle,
    .animate-editorial-settle,
    [data-motion] {
        animation: none !important;
        clip-path: none !important;
        opacity: 1 !important;
        transform: none !important;
        transition-delay: 0ms !important;
    }
}
```

In `resources/js/app.js`, `initializeMotion()` exits immediately if `prefers-reduced-motion` is detected, ensuring zero JavaScript animation overhead.

---

## 4. Hard Constraints & Prohibitions

- **No Continuous Loops**: Never add perpetual bouncing, floating badges, pulsing borders, or infinite marquees. Every animation must settle into a stable state.
- **No Gradients**: The design system strictly prohibits gradients anywhere on the site (colors must remain flat, solid, and warm-toned).
- **No Card Elevation in Variant B**: Variant B must never apply hover card lift (`translateY(-2px)`). It must maintain planar calmness (`transform: none`).
- **Mobile Stagger Suppression**: On viewports &le; 767px, stagger delays are bypassed to prevent slow scroll accumulation.
- **Touch Targets & Focus**: All interactive controls must provide &ge; 44x44px touch targets on mobile and high-contrast `:focus-visible` outlines for keyboard users.
- **Modularity Cap**: Every tracked text and code file must remain strictly &le; 300 lines (enforced by `pnpm check:line-counts`).

---

## 5. Verification & Testing Protocol

Before marking any motion work complete, execute this verification sequence:

1. **Modularity Audit**: `pnpm check:line-counts` (must report zero files > 300 lines).
2. **Static & Feature Tests**: `php artisan test --compact` or targeted feature suites.
3. **Playwright Interaction Checks**:
   - **Desktop**: Scroll full page; verify one-time triggers, no repeat flashing, correct easing.
   - **Mobile (375px & 320px)**: Confirm staggers are disabled, no horizontal overflow (`scrollWidth <= clientWidth`), touch targets &ge; 44px.
   - **Reduced Motion**: Emulate `prefers-reduced-motion: reduce`; verify instant visibility without movement.
   - **No-JS**: Verify full layout and copy visibility with JavaScript disabled.
