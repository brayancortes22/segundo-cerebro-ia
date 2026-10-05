---
name: cloud-infrastructure-architecture
description: Design or review cloud workloads, networks, identity, compute, storage, reliability, security, and cost. Use when planning a new cloud architecture, migrating a workload, selecting managed services, or reviewing production readiness across AWS, Azure, Google Cloud, or a hybrid environment.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Cloud infrastructure architecture

## Establish workload needs

- Inspect the current provider, environment, deployment topology, data flows, and operational skills before proposing changes.
- Clarify users, workload profile, uptime and recovery targets, latency, growth, data classification/residency, compliance, budget, and team ownership.
- Use the existing provider where possible. If the provider is undecided and materially affects the design, compare a small number of options against the requirements instead of presenting one as universally best.

## Design the system

- Map trust boundaries, identity, network ingress/egress, private service paths, DNS, secrets, storage, compute, dependencies, and failure domains.
- Choose managed services when they reduce operational burden without violating portability, control, data, or cost constraints.
- Design for least privilege, secure defaults, encryption, patching, backup and restore, observability, incident response, and ownership from the beginning.
- Set availability and recovery objectives before selecting regions, replication, failover, or multi-zone services. Explain the cost and consistency trade-offs.
- Estimate recurring and usage-based costs, data transfer, logs, idle environments, and scaling behavior. Add budgets and cost alerts where appropriate.
- Prefer one provider and a documented boundary over multi-cloud duplication unless a concrete resilience, regulatory, or business requirement justifies it.

## Review and deliver

- Use the selected provider's current Well-Architected guidance and service documentation; confirm region availability, quotas, pricing, and feature status.
- Produce a diagram or resource map, key decisions, network/IAM boundaries, cost assumptions, recovery plan, risks, and phased implementation path.
- Separate architecture recommendations from actual provisioning. Do not create, expose, resize, or delete live resources without explicit task authorization.

## References

- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/)
- [Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/)
- [Google Cloud Well-Architected Framework](https://docs.cloud.google.com/architecture/framework)
