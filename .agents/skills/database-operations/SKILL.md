---
name: database-operations
description: Plan and review database changes, migrations, backups, restores, replication, failover, capacity, and maintenance. Use for operational database work or production-readiness reviews, especially when data durability or downtime is at stake.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Database operations

## Establish operational context

- Identify engine/version, hosting model, environment, data size/growth, RPO/RTO, availability targets, replication topology, maintenance windows, and change owner.
- Inspect current backup schedule, retention, restore evidence, monitoring, migration framework, and rollback procedures.
- Treat production access and data as sensitive. Confirm the target environment and impact before any operation that changes, locks, or removes data.

## Migrations and releases

- Estimate lock duration, table rewrite, index build, storage, replication lag, and compatibility with old and new application versions.
- Prefer expand-migrate-contract for changes requiring backward compatibility during rolling deploys.
- Back up or snapshot according to the recovery plan before high-risk schema or data changes; a backup without a tested restore path is not a verified recovery strategy.
- Make data backfills restartable, observable, throttled, and idempotent. Separate schema deployment from large backfills when possible.
- Prepare a rollback or forward-fix plan and define the stop condition before execution.

## Durability and availability

- Define backup type, frequency, retention, encryption, access isolation, point-in-time recovery, and restore destination.
- Exercise restore procedures in an isolated environment and compare achieved recovery time and data loss to RTO/RPO.
- Review replication consistency, lag, failover behavior, quorum, connection pools, storage headroom, vacuum/compaction, and capacity alerts for the chosen engine.
- Avoid ad hoc failover or restore commands against ambiguous targets. Require explicit authorization for destructive or production-impacting operations.

## Report

Record environment, change window, prerequisites, commands or steps authorized, data impact, health checks, rollback decision, and recovery evidence. Mark anything not executed as a plan, not as a completed operation.

## References

- [PostgreSQL current documentation](https://www.postgresql.org/docs/current/)
- [MySQL 8.4 Reference Manual](https://dev.mysql.com/doc/refman/8.4/en/)
- [MongoDB Manual](https://www.mongodb.com/docs/manual/)
