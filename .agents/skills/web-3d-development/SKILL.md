---
name: web-3d-development
description: Build interactive real-time 3D experiences for browsers using Three.js, WebGL, WebGPU, glTF, or a project-selected renderer. Use for 3D product views, web games, configurators, and animated scenes.
metadata:
  version: "1.0.0"
  reviewed: "2026-10-04"
---
# Web 3D development

## Choose a browser-safe approach

- Inspect the framework, current renderer, device support, bundler, and existing 3D dependencies before selecting an API.
- Verify renderer and browser support at implementation time. Treat WebGPU as progressive enhancement unless supported devices and fallback behavior are established.
- Prefer the smallest renderer and asset pipeline that meets the experience; do not add a framework layer if the project does not use it.

## Scene and lifecycle

- Separate scene setup, loading, user interaction, render loop, resize handling, and disposal into clear lifecycle boundaries.
- Use glTF for portable runtime assets where suitable. Validate textures, color space, scale, coordinate orientation, animation clips, and loading size.
- Reuse geometry and materials where appropriate. Dispose GPU resources, event handlers, observers, and animation mixers when scenes unmount or change.
- Pause or reduce work when the canvas is hidden or offscreen when practical. Respect device pixel ratio with a sensible cap for performance.
- Provide loading, failure, and unsupported-device states, plus a meaningful fallback or alternate 2D presentation.

## Interaction and performance

- Keep camera, navigation, pointer, keyboard, touch, and focus behavior predictable. Provide non-canvas controls when essential operations would otherwise require precise 3D gestures.
- Track draw calls, triangles, texture memory, shader compilation, frame time, and network transfer on target devices.
- Avoid allocating objects every frame or rebuilding static scene data on each UI render.
- Honor reduced-motion preference for nonessential animated presentation and keep essential state changes understandable without motion.

## References

- [Three.js documentation](https://threejs.org/docs/)
- [Three.js animation system](https://threejs.org/manual/en/animation-system.html)
- [glTF 2.0 specification](https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html)
- [MDN WebGL API](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API)
- [MDN WebGPU API](https://developer.mozilla.org/en-US/docs/Web/API/WebGPU_API)
