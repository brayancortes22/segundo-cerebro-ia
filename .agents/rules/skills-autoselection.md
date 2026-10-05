---
trigger: always_on
description: Selecciona y carga automáticamente las Agent Skills pertinentes para cada tarea de Antigravity, sin exigir etiquetas manuales.
---
# Selección automática de skills

- Al inicio de cada tarea, compara lo solicitado y el proyecto con las skills descubiertas por el cliente. En Antigravity pueden venir de `.agents/skills/*/SKILL.md` del workspace o de `~/.gemini/config/skills/*/SKILL.md` globales. Lee las más pertinentes; no esperes etiquetas como `$skill` ni menciones explícitas.
- Inspecciona primero las instrucciones y fuentes de verdad pertinentes del repositorio. Separa lo implementado y verificado de lo planeado; si la bóveda y el repositorio discrepan, prioriza la evidencia actual del repositorio y registra la discrepancia cuando afecte el trabajo.
- Carga el conjunto mínimo útil: normalmente una skill de dominio y, solo si hacen falta, skills de apoyo. No leas todo el catálogo en cada tarea.
- En un proyecto de juego, usa `game-development-core`; en un árbol de código fuente de Godot/fork, usa `godot-engine-fork-development`; en un proyecto que consume Godot con `project.godot`, usa `godot-game-development`. No confundas Aurora Engine con el futuro videojuego que se construya usando el motor.
- Para cambios de arquitectura, API, datos u operación, aplica `project-technical-documentation`; para contratos, APIs públicas, módulos o docstrings, aplica `code-documentation`.
- Cuando el trabajo realmente se pueda dividir en tareas independientes, aplica `parallel-ide-agent-workflow` y las skills multiagente o de QA pertinentes. Evita paralelizar tareas que compitan por los mismos archivos.
- En Antigravity, usa `.agents/skills` y sus capacidades disponibles. En otro cliente, usa las skills que el cliente haya descubierto y no supongas que admite las reglas de Antigravity; si no tiene carga automática, explica brevemente qué archivo conviene cargar.
- Si ninguna skill encaja, trabaja con las instrucciones del proyecto sin forzar una skill.
