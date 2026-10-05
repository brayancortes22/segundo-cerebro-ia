---
tags:
  - mejora-continua
  - desarrollo-con-ia
  - videojuegos
  - aurora-engine
reviewed: 2026-10-04
---
# Auditoría del cerebro y desarrollo con IA

## Alcance y límites

Revisé el perfil de trabajo, las reglas de la bóveda, el catálogo y las skills; el post mortem NOVA → Aurora; las notas de Aurora Engine y Traductor de Juegos; y los checkouts locales de `aurora-engine`, `traductor de juegos` y `nasa project`, incluyendo sus remotos y commits recientes. La investigación externa se limitó a documentación oficial de Google y Google Cloud.

El CLI `gh` no está instalado en este entorno y la búsqueda pública no permitió consultar el contenido remoto de todos los repositorios u organizaciones. Los hallazgos sobre esos repos se basan en sus checkouts locales y URLs de `origin`, no en una auditoría de contenido privado en GitHub.

## Lo que ya haces bien

- **Piensas en producto y arquitectura a largo plazo.** Aurora tiene visión, módulos, upstream, riesgos, roadmap, ADRs, seguridad, CI y criterios de entrega.
- **Aprendes de fallos concretos.** El post mortem de NOVA reconoce construcción prematura de infraestructura, falta de resultados visibles, feature creep, optimización anticipada y recreación de herramientas que Godot ya resuelve.
- **Iteras y corriges.** Los commits de `traductor-de-juegos` alternan funciones, simplificaciones y fixes; `nasa project` registra integración de features y correcciones de CI/refactor después de detectar límites reales.
- **Tomas en serio trazabilidad y calidad.** Hay convenciones de ramas, documentación técnica, tests, pipelines y skills de QA/multiagente.

## Cuello de botella principal: convertir visión en evidencia

El historial local de `aurora-engine` está concentrado en documentación, gobernanza y CI. Su README, revisado el 2026-10-04, dice que Godot aún no fue importado, el repositorio no compila y no hay tests baseline. La visión de Aurora ya anticipa muchos sistemas; el siguiente paso de más valor es completar la foundation mínima que permita ejecutar el editor.

También había una discrepancia en la bóveda: esta nota marcaba M0 como terminado aunque el README del repo lo dejaba pendiente. La marqué incompleta en el centro de mando y en la ficha de proyecto. De ahora en adelante, considera un milestone terminado cuando existe evidencia de sus criterios de aceptación, no solo documentación, workflows o ramas.

## Aurora Engine y el videojuego futuro son productos distintos

El README de Aurora dice que el motor es generalista y que el juego AURORA será un proyecto separado para probarlo en uso real. En lo revisado no encontré un brief con género, jugador objetivo, plataforma, controles o loop principal del juego. `Traductor de Juegos` es una app Android de asistencia dentro de otros videojuegos; no es el repositorio del videojuego futuro.

No conviene inventar esos datos. Antes de diseñar mecánicas, prepara un brief de una página y acuerda sus decisiones abiertas. Mientras Aurora Engine no pueda compilar y ejecutar un proyecto, una recomendación práctica es validar las mecánicas con Godot estable sin fork; luego comprobar compatibilidad en Aurora cuando su foundation exista. Esto evita bloquear el juego por el desarrollo del motor.

## Flujo recomendado para trabajar con IA

1. **Define el resultado del usuario o jugador.** Una tarea debe terminar en una capacidad visible o una decisión útil; separa visión futura de objetivo del ciclo actual.
2. **Comprueba el estado real.** Lee instrucciones y archivos relevantes, identifica qué está implementado y qué solo está planeado. Si bóveda, README y código discrepan, deja constancia y corrige el registro.
3. **Divide en un lote pequeño.** Especifica alcance, archivos o módulos, criterios de aceptación y restricciones. Para trabajos complejos explora, prepara un plan corto y luego implementa.
4. **Usa agentes solo para trabajo independiente.** Asigna un dueño de integración, interfaces claras, rutas distintas o worktrees, y una salida verificable. Mantén QA como revisión independiente; evita que varios agentes escriban los mismos archivos.
5. **Cierra el ciclo localmente.** Usa el build, test, lint o reproducción visual pertinente al cambio cuando corresponda. Registra el comando, entorno y resultado real; no conviertas una sugerencia de agente en evidencia.
6. **Revisa el diff y conserva un punto de retorno.** Commits pequeños y rollback claro reducen el costo de probar una alternativa.
7. **Actualiza el registro técnico que cambió.** Modifica README, arquitectura, ADR, runbook o roadmap solo cuando la implementación lo requiera; enlaza fuentes en lugar de duplicar hechos que se desactualizan.

Google DORA identifica como capacidades que potencian el desarrollo con IA: política clara, datos internos accesibles y saludables, contexto interno disponible para IA, control de versiones sólido, lotes pequeños, foco en el usuario y plataformas internas de calidad. La guía de Antigravity añade un ciclo práctico de exploración → plan → ejecución con mecanismos locales de verificación. No son garantías de productividad; son condiciones para orientar y comprobar el trabajo.

## Reglas personales que conviene revisar con evidencia

- **Tres ramas obligatorias en todos los proyectos:** conserva protección y puntos de retorno, pero decide el número de ramas según el equipo, el despliegue y el coste de integración de cada repositorio. DORA respalda el control de versiones, los commits frecuentes, el rollback y los lotes pequeños; no exige un flujo universal de tres ramas.
- **Tope rígido de 150–200 líneas por archivo:** úsalo como señal para revisar responsabilidades y legibilidad, no como criterio automático de calidad. Divide cuando mejoren cohesión, pruebas y mantenimiento; evita refactors mecánicos para alcanzar un número.
- **Prohibiciones globales para toda tecnología o endpoint:** conserva la intención de seguridad y modularidad, pero expresa cada regla con su amenaza, alcance y excepción válida. Así el agente no implementa una defensa superficial ni fuerza patrones de Laravel en Godot, Android u otros stacks.
- **Planes largos antes de cualquier cambio:** el plan detallado sirve en decisiones arquitectónicas, cambios de riesgo o tareas multiarchivo; para un fix pequeño bastan objetivo, archivo y verificación. Mantener el costo de coordinación menor al valor del cambio acelera el ciclo sin perder trazabilidad.

## Práctica específica para el videojuego

Antes de ampliar la visión, acuerda jugador, fantasía central, género/cámara, plataforma, loop principal, restricciones, primer escenario y cómo se validará la experiencia. Luego construye una escena jugable de punta a punta con placeholders aceptados, controles reales y un resultado claro. Deja multijugador, mundo abierto, sistemas procedurales y tecnología de motor para cuando el prototipo demuestre que los necesita.

Al desarrollar, combina solo las skills pertinentes: `game-development-core` para alcance y prototipo; `gameplay-systems-design` para reglas/loop; la skill del motor del repo; `3d-animation-pipeline` para assets 3D; y `multi-agent-qa-testing` cuando pidas una revisión independiente. Para el código fuente de Aurora Engine, usa `godot-engine-fork-development`, no la skill de un juego Godot.

## Mejoras concretas ya incorporadas

- Skill nueva `godot-engine-fork-development` para mantener el límite entre fork de Godot y juegos hechos con el motor.
- `game-development-core` ahora incorpora lecciones del post mortem y exige distinguir un proyecto de juego de una herramienta de desarrollo.
- `project-technical-documentation` y la regla de auto selección ahora exigen reconciliar estado con evidencia actual del repo.
- La ficha de Aurora, el centro de mando y el conteo del catálogo se alinearon con el estado observado.

## Activación automática entre proyectos

Antigravity busca skills en `.agents/skills` del workspace y, para su IDE, en `~/.gemini/config/skills` global. Sincronizé las 32 skills y la regla de selección a las rutas globales para que se descubran al abrir otros workspaces. Comparé SHA-256 de los 225 archivos copiados y no hubo diferencias. El script `tools/sync-antigravity-skills.ps1` permite actualizarlas; admite `-WhatIf`, sobrescribe solo nombres coincidentes y no elimina otras carpetas. En otros clientes, la misma colección se puede cargar desde su ruta global propia, pero cada cliente define su configuración.

## Organizaciones y remotos observados localmente

- `aurora-engine-labs/aurora-engine`: remoto del checkout `aurora-engine`; el README lo identifica como privado.
- `nasa-earth-detectives/nasa-earth-trend-detective`: remoto del checkout `nasa project`, además de un remoto personal.
- `brayancortes22`: remotos personales para varios proyectos, incluidos `traductor-de-juegos`, `clickup-task-automator`, `netflix-tv-bridge` y `restaurante-bigpollo`.
- `DABC-resource`: aparece como organización del antecedente NOVA en el post mortem; no figura entre los remotos de los checkouts revisados.

## Fuentes oficiales consultadas

- [Google Cloud DORA: AI Capabilities Model](https://cloud.google.com/blog/products/ai-machine-learning/introducing-doras-inaugural-ai-capabilities-model)
- [Google Cloud DORA: reporte 2024](https://cloud.google.com/blog/products/devops-sre/announcing-the-2024-dora-report)
- [Antigravity CLI: mejores prácticas](https://www.antigravity.google/docs/cli/best-practices/)
- [Antigravity: Agent Skills](https://antigravity.google/docs/skills?app=antigravity-ide)

## Siguiente paso recomendado

Completar un único objetivo verificable de M0 —importar la versión fijada de Godot conservando su historial y conseguir el primer build local reproducible— antes de abrir los módulos de Aurora Intelligence, MCP, Blender o el videojuego. En paralelo, cuando quieras diseñar el juego, cerrar el brief de una página sin convertirlo todavía en una lista de sistemas.
