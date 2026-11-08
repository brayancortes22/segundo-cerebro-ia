---
title: Bitácora de Sesiones, Decisiones y Conocimiento Cruzado Multi-IA
categoria: Memoria y Trazabilidad de Sesiones
fecha_creacion: 2026-11-05
autor: Brayan Stid Cortés Lombana (bscl)
agentes_auditados: Antigravity (Google DeepMind), OpenCode (Claude / Codex), VS Code AI Studio
tags:
  - memoria-ia
  - trazabilidad
  - opencode
  - antigravity
  - decisiones-tecnicas
  - historia-de-proyectos
---

# 🧠 Bitácora de Sesiones, Decisiones y Conocimiento Cruzado Multi-IA

Este documento consolida el conocimiento, debates técnicos, resoluciones de problemas y directivas maestras recuperadas tras auditar las **30 sesiones en OpenCode (`opencode.db`)** y las **87 sesiones en Antigravity (`brain/`)**.

---

## 🎯 1. Directivas Maestras del Desarrollador (Brayan - `bscl`)

### A. La Filosofía "Mente Propia y Cero Genérico" (Sesión `d5fad74c`)
* **Prompt original de Brayan:** *"dígale que guarde en la memoria local que él tenga mente propia, que haga lo mejor en todo, que no sea nada genérico ni IA..."*.
* **Impacto Sistémico:** Esta instrucción dio origen a la **Regla 10 de GEMINI.md**:
  - Prohibido el código o diseño perezoso ("AI slop").
  - Obligatorio cuestionar decisiones erróneas con honestidad técnica (Asesor Crítico).
  - Obligatorio generar referencias visuales AAA antes de codificar frontend.

### B. Adopción de GitHub Spec-Kit para Todas las IAs (Sesión OpenCode `ses_e52776f6`)
* **Instrucción de Brayan:** *"https://github.com/github/spec-kit.git instala eso porfa en las skills para todas las IAs es interesante"*.
* **Impacto Sistémico:** Integración de la skill `spec-driven-workflow` y la **Regla 16 de GEMINI.md** (Spec-Driven Development, Clarify Loop taxonómico de 4 niveles, tareas paralelas `[P]` y convergencia append-only).

---

## 🛠️ 2. Origen Real de los Proyectos del Ecosistema

Al cruzar las sesiones históricas se evidencia cómo cada proyecto nació de una necesidad concreta de la vida real de Brayan y su entorno:

| Proyecto | Sesión de Origen | Necesidad Real del Usuario | Solución Técnica Desarrollada |
|---|---|---|---|
| **PlayKey** | Antigravity `d3d1323e` | *"Para mi tío Sebas, necesita controlar la música o lo que se esté reproduciendo con los botones de volumen y pantalla apagada."* | Servicio de accesibilidad en Android (`VolumeAccessibilityService`) que intercepta `KEYCODE_VOLUME_UP/DOWN` con pantalla apagada y manda Broadcast a Spotify. |
| **Screen Streamer Ultra** | Antigravity `4fbecd9b` | *"Compartir pantalla de la PC a mi tablet por cable USB o Wi-Fi porque las apps que instalé tienen lag."* | Captura a 60 FPS por MediaProjection / WebSockets local con latencia menor a 25 milisegundos. |
| **BSCL Sec Sentinel** | Antigravity `93ed598a` | *"Un proyecto para probar vulnerabilidades en los proyectos que se realicen, generalizado pero efectivo."* | Motor SAST modular con 6 motores de detección: secretos (Gitleaks pattern), inyecciones SQL/XSS, anti-bot/honeypot, privacidad Habeas Data y supply chain. |
| **EduMind AI** | Antigravity `d4dec847` | *"Asistente de estudio 360° profesional que no sea genérico de IA, con visión y voz."* | SPA con OCR en navegador del cliente (Tesseract.js para no pagar servidores), flashcards 3D interactivas y exámenes ciegos. |
| **Figma AI Copilot** | Antigravity `cb0d464f` | *"Cómo hago un MCP a Figma para que me cree diseño, edite en los proyectos de Figma."* | Conexión Model Context Protocol con el plugin oficial de Figma y generación de componentes design-to-code. |
| **Transferencia USB-C** | OpenCode `ses_e7a4a799` | *"No tengo memoria USB, pero tengo cable Thunderbolt / Tipo C y necesito pasar 12 GB entre dos PCs rápido."* | Configuración de red punto a punto IP directa sobre interfaz Thunderbolt / USB-C a velocidades gigabit. |
| **Auditoría de YAAS** | OpenCode `ses_e5b40162` | *"Security review del repo cloned YAAS."* | Hallazgo de marcas de agua fijas (`raunakpatil.com`), ausencia de CLI y lenguaje en inglés. Condujo a la refactorización modular completa en español (`youtube-autopilot`). |

---

## ⚡ 3. El Medidor de Cuota de IA (OpenCode `ses_e5ab0a56`)

* **Requerimiento:** Brayan solicitó un indicador en tiempo real del uso de IA en OpenCode y consultó sobre Google Cloud.
* **Solución Arquitectónica:** Uso de **Google Cloud Monitoring API** (`generativelanguage.googleapis.com`):
  - Monitoreo de cuota por modelo (`quota/allocation/usage`).
  - Tasa de tokens y peticiones por minuto (`quota/rate/net_usage`).
  - Previene que las sesiones caigan en fallos silenciosos por cuota agotada.

---

## 📋 4. Protocolo de Producción y Lotes de Guiones (OpenCode `ses_e5307...`)

En las sesiones matutinas del 2026-11-05, OpenCode estructuró la producción por lotes semanales:
* **Lote A (10–16 nov):** 6 shorts (Supervisor multi-agente, doble gasto en ledger, deadlock, etc.).
* **Lote B (17–22 nov):** 6 shorts (Circuit breaker, tres ramas de Git, squash merge anti-patrón, fallback 3D).
* **Lote C (23–29 nov):** 6 shorts (Saga pattern, Clean Architecture, Habeas Data, escáner SAST, 150 líneas).
* **Lote D (30 nov–5 dic):** 6 shorts (Monolito modular, outbox pattern, event sourcing, MCP, rate limiting).

Esta división coincide exactamente con los **Pilares 1 al 6** del catálogo maestro de 90 guiones en `guiones_90_videos_tecnologia.md`.
