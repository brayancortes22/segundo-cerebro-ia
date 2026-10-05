---
name: parallel-ide-agent-workflow
description: Coordinate independent coding, research, documentation, and QA agents in Antigravity or another AI-enabled IDE. Use when parallel work can reduce time without creating conflicting edits; default to the user's Antigravity environment unless the active tool or request identifies another IDE.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Parallel agents across IDEs

## Detect the actual environment

- Default to Antigravity for this user's workflow. Confirm whether the active surface is Antigravity IDE, Antigravity 2.0, CLI, SDK, or an Antigravity extension inside another editor; the available features and workspaces differ.
- If the project is open in VS Code, Cursor, JetBrains, Windsurf, Zed, Visual Studio, or another IDE, use only the features that the installed version and current documentation confirm are available.
- Do not assume agents share chat history, settings, permissions, skills, tool access, or filesystem state across IDEs. Verify the workspace root, branch, checkout/worktree, and agent context before delegation.
- Skills in this vault use the portable SKILL.md format. Automatic discovery depends on the IDE/client and configured skill path; if the current client cannot load them, read or attach the needed file explicitly.

## Decide if parallelism helps

- Delegate work only when tasks can proceed independently: examples include research, architecture review, separate frontend/backend slices with fixed contracts, documentation, or an independent QA pass.
- Use one agent for small, tightly coupled, or single-file changes. Parallel agents add coordination and merge cost.
- Keep the agent count proportional to independent deliverables. Do not create duplicate agents for the same requirement or allow unbounded delegation.

## Split work safely

1. Inspect the repository and write the shared objective, acceptance criteria, version/stack facts, constraints, and final integration owner.
2. Assign each agent one specific deliverable, allowed paths, excluded paths, interface contract, expected artifact, check/evidence format, and stop condition.
3. Prefer isolated branches/worktrees for concurrent code writers when the IDE provides them. Antigravity 2.0 documents project worktrees; earlier or alternate surfaces may have different isolation options.
4. Use a shared checkout only for read-only research or when one clearly designated agent owns each file. Never let multiple agents write the same file concurrently.
5. Agree on interfaces before parallel implementation: API schema, types, data model, UI props, scene ownership, event names, or document outline.
6. Ask agents to record technical decisions and update relevant docs when assigned implementation changes; use project-technical-documentation and code-documentation as applicable.

## Antigravity workflow

- In Antigravity IDE, use its agent/task surfaces and artifacts to follow plans, diffs, browser evidence, and results. For independent repository changes, inspect whether the active version offers a separate workspace/worktree before launching parallel writers.
- Antigravity IDE supports asynchronous agents and parallel agents; Antigravity 2.0 adds project-oriented workspaces and native worktree flows according to current product docs. Do not assume Antigravity IDE, 2.0, CLI, and SDK share every control or command.
- Antigravity also documents extensions for other editors. When working inside an extension, confirm which host-IDE features are exposed through the extension versus the Antigravity desktop/manager.
- Review each agent's artifact and complete diff before accepting it. A generated plan or success message is not proof that changes work.

## Adapt to other IDEs

- VS Code: check whether the task runs in Chat view or Agents window, whether sessions share a checkout, and whether worktrees are isolated. New chats may have separate context; pass the required instructions and contract explicitly.
- Cursor: confirm whether an agent is local or background/remote, what repository branch/worktree it uses, and whether external network/package installation is enabled before assigning sensitive or offline work.
- JetBrains and other editors: identify integrated agent, supported skills/instructions, project scope, diff review, permissions, and version-specific session behavior from installed documentation.
- In every IDE, preserve project-level instructions and user permissions. Do not change settings, sign in, grant access, publish, or trigger deployment merely because an agent panel offers that action.

## Integrate and close

- Collect each agent's changed files, decisions, verification evidence, and open issues. Treat output as a proposal until the repository state confirms it.
- Review cross-agent interface compatibility and all diffs. Resolve conflicts by evidence and agreed contracts, not majority vote.
- Run or request the appropriate project verification within task authorization. Report exactly what was executed and what remains unverified.
- Keep ownership of the final integration explicit. Do not merge, push, publish, deploy, or discard another agent's changes without authorization.

## Handoff template

For each agent provide: objective; relevant repository and version facts; workspace/branch/worktree; allowed and excluded paths; dependencies; acceptance criteria; required output/evidence; tools or IDE features known to be available; stop condition.

## References

- [Antigravity IDE overview](https://www.antigravity.google/docs/ide/overview/)
- [Antigravity skills](https://antigravity.google/docs/skills?app=antigravity-ide)
- [Antigravity projects and worktrees](https://www.antigravity.google/docs/projects/)
- [Antigravity IDE extensions](https://www.antigravity.google/docs/ide/extensions/)
- [VS Code agent sessions](https://code.visualstudio.com/docs/agents/run/sessions/manage-sessions)
- [Cursor Background Agents](https://docs.cursor.com/background-agent)
- [JetBrains AI Assistant agents](https://www.jetbrains.com/help/ai-assistant/agents.html)
