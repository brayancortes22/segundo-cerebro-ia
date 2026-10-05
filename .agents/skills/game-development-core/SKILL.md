---
name: game-development-core
description: Plan and implement engine-agnostic video game features, prototypes, architecture, content workflows, and releases. Use when starting a game, scoping a vertical slice, choosing a system boundary, or coordinating gameplay, art, audio, and platform work.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Game development core

## Workflow

1. Inspect the repository, engine/version, target platform, input devices, existing build path, asset conventions, and current playable state.
2. Turn the request into player-visible outcomes and acceptance criteria. Identify assumptions about audience, controls, online/offline behavior, accessibility, and delivery hardware.
3. Prefer a small playable vertical slice that exercises the full loop over a wide collection of disconnected placeholders.
4. Separate game rules from presentation and engine glue where that matches the project. Use explicit ownership for state, time, save data, events, and scene transitions.
5. Design from frame and memory budgets, expected content scale, networking requirements, and platform constraints. Record the trade-offs.
6. Use licensed or user-provided assets and preserve attribution and source details. Do not imply generated or placeholder assets are final production art.
7. Review on the target device and input path. Capture reproducible steps for gameplay defects and compare performance against a baseline.

## Engineering guidelines

- Follow the conventions already used by the project; do not introduce an engine or framework without a clear need.
- Model player actions and system states explicitly. Make pause, restart, scene change, save/load, disconnect, and failure states intentional.
- Keep gameplay data tunable and versioned; separate authored content from code when the engine and project benefit from it.
- Consider keyboard, gamepad, touch, remapping, readable UI, subtitles, and reduced-motion options where they fit the target audience.
- Make content import reproducible. Track source files, scale, units, orientation, compression, and runtime destination.
- Prefer deterministic simulation only where replay, rollback, lockstep, or reproducible tests require it; state the determinism boundary.

## Deliverable

Summarize the playable outcome, changed systems, engine/platform assumptions, setup or build steps, checks actually completed, and remaining risks. Keep future work separate from implemented behavior.

## References

- [Godot stable documentation](https://docs.godotengine.org/en/stable/)
- [Unity Manual](https://docs.unity3d.com/Manual/index.html)
- [Unreal Engine documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine)
