---
name: gameplay-systems-design
description: Design and implement gameplay loops, mechanics, progression, abilities, state machines, economy, and balancing. Use when a game feature changes player choices, rules, rewards, difficulty, or moment-to-moment feedback.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Gameplay systems design

## Define the experience

- Describe the player goal, available actions, constraints, feedback, and consequence in plain language.
- Map the core loop and the loop's start, success, failure, retry, and long-term progression paths.
- Separate the intended player fantasy from implementation details; preserve the former while making the latter testable.
- State the audience, session length, platform, accessibility needs, and any network or monetization constraints that affect the design.

## Build a system

1. Inspect existing systems and data before adding a new manager, event bus, or framework.
2. Write a concise mechanic specification: triggers, preconditions, state changes, timing, feedback, cancellation, and edge cases.
3. Represent valid states and transitions explicitly; make invalid transitions observable and recoverable.
4. Keep balancing values discoverable and safely editable. Use ranges, units, defaults, and validation rather than unexplained constants.
5. Prototype the smallest version that answers the design question. Do not build content scale before testing the mechanic's feel.
6. Test normal, boundary, interruption, pause, restart, save/load, multiplayer authority, and accessibility paths as relevant.

## Balance and iteration

- Track the metric that represents the design goal: completion time, success rate, choice diversity, resource pressure, or another meaningful outcome.
- Change one meaningful variable at a time when diagnosing balance. Keep a record of hypotheses and results.
- Distinguish intended challenge from unclear feedback, unreliable controls, and hidden rules.
- Avoid false precision: playtest observations and telemetry need sample size and context.

## Deliverable

Return a mechanic summary, state/transition model, tunable parameters, acceptance examples, and unresolved design questions. Label assumptions and cite the project files that define existing rules.
