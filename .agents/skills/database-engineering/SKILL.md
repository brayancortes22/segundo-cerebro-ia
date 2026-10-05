---
name: database-engineering
description: Model, query, secure, and tune relational or document databases. Use when choosing a data store, designing schemas and relationships, writing SQL or aggregation queries, adding indexes, or changing persistence behavior in an application.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Database engineering

## Understand the workload

- Inspect the current engine and version, ORM/query layer, schema, migrations, transaction boundaries, expected volume, access patterns, and consistency needs.
- Clarify entities, ownership, tenant boundaries, read/write ratio, query shapes, retention, concurrency, latency, availability, and data sensitivity.
- Prefer the existing database unless a measured workload or product requirement justifies another system. Do not choose NoSQL solely to avoid schema design or SQL solely from habit.

## Model data and behavior

- Define keys, types, constraints, nullability, uniqueness, relationships, lifecycle, and ownership from domain rules.
- Preserve invariants in the database when possible using constraints and transactions, not only application checks vulnerable to races.
- Choose relational normalization or document embedding/referencing based on update consistency, query patterns, and aggregate ownership.
- Use explicit transactions and isolation that match the business invariant. Plan for retries, deadlocks, duplicate delivery, and idempotency where relevant.
- Add indexes to serve known queries and ordering; consider write, storage, and maintenance cost as well as read speed.
- Parameterize user-controlled query input. Use least-privilege roles, bounded queries, and safe error handling.

## Diagnose performance

- Capture the slow query, representative parameters/data volume, and execution plan. Compare estimated and observed rows and costs where supported.
- Check missing or redundant indexes, N+1 access, scans, lock waits, stale statistics, result size, connection saturation, and application round trips.
- Benchmark with representative data and measure after changes. Avoid speculative indexes and configuration tuning.
- Be cautious with commands that execute mutations or production data scans. Confirm side effects and use a safe copy or transaction where appropriate.

## Deliver

Describe the schema or query change, integrity guarantees, migration implications, performance evidence, and version-specific behavior. Update the matching data model and API contract documentation when relevant.

## References

- [PostgreSQL current documentation](https://www.postgresql.org/docs/current/)
- [PostgreSQL EXPLAIN](https://www.postgresql.org/docs/current/sql-explain.html)
- [MySQL 8.4 Reference Manual](https://dev.mysql.com/doc/refman/8.4/en/)
- [MongoDB Manual](https://www.mongodb.com/docs/manual/)
