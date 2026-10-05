# 🌌 Aurora Engine — Plataforma de Desarrollo y Creación con IA

> **Estado:** 🟡 En Desarrollo Activo (Milestone 0 — Fork Foundation)  
> **Fundación:** **Godot 4.7.2-stable** (Oficialmente adoptado en ADR-0001, SHA: `ed1daf0bf001b61586d9930840f2f1394092c079`)  
> **Organización Oficial:** [aurora-engine-labs](https://github.com/aurora-engine-labs)  
> **Repositorio Oficial:** [aurora-engine](https://github.com/aurora-engine-labs/aurora-engine)  
> **Equipo Fundador:** Brayan Stid Cortés Lombana (`bscl` / @brayancortes22) & Diego Arias (@DiegoArias32)  
> **Ecosistema Integrado:** Aurora Intelligence, Aurora MCP, Blender Production MCP, Substance Painter MCP

---

## 🧭 Visión y Filosofía de Desarrollo

Aurora Engine nace como una plataforma de desarrollo de videojuegos (2D y 3D), cinematografía, animación y entornos interactivos que fusiona:
1. **Un motor gráfico y editor maduro** basado en el chasis de código abierto de **Godot Engine 4.7.2-stable** (la versión más moderna y estable a octubre de 2026, con 57 correcciones y sin incompatibilidades).
2. **Capa Nativa de Agentes Inteligentes (Aurora Intelligence):** Conexión con Claude Code, Codex, Gemini y modelos locales mediante CLI/Login oficial primero y APIs REST secundarias.
3. **Control Estructurado vía MCP (Model Context Protocol):** La IA no manipula código arbitrario ni memoria sin control; interactúa mediante un registro formal de herramientas (*Tool Registry*), validación estricta de esquemas, permisos por capas y un sistema de transacciones reversibles (**Undo AI Changes**).
4. **Pipeline Desacoplado de Producción:** Integración nativa con **Blender** (vía Blender Production MCP) para retopología, LODs, UVs y rigging automático, y con **Substance Painter** para texturizado PBR inteligente.

```
                    ┌─────────────────────────────────────────┐
                    │          AURORA INTELLIGENCE            │
                    │   (Orchestrator · Model Router · MCP)   │
                    └────────────────────┬────────────────────┘
                                         │
            ┌────────────────────────────┼────────────────────────────┐
            ▼                            ▼                            ▼
  ┌───────────────────┐        ┌───────────────────┐        ┌───────────────────┐
  │   AURORA ENGINE   │        │      BLENDER      │        │ SUBSTANCE PAINTER │
  │ (Godot 4.7.2 Fork)│        │ (Production MCP)  │        │   (Substance MCP) │
  │ • Runtime & Nodes │        │ • Retopology/LODs │        │ • PBR Texturing   │
  │ • Clustered / RT  │        │ • Rigging & Anim  │        │ • Smart Materials │
  │ • Cinematics/Seq  │        │ • Mesh Processing │        │ • Mask Baking     │
  └───────────────────┘        └───────────────────┘        └───────────────────┘
```

---

## 📚 Índice de Documentación Oficial en el Repositorio (`docs/`)

El repositorio cuenta con 13 especificaciones técnicas exhaustivas redactadas por el equipo:
* **`docs/MASTER_CONTEXT.md`:** Las 133 secciones fundacionales originales.
* **`docs/00-vision-y-principios.md`:** Filosofía, alcance y límites.
* **`docs/01-arquitectura.md`:** Diagrama de capas y flujo de ejecución de IA.
* **`docs/02-estructura-del-repositorio.md`:** Estructura de carpetas (`modules/aurora_*`).
* **`docs/03-upstream-ramas-y-versiones.md`:** Convivencia con Godot, importación con historial completo y tags.
* **`docs/04-compilacion-y-entorno.md`:** Requisitos en Windows/Linux, SCons $\ge$ 4.10.1 (requerido para VS 2026), Direct3D 12 y variable `DISABLE_GODOT_CI=true` (activa).
* **`docs/05-aurora-intelligence.md`:** Proveedores, autenticación local y orquestador.
* **`docs/06-aurora-mcp-y-tool-registry.md`:** Protocolo MCP, transacciones y esquemas JSON.
* **`docs/07-pipeline-externo.md`:** Blender Production MCP y procedencia de assets.
* **`docs/08-sistemas-del-motor.md`:** Shaders, volumetría, cinemáticas y animación.
* **`docs/09-roadmap.md`:** Hitos M0 a M20 con criterios de aceptación demostrables.
* **`docs/10-estandares.md`:** Convenciones de C++, naming (`p_param`, snake_case, `Ref<>`), logging y Definition of Done.
* **`docs/11-seguridad-y-privacidad.md`:** Gestión de credenciales y sandbox.
* **`docs/12-riesgos.md`:** Matriz de riesgos y mitigaciones.
* **`docs/adr/`:** Decisiones de Arquitectura (ADR-0001: Godot 4.7.2, ADR-0002: Fork con historial, ADR-0003: Autenticación).
* **`docs/lessons_learned/Errores_del_proceso.md`:** Los 100 errores reales y guardrails.

---

## 🛡️ Lección Aprendida y Evolución Histórica

Este proyecto es el heredero directo y evolución madura de **NOVA ENGINE (DABC_Brisk3D)**.
Para detalles técnicos completos de los errores cometidos en NOVA Engine y las 100 reglas de validación práctica para pipelines 3D y agentes, consultar:
👉 **[[Post Mortem Nova Engine a Aurora|Post-Mortem: De Nova Engine a Aurora Engine]]**  
👉 **[[Reglas de Validacion y Anti Patrones 3D y Animacion|100 Reglas de Validación y Anti-Patrones: 3D, Rigging y Animación]]**

| Dimensión | NOVA Engine (Lección / Error) | AURORA ENGINE (Estrategia Definitiva) |
| :--- | :--- | :--- |
| **Punto de Partida** | Cero absoluto (GLFW, GLAD, Win32, CMake) | **Godot 4.7.2 Foundation** (Chasis maduro y probado) |
| **Tiempo al Primer Frame** | Semanas en `Logger.h` y CMake sin ver nada | **Día 1:** Viewport 3D, Forward+ e iluminación activa |
| **Integración con IA** | Chat externo manual sin conexión al motor | **Aurora MCP nativo** con Tool Registry y Undo |
| **Hardware Objetivo** | Incierto / Vulnerable a cuellos de botella | Optimizado para **PCs básicas con RTX de entrada** |

---

## 🏛️ Gobernanza y Ramas en Git

El repositorio opera bajo la política estricta de **3 ramas**:
* `development`: Integración activa de módulos de Aurora (`modules/aurora_*`).
* `qa`: Estabilización, pruebas de rendimiento, regresión gráfica y profiling de hardware.
* `production`: Versiones oficiales de lanzamiento del editor y runtime.

---

## 🚀 Infraestructura de CI/CD y Calidad Automatizada

El repositorio cuenta con pipelines automatizados en `.github/workflows/` documentados en detalle en:
👉 **[[DevOps y CICD Aurora Engine|DevOps, CI/CD y Automatización en Aurora Engine]]**.

* **`ci.yml`:** Quality gate de 100 anti-patrones, escaneo de secretos y compilación SCons (MSVC/GCC) con caché distribuido.
* **`branch-governance.yml`:** Validador automático que bloquea cualquier intento de merge a `production` que no provenga de `qa`.
* **`cd-release.yml`:** Generador automático de changelog y empaquetado de releases.

---

## 🗺️ Roadmap de Milestones

* [x] **M0 — Fork Foundation:** Repositorio oficial en `aurora-engine-labs`, 3 ramas (`development`, `qa`, `production`), CI/CD completo, gobernanza de ramas y estrategia upstream lista.
* [ ] **M1 — Aurora Module Foundation:** Módulos esqueleto C++ (`modules/aurora_core/`, `modules/aurora_intelligence/`, `modules/aurora_mcp/`).
* [ ] **M2 — Aurora Intelligence Core:** `IAgentProvider`, `AgentBridge`, terminales IPC y panel de chat integrado.
* [ ] **M3 — Provider Authentication:** Conexión preferente por CLI oficial (Claude Code / Codex / Gemini CLI) + soporte opcional de API Key.
* [ ] **M4 — Aurora Tool Registry:** APIs seguras para manipulación de Nodos, Escenas, Luces y Transformaciones.
* [ ] **M5 — Aurora MCP:** Exposición del motor al exterior mediante el estándar Model Context Protocol.
* [ ] **M6 — Agentic Editing:** Ejecución transaccional con reversibilidad completa (*Undo AI Changes*).
* [ ] **M8 — Blender Production MCP:** Pipeline automatizado de mallas, retopología y LODs coordinado por agentes.

---

## 👥 Matriz de Roles y Asignación de Tareas en ClickUp

> **Workspace:** `nasa project` | **Espacio:** `Aurora Engine` (ID: `90177844648`)

| Hito / Dimensión | Brayan Stid Cortés Lombana (`bscl`) | Diego Arias (@DiegoArias32) |
| :--- | :--- | :--- |
| **M0 — Fork Foundation** | • Script de CI local (`aurora/tools/ci_local`)<br>• Branding mínimo «Aurora Engine»<br>• Validar compilación local en Windows<br>• Medir costes y tiempo de build en CI | • Importar Godot 4.7.2 con historial completo<br>• Entorno SCons ≥ 4.10.1 (`.venv`)<br>• Compilar editor Windows (RAM/Disco/CPU)<br>• Ejecutar tests baseline (`--test`)<br>• Crear `UPSTREAM.md` y chequear `THIRD_PARTY.md` |
| **M1 — Module Foundation** | • Módulo `aurora_core` (logging, settings, version)<br>• Esqueleto `aurora_intelligence`<br>• Esqueleto `aurora_mcp`<br>• Guía técnica: «Anatomía de un módulo C++» | • Esqueleto `aurora_external_tools` + `IExternalTool`<br>• Tests unitarios doctest para los 4 módulos en CI |
| **M2–M7 — Intelligence & MCP** | • `IAgentProvider` + `ProviderManager`<br>• `AgentBridge` (procesos, IPC, streaming)<br>• Conectores: Claude CLI y Codex JSON-RPC<br>• Tool Registry: JSON Schema y errores tipados<br>• Servidor `Aurora MCP` (stdio + HTTP streamable)<br>• Transacciones `AI_TX` + botón «Undo AI Changes»<br>• `Context Manager` y Memoria del Proyecto | • Panel `AURORA AI` en editor (Chat UI)<br>• Sistema de tareas (cola, progreso, cancelación)<br>• Almacén de API keys en Windows Credential Manager<br>• Conector `GeminiProvider` (Gemini CLI)<br>• Tools: Scene, Node, Transform, Project, Debug<br>• Tool Calls UI (Compact / Detailed / Developer)<br>• Task Planner + Validation Loop y panel de privacidad |
| **M8–M10 — Pipeline Externo** | • Orquestación Aurora ↔ Blender MCP<br>• `Aurora Asset System` (GUIDs, metadata, deps)<br>• Historial de IA por asset | • Adaptador `BlenderTool` (retopo, LODs, UVs)<br>• Adaptador `SubstancePainterTool` y flujos de texturas<br>• Export/re-import bidireccional automático |
| **M11–M21+ — Motor & Research** | • Presets de calidad (Low → Cinematic/RT)<br>• Edición de grafos de materiales por IA<br>• `Aurora Sequencer` para cinemáticas<br>• Profiler + Performance Agent + regresión en CI<br>• `Aurora Procedural` (scatter, biomas) y `Aurora 2D`<br>• Model Router y Orchestrator multiagente | • Auditoría PBR vs DCC y `AuroraForestBenchmark`<br>• Editor visual de materiales por nodos<br>• Atmósfera (cielo, niebla, nubes) y `Aurora Snow`<br>• Movie Renderer (EXR/video) y Cámara cinematográfica<br>• `Aurora VFX` (GPU particles) y Foliage/Terrain<br>• Retargeting/IK en Blender y Path Tracer / Meshlets |
| **Hitos Conjuntos (DoD)** | **Ambos:** Cierre de M0, M1, M4, M5, M7. 🎯 Demo MVP 1 (M6) y MVP 2 (M8). Rituales semanales y DoD. |

