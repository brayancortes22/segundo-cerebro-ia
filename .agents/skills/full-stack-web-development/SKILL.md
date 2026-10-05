---
name: full-stack-web-development
description: Deliver end-to-end web features spanning frontend, backend, data, integration, and deployment. Use when a request crosses browser UI and server or persistence boundaries, or when starting a full-stack application.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Full-stack web development

## Understand the existing stack

- Inspect package manifests, framework versions, routes, component conventions, API contracts, database schema and migrations, authentication, deployment, and current checks.
- Confirm the user flow, roles, data sensitivity, expected failure states, and deployment environment before choosing an architecture.
- Follow installed versions and official docs. Avoid rewriting the stack or adding dependencies for a feature that fits existing patterns.

## Build a vertical slice

1. Define acceptance examples and the data flow from user action through UI, server validation, authorization, persistence, and response.
2. Specify request/response schemas and error semantics before implementing both sides of a new boundary.
3. Validate all untrusted input on the server. Apply authorization to each protected operation and object, not just to the visible page.
4. Use database transactions and constraints for invariants that must hold under concurrency. Add migrations that can be applied and rolled back according to project policy.
5. Make loading, empty, success, validation, retry, permission-denied, and server-error states accessible and explicit.
6. Keep secrets on the server, configure environments through the existing mechanism, and avoid leaking stack traces or sensitive data to clients and logs.
7. Check observability, caching, failure recovery, and deployment compatibility for the feature's critical path.

## Quality gates

- Preserve type safety and API contracts across layers.
- Cover critical business rules with focused tests when requested or when the project's contribution workflow requires them; state what actually ran.
- Review responsive layout, keyboard path, semantic markup, and realistic network/data conditions.
- Separate completed behavior, inferred assumptions, security considerations, and operational follow-up in the handoff.

## References

- [Next.js production checklist](https://nextjs.org/docs/app/guides/production-checklist) when the project uses Next.js App Router.
- [Playwright best practices](https://playwright.dev/docs/best-practices) when the project uses Playwright.
- [OWASP Application Security Verification Standard](https://owasp.org/www-project-application-security-verification-standard/)
