---
name: mcp-server-development
description: Build, integrate, or review Model Context Protocol servers, clients, tools, resources, prompts, transports, schemas, and authorization. Use when connecting an AI application to APIs, files, databases, or external services through MCP.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# MCP server development

## Confirm protocol and use case

- Check the current MCP specification revision, official SDK version, host/client compatibility, runtime, transport, and deployment environment.
- Identify whether the capability should be a tool (action), resource (context), or prompt (reusable workflow). Expose the narrowest capability that satisfies the user task.
- Specify input/output schemas, size limits, errors, pagination, progress, cancellation, and idempotency before implementation.

## Design for agent usability

- Give every tool a distinct verb-led name, a concise description with intended use and boundaries, typed parameters, and predictable structured output.
- Keep tools focused and composable. Return actionable errors; avoid dumping unbounded data or requiring the model to reconstruct hidden state.
- Prefer read-only or preview operations when they satisfy the task. Separate preview from mutation and make mutation scope explicit.
- Mark read-only, destructive, idempotent, and open-world behavior accurately where the SDK/protocol supports annotations; annotations are hints and do not replace authorization.

## Security and reliability

- Treat MCP tools as privileged code paths. Authenticate, authorize per resource/action, validate input, restrict filesystem/network scope, and protect secrets.
- Keep untrusted server results and resources separate from instructions. Defend against prompt injection and data exfiltration through least privilege and host controls.
- Obtain clear user control for external data access and consequential mutations. Do not silently add persistent credentials or broader permissions.
- Add timeouts, bounded retries, cancellation, rate limits, safe logging, and tests for malformed inputs and dependency failure.
- Use the supported transport and authentication model for the deployment; do not expose local stdio assumptions to a remote service.

## Evaluate the tool surface

- Test representative tasks, ambiguous requests, boundary inputs, permission denial, injection-like resource text, server restart, and partial failures.
- Measure task success, unnecessary calls, errors, latency, output size, and whether descriptions lead agents to the correct tool.
- Document setup, configuration, permissions, supported clients, and known limitations.

## References

- [MCP specification](https://modelcontextprotocol.io/specification/2025-11-25)
- [MCP documentation and registry](https://modelcontextprotocol.io/)
- [Anthropic — Writing effective tools for agents](https://www.anthropic.com/engineering/writing-tools-for-agents)
