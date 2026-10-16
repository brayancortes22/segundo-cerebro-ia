# 📘 Manual Operativo del Ecosistema de Desarrollo (bscl)

Este manual documenta la arquitectura técnica, comandos operativos, variables de entorno y procedimientos estándar para todos los proyectos del desarrollador **Brayan Stid Cortés Lombana (bscl)**.

---

## 📑 Tabla de Contenidos
1. [Arquitectura General y Protocolo](#1-arquitectura-general-y-protocolo)
2. [CI/CD Web & Bypass de Proveedores Cloud (Vercel + GitHub Actions)](#2-cicd-web--bypass-de-proveedores-cloud-vercel--github-actions)
3. [Gestión de Forks Masivos (Aurora Engine / Godot 4.7.2)](#3-gestión-de-forks-masivos-aurora-engine--godot-472)
4. [Pipeline 3D Automatizado (Blender Production MCP)](#4-pipeline-3d-automatizado-blender-production-mcp)
5. [Pipeline Design-to-Code (Google Stitch MCP & Cloud ADC)](#5-pipeline-design-to-code-google-stitch-mcp--cloud-adc)
6. [Respaldo y Ruteo de Modelos IA (Smart AI Router)](#6-respaldo-y-ruteo-de-modelos-ia-smart-ai-router)

---

## 1. Arquitectura General y Protocolo

Todos los proyectos se rigen bajo las directrices estipuladas en [GEMINI.md](file:///c:/Users/NITRO%20ACER/Desktop/proyectos%20con%20ia/GEMINI.md):
* **3 Ramas Estrictas:** `development` (desarrollo) ➔ `qa` (staging/pruebas) ➔ `main` o `production` (despliegue verificado).
* **Modularidad Estricta:** Archivos concisos (<150-200 líneas). Cero God-Classes o God-Nodes.
* **Cero Hardcoding:** Todo parametrizable por base de datos o variables de entorno (`.env`).
* **Verificación Empírica (Addy Osmani):** Toda tarea pasa por `/spec` ➔ `/plan` ➔ `/build` ➔ `/review` con comandos reales.

---

## 2. CI/CD Web & Bypass de Proveedores Cloud (Vercel + GitHub Actions)

### 2.1. El Problema Resuelto
Vercel cobra $20/mes por asiento de colaborador en repositorios de equipo Pro, y en cuentas gratuitas (Hobby) bloquea o restringe despliegues colaborativos directos desde la integración Git oficial.

### 2.2. Solución Arquitectónica
Desacoplar la integración nativa Git de Vercel y orquestar el despliegue a través del runner de **GitHub Actions** utilizando el CLI de Vercel y secretos de cuenta de servicio.

### 2.3. Secretos y Variables Requeridas en GitHub
En el repositorio (Settings ➔ Secrets and variables ➔ Actions):
* **Secretos (`Secrets`):**
  * `VERCEL_TOKEN`: Token de acceso personal o de servicio generado en Vercel Account Settings.
  * `VERCEL_ORG_ID`: ID de la organización o cuenta de Vercel (extraído de `.vercel/project.json` o settings de Vercel).
  * `VERCEL_PROJECT_ID`: ID único del proyecto en Vercel.
  * `PR_AUTOMATION_TOKEN`: Personal Access Token (PAT) con alcance `repo` y `workflow` para auto-aprobar PRs.
* **Variables (`Variables`):**
  * `AUTO_MERGE_SOURCE_USER`: (Opcional) Nombre de usuario del colaborador de confianza (ej. `DiegoArias32`).

### 2.4. Flujo de Auto-Aprobación y Fusión (`auto-approve-merge.yml`)
Ubicación: `.github/workflows/auto-approve-merge.yml`
* Detecta PRs hacia `main` provenientes del colaborador o con la etiqueta `automerge`.
* Aprueba el PR usando `hmarr/auto-approve-action@v4` con `PR_AUTOMATION_TOKEN`.
* Activa la fusión automática squash usando `peter-evans/enable-pull-request-automerge@v3`.

### 2.5. Configuración Requerida en GitHub Repo
Para que los workflows tengan permisos de ejecutar fusiones y revisiones:
```powershell
# Habilitar auto-merge en el repositorio
gh repo edit <owner>/<repo> --enable-auto-merge

# Si se usa la API para ajustar permisos de workflow:
gh api -X PUT "repos/<owner>/<repo>/actions/permissions" -f default_workflow_permissions=write -F can_approve_pull_request_reviews=true
```

---

## 3. Gestión de Forks Masivos (Aurora Engine / Godot 4.7.2)

### 3.1. Regla Inquebrantable de Merges
En repositorios derivados de bases de código gigantescas (Godot cuenta con más de 84,000 commits):
* **PROHIBIDO:** Usar `squash merge` al integrar `development` hacia `qa` o `main`. Aplastar commits destruye la genealogía del historial y provoca conflictos irresolubles al sincronizar con upstream (`godotengine/godot`).
* **OBLIGATORIO:** Usar fusiones estándar con commit de merge:
  ```powershell
  # Aprobación y fusión de PR en forks upstream masivos
  gh pr merge <PR_NUMBER> --merge --auto
  ```

### 3.2. Aislamiento de Código Propio
* Todo desarrollo propio de Aurora Engine debe ubicarse en módulos independientes:
  `modules/aurora_core/`, `modules/aurora_intelligence/`, `modules/aurora_mcp/`.
* El código nativo de Godot no se modifica directamente a menos que sea estrictamente necesario para puntos de entrada del motor.

### 3.3. Trazabilidad de Milestones
* Al completar un hito:
  ```powershell
  git tag -a m0 -m "Milestone 0: Fork foundation, branding y baseline CI"
  git push origin m0
  ```
* Notificar al equipo y registrar el progreso en ClickUp (ej. tarea `86e3jvvu6`).

---

## 4. Pipeline 3D Automatizado (Blender Production MCP)

### 4.1. Arquitectura Local
El ecosistema conecta a los agentes de IA con **Blender 5.2.2 LTS** mediante el protocolo MCP con **274 herramientas especializadas**:
* **Addon de Blender:** Escucha en `localhost:9876`.
  * Ruta del Addon: `%APPDATA%\Blender Foundation\Blender\5.2\scripts\addons\blender_mcp.py`
* **Servidor MCP Python:** Repositorio local `blender-production-mcp`.
  * Entorno virtual: Administrado con `uv` (Python 3.11).
  * Ruta venv: `c:\Users\NITRO ACER\Desktop\proyectos con ia\blender-production-mcp\.venv\Scripts\python.exe`

### 4.2. Registro en Antigravity (`mcp_config.json`)
Ubicación: `%USERPROFILE%\.gemini\config\mcp_config.json`
```json
"blender-production": {
  "command": "c:\\Users\\NITRO ACER\\Desktop\\proyectos con ia\\blender-production-mcp\\.venv\\Scripts\\python.exe",
  "args": ["-m", "blender_production_mcp"],
  "cwd": "c:\\Users\\NITRO ACER\\Desktop\\proyectos con ia\\blender-production-mcp",
  "env": {
    "BLENDER_PORT": "9876",
    "BLENDER_HOST": "localhost",
    "BLENDER_PRODUCTION_SAFE_MODE": "true"
  }
}
```

### 4.3. Protocolo Operativo 3D
1. **Comprobar Salud del Entorno:**
   ```powershell
   cd "c:\Users\NITRO ACER\Desktop\proyectos con ia\blender-production-mcp"
   .venv\Scripts\python.exe verify_install.py
   .venv\Scripts\python.exe tests\environment_health.py
   ```
2. **Iniciar Blender con el Addon Activo:**
   Asegurar que en Blender (Edit ➔ Preferences ➔ Add-ons) el addon `Blender Production MCP` esté marcado y conectado al puerto `9876`.
3. **Puntos de Control Previos Obligatorios:**
   Antes de aplicar modificaciones en esqueletos (rigs), cinemática IK/FK, retopología o fijación de deslizamiento de pies (*foot sliding*), invocar la herramienta MCP:
   `production.create_checkpoint`

---

## 5. Pipeline Design-to-Code (Google Stitch MCP & Cloud ADC)

### 5.1. Arquitectura y Credenciales
Google Stitch conecta Antigravity con los modelos de diseño de Google (Gemini 3.8 Flash UI) alojados en Google Cloud:
* **Autenticación Directa por API Key (Método Primario y Permanente):**
  - Variable de entorno `STITCH_API_KEY` en `mcp_config.json`.
  - Inyecta directamente `X-Goog-Api-Key` hacia `https://stitch.googleapis.com/mcp`.
  - No requiere `gcloud auth application-default login` recurrente ni sufre caducidad de tokens interactivos.
* **Autenticación por Google Cloud ADC (Método de Respaldo / Fallback):**
  - Instalación portable en `%LOCALAPPDATA%\google-cloud-sdk\bin`.
  - Proyecto de cuotas: `stitch-dev-ia`.

### 5.2. Configuración en Antigravity (`mcp_config.json`)
```json
"stitch": {
  "command": "node",
  "args": [
    "C:/Users/NITROA~1/.gemini/stitch-mcp/index.js"
  ],
  "env": {
    "STITCH_API_KEY": "TU_STITCH_API_KEY",
    "GOOGLE_CLOUD_PROJECT": "stitch-dev-ia",
    "GOOGLE_APPLICATION_CREDENTIALS": "C:\\Users\\NITROA~1\\AppData\\Roaming\\gcloud\\application_default_credentials.json",
    "PATH": "C:\\Users\\NITROA~1\\AppData\\Local\\google-cloud-sdk\\bin;C:\\Windows\\System32;C:\\Windows;C:\\Program Files\\nodejs;C:\\Users\\NITROA~1\\AppData\\Roaming\\npm",
    "APPDATA": "C:\\Users\\NITROA~1\\AppData\\Roaming",
    "LOCALAPPDATA": "C:\\Users\\NITROA~1\\AppData\\Local",
    "USERPROFILE": "C:\\Users\\NITROA~1",
    "SystemRoot": "C:\\Windows",
    "SystemDrive": "C:"
  }
}
```

### 5.3. Flujo de Trabajo Design-to-Code
1. **Crear o Cargar Sistema de Diseño:** Subir `DESIGN.md` con tokens de diseño usando `upload_design_md`.
2. **Generar Pantalla:** Invocar `generate_screen_from_text` indicando el dispositivo (`MOBILE`, `DESKTOP`, `TABLET`).
3. **Validar Render Visual:** Descargar el screenshot con `fetch_screen_image`.
4. **Extraer y Refactorizar Código:** Obtener el código HTML/CSS con `fetch_screen_code` y modularizarlo inmediatamente en componentes React/Blade limpios (<150 líneas) aplicando la filosofía Ponytail.

---

## 6. Respaldo y Ruteo de Modelos IA (Smart AI Router)

### 6.1. Propósito
Garantizar continuidad operativa absoluta sin interrupciones por saturación de cuota o límites de tokens en los modelos principales de Gemini.

---

## 7. Suite de Agent Skills Portables (52 Skills Estandarizadas)

El ecosistema cuenta con 52 skills modulares sincronizadas entre el Vault de Obsidian (`proyectos con ia/.agents/skills`), el workspace activo (`.agents/skills`) y la configuración global (`~/.gemini/config/skills`).

### 7.1. Categorización de Skills Activas

* 🗜️ **Optimización de Tokens y Headroom de Contexto (Token Saving Suite):**
  - `caveman`: Reducción radical del 65% al 75% de tokens de salida suprimiendo relleno conversacional y cortesías superfluas sin perder rigor técnico, explicaciones fundamentales ni código.
  - `context-budget`: Monitoreo y auditoría activa del headroom de la ventana de contexto, detección de fugas y prevención de context bloat por lecturas excesivas de archivos.
  - `token-budget-advisor`: Estrategia y ajuste del gasto de tokens según el tipo de tarea (económica, estándar, exhaustiva).
  - `prompt-caching-strategy`: Optimización de prefijos estables para maximizar la tasa de aciertos de caché (Prompt Caching) en LLMs (Gemini, Claude, GPT), reduciendo el costo de entrada hasta en un 90%.
  - `strategic-compact`: Compactación estructurada en límites lógicos de fase para sostener conversaciones largas sin pérdida de información crítica.

* 🏗️ **Arquitecturas de Software y Organización de Código (Blueprints):**
  - `software-architecture-blueprints`: Matriz de decisión arquitectónica y estructuras de carpetas listas para usar (FSD, ADR Laravel 11, Clean Architecture, Game Engine Hierarchy, Monorepos).

* 🎨 **Suite Elite de Diseño UI/UX y Design-to-Code:**
  - `spline-3d-design`: Diseño, integración e interactividad 3D WebGL en tiempo real con Spline (heroes inmersivos, Bento 3D, React `@splinetool/react-spline` y Web Components a 60 FPS).
  - `web-motion-animation`: Micro-animaciones e iconografía reactiva con Lucide Animated (350+ iconos interactivos) y orquestación con Anime.js v4 (timelines, stagger y SVG morphing a 60 FPS).
  - `impeccable`: Auditoría de calidad visual, jerarquía, micro-interacciones y erradicación de "AI slop" (Paul Bakaus).
  - `huashu-design`: Producción visual HTML nativa, 20 doctrinas de diseño y radares de evaluación estética en 5D.
  - `ui-ux-pro-max`: Base de 67+ estilos visuales, paletas cromáticas armónicas y directrices por framework.
  - `taste-skill`: Diales de diseño (densidad visual, varianza, control de contraste, anti-patrones).
  - `web-design-guidelines`: Directrices oficiales de Vercel para accesibilidad y ergonomía de interfaz.
  - `awesome-design`: Tokens, variables y sistemas de diseño curados.
  - `image-to-code`: Protocolo de traducción visual de capturas o mockups a componentes modulares <150 líneas.
  - `ui-ux-designer`: Especialista en arquitectura de diseño y flujos de usuario.
  - `ux-ui-accessible-design`: Directrices estrictas WCAG 2.2 AA.

* 🧪 **Testing, QA y Automatización E2E:**
  - `playwright-best-practices`: Testing E2E senior, Page Object Model (POM), selectores resilientes (`getByRole`) y auto-waiting.
  - `multi-agent-qa-testing`: Orquestación de pruebas concurrentes con agentes evaluadores.

* 🛡️ **Seguridad Ofensiva, Pentesting y DevSecOps (Strix):**
  - `owasp-top-10-testing`: Explotación y validación activa de OWASP Top 10 (SSRF, Inyecciones, Broken Auth).
  - `api-security-testing`: Pentesting y auditoría de endpoints API REST y GraphQL.
  - `find-security-vulnerabilities-in-code`: Detección estática y dinámica de fallas en código fuente.
  - `fix-security-vulnerabilities-with-strix`: Generación automatizada de parches de remediación.
  - `web-app-penetration-testing`: Pruebas de intrusión en aplicaciones web completas.
  - `backend-api-data-security` y `data-security-privacy`: Cumplimiento legal (Habeas Data Colombia / SIC) y cifrado.
  - `devsecops-supply-chain`: Protección de dependencias y cadena de suministro de software.

* 🎮 **Videojuegos y Motores 3D:**
  - `game-development-core`: Fundamentos de loop de juego, arquitectura y mecánicas.
  - `godot-engine-fork-development`: Desarrollo C++ en fork de Godot (Aurora Engine).
  - `godot-game-development`: Creación de videojuegos sobre Godot (`project.godot`).
  - `unity-game-development` y `unreal-game-development`: Desarrollo en Unity y Unreal Engine.
  - `game-performance-optimization` y `gameplay-systems-design`: Optimización de framerate y diseño de sistemas.
  - `3d-animation-pipeline`: Automatización con Blender Production MCP (274 herramientas).
  - `web-3d-development`: Experiencias WebGL, Three.js y Shaders en navegador.

* 🌐 **Full Stack, Nube e Infraestructura:**
  - `full-stack-web-development`: Desarrollo frontend/backend moderno (Laravel, Next.js, React).
  - `cloud-infrastructure-architecture`, `container-platform-engineering` e `infrastructure-as-code`: Docker, Kubernetes, Terraform y Cloud.
  - `database-engineering` y `database-operations`: Modelado relacional, índices, réplicas y operaciones SQL/NoSQL.
  - `ci-cd-engineering`: GitHub Actions, auto-merge con PAT y pipelines de despliegue continuo.
  - `observability-sre`: Métricas, telemetría y fiabilidad de sistemas en producción.

* 📐 **Arquitectura y Agentes:**
  - `archify`: Generación de diagramas de arquitectura en Mermaid y C4.
  - `parallel-ide-agent-workflow`: Orquestación paralela en Antigravity IDE sin colisiones.
  - `multi-agent-software-development`: Flujos de enjambre Ruflo (Arquitecto, Senior, QA, DevSecOps).
  - `mcp-server-development`: Creación de servidores Model Context Protocol estándar.
  - `code-documentation`, `project-technical-documentation` y `universal-docs`: Documentación viva y estándares de lenguaje.

### 7.2. Script de Sincronización Automática
Para propagar cambios o nuevas skills del Vault a la configuración global de Antigravity:
```powershell
powershell -ExecutionPolicy Bypass -File "tools\sync-antigravity-skills.ps1"
```

---

## 8. Gateway Multi-Proveedor OmniRoute (`diegosouzapw/OmniRoute`)

### 8.1. Arquitectura y Beneficios
En cumplimiento de la **Regla 14 de GEMINI.md**, OmniRoute unifica cientos de proveedores de IA y modelos detrás de un único endpoint local:
* **~1.62B Tokens Gratuitos / Mes:** Aprovechamiento de más de 150 proveedores con free-tiers sin costo.
* **Cascada de Resiliencia en 4 Niveles:** Tier 1 (Suscripción) ➔ Tier 2 (API Key) ➔ Tier 3 (Modelos Económicos) ➔ Tier 4 (Tiers Gratuitos con Auto-Fallback).
* **Compresión Integrada RTK + Caveman:** Ahorro automático de entre 15% y 95% de tokens en cada solicitud.
* **Endpoint Local OpenAI-Compatible:** `http://localhost:20128/v1` accesible para cualquier agente o herramienta.
* **Servidor MCP con 110 Herramientas:** Operable por `stdio` (`omniroute --mcp`) o streaming HTTP (`http://localhost:20128/api/mcp/stream`).

### 8.2. Integración en `mcp_config.json`
```json
"omniroute": {
  "command": "cmd.exe",
  "args": [
    "/c",
    "omniroute",
    "--mcp"
  ]
}
```

### 6.1. Propósito
Garantizar continuidad operativa absoluta sin interrupciones por saturación de cuota o límites de tokens en los modelos principales de Gemini.

### 6.2. Configuración en Antigravity (`mcp_config.json`)
```json
"smart-router": {
  "command": "node",
  "args": [
    "C:\\Users\\NITRO ACER\\Desktop\\proyectos con ia\\smart-ai-router\\dist\\index.js"
  ]
}
```

### 6.3. Modelos Disponibles de Respaldo
Mediante la herramienta `consult_free_ai`:
* **Groq:** Qwen 2.5 Coder 32B / Llama 3.3 70B / DeepSeek R1 Distill.
* **OpenRouter:** Nemotron 70B / Mistral Small / Cohere.
* **Ollama Local:** Modelos locales en ejecución si no hay conexión a internet.
