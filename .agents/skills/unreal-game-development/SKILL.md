---
name: unreal-game-development
description: Develop and debug Unreal Engine games using Blueprints, C++, Gameplay Framework, assets, plugins, replication, and packaging. Use when the project contains a .uproject or the user requests Unreal Engine work.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Unreal Engine development

## Inspect first

- Read the .uproject engine association, plugins, target files, modules, config, content conventions, build target, and source-control status.
- Match the installed Unreal Engine version and project conventions. Confirm module/API changes in the matching Epic documentation.
- Preserve whether the feature is Blueprint-first, C++-first, or intentionally shared. Do not create duplicate authority in Blueprint and C++.

## Architecture and gameplay

- Assign responsibilities to the existing Gameplay Framework types: GameMode, GameState, PlayerController, PlayerState, Pawn/Character, components, and subsystems.
- Respect server authority for replicated gameplay. Define which state replicates, who can mutate it, ownership, relevancy, prediction, and join/leave behavior.
- Use reflection macros, UPROPERTY/UFUNCTION specifiers, module dependencies, garbage collection, and asset references according to Unreal's rules.
- Keep editor-only code and runtime code separated. Avoid loading heavy assets or doing expensive work in Tick without a measured need.
- Use assets and data assets for designer-tunable content where appropriate; preserve redirectors and references when renaming or moving assets.

## Build, debug, and ship

- Use the project's build scripts and targets. Do not assume a project compiles from a generic command that ignores its engine installation.
- Check logs, packaging output, plugin compatibility, config overrides, cooked assets, and target platform.
- Profile representative packaged builds with Unreal Insights and platform tools. Record frame time, not only average FPS.
- Report the exact engine version, platform, build configuration, and validation performed.

## References

- [Unreal Engine documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine)
- [Unreal Engine C++ programming](https://dev.epicgames.com/documentation/en-us/unreal-engine/programming-with-cplusplus-in-unreal-engine)
- [Unreal Engine profiling](https://dev.epicgames.com/documentation/en-us/unreal-engine/introduction-to-performance-profiling-and-configuration-in-unreal-engine)
