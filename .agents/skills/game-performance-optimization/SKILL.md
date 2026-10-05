---
name: game-performance-optimization
description: Diagnose and improve game frame time, CPU/GPU load, memory, loading, stutter, draw calls, networking, and battery use. Use when a game misses an explicit platform performance or stability target.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Game performance optimization

## Measure first

- Confirm the target platform, device tier, resolution, quality settings, desired frame rate, memory/battery budget, and reproducible scene or workload.
- Capture a baseline from a representative build on target hardware. Separate CPU-bound, GPU-bound, memory, I/O, network, and frame-pacing symptoms.
- Record frame-time distribution and spikes, not only average FPS. Include warm/cold start, shader compilation, scene transition, and sustained load when relevant.
- Use the engine profiler and platform-specific tools. Account for profiler overhead and compare equivalent builds and settings.

## Fix the measured bottleneck

- Change one likely cause at a time and remeasure. If the bottleneck moves, profile again before choosing the next change.
- Inspect algorithms and data first, then allocations/GC, scene or actor count, draw calls/materials, texture and mesh cost, shaders, physics, animation, streaming, and network replication as evidence indicates.
- Use object pooling, batching, instancing, LOD, culling, async loading, or lower precision only when measurements and lifecycle support them.
- Preserve correctness, input responsiveness, visual readability, thermal stability, and memory headroom across low-end supported devices.
- Keep optimization decisions and budgets documented so content additions do not silently erase gains.

## Validate and communicate

- Re-run the same workload and compare baseline to result. Include device, build, settings, profiler capture, measurement window, and variance.
- Check for regressions in loading, memory, correctness, and other platforms.
- Distinguish engine/editor estimates from target-device results. State when a device build or profiler was unavailable.

## References

- [Godot stable performance guides](https://docs.godotengine.org/en/stable/tutorials/performance/index.html)
- [Unity Profiler manual](https://docs.unity3d.com/Manual/Profiler.html)
- [Unreal performance profiling](https://dev.epicgames.com/documentation/en-us/unreal-engine/introduction-to-performance-profiling-and-configuration-in-unreal-engine)
