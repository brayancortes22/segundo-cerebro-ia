---
tags:
  - proyecto
  - inteligencia-artificial
  - extension-vscode
  - multiagente
estado: 🟢 En uso · mejoras en curso
autor: Brayan Stid Cortés Lombana (bscl)
version: 0.9.5
actualizado: 2026-10-13
---

# BSCL AI Studio

- **Tipo:** Extensión VS Code y derivados compatibles.
- **Código:** [Carpeta del proyecto](../../bscl-ai-studio/)
- **Documentación:** [README](../../bscl-ai-studio/README.md) · [Arquitectura](../../bscl-ai-studio/docs/ARCHITECTURE.md) · [Runbook](../../bscl-ai-studio/docs/RUNBOOK.md)
- **Router:** [Smart AI Router](../../smart-ai-router/README.md)
- **Relacionado:** [[00_Centro_de_Mando]], [[Sistemas Multiagente (Arquitectura, Orquestacion y Patrones)]], [[Redes Neuronales y Deep Learning]]

## Qué hace

Chat en español con contexto del editor, agentes con objetivo/subtareas/progreso y cambios de workspace reversibles. En modo automático, intenta Gemini 3.8 Flash y, si el usuario activa explícitamente Groq Free, Qwen 3.8 27B; después puede continuar con Smart AI Router, OpenRouter `:free` u Ollama local. Groq usa una sola solicitud simultánea y límites conservadores de contexto y respuesta. La clave Gemini y Groq se guarda en SecretStorage de VS Code. La opción automática de Groq viene apagada.

Se reutiliza de Figma AI Copilot la cascada Gemini/Groq/OpenRouter, junto con una explicación visible de qué proveedor conviene por tarea. Cerebras ofrece crédito de prueba limitado y OpenAI API puede facturar; Pollinations recibe prompts en un endpoint público. No se llaman en la extensión para proteger el modo sin costo y el código del workspace.

La extensión no puede consultar ni impedir cambios en la facturación de Google o Groq. Para conservar el costo cero, conserva ambos proyectos en Free, sin método de pago ni facturación vinculada. OpenRouter y los modelos gratuitos mantienen límites; no agregar saldo.

Antes de enviar cada modelo `:free`, el router y la extensión consultan el catálogo actual y comprueban que entrada y salida sigan en $0; si no pueden confirmarlo, bloquean la solicitud. El router prioriza Qwen, DeepSeek, MiniMax/Kimi y GLM cuando aparecen disponibles en ese catálogo. `openrouter/free` y Ollama local sirven de respaldo. No se agrega saldo ni se cambia a proveedores pagos.

La búsqueda web de OpenRouter puede cobrar por consulta aparte del modelo; por eso está desactivada. La extensión explica que las respuestas de investigación no consultan Internet y no debe inventar fuentes. Google Search grounding y la transcripción cloud también están desactivados.

La extensión acepta una carpeta arrastrada como carpeta de trabajo y adjunta código/documentación e imágenes. La transcripción cloud de audio está desactivada. Dentro de la carpeta puede crear, editar, borrar o renombrar archivos. Al finalizar, muestra los archivos afectados y permite revertir una entrega; cambios posteriores pueden bloquear una reversión insegura.

## Límites conocidos

El acceso local respeta permisos de Windows. Video, terminal autónoma, streaming progresivo y sincronización automática con Obsidian no están implementados. QA es análisis generativo, no compilación ni pruebas. Proveedores pueden fallar por cuota o conexión.

Ollama ejecuta solo si el servicio está disponible y la memoria libre supera el margen seguro. `ollama list` actualmente solo confirma `huihui_ai/qwen2.5-coder-abliterate:7b`; `qwen3.5:0.8b` todavía no aparece como instalado, por lo que no se ofrece en el selector hasta que la descarga termine. El modo automático omite el modelo local si la memoria está baja y no cambia a una API paga.

## Documentación técnica

- [Decisiones](../../bscl-ai-studio/docs/DECISIONS.md)
- [Referencia IPC/API](../../bscl-ai-studio/docs/API_REFERENCE.md)
- [Hoja de ruta](../../bscl-ai-studio/docs/VISION_AND_ROADMAP.md)

## Fuentes de política de costo

- [Modelos gratuitos de OpenRouter](https://openrouter.ai/collections/free-models/)
- [Qwen3.8 27B gratuito](https://openrouter.ai/qwen/qwen3.8-27b%3Afree)
- [Precios de la búsqueda web de OpenRouter](https://openrouter.ai/docs/guides/features/server-tools/web-search)
- [Planes y límites gratuitos de OpenRouter](https://openrouter.ai/pricing/)
- [Límites gratuitos de Groq](https://console.groq.com/docs/rate-limits)
- [Modelos de Groq](https://console.groq.com/docs/models)
- [Preguntas de facturación Groq](https://console.groq.com/docs/billing-faqs)
- [Precios actuales de Cerebras](https://www.cerebras.ai/pricing)
