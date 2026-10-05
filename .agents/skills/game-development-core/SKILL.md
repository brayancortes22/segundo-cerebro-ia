---
name: game-development-core
description: Plan and implement engine-agnostic video game features, playable prototypes, architecture, content workflows, and releases. Use for a game project, player-facing feature, game brief, or vertical slice; use godot-engine-fork-development for Godot engine source and fork work.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Game development core

This skill is for the game being played and the experience delivered to its player. A game engine, editor, MCP server, or asset tool is a separate product with its own roadmap; do not treat work on those systems as progress on the game's playable loop.

## Workflow

1. Inspect the repository, engine/version, target platform, input devices, existing build path, asset conventions, and current playable state.
2. Turn the request into player-visible outcomes and acceptance criteria. Identify assumptions about audience, controls, online/offline behavior, accessibility, and delivery hardware.
3. Prefer a small playable vertical slice that exercises the full loop over a wide collection of disconnected placeholders.
4. Separate game rules from presentation and engine glue where that matches the project. Use explicit ownership for state, time, save data, events, and scene transitions.
5. Design from frame and memory budgets, expected content scale, networking requirements, and platform constraints. Record the trade-offs.
6. Use licensed or user-provided assets and preserve attribution and source details. Do not imply generated or placeholder assets are final production art.
7. Review on the target device and input path. Capture reproducible steps for gameplay defects and compare performance against a baseline.

## Keep the first game slice small

- Start from the actual game brief and repository. If the player, core fantasy, genre, platform, controls, or central loop are unknown, mark those as open decisions instead of inventing them.
- Choose one player-facing loop that can be played from input through feedback to a meaningful result. Build that end-to-end before expanding content or infrastructure.
- Do not build engine features, multiplayer, open-world streaming, procedural systems, or a large content pipeline just because they appear in a future vision. Prototype with the existing engine first and promote a requirement only when the slice demonstrates it.
- Use greybox or clearly labeled placeholder assets until the interaction is validated. Capture playtest observations separately from design hypotheses.
- Do not claim a milestone is done because its roadmap or documentation is complete. Require a runnable build and its specific acceptance evidence.

## Lessons from prior engine work

The NOVA-to-Aurora post-mortem records the cost of building low-level infrastructure before a visible result, feature creep, premature optimization, and rebuilding editor capabilities already available in Godot. Apply those lessons to game scope: make it work, make it right, then measure and make it fast. If the request is actually about the Aurora engine fork, switch to `godot-engine-fork-development`.

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
