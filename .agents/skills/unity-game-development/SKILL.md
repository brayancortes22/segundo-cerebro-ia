---
name: unity-game-development
description: Implement and maintain games in Unity using C#, scenes, prefabs, ScriptableObjects, packages, rendering, input, and build pipelines. Use when the repository contains a Unity project or the user requests Unity-specific work.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Unity game development

## Inspect and match versions

- Read ProjectSettings/ProjectVersion.txt, package manifests and locks, asmdefs, scenes, prefabs, input setup, render pipeline, and build configuration.
- Use Unity documentation and package manuals matching the project's installed Editor and package versions. Verify lifecycle methods and APIs before relying on memory.
- Preserve the chosen render pipeline, input system, and package architecture unless the task explicitly calls for a migration.

## Implementation

- Keep MonoBehaviours focused on engine lifecycle and scene composition. Move reusable rules into plain C# types or data assets where that improves testability.
- Use ScriptableObjects for authored shared configuration, and define runtime ownership so a play session cannot accidentally mutate project assets.
- Make scene and prefab references explicit. Respect serialization, stable asset GUIDs, .meta files, assembly boundaries, and existing naming conventions.
- Subscribe and unsubscribe event handlers according to object lifecycle. Handle scene unload, destroyed references, domain reload settings, and async cancellation.
- Prefer the current project's input abstraction. Support remapping and multiple device classes when relevant.
- Check object lifetime, allocations in frame loops, and asset loading strategy before introducing pooling, Jobs, Burst, Addressables, or DOTS.

## Assets and delivery

- Inspect importer settings, compression, texture formats, animation rigs, platform overrides, Addressables groups, and licensing metadata as relevant.
- Avoid manual edits to generated project files unless the project deliberately versions them.
- Verify builds and runtime behavior on the target platform. Editor Play Mode is useful for iteration but is not a substitute for profiling the target build.

## References

- [Unity Manual](https://docs.unity3d.com/Manual/index.html)
- [Unity Scripting API](https://docs.unity3d.com/ScriptReference/)
- [Unity Profiler documentation](https://docs.unity3d.com/Manual/Profiler.html)
