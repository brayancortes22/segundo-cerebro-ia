---
name: godot-engine-fork-development
description: Maintain or extend a source fork of Godot as an engine, including upstream strategy, native modules, SCons builds, CI, and separation from game projects. Use for Aurora Engine or another Godot engine fork; use godot-game-development for projects built with Godot.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Godot engine fork development

## Scope

Use this skill for the Godot engine source tree and its fork-specific technology. It is not for ordinary games with a `project.godot`; route those to `godot-game-development`. Keep engine work and any future game repository separate. Add a game-specific engine feature only when a demonstrated game requirement cannot be met with the existing engine or a normal project addon.

## Establish repository truth first

- Read the repository instructions, `README`, `THIRD_PARTY` or license notices, architecture and upstream notes, ADRs, CI workflows, and current branch/status before proposing a change.
- Confirm the exact upstream URL, pinned release or commit, compiler/toolchain, SCons version, build preset, and local verification commands from the checked-out repository. Do not copy version assumptions from an old vault note.
- Inspect whether upstream source is actually present. Documentation, CI configuration, and a planned fork do not prove that the engine has been imported, built, or tested.
- Record the baseline and distinguish verified state from planned work. Do not mark a milestone complete without its acceptance evidence.

## Keep the fork maintainable

- Prefer a native Godot module or another documented extension point for Aurora-owned features. Modify upstream core only when the capability genuinely requires it; record why and the expected merge cost.
- Keep a clear boundary between upstream files and Aurora-owned files. Preserve upstream history and license notices, and document the exact source revision and local patch strategy.
- Make one bounded change at a time. Build or run the smallest relevant check after changes when the task authorizes verification; record the command and actual result.
- For renderer or runtime changes, capture a baseline on a named machine/build and representative scene before optimizing. Compare the same workload after the change; do not use an unverified FPS target as evidence.
- Keep generated build artifacts and local credentials out of commits. Never pass secrets or entire asset directories to a model without a project-approved reason.

## Integrate with game development

- Prototype a future game with the regular Godot workflow while the fork is not yet buildable, unless the task specifically needs a fork-only feature.
- Treat game needs as evidence for engine priorities, not as permission to put game-specific mechanics or content into the engine.
- Coordinate engine and game milestones through explicit version compatibility, migration notes, reproducible builds, and a small integration test.

## Handoff

Report upstream revision, fork-owned files, build/checks actually run, known integration risks, and whether the result is engine code, project code, or a proposal. Use `project-technical-documentation` for material architecture, compatibility, or release changes.
