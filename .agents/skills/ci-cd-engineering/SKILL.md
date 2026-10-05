---
name: ci-cd-engineering
description: Design, implement, secure, and troubleshoot continuous integration, delivery, and deployment pipelines. Use when automating builds, checks, artifact publication, environment promotion, release, or rollback across GitHub Actions, GitLab CI, Azure Pipelines, Jenkins, or another existing runner.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# CI/CD engineering

## Discover the delivery path

- Inspect the repository's current provider, workflow files, branch protections, build commands, artifact registry, deployment targets, environments, and release conventions.
- Confirm what constitutes a valid change, which checks are required, how secrets are delivered, and whether deployment is automatic or approval-gated.
- Prefer extending the existing pipeline over introducing a second CI system. Check current provider docs and syntax for the runner version in use.

## Shape the pipeline

- Use explicit stages for validation, build, artifact creation, publication, and deployment. Share immutable artifacts between stages instead of rebuilding different bits for each environment.
- Run fast, relevant checks early; parallelize independent jobs and cache only safe, reproducible dependencies.
- Promote the same versioned artifact through environments. Keep environment-specific configuration outside the artifact.
- Use concurrency controls to prevent stale overlapping deployments. Add health verification and a clear rollback path proportionate to the service.
- Make failures visible and actionable. Bound retries and timeouts; do not retry non-idempotent work blindly.
- Store configuration and secrets in the platform's protected mechanism. Prefer short-lived federated identity such as OIDC over long-lived cloud credentials when supported.

## Secure the workflow

- Grant each job only the permissions it needs. Separate untrusted pull-request validation from privileged release/deployment jobs.
- Review third-party actions/plugins, versions, permissions, and update policy. Pin dependencies to immutable references when the platform and maintenance process support it.
- Do not expose deployment secrets to forked or otherwise untrusted code. Treat uploaded artifacts from untrusted workflows as untrusted input.
- Use protected environments, reviewers, concurrency limits, and deployment records for production where appropriate.
- Avoid embedding secrets in logs, command lines, artifacts, caches, or build metadata.

## Verify and hand off

- Check workflow syntax and provider validation. Where execution is available and authorized, exercise pull-request, mainline, release, failure, cancellation, and rollback paths.
- Report which workflows changed, required variables/permissions, expected cost, checks actually observed, and steps that still require an operator.

## References

- [GitHub Actions deployments](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments)
- [GitHub Actions secure use](https://docs.github.com/en/actions/reference/security/secure-use)
- [GitLab CI/CD documentation](https://docs.gitlab.com/ci/)
- [Azure Pipelines documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/)
