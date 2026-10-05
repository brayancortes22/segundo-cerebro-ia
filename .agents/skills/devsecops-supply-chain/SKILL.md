---
name: devsecops-supply-chain
description: Reduce software delivery and dependency risks across source control, CI runners, build artifacts, registries, secrets, and deployment. Use for DevSecOps hardening, dependency governance, SBOM/provenance, signing, or pipeline security reviews.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# DevSecOps and software supply chain

## Map trust and dependencies

- Inspect source, build workflows, third-party actions/plugins, package lockfiles, base images, artifact registries, signing, deployment identity, and release path.
- Identify untrusted contributors, forked pull requests, self-hosted runners, secrets, caches, and artifacts that cross trust boundaries.
- Use the current threat model and compliance needs to choose controls; do not add scanners that produce unowned noise.

## Harden the build

- Grant minimum job and token permissions; separate untrusted validation from privileged release and deployment steps.
- Review third-party actions and dependencies, pin or lock them according to platform guidance, and automate safe update review.
- Avoid running untrusted code in privileged workflow contexts or sharing privileged caches and runners with untrusted jobs.
- Prefer short-lived identity federation over long-lived cloud secrets. Scope credentials to the repository, environment, audience, and time required.
- Scan source, dependencies, secrets, container images, and IaC at appropriate points. Prioritize exploitable risk and reachable impact.
- Produce a software bill of materials and build provenance where release risk, customer expectations, or regulation warrants it. Sign and verify artifacts through a documented trust chain.
- Protect build outputs and deployment inputs from tampering; promote immutable artifacts and retain traceability to source revision and workflow.

## Respond and communicate

- Define vulnerability intake, severity/ownership, patch SLAs, dependency exception expiry, incident response, and customer notification path.
- Review scanner findings and exemptions; do not claim a clean supply chain from one passing scanner.
- Summarize risks, evidence, compensating controls, owners, and prioritized next actions. Distinguish mandatory policy from recommended maturity steps.

## References

- [GitHub Actions secure use](https://docs.github.com/en/actions/reference/security/secure-use)
- [SLSA specification](https://slsa.dev/spec/v1.1/)
- [OpenSSF Scorecard](https://github.com/ossf/scorecard)
- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/)
