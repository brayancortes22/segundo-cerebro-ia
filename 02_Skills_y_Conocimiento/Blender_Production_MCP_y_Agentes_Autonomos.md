---
tags:
  - mcp
  - blender
  - automatizacion
  - inteligencia-artificial
  - agentes
reviewed: 2026-10-19
---

# Blender Production MCP y Agentes Autónomos

## 1. Arquitectura de Conexión Local
* **Host y Puerto:** `localhost:9876` (TCP Socket bidireccional).
* **Addon:** `MCP for Blender` (`addon.py`), protocolo versión 9.
* **Modo Operativo:**
  * Las peticiones enviadas por clientes externos (Antigravity) se encolan en `command_queue` y son procesadas por un temporizador recurrente en el hilo principal de Blender (`_drain_command_queue`), garantizando acceso seguro y estable al contexto de `bpy`.

---

## 2. Capacidades y Comandos Soportados

| Comando / Tipo | Parámetros | Utilidad |
| :--- | :--- | :--- |
| `scene_audit` | `{}` | Inspecciona número de objetos, mallas, cámaras, materiales, curvas y escalas no uniformes. |
| `execute_code` | `{"code": "import bpy..."}` | Ejecuta scripts de Python directamente en la sesión activa de Blender con la interfaz gráfica visible. |
| `get_viewport_screenshot` | `{"filepath": "..."}` | Captura en tiempo real lo que el usuario o el agente ve en el viewport 3D. |
| `get_world_state_snapshot` | `{}` | Mapeo rápido de selecciones y transformaciones de los objetos. |

---

## 3. Skills de Extensión y Video/RAG Investigadas
Para acelerar la investigación de tutoriales de modelado de piel en Blender en tiempo récord:
1. **`ZeroPointRepo/youtube-skills` & `wendy7756/AI-Video-Transcriber`:** Extracción automática de transcripciones de videos de YouTube para digerir técnicas de modelado sin requerir visualización manual completa.
2. **`ganesh3/rag-youtube-assistant` & `XynaxDev/youtube-rag-system`:** RAG sobre videos técnicos de YouTube para consultar rápidamente flujos de trabajo específicos (nodos de piel, alphas de poros, retopología).
3. **`addyosmani/agent-skills`:** Protocolo estricto de ingeniería (Spec $\rightarrow$ Plan $\rightarrow$ Build $\rightarrow$ Review) para ejecución de código y modelos 3D sin racionalizaciones prematuras.
