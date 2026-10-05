---
name: ux-ui-accessible-design
description: Research, design, and implement clear, responsive, accessible UX and UI for web, mobile, desktop, and in-game screens. Use when creating user flows, navigation, forms, dashboards, design systems, or visual interaction patterns.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# UX/UI and accessible design

## Discover before styling

- Inspect the product, existing design system, user roles, primary tasks, visual language, device sizes, and available references.
- Describe the user goal, context, main path, alternatives, and likely failure states. Separate evidence from assumptions.
- Preserve established product conventions unless the request is specifically to redesign them.

## Design the interaction

- Prioritize hierarchy, readable type, clear labels, visible system status, predictable navigation, and recoverable errors.
- Design empty, loading, success, validation, permission, offline, and destructive-action states as part of the flow.
- Use consistent spacing, color roles, component states, and responsive behavior. Avoid visual effects that reduce contrast or legibility.
- Prefer semantic controls and keyboard-operable flows. Keep focus visible, order logical, labels programmatic, and touch targets practical.
- Check contrast, text resizing/reflow, zoom, screen-reader names, error identification, and motion preferences against the project's accessibility target.
- For games and immersive interfaces, consider remappable inputs, subtitles, readable HUD, color-independent cues, and adjustable motion where relevant.

## Validate

- Walk the main task with keyboard, touch, and assistive technology paths where applicable.
- Review at narrow and wide sizes with realistic copy and content volume.
- Use automated accessibility checks as a starting point; manually verify the interaction and semantics they cannot judge.
- Report unresolved usability or accessibility issues with their affected flow and impact.

## References

- [W3C WCAG 2.2](https://www.w3.org/TR/WCAG22/)
- [WAI introduction to web accessibility](https://www.w3.org/WAI/fundamentals/accessibility-intro/)
- [Vercel web design guidelines skill](https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines)
