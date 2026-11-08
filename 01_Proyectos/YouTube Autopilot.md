---
title: YouTube Autopilot — Canal Arquitectura IA
status: 🟢 En Producción · Pipeline Automatizado
fecha_inicio: 2026-11-04
ultima_actualizacion: 2026-11-05
autor: Brayan Stid Cortés Lombana (bscl)
agentes: Antigravity (Director & Guionista) + OpenCode / Claude (Productor & Publicador)
repositorio: https://github.com/brayancortes22/youtube-autopilot
tags:
  - youtube-autopilot
  - hyperframes
  - tiktok-api
  - arquitectura-ia
  - multiagente
  - automatizacion
---

# 📺 YouTube Autopilot — Canal Automatizado "Arquitectura IA"

Sistema autónomo de producción, renderizado, diseño de avatares y publicación programada de contenido técnico vertical (YouTube Shorts y TikTok) sobre arquitectura de software, inteligencia artificial, DevSecOps y lecciones reales del vault de proyectos de **Brayan Stid Cortés Lombana (`bscl`)**.

---

## 👥 1. Arquitectura de Coordinación Multi-Agente (Antigravity + OpenCode)

Para evitar colisiones de archivos o corrupción de procesos (`WinError 32` en codificación H.264), se estableció un protocolo estricto documentado en `COORDINACION.md`:

| Dimensión | Antigravity (Google DeepMind) | OpenCode (Claude / Anthropic) |
|---|---|---|
| **Rol Oficial** | **Guionista & Director de Escena** | **Productor Técnico & Publicador** |
| **Responsabilidades** | • Investigación técnica y banco de temas.<br>• Catálogo maestro de 90 guiones en 6 pilares.<br>• Puesta en escena visual y disparadores de poses.<br>• Diseño de arte conceptual de avatares y escenarios.<br>• Análisis acústico de la voz real de Brayan. | • Motor de animación 3D / HyperFrames (`index.html`).<br>• Síntesis de voz y sincronización de subtítulos (`words.json`).<br>• Renderizado acelerado por GPU (ANGLE NVIDIA).<br>• Miniaturas panorámicas (`miniatura.jpg`).<br>• Subida y programación en YouTube Data API v3 y TikTok. |
| **Zona de Escritura Exclusiva** | `guiones_90_videos_tecnologia.md`, `.agents/automations/`, scripts de slicing de sprites y prompts de arte conceptual. | `hyperframes-studio/**`, `autopilot/**`, `canal/shorts/**` (`hf.json`, `miniatura.jpg`, `youtube.json`). |
| **Rama Git Oficial** | `development` (siguiendo la regla de 3 ramas: `development ➔ qa ➔ main`). |

---

## 🎨 2. Universo Visual y Sistema de Sprites Modulares

Para garantizar **retención visual máxima** sin caer en inconsistencias de IA generativa ("AI slop"), se desarrolló un kit modular de sprites 2D sobre fondos cel-shaded premium:

### A. Avatar de Brayan (`bscl`)
* **Rasgos:** Joven programador latino de 22-25 años, hoodie verde bosque oscuro con cordones blancos limpios, gorra negra deportiva y visor deportivo con HUD cian.
* **6 Poses Recortadas con Transparencia Alfa (PNG):**
  1. `brayan_idle_talking.png` (explicación a cámara).
  2. `brayan_pointing.png` (señalando arriba a la tarjeta de código).
  3. `brayan_thinking_skeptical.png` (duda con ceja alzada).
  4. `brayan_panic_facepalm.png` (reacción a fallas en producción).
  5. `brayan_victory_thumbsup.png` (aprobación y cierre).
  6. `brayan_coding_hacker.png` (tecleando en terminal flotante).

### B. Elenco Secundario
* **Byte (Dron IA):** Proyector holográfico, alertas de latencia y métricas (`byte_hover_idle.png`, `byte_projector.png`, `byte_alert_panic.png`, `byte_idea_success.png`).
* **El Monolito:** Coloso servidor de piedra y racks IBM/Linux (`monolith_solid_fortress.png`, `monolith_overloaded_smoke.png`).
* **El Glitch / Bug:** Bicho cibernético con aberración cromática (`glitch_crawling_sabotage.png`, `glitch_error_explosion.png`, `glitch_defeated_running.png`).
* **El Bot Scraper:** Androide encapuchado de múltiples brazos (`scraper_sneaky_typing.png`, `scraper_honeypot_trapped.png`).
* **Elena (DevOps / SRE):** Médica táctica con desfibrilador cibernético (`elena_diagnosing_defibrillator.png`).

### C. Los 4 Escenarios de Fondo
1. **Escenario A — Cyber Command Lab:** Centro de datos nocturno con terminales holográficas cian.
2. **Escenario B — Server Outage Room:** Sala de servidores en llamas con humo y alertas 500.
3. **Escenario C — Digital Fortress & WAF Bastion:** Escudo láser y trampa de Honeypot.
4. **Escenario D — Clean Architecture Suite:** Espacio zen minimalista estilo Ponytail.

---

## 🎙️ 3. Perfil Acústico y Síntesis de Voz de Brayan

Analizado a partir de nota de voz real de 28.48s (`brayan_voice_sample.ogg`, Opus 48 kHz mono):
* **Frecuencia Fundamental (F0):** 120 Hz – 142 Hz (Barítono medio / tenor ligero).
* **Cadencia:** 116 WPM (conversacional y reflexivo), adaptado a ~130-135 WPM en Shorts.
* **Acento:** Colombiano andino (respetuoso, suave y educado).
* **Calibración Edge-TTS:** `es-CO-GonzaloNeural` (`rate="+2%"`, `pitch="-1Hz"`). Probado con `brayan_calibrada.mp3`.
* **Muestra Dorada para Voice Cloning:** Lista para F5-TTS / XTTS-v2 / ElevenLabs.

---

## 📜 4. Catálogo Maestro de los 90 Guiones

Registrados y enriquecidos en `guiones_90_videos_tecnologia.md`:
* **Pilar 1 (01–15):** Arquitectura de Software & Sistemas Distribuidos (Monolito vs Microservicios, Circuit Breaker, Saga, Outbox, Event Sourcing).
* **Pilar 2 (16–30):** Historias Reales del Vault de Obsidian (CarBeat 3D en radios viejas, Aurora Engine en C++, Banking Transaction Core API, BSCL Sec Sentinel, Smart AI Router, EduMind, etc.).
* **Pilar 3 (31–45):** Inteligencia Artificial, Agentes y LLMs (Patrón ReAct, Memory episódica/semántica, Groq LPUs, SLMs, Prompt Caching).
* **Pilar 4 (46–60):** DevSecOps, Ciberseguridad y Blindaje Web (Honeypots, Denial of Inventory, Envenenamiento npm/pip, Habeas Data Ley 1581).
* **Pilar 5 (61–75):** Ingeniería de Videojuegos & Pipeline 3D (No squash merge en forks gigantes, Shaders PBR/SSS, Blender MCP 274 tools).
* **Pilar 6 (76–90):** Cultura Senior, Debates de Reddit y Filosofía Ponytail (Anti-God class <150 líneas, Clean Arch vs Pragmatismo).

---

## 🚀 5. Automatización y Estado de Publicación

### Pipeline Operativo Diario:
* **YouTube Data API v3:** Cuota diaria protegida (máximo 5 subidas por día para no agotar las 10.000 unidades).
* **TikTok Content Posting API:** Borrador enviado directamente a la bandeja de entrada del teléfono de Brayan.
* **Mecanismos de Automatización:**
  1. **GitHub Actions:** `.github/workflows/autopilot_daily.yml` (se dispara diario a las 14:00 UTC / 09:00 AM Colombia).
  2. **Windows Task Scheduler:** `instalar_tarea_programada.ps1` ejecuta `autopilot/daily.cmd` a las 09:30 AM localmente.
  3. **Antigravity CLI:** Ejecución bajo demanda mediante `.agents/automations/automatizacion_subida_videos.md`.

### Estado de Publicación a 2026-11-05:
* **Total Videos Generados:** 32 shorts.
* **Videos ya Programados en YouTube:** **6 shorts** (del 5 al 10 de noviembre).
* **Videos Aprobados en Cola:** **25 shorts** (del 11 de noviembre en adelante, subiéndose en lotes diarios de a 5).
