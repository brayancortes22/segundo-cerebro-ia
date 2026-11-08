---
name: browser-hands
description: Da ojos y manos reales en el navegador mediante el servidor MCP chrome-devtools. Navega, inspecciona el arbol de accesibilidad, hace clic y llena formularios, lee consola y red, captura evidencia y prepara el panel QA Annotator. Usala para probar o automatizar cualquier UI.
metadata:
  version: "1.0.0"
  reviewed: "2026-11-07"
---

# Browser Hands: ojos y manos en Chrome DevTools

## Regla de oro

- Usa las tools del servidor MCP **`chrome-devtools`**. En tu lista aparecen con un prefijo del tipo `mcp_chrome-devtools_` (el cliente muestra el nombre exacto). Busca las que terminan en `_navigate_page`, `_take_snapshot`, `_click`, `_fill`, `_take_screenshot`.
- **No uses el subagente `/browser`** ni abras Chrome visible para una prueba normal. El MCP esta configurado `--headless --isolated`: no debe aparecer ninguna ventana.
- Si las tools no aparecen, el servidor MCP no esta conectado: pide reiniciar Antigravity. No caigas a Playwright.
- **Nunca ejecutes `npx chrome-devtools-mcp` en la terminal.** Antigravity ya administra ese servidor; si lo lanzas a mano, el comando se queda colgado para siempre y bloquea la conversacion.

## Ciclo obligatorio (el mismo que usa OpenCode)

1. **Abrir**: `list_pages` para ver paginas; `navigate_page` sobre la pagina seleccionada. Si usas `new_page`, **no asumas `pageId: 1`**: vuelve a `list_pages` y usa el id de la pagina que quedo `[selected]`.
2. **Esperar**: `wait_for` si sabes que texto debe aparecer.
3. **Mirar**: `take_snapshot` con el `pageId` correcto. Devuelve el arbol de accesibilidad y `uid`s. Si el snapshot muestra `about:blank`, apuntaste a la pagina equivocada.
4. **Actuar**: `click`, `fill`, `fill_form`, `press_key`, `select_option`, `hover`, `drag`, `upload_file`, `handle_dialog` usando los `uid`s de ese snapshot.
5. **Volver a mirar**: despues de cada accion que cambie la pagina, `take_snapshot` de nuevo. Los `uid`s viejos expiran.
6. **Diagnosticar**: `list_console_messages` y `list_network_requests`; `get_network_request` para una request concreta.
7. **Evidencia**: `take_screenshot` con `pageId` y `filePath`.
8. **Cerrar**: reporta PASS/FAIL con consola, red y captura. Sin eso es NO VERIFICADO.

## Herramientas disponibles

| Necesidad | Tool |
| :--- | :--- |
| Paginas | `list_pages`, `new_page`, `navigate_page`, `select_page`, `close_page`, `resize_page` |
| Estructura | `take_snapshot` (uids), `wait_for` |
| Interaccion | `click`, `fill`, `fill_form`, `type_text`, `press_key`, `hover`, `drag`, `select_option`, `upload_file`, `handle_dialog` |
| Ver | `take_screenshot`, `screencast_start`, `screencast_stop` |
| Consola | `list_console_messages`, `get_console_message` |
| Red | `list_network_requests`, `get_network_request` |
| JS | `evaluate_script` |
| Estilos | `get_css_styles` |
| Rendimiento | `performance_start_trace`, `performance_stop_trace`, `performance_analyze_insight`, `lighthouse_audit` |
| Emular | `emulate` (viewport, red, CPU) |
| Memoria | `take_heapsnapshot` y derivadas |
| DevTools | `open_devtools`, `get_devtools_comments`, `resolve_devtools_comment`, `reveal_in_devtools` |

## Preparar el panel QA Annotator

Hazlo cuando quieras que el usuario comente secciones. El MCP escribe los archivos si pasas `filePath` y el servidor tiene `--workspace` apuntando al proyecto.

1. Genera un id: `qa_<timestamp>`.
2. Captura:

```text
take_screenshot({
  pageId,
  filePath: ".qa/shots/qa_123.png",
  format: "png"
})
```

3. Escribe la sesion con `evaluate_script` y `filePath`:

```text
evaluate_script({
  pageId,
  filePath: ".qa/latest.json",
  function: "() => { /* ver funcion de abajo */ }"
})
```

La funcion debe devolver exactamente:

```js
() => {
  const vw = innerWidth, vh = innerHeight;
  const selectorOf = (el) => {
    if (el.id) return '#' + CSS.escape(el.id);
    const tid = el.getAttribute('data-testid');
    if (tid) return '[data-testid="' + tid.replace(/"/g, '\\"') + '"]';
    const parts = [];
    let n = el;
    while (n && n.nodeType === 1 && parts.length < 4) {
      let s = n.tagName.toLowerCase();
      if (n.id) { parts.unshift('#' + CSS.escape(n.id)); break; }
      const cls = [...n.classList].filter((c) => /^[A-Za-z][\w-]*$/.test(c)).slice(0, 2);
      if (cls.length) s += '.' + cls.map((c) => CSS.escape(c)).join('.');
      const parent = n.parentElement;
      if (parent) {
        const same = [...parent.children].filter((c) => c.tagName === n.tagName);
        if (same.length > 1) s += ':nth-of-type(' + (same.indexOf(n) + 1) + ')';
      }
      parts.unshift(s);
      n = n.parentElement;
    }
    return parts.join(' > ');
  };
  const out = [];
  const nodes = document.querySelectorAll('button,a[href],input,select,textarea,[role="button"],h1,h2,h3,img,header,nav,main,section,footer,article,form,table,label');
  for (const el of nodes) {
    const r = el.getBoundingClientRect();
    if (r.width < 6 || r.height < 6) continue;
    if (r.bottom < 0 || r.top > vh || r.right < 0 || r.left > vw) continue;
    const st = getComputedStyle(el);
    if (st.visibility === 'hidden' || st.display === 'none' || Number(st.opacity) === 0) continue;
    const text = (el.innerText || el.value || el.getAttribute('aria-label') || '').trim().replace(/\s+/g, ' ').slice(0, 120);
    if (!text && !['IMG', 'INPUT', 'SELECT', 'TEXTAREA'].includes(el.tagName)) continue;
    out.push({
      selector: selectorOf(el),
      tag: el.tagName.toLowerCase(),
      text,
      rect: { x: Math.round(r.x), y: Math.round(r.y), width: Math.round(r.width), height: Math.round(r.height) }
    });
    if (out.length >= 220) break;
  }
  out.sort((a, b) => (b.rect.width * b.rect.height) - (a.rect.width * a.rect.height));
  return {
    id: 'qa_123',
    createdAt: new Date().toISOString(),
    url: location.href,
    title: document.title,
    viewport: { width: vw, height: vh },
    screenshot: '.qa/shots/qa_123.png',
    elements: out
  };
}
```

4. Avisa al usuario:

> Abre el panel **QA Annotator**, comenta las secciones y pulsa **Enviar al agente**.

5. Cuando llegue el mensaje `QA Annotator — comentarios del usuario`, atiende cada linea y re-captura.

## Comentarios nativos de DevTools (opcional)

Si el usuario prefiere comentar en DevTools y Chrome esta en modo visible:

1. `open_devtools` con `pageId`.
2. `get_devtools_comments` con `timeout: 30000`. Espera comentarios anclados a elementos y devuelve hilos con `threadId`.
3. Corrige y `resolve_devtools_comment` con `threadId` y `replyText`.

En modo `--headless` no hay ventana de DevTools: usa el panel QA Annotator.

## Errores comunes

- **`pageId` requerido**: llama `list_pages` y usa el id exacto.
- **Solo aparecen 9 tools**: el cliente esta en modo solo lectura / Plan Mode. Pide desactivarlo.
- **`Could not find DevToolsActivePort`**: el servidor intenta `--autoConnect` contra un Chrome que no tiene remote debugging. Con `--headless --isolated` no deberia pasar; reinicia el MCP.
- **Socket cerrado / Target closed**: reinicia el servidor MCP (cerrar y abrir Antigravity) y vuelve a `list_pages`.
- **La captura no se guarda**: `filePath` se resuelve relativo al directorio de trabajo del servidor (el proyecto), no a `--workspace`. Usa `.qa/shots/<id>.png` y confirma la ruta absoluta que devuelve la tool. `--workspace` solo limita que archivos puede tocar.

## Prohibido

- `/browser`, Playwright, Puppeteer, Selenium, `browser-pilot`, `start chrome`.
- Abrir ventanas nuevas de Chrome para "mostrar" una pagina.
- Declarar PASS sin consola, red y captura.
- Tocar produccion, pagos o datos reales sin permiso explicito.
