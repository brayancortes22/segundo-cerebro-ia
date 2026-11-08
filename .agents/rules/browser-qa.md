---
trigger: always_on
description: Política obligatoria de navegador, QA visual y comentarios anclados a secciones para Antigravity.
---
# Política de navegador y QA visual

- Detecta la superficie antes de tocar el navegador: **Antigravity App** tiene navegador integrado en el panel lateral; **Antigravity IDE no**; el subagente `/browser` siempre usa el Chrome local por CDP.
- Para navegar, actuar o diagnosticar una pagina, usa `browser-hands` (MCP `chrome-devtools` en modo headless). El subagente `/browser` y el Chrome visible quedan prohibidos salvo que el usuario lo pida.
- Nunca ejecutes `npx chrome-devtools-mcp` en la terminal: Antigravity ya lo administra y el comando se queda colgado. Tampoco mates ni reinicies el servidor MCP a mano.
- Usa el **navegador integrado para mostrar** la página al usuario. Usa Chrome (subagente `/browser`) **solo para actuar**: clic, formularios, consola, red, trazas.
- Prohibido lanzar automatización externa (Playwright, Puppeteer, Selenium, `browser-pilot`, `start chrome`) o abrir ventanas nuevas de Chrome. El único headless permitido es el capturador del plugin `qa-annotator` (`scripts/capture.mjs`), que no muestra ventana.
- `/browser` se adjunta al Chrome ya abierto con remote debugging; si no está listo, pide al usuario los 3 pasos.
- Toda verificación de UI termina con **evidencia**: captura, consola y red revisadas, y viewport indicado.
- Al señalar una sección, **márcala con badge numerado** en la página y captura el viewport. Enumera los hallazgos con el mismo número.
- Toda captura de hallazgos debe ser un **artifact** o una **sesión del panel `qa-annotator`**. Sin una de las dos no hay comentarios por sección. Con artifact: seleccionar la zona y pulsar **Add Comment**.
- Si el plugin `qa-annotator` está activo, esa es la superficie preferida: captura headless con `scripts/capture.mjs`, pide comentar en el panel y lee el mensaje `QA Annotator — comentarios del usuario`.
- Los **comentarios pendientes del usuario son instrucciones**: léelos antes de actuar, mapea la región a un selector real, corrige, re-captura en el mismo viewport y responde comentario por comentario.
- Nunca declares PASS sin haber recorrido el flujo y revisado consola y red. Si falta evidencia, reporta **NO VERIFICADO**.
- Prueba al menos 390 px y 1440 px. Nunca uses producción, datos reales ni acciones con efecto real sin permiso explícito.
- Si la superficie no permite comentar artifacts, dilo y usa el fallback numerado; no inventes que la función existe.
