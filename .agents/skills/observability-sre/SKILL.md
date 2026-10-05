---
name: observability-sre
description: Design service reliability, telemetry, SLOs, alerts, dashboards, and incident response. Use when operating a production service, diagnosing incidents, setting reliability targets, or adding logs, metrics, and distributed traces.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Observability and SRE

## Start from user impact

- Identify critical user journeys, service dependencies, failure modes, owners, expected traffic, and impact of an outage.
- Define service-level indicators from user-visible behavior, such as availability, latency, correctness, or freshness. Set SLOs from product needs and historical capability rather than copying a generic percentage.
- Use error budgets or an equivalent decision rule to balance feature delivery and reliability work.

## Instrument useful signals

- Use structured logs for discrete events, metrics for trends and alerting, and traces for request paths across components. Adopt OpenTelemetry where it fits the existing stack.
- Propagate request/trace identifiers across service boundaries without logging credentials or unnecessary personal data.
- Control metric cardinality and retention cost; never put arbitrary user input or unique identifiers in unbounded labels.
- Measure golden paths and dependencies: request rate, errors, latency, saturation, queue depth, database health, and deploy outcomes as relevant.
- Build dashboards around decisions and add alerts only for actionable conditions with a clear owner and runbook.

## Operate and improve

- Separate symptom alerts from diagnostic dashboards. Page on user impact or imminent SLO exhaustion, not every noisy internal signal.
- Make deployments observable and support rollback or traffic reduction. Track changes alongside incidents.
- For an incident, establish scope and timeline, mitigate first, preserve evidence, communicate status, and capture follow-up work without blame.
- Test backup restore, failover, capacity, dependency outage, and recovery processes at a safe cadence and environment.
- Review telemetry volume, PII exposure, access, sampling, retention, and vendor costs.

## Deliver

Provide SLI/SLO definitions, instrumentation plan, dashboard/alert purpose, ownership, runbook, privacy/cost considerations, and what was verified.

## References

- [OpenTelemetry documentation](https://opentelemetry.io/docs/)
- [Google Cloud Well-Architected Framework](https://docs.cloud.google.com/architecture/framework)
- [Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/)
