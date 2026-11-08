# Semantic Motion Profiles: Expressive vs. Calm Editorial

This document specifies the exact parameters, tokens, and visual behaviors for both site motion languages.

---

## 1. Expressive / 2D Cutout Profile (Variant A)

The expressive profile provides tactile, layered, hierarchy-led choreography. Elements feel physical, grounded, and responsive without cartoonish bounce or looping.

### Token Specifications

| Token | Distance | Duration | Easing | Intent & Visual Behavior |
|---|---|---|---|---|
| `headline` | 18px | 0.56s | `[0.16, 1, 0.3, 1]` | Authoritative upward entry for major section headings. |
| `copy` | 14px | 0.46s | `[0.16, 1, 0.3, 1]` | Smooth text reveal following headline entry. |
| `card` | 20px | 0.52s | `[0.16, 1, 0.3, 1]` | Layered card rise for treatment and feature blocks. |
| `image` | 28px | 0.62s | `[0.16, 1, 0.3, 1]` | Directional rise for 2D cutout compositions and photos. |
| `action` | 12px | 0.42s | `[0.16, 1, 0.3, 1]` | Crisp button and link reveal, settling last in sequence. |
| `group` | 16px | 0.48s | `[0.16, 1, 0.3, 1]` | Cohesive container or row entry. |
| `rise` | 12px | 0.44s | `[0.16, 1, 0.3, 1]` | Default subtle upward reveal for unclassified items. |
| `review` | 18px | 0.48s | `[0.16, 1, 0.3, 1]` | Testimonial card entrance. |
| `fade` | 0px | 0.36s | `[0.16, 1, 0.3, 1]` | Pure opacity fade for subtle background planes or badges. |
| `mask` | N/A | 0.64s | `[0.16, 1, 0.3, 1]` | Horizontal clip-path unmasking (`inset(0 100% 0 0)` &rarr; `inset(0 0 0 0)`). |
| `timeline` | N/A | 0.60s | `[0.16, 1, 0.3, 1]` | Journey progression connector line reveal. |

### Easing & Stagger Rules
- **Base Easing**: `cubic-bezier(0.16, 1, 0.3, 1)` (snappy start, smooth deceleration).
- **Desktop Stagger**: `data-motion-stagger="80"` (50ms–120ms between siblings).
- **Mobile Stagger**: Evaluated to `0ms` via media query `(max-width: 767px)` to eliminate scroll backlog.

### Interactive Micro-Interactions
- **Hover**: `transform: translateY(-2px)` on `[data-motion-interactive]`.
- **Active / Press**: `transform: scale(0.985)`.
- **Transitions**: Fast surface color, border, and lift response (`360ms`).

---

## 2. Calm / Editorial Profile (Variant B)

The calm editorial profile delivers an understated, high-end architectural feel. Informed by clinical and editorial benchmarks, it emphasizes restraint, slower timing, shorter travel, and quiet hairlines.

### Token Specifications

| Token | Distance | Duration | Easing | Intent & Visual Behavior |
|---|---|---|---|---|
| `headline` | 12px | 0.72s | `[0.22, 1, 0.36, 1]` | Restrained upward drift for editorial titles. |
| `copy` | 10px | 0.62s | `[0.22, 1, 0.36, 1]` | Gentle text fade and rise. |
| `card` | 12px | 0.70s | `[0.22, 1, 0.36, 1]` | Subtle card settle without elevation. |
| `image` | 10px | 0.76s | `[0.22, 1, 0.36, 1]` | Soft unmask with micro-scale (`scale(1.02)` &rarr; `scale(1.0)`). |
| `action` | 8px | 0.56s | `[0.22, 1, 0.36, 1]` | Quiet CTA settle. |
| `group` | 12px | 0.64s | `[0.22, 1, 0.36, 1]` | Asymmetric content cluster entry. |
| `rise` | 10px | 0.60s | `[0.22, 1, 0.36, 1]` | Default gentle rise. |
| `review` | 12px | 0.68s | `[0.22, 1, 0.36, 1]` | Editorial review quote settle. |
| `fade` | 0px | 0.50s | `[0.22, 1, 0.36, 1]` | Deliberate, soft opacity transition. |
| `mask` | N/A | 0.82s | `[0.22, 1, 0.36, 1]` | Slow, elegant clip-path reveal for images and dividers. |
| `timeline` | N/A | 0.80s | `[0.22, 1, 0.36, 1]` | Slow hairline progress along patient journey. |

### Easing & Stagger Rules
- **Base Easing**: `cubic-bezier(0.22, 1, 0.36, 1)` (extended deceleration curve, serene finish).
- **Desktop Stagger**: `data-motion-stagger="100"` (60ms–140ms between siblings).
- **Mobile Stagger**: Evaluated to `0ms` via media query `(max-width: 767px)`.

### Interactive Micro-Interactions
- **Hover**: `transform: none` (strictly no card lift or elevation in Variant B).
- **Active / Press**: `transform: scale(0.992)` (very subtle press feedback).
- **Feedback**: Minimal border/hairline tone shifts and understated underline animations.

---

## 3. Side-by-Side Comparison Matrix

| Property | Expressive (Variant A) | Calm Editorial (Variant B) | Architectural Difference |
|---|---|---|---|
| **Max Travel** | 28px (images) | 12px (cards/headlines) | Variant B reduces travel by >50%. |
| **Pacing** | Snappy (360ms–620ms) | Serene (500ms–820ms) | Variant B extends durations by ~30–40%. |
| **Image Treatment** | Tactile directional lift | Restrained clip-path mask + 1.02 micro-scale | Variant B reveals via frame rather than movement. |
| **Hover Feedback** | -2px elevation | No elevation (`transform: none`) | Variant B preserves planar editorial calmness. |
| **Hierarchy** | Component-first blocks | Eyebrow &rarr; Hairline &rarr; Content | Variant B emphasizes typographic sequencing. |
