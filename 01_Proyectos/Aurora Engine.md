# 🌌 Aurora Engine — Plataforma de Desarrollo y Creación con IA

> **Estado:** 🟡 En Desarrollo Activo (Milestone 0 — Fork Foundation)  
> **Fundación:** Godot 4.3+ (Fork Profundo con Módulos C++)  
> **Organización Oficial:** [aurora-engine-labs](https://github.com/aurora-engine-labs)  
> **Repositorio Oficial:** [aurora-engine](https://github.com/aurora-engine-labs/aurora-engine)  
> **Equipo Fundador:** Brayan Stid Cortés Lombana (`bscl` / @brayancortes22) & Diego Arias (@DiegoArias32)  
> **Ecosistema Integrado:** Aurora Intelligence, Aurora MCP, Blender Production MCP, Substance Painter MCP

---

## 🧭 Visión y Filosofía de Desarrollo

Aurora Engine nace como una plataforma de desarrollo de videojuegos (2D y 3D), cinematografía, animación y entornos interactivos que fusiona:
1. **Un motor gráfico y editor maduro** basado en el chasis de código abierto de **Godot Engine**.
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
  │  (Godot Deep Fork)│        │ (Production MCP)  │        │   (Substance MCP) │
  │ • Runtime & Nodes │        │ • Retopology/LODs │        │ • PBR Texturing   │
  │ • Clustered / RT  │        │ • Rigging & Anim  │        │ • Smart Materials │
  │ • Cinematics/Seq  │        │ • Mesh Processing │        │ • Mask Baking     │
  └───────────────────┘        └───────────────────┘        └───────────────────┘
```

---

## 🛡️ Lección Aprendida y Evolución Histórica

Este proyecto es el heredero directo y evolución madura de **NOVA ENGINE (DABC_Brisk3D)**.
Para detalles técnicos completos de los errores cometidos en NOVA Engine y las 100 reglas de validación práctica para pipelines 3D y agentes, consultar:
👉 **[[Post Mortem Nova Engine a Aurora|Post-Mortem: De Nova Engine a Aurora Engine]]**  
👉 **[[Reglas de Validacion y Anti Patrones 3D y Animacion|100 Reglas de Validación y Anti-Patrones: 3D, Rigging y Animación]]**

| Dimensión | NOVA Engine (Lección / Error) | AURORA ENGINE (Estrategia Definitiva) |
| :--- | :--- | :--- |
| **Punto de Partida** | Cero absoluto (GLFW, GLAD, Win32, CMake) | **Godot 4.3 Foundation** (Chasis maduro y probado) |
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

## 🗺️ Roadmap de Milestones

* [x] **M0 — Fork Foundation:** Repositorio creado en `DABC-resource`, branches configuradas, atribuciones a Godot y estrategia upstream lista.
* [ ] **M1 — Aurora Module Foundation:** Módulos esqueleto C++ (`modules/aurora_core/`, `modules/aurora_intelligence/`, `modules/aurora_mcp/`).
* [ ] **M2 — Aurora Intelligence Core:** `IAgentProvider`, `AgentBridge`, terminales IPC y panel de chat integrado.
* [ ] **M3 — Provider Authentication:** Conexión preferente por CLI oficial (Claude Code / Codex / Gemini CLI) + soporte opcional de API Key.
* [ ] **M4 — Aurora Tool Registry:** APIs seguras para manipulación de Nodos, Escenas, Luces y Transformaciones.
* [ ] **M5 — Aurora MCP:** Exposición del motor al exterior mediante el estándar Model Context Protocol.
* [ ] **M6 — Agentic Editing:** Ejecución transaccional con reversibilidad completa (*Undo AI Changes*).
* [ ] **M8 — Blender Production MCP:** Pipeline automatizado de mallas, retopología y LODs coordinado por agentes.
