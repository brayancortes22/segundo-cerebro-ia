---
name: godot-game-development
description: Build, debug, profile, and package games in Godot. Use when the repository contains a Godot project or the user explicitly requests Godot scenes, nodes, GDScript, C#, resources, signals, shaders, exports, or engine integration.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Godot game development

## Start with the project

- Read project.godot, the installed Godot version, export presets, autoloads, addons, scene tree, and existing script style before editing.
- Use documentation matching the project's major/minor version. Prefer the stable manual; the latest manual may describe unreleased behavior.
- Follow the project's GDScript or C# choice. Do not migrate language or renderer as an incidental part of a feature.

## Godot patterns

- Treat scenes as composable ownership boundaries. Keep a node's responsibility focused and expose only the signals, methods, and data the scene needs.
- Use Resources for reusable authored data when they simplify authoring and validation. Define who owns mutable runtime state; do not share mutable resource state accidentally.
- Use signals for meaningful decoupled events, but keep direct references for clear local ownership instead of making every interaction global.
- Use autoloads for truly application-wide services, not as a default home for unrelated gameplay code.
- Choose _process, _physics_process, timers, and await based on required timing and lifecycle. Handle node deletion, scene changes, and cancellation safely.
- Preserve input actions and remapping support. Make pause, focus loss, restart, and scene transitions deliberate.
- Use typed GDScript or C# patterns only where supported by the exact engine version. Verify node paths, resource paths, class names, and signal signatures.

## Assets and export

- Check import settings, resource UIDs/paths, texture and audio formats, project scale, renderer, and platform-specific export presets.
- Keep generated files and imported caches consistent with repository policy. Avoid overwriting user-authored scenes or settings without examining their diffs.
- After changes, report the exact editor, headless, export, or runtime checks performed. If Godot is unavailable, say so and give a reproducible manual check.

## Performance

Profile a representative build on target hardware. Identify CPU, GPU, memory, draw-call, scene-tree, shader compilation, or loading bottlenecks before changing architecture. Re-measure after each significant optimization.

## References

- [Godot stable documentation](https://docs.godotengine.org/en/stable/)
- [Godot stable performance guides](https://docs.godotengine.org/en/stable/tutorials/performance/index.html)
- [Godot stable best practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)
