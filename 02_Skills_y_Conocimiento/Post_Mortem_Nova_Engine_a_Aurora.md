# 🧠 Post-Mortem de Ingeniería: De NOVA Engine a AURORA ENGINE

> **Propósito:** Análisis crítico de los errores cometidos en el proyecto predecesor (**NOVA Engine / DABC_Brisk3D**) para blindar el desarrollo de **AURORA ENGINE**, ahorrar meses de trabajo y no volver a caer en las trampas que destruyen los proyectos de motores gráficos.

---

## 1. El Antecedente: ¿Qué fue NOVA Engine?

En abril de 2026, **Brayan Stid Cortés Lombana (`bscl`)** y **Diego Arias (`DiegoArias32`)** en la organización **`DABC-resource`** iniciaron el desarrollo de **NOVA Engine**, concebido inicialmente como un motor C++20 propietario desde cero absoluto para juegos FPS de alta intensidad y mundos abiertos.

El proyecto redactó un manifiesto de más de 2,000 líneas con 14 milestones ambiciosos (Vulkan, Ray Tracing, Jolt, Networking cliente-servidor, VFS .pak y Streaming de chunks estilo GTA V).

Sin embargo, el proyecto quedó congelado en la versión **`v0.0.0`** (setup de CMake y Logger spdlog).

---

## 2. Los 7 Errores Mortales Identificados (Autopsia Técnica)

El propio README de NOVA Engine enumeraba en su Sección 13 los errores comunes que matan este tipo de proyectos. El equipo cayó exactamente en varios de ellos:

### ❌ Error #1: La Ilusión del "Cero Absoluto" (The Engine Trap)
* **Qué falló:** Querer programar manualmente la ventana (GLFW), la carga de extensiones de OpenGL/Vulkan (GLAD), los memory allocators (Linear, Pool, Stack), el parser de VFS y el sistema de logging antes de tener siquiera un juego jugable.
* **Impacto:** Cientos de horas invertidas en fontanería de bajo nivel invisible.
* **Corrección en Aurora Engine:** Usar **Godot 4.3 como Foundation**. Godot ya resolvió de forma ultraligera y testeada la ventana, la serialización, el audio, los drivers y el viewport.

### ❌ Error #2: Construir sin Ver Resultados Visuales
* **Qué falló:** *"Primero el VFS, luego el allocator, luego el job system... y luego el triángulo"*. Si pasan semanas sin ver nada en pantalla, la motivación del equipo se extingue.
* **Corrección en Aurora Engine:** El día 1 de Aurora ya tiene un renderizador **Forward+ Clustered** con niebla volumétrica y luces dinámicas corriendo a 120 FPS en el viewport.

### ❌ Error #3: Feature Creep Desenfrenado
* **Qué falló:** Planificar simulación balística dual (hitscan + projectil con bullet drop), networking de 64 jugadores estilo Warzone y streaming de 1000m estilo RAGE antes de renderizar un modelo 3D.
* **Corrección en Aurora Engine:** Regla estricta de **Milestones Incrementales (M0 a M20)** con foco exclusivo en el **Primer MVP (Sección 107)**: un agente que crea 3 cubos y se puede hacer Undo.

### ❌ Error #4: Sobreoptimización Prematura
* **Qué falló:** Pensar en estructuras de datos contiguas de memoria (DOD/ECS) con SIMD manual y allocators lock-free antes de que la lógica básica existiera.
* **Regla de Oro:** *"Make it work $\rightarrow$ Make it right $\rightarrow$ Make it fast"*. En ese orden estricto.

### ❌ Error #5: El Salto Abismal del Editor
* **Qué falló:** Intentar construir un editor desde cero usando *Dear ImGui*. Crear un editor con jerarquía de nodos, inspector de propiedades, navegador de assets y gizmos 3D requiere al menos 6 a 12 meses de trabajo solo en UI.
* **Corrección en Aurora Engine:** Heredar el editor maduro de Godot y extenderlo con **Aurora Intelligence** y **Aurora MCP**.

### ❌ Error #6: Querer que el Motor Haga Todo (vs. Delegación Inteligente)
* **Qué falló:** Intentar que el motor gestione retopología, LODs y texturizado por sí mismo.
* **Corrección en Aurora Engine:** Delegación explícita mediante **Blender Production MCP** (Blender procesa mallas y LODs) y **Substance MCP** (Substance genera texturas). El motor solo orquesta y consume.

### ❌ Error #7: IA como Asistente de Chat Desconectado
* **Qué falló:** Usar la IA únicamente como un chat web externo para pedir snippets de C++ que luego había que pegar y depurar a ciegas.
* **Corrección en Aurora Engine:** La IA se convierte en un operador nativo del motor mediante **MCP (Model Context Protocol)** con un **Tool Registry** tipado y transaccional con soporte de **Undo AI Changes**.

---

## 3. Matriz Comparativa: NOVA vs. AURORA

| Área | NOVA Engine (Paradigma Antiguo) | AURORA ENGINE (Paradigma Nuevo) |
| :--- | :--- | :--- |
| **Tiempo al Primer Prototipo** | 12 - 18 meses | **2 a 4 semanas** |
| **Riesgo de Abandono** | 90% (por fatiga de infraestructura) | **Bajo** (infraestructura resuelta por upstream) |
| **Modo de Operación de IA** | Copy-Paste manual de código | **Agente integrado vía MCP con permisos y Undo** |
| **Pipeline 3D** | Carga básica con Assimp | **Orquestación en vivo con Blender Production MCP** |
| **Target de Hardware** | Incierto (vulnerable a bugs de driver) | **Optimizado para PC básica con RTX de entrada** |

---

## 4. Compromiso de Desarrollo para Aurora Engine

1. **No tocar internals de Godot innecesariamente:** Toda la tecnología de Aurora vive en `modules/aurora_*` para no romper la compatibilidad con actualizaciones futuras de Godot.
2. **Definición de Terminado (DoD):** Ningún milestone se cierra sin que compile limpiamente, pase tests y haya sido validado en ejecución real.
3. **Visibilidad Continua:** Todo avance debe reflejarse en algo visible y medible en el editor.
