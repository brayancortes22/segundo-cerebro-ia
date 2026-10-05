---
name: multi-agent-qa-testing
description: Coordinate independent AI testers to find, reproduce, rank, and verify defects in software, games, engines, or agent workflows. Use for a dedicated QA pass, release candidate review, security/performance audit, or adversarial test of a multi-agent feature.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Multi-agent QA and tester team

## Prepare the test mission

- Inspect the repository, change scope, acceptance criteria, supported platforms, test commands, and the exact build or commit under review.
- State the risk areas and what the user asked to verify. Distinguish read-only inspection from authorized code changes or external actions.
- Create a compact test matrix with requirement, scenario, environment, expected result, evidence source, and owner.
- Assign independent, bounded test tracks. Start with 2-4 agents when the scope supports separate specialties; use one tester when the change is small.

## Tester roles

1. Functional tester: checks acceptance paths, boundary values, errors, interruption, and regression scenarios.
2. Security tester: inspects trust boundaries, access control, validation, secret handling, abuse cases, and dependency risks within the authorized scope.
3. Platform/performance tester: checks target device/browser, responsiveness, frame/latency/memory budgets, and resource behavior.
4. Adversarial/UX tester: tries confusing input, recovery paths, accessibility, and assumptions not covered by the happy path.

Assign only roles that match the change. Each tester should work independently where possible, avoid editing implementation files, and report what was actually inspected or executed.

## Game and engine coverage

- For a game, include the actual target device and input path when available. Exercise a complete player loop and relevant recovery paths such as pause/resume, restart, death/failure, scene transition, save/load, focus loss, and reconnect; omit paths the game does not support.
- For engine or renderer work, verify the pinned engine/toolchain, editor or sample project startup, the smallest relevant engine test, and a before/after baseline for any performance claim. A documentation-only repository cannot pass a runtime check.
- For 3D assets or animation, inspect import, scale/orientation, materials, skeleton/retargeting, collisions, contact, and playback only when relevant to the changed asset. Use the project's established validation rules rather than inventing universal visual thresholds.
- Automated agents can check reproducible behavior, but cannot prove that gameplay is fun or understandable. Report human playtesting as a separate evidence gap when player experience is an acceptance criterion.

## Required finding format

For each finding include:

- Severity: P0 blocker, P1 high, P2 normal, or P3 low, with a short impact rationale.
- Title and affected file/route/scene/API with line or locator if available.
- Preconditions and precise reproduction steps.
- Expected versus observed result.
- Evidence: assertion, log, screenshot, trace, test output, or cited code path.
- Confidence and scope. Mark unverified hypotheses as questions, not defects.
- Whether another tester independently confirmed it.

Do not report style preferences as bugs. Avoid duplicate findings by linking related cases and naming the underlying cause.

## Coordinator synthesis

- Recheck every high-impact report against the source or repeatable evidence. Resolve disagreements by inspecting the artifact, not voting.
- Separate confirmed defects, likely issues, coverage gaps, and passed checks.
- Report checks not run and why. Never invent a pass or treat a static review as runtime verification.
- The tester team reports findings; implementation fixes belong to a separately assigned task unless the user requests fixes.
- If fixes are authorized, assign one owner per file, then rerun the failing scenario and relevant regression checks.

## Agentic system evaluation

For AI agents, test task completion and end state as well as interaction traces. Include normal tasks, ambiguous requests, tool failures, retries, permission boundaries, untrusted tool output, duplicate actions, timeouts, and recovery. Use a rubric with factual correctness, completeness, tool choice, safety, efficiency, and final-state correctness. Keep a representative evaluation set and compare versions; nondeterministic agents may validly take different paths to the same correct outcome.

## References

- [Playwright best practices](https://playwright.dev/docs/best-practices)
- [Anthropic — Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)
- [Anthropic — Multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
