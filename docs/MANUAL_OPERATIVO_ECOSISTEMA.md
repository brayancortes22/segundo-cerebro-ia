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
* **Google Cloud SDK:** Instalación portable en `%LOCALAPPDATA%\google-cloud-sdk\bin`.
* **Proyecto Activo y de Cuotas:** `stitch-dev-ia`.

### 5.2. Comandos de Inicialización y Renovación de Acceso
Si el token de Google Cloud expira o se requiere re-autenticar:
```powershell
# 1. Login interactivo de usuario
gcloud auth login

# 2. Credenciales por defecto para aplicaciones (ADC)
gcloud auth application-default login

# 3. Asignación del proyecto de cuotas para llamadas de API
gcloud auth application-default set-quota-project stitch-dev-ia

# 4. Fijar proyecto por defecto
gcloud config set project stitch-dev-ia
```

### 5.3. Configuración en Antigravity (`mcp_config.json`)
Para evitar que los subprocesos de Node en Windows pierdan el acceso al binario `gcloud`:
```json
"stitch": {
  "command": "cmd.exe",
  "args": [
    "/c",
    "set PATH=C:\\Users\\NITRO ACER\\AppData\\Local\\google-cloud-sdk\\bin;%PATH% && npx -y stitch-mcp"
  ],
  "env": {
    "GOOGLE_CLOUD_PROJECT": "stitch-dev-ia"
  }
}
```

### 5.4. Flujo de Trabajo Design-to-Code
1. **Crear o Cargar Sistema de Diseño:** Subir `DESIGN.md` con tokens de diseño usando `upload_design_md`.
2. **Generar Pantalla:** Invocar `generate_screen_from_text` indicando el dispositivo (`MOBILE`, `DESKTOP`, `TABLET`).
3. **Validar Render Visual:** Descargar el screenshot con `fetch_screen_image`.
4. **Extraer y Refactorizar Código:** Obtener el código HTML/CSS con `fetch_screen_code` y modularizarlo inmediatamente en componentes React/Blade limpios (<150 líneas) aplicando la filosofía Ponytail.

---

## 6. Respaldo y Ruteo de Modelos IA (Smart AI Router)

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
