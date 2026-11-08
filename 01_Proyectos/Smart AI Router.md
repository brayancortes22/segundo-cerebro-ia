# 🔀 Smart AI Router — Gateway Local Multi-Proveedor

* **Ubicación Local:** `smart-ai-router` (Puerto local `3000`)
* **Estado:** 🟢 Activo · v2.0.0
* **Lead Architect:** Brayan Stid Cortés Lombana (`bscl`)
* **Stack Tecnológico:** Node.js, Express, OpenAI API Compatible Specs, Google Gemini SDK, Groq SDK, OpenRouter API, Ollama

---

## ⚡ Descripción y Funcionamiento

Gateway local compatible con el estándar de OpenAI (`/v1/chat/completions`) que enruta las solicitudes hacia la cascada de modelos gratuitos más potentes de la industria con enfriamiento individual por modelo y tolerancia a fallos.

---

## 🏛️ Cascada de Enrutamiento Resiliente (v2.0.0)

1. **Capa 1: Cascada Multi-Modelo de Gemini (2026):**
   - Conmutación automática entre `gemini-3.8-flash`, `gemini-3.6-flash`, `gemini-3.5-flash`, `gemini-flash-lite` y `gemini-2.5-flash` con detección de rate limits y cooldown dinámico.
2. **Capa 2: Cascada Ultra-Rápida Groq & Cerebras:**
   - Enrutamiento hacia `qwen/qwen3.8-27b`, `openai/gpt-oss-120b` y `llama-3.3-70b-versatile` en LPUs dedicados.
3. **Capa 3: OpenRouter `:free` con Puntuación Inteligente:**
   - Detección en vivo de modelos con coste \$0, priorizando modelos de programación y razonamiento (`qwen3-coder`, `deepseek-r1`, `nemotron`).
4. **Capa 4: Nube Gratuita Pública (`free-cloud`):**
   - Fallback a endpoints públicos sin clave API (`pollinations.ai`) para garantizar respuesta continua.
5. **Capa 5: Ollama Local:**
   - Inferencia offline en máquina local con verificación previa de memoria RAM libre.
