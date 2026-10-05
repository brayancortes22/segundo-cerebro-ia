---
name: backend-api-data-security
description: Design and implement secure backend APIs, authentication, authorization, data models, SQL persistence, validation, and integrations. Use when a change creates or modifies server endpoints, identity, access control, stored data, or external service calls.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Backend APIs, data, and security

## Establish the contract

- Inspect framework, runtime, database, migration conventions, identity provider, API versioning, deployment model, and current threat controls.
- Define caller, resource, allowed operation, schema, error behavior, idempotency, pagination, and rate/cost limits.
- Keep public API behavior explicit and compatible with existing clients; document breaking changes.

## Protect every boundary

- Authenticate the caller and authorize each action against the specific resource and tenant. A hidden UI control is not authorization.
- Parse and validate input with bounded lengths, types, formats, and ranges. Parameterize queries and encode output for its destination.
- Store secrets in the established secret manager/environment; never log credentials, tokens, or sensitive payloads.
- Apply least privilege to database roles and service tokens. Use explicit timeouts, safe retries, and idempotency keys where duplicate effects matter.
- Use database constraints and transactions for integrity. Design indexes from query patterns and validate with query plans rather than assumptions.
- Use rate limits based on abuse and resource cost. Add bot challenges only when a threat assessment and accessible fallback justify them; do not treat a missing User-Agent as proof of abuse.
- Consider privacy minimization, retention, deletion/export needs, encryption, auditability, and relevant jurisdictional obligations.

## Resilience and observability

- Handle timeouts, unavailable dependencies, partial failure, and retries without duplicating irreversible effects.
- Return stable, useful error responses while keeping internal diagnostics private.
- Record request identifiers and operational metrics without exposing sensitive user data.
- Review schema migration safety, backup/restore needs, and compatibility during rolling deployment.

## References

- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/)
- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/)
- [Model Context Protocol security principles](https://modelcontextprotocol.io/specification/2025-11-25) when building AI tool integrations.
