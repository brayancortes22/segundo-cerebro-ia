---
tags:
  - proyecto
  - inteligencia-artificial
  - extension-vscode
  - multiagente
estado: 🟢 En uso · mejoras en curso
autor: Brayan Stid Cortés Lombana (bscl)
version: 0.9.3
actualizado: 2026-10-08
---

# BSCL AI Studio

- **Tipo:** Extensión VS Code y derivados compatibles.
- **Código:** [Carpeta del proyecto](../../bscl-ai-studio/)
- **Documentación:** [README](../../bscl-ai-studio/README.md) · [Arquitectura](../../bscl-ai-studio/docs/ARCHITECTURE.md) · [Runbook](../../bscl-ai-studio/docs/RUNBOOK.md)
- **Router:** [Smart AI Router](../../smart-ai-router/README.md)
- **Relacionado:** [[00_Centro_de_Mando]], [[Sistemas Multiagente (Arquitectura, Orquestacion y Patrones)]], [[Redes Neuronales y Deep Learning]]

## Qué hace

Chat en español con contexto del editor, agentes con objetivo/subtareas/progreso y cambios de workspace reversibles. En modo automático, la extensión intenta Gemini 3.8 Flash directamente con la clave de un proyecto Google AI Studio Free; si Gemini falla o agota su cuota, usa Smart AI Router con Ollama local y modelos OpenRouter `:free` cuyo precio de entrada/salida se confirma como $0. Groq, SambaNova, OpenCode y APIs personalizadas no se llaman aunque sus claves sigan guardadas. La clave Gemini se guarda en SecretStorage de VS Code y debe volver a introducirse tras actualizar a 0.9.3.

El código no puede consultar ni impedir cambios en la facturación del proyecto de Google. Para conservar el costo cero, el proyecto debe mantenerse en Free y sin facturación vinculada. OpenRouter y los modelos gratuitos mantienen límites de uso; no agregar saldo.

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
