---
name: web-motion-animation
description: Design and implement purposeful web UI animation, transitions, micro-interactions, scroll effects, and motion systems. Use when animating interface state, onboarding, navigation, feedback, or marketing experiences.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Web motion and animation

## Define the job of motion

- State what the movement communicates: state change, hierarchy, cause and effect, continuity, feedback, or atmosphere.
- Match duration, easing, distance, and delay to the importance and physical scale of the event. Keep response to direct input immediate.
- Prefer a small shared motion vocabulary over unrelated timings and spring behaviors.

## Implement responsibly

- Inspect the framework and existing motion library before adding another dependency.
- Prefer transforms and opacity for frequent motion; measure layout, paint, compositing, and GPU costs for complex effects.
- Avoid blocking interaction behind long transitions, animated layout thrash, continuous offscreen work, and motion that harms text clarity.
- Respect prefers-reduced-motion and app-level motion preferences. Remove or simplify nonessential movement while preserving state changes and information.
- Make animation interruptible and resilient to rapid input, route changes, cancellation, and reduced-motion settings.
- Use CSS transitions/animations, Web Animations API, or a framework library according to project needs; check current browser support and library docs.
- Keep essential instructions available without relying only on a visual animation or color change.

## Validate

- Review the animation at realistic device refresh rates and under CPU/GPU load.
- Verify keyboard/focus behavior, reduced motion, slow networks, interruption, and repeated activation.
- Report the design intent, preference behavior, and performance evidence.

## References

- [MDN Web Animations API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API)
- [W3C WCAG 2.2](https://www.w3.org/TR/WCAG22/)
