---
name: multi-agent-software-development
description: Plan and deliver complex software work with a coordinator and specialized AI agents. Use when a task has genuinely independent code, research, design, or review tracks and the available platform supports delegated agents.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Multi-agent software development

## Decide whether to delegate

- First understand the goal and repository. Use one agent for a narrow change or when all work depends on a single evolving file or shared reasoning context.
- Delegate only separable work whose outputs can be integrated: for example, architecture review, UI implementation, API implementation, documentation, or independent QA.
- Set a small agent count proportional to parallel work. Extra agents add cost, coordination, and merge risk.

## Coordinator responsibilities

1. Write the goal, acceptance criteria, constraints, repository branch/state, and final integration owner.
2. Divide work into non-overlapping deliverables. Name files/areas each agent may inspect or edit and files it must leave untouched.
3. Give every agent the relevant context, exact objective, assumptions to verify, expected output format, and stop condition.
4. Agree on interface contracts before parallel implementation: types, routes, events, scene ownership, schema, or component props.
5. Keep shared work isolated with separate branches/worktrees or assign a single writer per file. Avoid concurrent edits to the same file.
6. Ask agents to return concise findings with evidence, changed paths, checks performed, and unresolved risks.
7. Integrate deliberately, resolve conflicts, inspect the complete diff, and verify cross-track behavior as authorized.

## Agent roles

- Architect: identifies constraints, interfaces, and risks; does not make speculative redesigns.
- Implementer: owns only the assigned slice and follows the contract.
- Researcher: checks version-matched primary documentation and returns links and decisions.
- Reviewer/tester: evaluates independently and reports reproducible findings; does not silently patch the implementation.
- Integrator: owns the final source of truth and reconciles differing recommendations.

## Communication contract

Use a short handoff: objective; context; allowed scope; dependencies; acceptance; expected artifact; tools available; stop condition. Ask agents to avoid duplicating other tracks and to report blockers early. Treat each agent output as a proposal until verified against the repository and acceptance criteria.

## Control cost and failure

- Reserve parallelism for independent work; serialize decisions that depend on shared code or evolving design.
- Track progress through artifacts and checkpoints instead of repeated status chatter.
- Stop an agent when its result is sufficient or its scope is invalidated. Do not let agents recursively delegate without an explicit budget.
- If agents disagree, compare evidence and assumptions; do not resolve by majority vote.
- Account for token/time cost and integration effort in the final recommendation.

## References

- [Anthropic — Multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
- [LangGraph examples](https://langchain-ai.github.io/langgraph/tutorials/overview/) for framework-specific supervisor patterns.
