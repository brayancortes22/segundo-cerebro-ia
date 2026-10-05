---
name: infrastructure-as-code
description: Create, review, test, and maintain versioned cloud or platform infrastructure using Terraform, OpenTofu, Pulumi, CloudFormation, Bicep, or the tool already present. Use when editing infrastructure definitions, modules, state, plans, or environment configuration.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Infrastructure as code

## Inspect the toolchain and state

- Identify the existing IaC tool and exact version, providers/plugins, modules, backend/state, workspaces/environments, naming/tags, and CI workflow.
- Read the current configuration and dependency graph before editing. Do not migrate tools or restructure state as an incidental cleanup.
- Consult version-matched tool and provider documentation. Pin compatible versions according to the repository's existing update policy.

## Make safe, reviewable changes

- Express desired state declaratively and keep resources, inputs, outputs, and modules cohesive. Avoid duplicating environments through unsafe copy/paste.
- Keep credentials and sensitive values out of source, plans, logs, outputs, and committed state. Treat state and plan files as sensitive because they may contain secret values.
- Use remote state, locking, access control, encryption, backup, and environment separation appropriate to the tool and team.
- Design changes for repeatability and drift review. Add validation, formatting, linting, policy checks, and plan review to the normal pipeline where the project supports them.
- Prefer staged or reversible changes for replacement-sensitive resources. Call out data loss, downtime, public exposure, and state moves explicitly.

## Plan before apply

- Run formatting and static validation where available; inspect a plan in the intended workspace/account.
- Summarize resources added, changed, replaced, or destroyed, plus permissions and estimated cost impact.
- Never apply a destructive or production-impacting plan without clear user authorization. Stop if account, workspace, region, or state identity is uncertain.
- After an authorized apply, verify the resulting state and service health; report the exact environment and operations performed.

## References

- [Terraform language documentation](https://developer.hashicorp.com/terraform/language)
- [OpenTofu documentation](https://opentofu.org/docs/)
- [Pulumi documentation](https://www.pulumi.com/docs/)
