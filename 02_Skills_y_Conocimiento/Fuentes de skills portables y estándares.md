---
tags:
  - referencias
  - agent-skills
  - desarrollo
reviewed: 2026-10-04
updated: 2026-10-04
---
# Fuentes de skills portables y estándares

Fuentes consultadas para crear la colección y referencias para mantenerla vigente. Se priorizan especificaciones y documentación oficial; las cifras del mercado se toman como señales temporales, no como prueba de calidad.

## Formato y directorio de skills

- [Agent Skills — Specification](https://agentskills.io/specification): estructura de carpetas, YAML requerido y reglas del archivo SKILL.md.
- [skills.sh — Agent Skills Directory](https://www.skills.sh/): directorio y leaderboard comunitario; popularidad y vigencia pueden cambiar.
- [Vercel Labs — Agent Skills](https://github.com/vercel-labs/agent-skills): skills de React y buenas prácticas web.
- [Anthropic — Skills](https://github.com/anthropics/skills): skills publicadas para trabajo con agentes, incluido diseño frontend.
- [Matt Pocock — Skills](https://github.com/mattpocock/skills): materiales comunitarios de TDD, revisión y arquitectura.

## Motores y 3D

- [Godot — Performance](https://docs.godotengine.org/en/stable/tutorials/performance/index.html): optimización, profiling, CPU, GPU, 3D y multihilo. Preferir stable a latest cuando se necesite una versión publicada.
- [Unity — Manual](https://docs.unity3d.com/Manual/index.html): documentación del editor y runtime; confirmar el selector de versión del proyecto.
- [Unity — Profile your application](https://docs.unity3d.com/Manual/profiler-profiling-applications.html): mediciones de la aplicación y diferencias entre Editor y dispositivo destino.
- [Unreal Engine — Documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine): documentación de engine, Gameplay Framework, Blueprints y C++.
- [Unreal Engine — Performance Profiling](https://dev.epicgames.com/documentation/en-us/unreal-engine/introduction-to-performance-profiling-and-configuration-in-unreal-engine): frame time, Insights y configuración.
- [Blender 5.2 Manual — Animation & Rigging](https://docs.blender.org/manual/en/5.2/animation/index.html): keyframes, armatures, actions, constraints y rigging.
- [Blender — Geometry Nodes](https://docs.blender.org/manual/en/latest/modeling/geometry_nodes/index.html): modelado y generación procedural; revisar posibles funciones experimentales antes de depender de ellas.
- [Three.js Docs](https://threejs.org/docs/): referencia de APIs de renderizado y animación web.
- [Three.js Manual — Animation System](https://threejs.org/manual/en/animation-system.html): clips, loaders y AnimationMixer.

## Web, UX, accesibilidad y pruebas

- [W3C — WCAG 2.2](https://www.w3.org/TR/WCAG22/): estándar de accesibilidad web; validar los criterios aplicables al contexto y nivel objetivo.
- [Playwright — Best Practices](https://playwright.dev/docs/best-practices): prácticas de pruebas end-to-end de navegador.
- [Next.js — Production Checklist](https://nextjs.org/docs/app/guides/production-checklist): rendimiento, accesibilidad, seguridad, SEO y producción; específico de Next.js App Router.
- [MDN — Web Animations API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API): APIs web para animaciones controlables.

## CI/CD, nube e infraestructura

- [GitHub Actions — Deployments](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments): entornos, protecciones, concurrencia e historial de despliegues.
- [GitHub Actions — Secure use](https://docs.github.com/en/actions/reference/security/secure-use): riesgos de código no confiable, acciones de terceros, permisos y autenticación OIDC.
- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/): revisión de arquitectura para cargas de AWS.
- [Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/): confiabilidad, seguridad, costo, operación y rendimiento en Azure.
- [Google Cloud Well-Architected Framework](https://docs.cloud.google.com/architecture/framework): guías para cargas seguras, resilientes, eficientes y costo-efectivas.
- [Terraform — Configuration Language](https://developer.hashicorp.com/terraform/language): referencia de configuración declarativa.
- [OpenTofu — Documentation](https://opentofu.org/docs/): referencia de infraestructura como código compatible con su propia versión.
- [Docker — Build best practices](https://docs.docker.com/build/building/best-practices/): imágenes pequeñas, bases confiables, caché y reproducibilidad.
- [Kubernetes — Resource management](https://kubernetes.io/docs/concepts/resource-management/): solicitudes, límites y asignación de recursos.

## Bases de datos y operación

- [PostgreSQL 18 — Documentation](https://www.postgresql.org/docs/current/): referencia vigente, incluyendo consultas, índices, administración y respaldo.
- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/current/sql-explain.html): lectura de planes; EXPLAIN ANALYZE ejecuta la sentencia y puede producir sus efectos.
- [MySQL 8.4 — Reference Manual](https://dev.mysql.com/doc/refman/8.4/en/): manual con versión identificada para SQL, administración y rendimiento.
- [MySQL — EXPLAIN](https://dev.mysql.com/doc/refman/8.4/en/explain.html): inspección del plan de ejecución.
- [MongoDB — Manual](https://www.mongodb.com/docs/manual/): documentos, modelado, índices, consultas y operaciones.

## Observabilidad y seguridad de la cadena de suministro

- [OpenTelemetry — Documentation](https://opentelemetry.io/docs/): señales, SDKs y exportación neutral de trazas, métricas y logs.
- [SLSA specification](https://slsa.dev/spec/v1.1/): procedencia y garantías de la cadena de suministro de software.
- [OpenSSF Scorecard](https://github.com/ossf/scorecard): comprobaciones automatizables para prácticas de seguridad de repositorios.

## MCP y agentes

- [Model Context Protocol — Specification](https://modelcontextprotocol.io/specification/2025-11-25): roles de host/client/server, herramientas, recursos, prompts y consideraciones de seguridad.
- [Anthropic — How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system): delegación, paralelización, coste, evaluación y observabilidad.
- [Anthropic — Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents): evaluación de agentes con casos, métricas y jueces.
- [LangGraph — Examples](https://langchain-ai.github.io/langgraph/tutorials/overview/): ejemplo de supervisores y patrones de agente en una implementación concreta.

## Documentación técnica

- [Diátaxis — Documentation framework](https://diataxis.fr/): distingue tutoriales, guías prácticas, referencia y explicación para organizar documentación técnica.
- [Google Developer Documentation Style Guide](https://developers.google.com/style): claridad, estructura y convenciones de documentación técnica.
- [Microsoft Writing Style Guide](https://learn.microsoft.com/en-us/style-guide/welcome/): referencia de estilo y terminología técnica.

## Antigravity y otros IDEs con agentes

- [Google Antigravity IDE — Overview](https://www.antigravity.google/docs/ide/overview/): editor, agentes asíncronos/paralelos, navegador y artefactos.
- [Google Antigravity — Rules](https://www.antigravity.google/docs/rules/): reglas persistentes del workspace, ubicaciones y activadores `always_on`, `model_decision`, `glob` y `manual`.
- [Google Antigravity — Agent Skills](https://antigravity.google/docs/skills?app=antigravity-ide): descubrimiento de skills y ubicación workspace/global.
- [Google Antigravity — Projects](https://www.antigravity.google/docs/projects/): proyectos, carpetas y worktrees aislados para agentes concurrentes.
- [Google Antigravity — IDE extensions](https://www.antigravity.google/docs/ide/extensions/): editores con extensión oficial listados en la documentación.
- [Google Antigravity — Workflows to skills migration](https://antigravity.google/docs/migration/workflows-to-skills): transición desde workflows a skills.
- [VS Code — Manage agent sessions](https://code.visualstudio.com/docs/agents/run/sessions/manage-sessions): sesiones paralelas, workspaces y aislamiento de cambios.
- [Cursor — Background Agents](https://docs.cursor.com/background-agent): agentes remotos asíncronos y flujo de handoff.
- [JetBrains AI Assistant — Agents](https://www.jetbrains.com/help/ai-assistant/agents.html): agentes, instrucciones de proyecto, skills y permisos en IDEs JetBrains.

## Criterio de mantenimiento

Antes de recomendar una API concreta, comprobar la documentación de la versión instalada y la plataforma objetivo. Registrar cambios de versión en la skill afectada. Auditar el contenido antes de instalar skills de terceros; no ejecutar scripts ni copiar secretos desde un paquete solo porque aparece en un ranking.
