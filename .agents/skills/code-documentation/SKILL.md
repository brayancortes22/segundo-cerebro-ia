---
name: code-documentation
description: Write and maintain useful comments, docstrings, API references, type documentation, and runnable examples alongside source changes. Use when code has a public contract, complex invariant, extension point, integration requirement, or when the user requests code documentation.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Code documentation

## Match the language and project

- Inspect nearby source, public API conventions, documentation generator, lint rules, and supported language version before adding documentation syntax.
- Use the project's established format: for example, JSDoc/TSDoc, Python docstrings, PHPDoc, C# XML comments, Rust rustdoc, Go doc comments, or its existing C/C++ convention.
- Do not introduce a documentation framework or annotate every private line when the project's conventions do not call for it.

## Document contracts and reasoning

- For public functions, classes, modules, events, CLI commands, and APIs, document purpose, parameters, return values, errors, side effects, ordering, async behavior, and important constraints.
- Include a short example when it helps a caller use the API correctly. Keep examples consistent with current signatures and supported versions.
- Explain why code has a non-obvious invariant, security check, concurrency rule, caching policy, numerical tolerance, or workaround. Link to an ADR or issue for wider rationale.
- Document units, nullability, ownership/lifetime, mutability, thread-safety, and compatibility when they affect correct use.
- Keep comments next to the code they explain and update or remove them when behavior changes.

## Keep source clear

- Prefer improving names, types, structure, or the API itself over adding a comment that restates obvious operations.
- Avoid speculative, redundant, time-sensitive, or inaccurate comments. Do not use comments as a changelog or as a substitute for tests and type constraints.
- Keep examples minimal and safe. Do not include credentials, personal data, internal endpoints, or production identifiers.
- Do not expose private implementation details or security-sensitive internals in generated public API docs.

## Verify documentation

- Check that signatures, types, examples, links, and annotations match the final code.
- Run the repository's doc generation or doc lint command only when it is available and appropriate to the task; report whether it was run and its result.
- For generated API docs, update the source annotations/schema rather than editing generated output unless project policy says otherwise.

## References

- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Microsoft Writing Style Guide](https://learn.microsoft.com/en-us/style-guide/welcome/)
