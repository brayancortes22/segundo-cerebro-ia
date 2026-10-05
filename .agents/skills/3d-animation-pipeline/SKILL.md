---
name: 3d-animation-pipeline
description: Create, validate, optimize, and hand off real-time 3D models, materials, rigs, animation, and exports. Use for Blender-to-game-engine pipelines, animated characters, scenes, props, glTF/FBX interchange, or 3D asset reviews.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# 3D and animation pipeline

## Establish the target

- Confirm the Blender version, destination engine/runtime, target platform, real-time or offline rendering, coordinate system, scale, frame rate, unit, and export format.
- Inspect source references and license/attribution requirements. Keep editable sources separate from generated exports.
- Define a measurable asset budget: triangle and material counts, texture dimensions/formats, bone count, animation clips, memory, and draw calls appropriate to the target.

## Model and animate

- Model for silhouette, deformation, and camera distance. Use clean topology where deformation or subdivision requires it; avoid invisible detail that consumes runtime budget.
- Use consistent transforms, naming, origins, scale, normals, UVs, material slots, and texture color spaces.
- Rig with clear control/deformation layers, sensible bone hierarchy, stable weights, and named animation actions. Avoid fragile constraints or unbaked dependencies in runtime exports.
- Validate key poses, root motion, looping, additive layers, timing, interpolation, and transitions in the destination runtime.
- Use instances or procedural geometry when they reduce authored duplication without making runtime behavior or editing harder.

## Export and verify

- Apply only transforms and modifiers required by the target; preserve the native editable source.
- Export a minimal test asset first. Confirm axis, scale, pivots, skeleton, animation clips, materials, texture paths, tangents, and compression after import.
- Compare the imported result to the source in the destination renderer. Check missing textures, altered normals, root motion, bind pose, and animation timing.
- Automate repeatable export settings when possible; do not silently overwrite existing deliverables.

## References

- [Blender Animation and Rigging manual](https://docs.blender.org/manual/en/5.2/animation/index.html)
- [Blender Geometry Nodes manual](https://docs.blender.org/manual/en/latest/modeling/geometry_nodes/index.html)
- [glTF 2.0 specification](https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html)
