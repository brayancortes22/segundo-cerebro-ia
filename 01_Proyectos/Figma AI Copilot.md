# 🎨 Figma AI Copilot — Asistente de Diseño Autónomo en Figma

* **Ubicación Local:** `figma-ai-copilot`
* **Estado:** 🟢 Activo · Plugin de Figma
* **Lead Developer:** Brayan Stid Cortés Lombana (`bscl`)
* **Stack Tecnológico:** TypeScript, Figma Plugin API, Google Gemini (2026), Cerebras Cloud (Llama 3.3 70B), Groq Cloud LPU, Pollinations.ai (Free Cloud)

---

## ⚡ Descripción y Funcionamiento

Plugin para Figma de diseño asistido por Inteligencia Artificial, creado para diseñadores y equipos de producto. Opera de manera autónoma, sin necesidad de servidores locales ni bloqueos por cuotas de API.

---

## 🌟 Arquitectura de Cascada Inteligente (Auto-Smart Cascade)

1. **Gestión Automática de Cuotas:**
   - Si la API principal de Google Gemini arroja `429 Too Many Requests` o `503 Service Unavailable`, conmuta en milisegundos a través de la jerarquía de modelos: `gemini-3.8-flash` ➔ `3.6-flash` ➔ `3.5-flash` ➔ `2.5-flash` ➔ `2.5-flash-lite`.
2. **Inferencia Ultra-Rápida con Groq & Cerebras:**
   - Integración con chips LPU de Groq y Cerebras (hasta 2.600 tokens/segundo con `llama-3.3-70b`).
3. **Nube Gratuita Pública (Fallback 100% Libre sin API Key):**
   - Si el usuario carece de claves de API o se agotan todas las cuotas del día, el plugin conmuta de forma transparente a endpoints públicos seguros (`https://text.pollinations.ai/`), garantizando que la herramienta nunca se detenga.
