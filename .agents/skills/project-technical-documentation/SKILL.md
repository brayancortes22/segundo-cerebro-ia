---
name: project-technical-documentation
description: Create and maintain accurate technical documentation for software projects as architecture, code, APIs, data, infrastructure, or delivery changes. Use when starting a project, implementing a feature, changing system behavior, releasing a version, or handing work to another developer or AI.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Project technical documentation

## Purpose

Keep the project's technical record useful to the next developer, operator, and AI agent. Update documentation alongside the work so it describes the repository's real current state, not a plan that was never implemented.

## Discover the documentation system

- Inspect the repository README, project instructions, documentation folder, API schemas, diagrams, changelog, ADRs, runbooks, and release process before creating new documents.
- Identify the authoritative source for each fact. Prefer generated API references, package manifests, schema/migrations, and deployment configuration over copied descriptions.
- Follow the project's language, terminology, link style, versioning, and docs tooling. Reuse existing pages rather than creating duplicate guides.
- If no documentation structure exists, add the smallest useful structure for the change and link it from the existing entry point.

## Protect the record from drift

- Before reporting project status, compare the current repository with its README, roadmap, CI workflows, release artifacts, and relevant vault notes. Repository files are evidence; a plan, checklist, design document, or prior agent summary is not proof of implementation.
- Use explicit states such as proposed, in progress, implemented, locally verified, CI-verified, and released. Attach a dated source or check result when the status matters.
- If two authoritative documents disagree, identify the conflict and resolve the one relevant to the task. Do not silently propagate the more optimistic claim. If resolution depends on an unverified remote or a missing decision, preserve that uncertainty.
- For milestones, describe the acceptance evidence still missing. A repository, workflow, or test file existing does not prove that a build or test passed.

## Keep technical records in sync

For every completed project change, inspect which of these need an update and change only the relevant ones:

- README and onboarding: purpose, supported versions, prerequisites, setup, configuration, development commands, and troubleshooting.
- Architecture: component boundaries, data/control flows, important dependencies, deployment topology, and trust boundaries. Use a diagram only when it clarifies relationships; keep it synchronized with source.
- Decisions: add an Architecture Decision Record for consequential choices that are hard to reverse or affect interfaces, security, cost, scale, or operations. Record context, considered options, decision, consequences, and status.
- Interfaces: document public APIs, events, CLI commands, configuration, error behavior, compatibility, and examples. Prefer the project's OpenAPI/AsyncAPI/schema source of truth when applicable.
- Data: describe domain meaning, relationships, constraints, retention, migrations, and compatibility; do not duplicate a full schema already generated elsewhere.
- Operations: update build/CI/CD, deployment, environment variables, secrets setup, monitoring, backup/restore, rollback, and runbooks when the change affects them. Never put real secrets in docs or examples.
- Releases: update changelog or release notes according to the repository's convention, focusing on user/developer-visible changes and migration requirements.
- Code: use the dedicated code-documentation skill for comments, docstrings, and reference pages when those require substantive work.

## Document the actual change

1. Capture the requested outcome and locate the files and systems that changed.
2. Compare the final implementation and configuration with existing docs; do not write from the original plan alone.
3. Explain behavior, interfaces, constraints, setup, and operational consequences at the level a maintainer needs.
4. Mark assumptions, unsupported behavior, version limits, security boundaries, and unresolved decisions clearly.
5. Link related source files, generated references, ADRs, and diagrams rather than copy/pasting facts that will drift.
6. Review every edited page for stale commands, broken local links, contradictory guidance, or claims unsupported by the repository.

## Technical writing rules

- Be precise and task-oriented. Prefer concrete commands, input/output examples, diagrams, and tables when they reduce ambiguity.
- Separate current behavior, design intent, rationale, examples, and future work. Label proposed work as proposed.
- Include reproduction or verification steps and their environment when they are part of the handoff. State exactly what was run; never imply a check passed if it was not performed.
- Write for both a person and an AI: use stable headings, explicit names, short definitions, and links to primary sources. Avoid vague references such as “the thing above.”
- Do not record every edit or agent action. Preserve decisions, contracts, procedures, and facts that will prevent future mistakes.
- Treat docs as versioned project content. Avoid silently rewriting history; correct obsolete guidance with a dated/versioned note when needed.

## Handoff checklist

Summarize the implemented behavior, documentation pages updated, important decisions, setup/operation changes, checks actually performed, and remaining documentation gaps. If the task made no user-visible or maintainer-relevant change, explain briefly why no docs changed.

## References

- [Diátaxis](https://diataxis.fr/) for organizing tutorials, how-to guides, reference, and explanation.
- [Google Developer Documentation Style Guide](https://developers.google.com/style) for technical writing practices.
- [Microsoft Writing Style Guide](https://learn.microsoft.com/en-us/style-guide/welcome/) for terminology and style.
