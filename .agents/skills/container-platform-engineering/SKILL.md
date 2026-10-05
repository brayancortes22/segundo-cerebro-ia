---
name: container-platform-engineering
description: Build, secure, and deploy containerized applications with Docker and, when the workload needs it, Kubernetes. Use when editing Dockerfiles, images, Compose files, manifests, probes, resource requests, or container release workflows.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Container and platform engineering

## Select the right runtime

- Inspect the existing deployment target, workload scale, runtime requirements, state, networking, secrets, and operator capacity.
- Use a managed application/container service or Compose when it meets the need. Adopt Kubernetes only when orchestration, scale, portability, or platform requirements justify its operational cost.
- Confirm runtime and cluster versions, supported APIs, deployment ownership, and current manifests before editing.

## Build reliable images

- Use a trusted, minimal base image and multi-stage builds where useful. Pin and update base images according to the security and reproducibility policy.
- Exclude secrets, caches, local artifacts, and unnecessary source from build context. Run with a non-root user and reduce capabilities when compatible.
- Keep runtime images lean; separate build tools from production runtime and handle signals, shutdown, and writable paths intentionally.
- Make containers replaceable and keep durable data in the platform's intended storage service, not an ephemeral container filesystem.
- Scan images and dependencies where available; publish immutable image references and promote the same artifact across environments.

## Orchestrate carefully

- For Kubernetes, set realistic CPU/memory requests and limits based on workload measurements; define startup, readiness, and liveness probes according to distinct purposes.
- Scope service accounts and network access narrowly. Store secrets through the approved secret mechanism rather than committing plaintext manifests.
- Configure rollout strategy, disruption budgets, autoscaling, and persistent volumes to match availability and recovery requirements.
- Add namespaces, policy, ingress, DNS, certificates, and observability only as required by the platform, and respect established cluster conventions.
- Validate manifest API versions and admission policies against the actual cluster version.

## Verify

- Build and scan the image, inspect the rendered deployment diff, and verify startup, health, scaling, shutdown, and rollback behavior in a non-production environment where authorized.
- Report image identity, runtime/cluster version, resource assumptions, checks run, and remaining operational work.

## References

- [Docker build best practices](https://docs.docker.com/build/building/best-practices/)
- [Kubernetes resource management](https://kubernetes.io/docs/concepts/resource-management/)
- [Kubernetes probes](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/)
