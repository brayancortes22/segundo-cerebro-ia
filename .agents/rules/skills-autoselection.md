---
trigger: always_on
description: Selecciona y carga automáticamente las Agent Skills aplicables a cada tarea de esta bóveda, sin exigir etiquetas manuales.
---
# Selección automática de skills

- Al inicio de cada tarea, compara lo solicitado y el proyecto con los nombres y descripciones de `.agents/skills/*/SKILL.md`; lee las skills más pertinentes antes de actuar. No esperes etiquetas como `$skill` ni menciones explícitas.
- Carga el conjunto mínimo útil: normalmente una skill de dominio y, solo si hacen falta, skills de apoyo. No leas todo el catálogo en cada tarea.
- Para cambios de arquitectura, API, datos u operación, aplica `project-technical-documentation`; para contratos, APIs públicas, módulos o docstrings, aplica `code-documentation`.
- Cuando el trabajo realmente se pueda dividir en tareas independientes, aplica `parallel-ide-agent-workflow` y las skills multiagente o de QA pertinentes. Evita paralelizar tareas que compitan por los mismos archivos.
- En Antigravity, usa `.agents/skills` y sus capacidades disponibles. En otro cliente, usa las skills que el cliente haya descubierto y no supongas que admite las reglas de Antigravity; si no tiene carga automática, explica brevemente qué archivo conviene cargar.
- Si ninguna skill encaja, trabaja con las instrucciones del proyecto sin forzar una skill.
