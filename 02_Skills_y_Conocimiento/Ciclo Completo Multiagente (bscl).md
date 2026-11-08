# 🤖 Ciclo Completo Multiagente (bscl) — Protocolo Autónomo

* **Estándar:** Flujo Integral Autónomo de Brayan Stid Cortés Lombana (`bscl`)
* **Ubicación de Skill:** `.agents/skills/ciclo-completo/SKILL.md`
* **Memoria Persistente:** `.agents/memory/decisions.md` y `.agents/memory/learnings.jsonl`

---

## ⚡ Filosofía y Anatomía del Sistema

Este flujo de trabajo es el estándar de ejecución obligatoria para requerimientos y desarrollos del ecosistema de **bscl**:

1. **Orquestador Central:** Antigravity (hilo principal). Coordina, delega tareas independientes y sintetiza resultados.
2. **Escuadrón de 7 Subagentes Especializados:** Invocados concurrentemente vía `invoke_subagent`.
3. **Memoria Persistente Compartida:** Consulta y actualización automática en `.agents/memory/decisions.md` y `.agents/memory/learnings.jsonl`.
4. **Herramientas & MCPs Activos:** Chrome DevTools (con puntero visual inyectado), Stitch MCP, Reddit Buddy y Smart AI Router.
5. **Estrategia de Modelos Zero-Friction:** Prioridad a IAs gratuitas/directas para tareas rutinarias; reserva de modelos de alta potencia para razonamiento crítico o pentesting.
6. **Supervisión Humana:** Brayan aprueba el plan inicial (Regla 2) y recibe el informe final con evidencias gráficas y trazabilidad.

---

## 👥 Escuadrón de 7 Subagentes Especializados

| Subagente | Rol / Tipo | Misión Principal | Evidencia Requerida |
| :--- | :--- | :--- | :--- |
| **1. Arquitecto / Investigador** | `Codebase & Architecture Researcher` | Consulta la memoria persistente, analiza dependencias y diseña la estructura modular (<150-200 líneas). | Plan técnico y contratos de interfaces. |
| **2. Desarrollador Senior** | `Senior Feature Developer` | Implementa con Filosofía Ponytail, sin código quemado (No Hardcoding) y estética Refero AAA. | Código modular y desacoplado. |
| **3. Auditor QA & Tester Visual** | `QA & Visual Verification Engineer` | Compila, corre tests y navega con puntero visual inyectado en Chrome (`take_screenshot`). | Capturas con puntero, consola limpia y 60 FPS. |
| **4. DevSecOps & Hardening** | `DevSecOps & Code Hardening Engineer` | Audita trampas invisibles (honeypot), rate-limiting estricto, saneamiento de datos y CORS. | Reporte de defensas y saneamiento. |
| **5. Hacker Ético / Pentester** | `Adversarial Pentester & Security Hacker` | Ataca activamente la app: busca inyecciones (SQLi/XSS), bypass de autenticación e IDOR. | Reporte de vulnerabilidades explotadas y mitigadas. |
| **6. Auditor Legal & Anti-Demandas** | `Legal Compliance & Data Privacy Officer` | Blindaje regulatorio: Habeas Data (Ley 1581 Colombia y GDPR), consentimientos y términos. | Checklist legal anti-demandas verificado. |
| **7. Usuario Final Crítico (UX)** | `Critical End-User & UX Auditor` | Audita con `web-design-guidelines` y Chrome DevTools en móvil (390px) y desktop (1440px). | Capturas de defectos y fricción de uso. |

---

## 📋 Protocolo Obligatorio en 8 Fases

1. **Fase 1: Consulta de Memoria Persistente y Selección de Skills:** Lectura de `.agents/memory/` y activación de skills pertinentes.
2. **Fase 2: Plan de Acción Estructurado:** Presentación a Brayan del objetivo, archivos exactos y plan de pruebas.
3. **Fase 3: Investigación y Arquitectura (Subagente 1):** Diseño de contratos limpios y validación de compatibilidad.
4. **Fase 4: Construcción Modular (Subagente 2):** Implementación Ponytail (<150 líneas) y tipado estricto.
5. **Fase 5: QA Técnico con Puntero Visual en Navegador (Subagente 3):** Inyección de cursor interactivo en Chrome DevTools y capturas de flujo.
6. **Fase 6: DevSecOps Perimetral (Subagente 4):** Validación de rate-limiting, honeypot y dependencias.
7. **Fase 7: Hacking Ofensivo y Pentesting (Subagente 5):** Ataque activo a endpoints y parches inmediatos ante hallazgos.
8. **Fase 8: Blindaje Legal y Auditoría UX (Subagentes 6 y 7):** Checkboxes de Habeas Data y ergonomía en múltiples resoluciones.
