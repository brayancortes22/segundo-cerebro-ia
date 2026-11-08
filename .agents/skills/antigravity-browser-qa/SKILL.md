---
name: antigravity-browser-qa
description: Prueba y valida aplicaciones web en la superficie de navegador correcta, con evidencia visual, consola, red, responsive y comentarios anclados a las secciones que se señalan. Úsala cuando haya que verificar una UI, reproducir un error, hacer QA visual, señalar una sección, o pedir y atender comentarios sobre una captura.
metadata:
  version: "1.0.0"
  reviewed: "2026-11-07"
---

# QA visual en Antigravity (navegador integrado + comentarios por sección)

## Modelo mental: qué navegador existe en cada superficie

| Superficie | Navegador integrado | Herramienta del agente | Para qué sirve |
| :--- | :--- | :--- | :--- |
| **Antigravity App** | Sí: panel lateral, cookies propias | No es una tool; es UI | **Mostrar** la página al usuario y comentar |
| **Antigravity IDE** | No existe | — | Solo editor |
| **Cualquier superficie** | — | Subagente `/browser` sobre **Chrome local** vía CDP | **Actuar**: clic, formularios, consola, red, trazas |

Reglas duras:

1. **No lances automatización externa** (Playwright, Puppeteer, Selenium, `browser-pilot`, `start chrome`, headless propio) para sustituir al navegador de la superficie. Eso es exactamente lo que molesta al usuario.
2. **Chrome solo se usa para actuar**, nunca solo para "mostrar" una página o tomar una captura simple. Si la superficie puede mostrar la página, muéstrala ahí.
3. **Nunca abras una ventana nueva de Chrome**: `/browser` se adjunta al Chrome que el usuario ya tiene abierto con remote debugging. Si no está listo, pide los 3 pasos; no lo resuelvas abriendo otra instancia.
4. Si la superficie no expone una acción para abrir el navegador integrado, **no lo simules**: entrega la URL y pide abrirla en el panel lateral. No caigas en abrir Chrome "para que la veas".

## Equivalencias: cómo lo hago yo en OpenCode

En OpenCode uso la tool `browser`, que abre un Chromium **dentro de la app** (panel Review) y expone refs de accesibilidad. En Antigravity no existe esa tool: usa la superficie equivalente.

| Lo que hago en OpenCode | Equivalente en Antigravity |
| :--- | :--- |
| `tabs.open` + `snapshot` | `/browser` → navegar + snapshot accesible |
| `click`, `fill`, `select`, `check`, `press` | clic, formulario, teclas del subagente |
| `console` y `network.list` | consola y red del subagente |
| `screenshot` | captura guardada como **artifact** |
| Comentario del usuario → `ref` | **Add Comment** → región → selector |
| `preview` | artifact en el panel lateral |
| `lighthouse`, `trace`, `cpu`, `heap` | auditoría, traza y memoria del subagente |
| `tabs.focus` | panel lateral / pestaña activa de la app |

## Cómo desarrollo yo (el ciclo que debes copiar)

1. **Contexto primero**: lee el repositorio y, si existe, `.agents/memory/decisions.md` y `learnings.jsonl`. Separa lo verificado de lo supuesto.
2. **Plan explícito**: objetivo, archivos exactos, criterio de aceptación y cómo se va a verificar en navegador.
3. **Cambios pequeños**: archivos <150–200 líneas, sin hardcoding, patrones del proyecto.
4. **Verificación real**: no declares éxito por "compila". Abre la página, recorre el flujo, revisa consola y red, y captura evidencia.
5. **Documentación y memoria**: actualiza el doc afectado y registra el aprendizaje si hubo un fallo relevante.

Para trabajo multi-frente, combina con `ciclo-completo`. Para UI/accesibilidad, con `web-design-guidelines` o `ux-ui-accessible-design`.

## Protocolo de prueba (7 pasos, con evidencia)

### 1. Pre-vuelo
- Confirma URL, comando del dev server, datos de prueba y viewport(s). Nunca uses datos ni pagos de producción.
- Baseline: captura el estado inicial antes de tocar nada.

### 2. Carga
- Revisa **consola** (errores y warnings) y **red** (4xx/5xx, fallos de transporte, requests lentos).
- Confirma título/URL final y que no haya pantalla en blanco ni error boundary.

### 3. Flujo funcional
- Toma un snapshot accesible antes de actuar; usa refs de ese snapshot, no inventes selectores.
- Ejecuta el happy path completo. Después de cada acción que cambie la página, **snapshot nuevo**.
- Prueba el camino triste: validación, doble clic, submit vacío, permisos.

### 4. Estados
- Loading, vacío, error, sin permisos, deshabilitado, éxito.
- Que cada estado tenga feedback visible y recuperable.

### 5. Responsive
- 390 px (móvil), 768 px (tablet), 1440 px (desktop). Revisa overflow horizontal, texto cortado y targets táctiles.

### 6. Accesibilidad y rendimiento
- `lighthouse` para a11y/SEO/best practices; navegación con teclado y foco visible.
- Traza solo si hay un problema de rendimiento concreto; no la uses como decoración.

### 7. Regresión
- Re-ejecuta el flujo tras el fix, en el mismo viewport y con el mismo dato. Compara antes/después.

**Un PASS exige**: flujo recorrido + consola sin errores nuevos + red sin fallos nuevos + captura artifact. Si falta algo, es "no verificado", no "funciona".

## Señalar secciones y pedir comentarios (obligatorio)

El usuario quiere **comentar sobre la sección exacta que señalas**, no leer una descripción. Haz siempre este ciclo:

### A. Marca la sección en la página
Inyecta badges numerados sobre los elementos señalados y captura el viewport (no full page: los badges son `position: fixed` y se desplazan al hacer scroll).

```js
() => {
  document.querySelectorAll('[data-qa-mark]').forEach(n => n.remove());
  const marks = [
    { sel: 'header nav', label: 'Contraste bajo' },
    { sel: 'main form button[type=submit]', label: 'Sin estado disabled' }
  ];
  const found = [];
  marks.forEach((m, i) => {
    const el = document.querySelector(m.sel);
    if (!el) return;
    const r = el.getBoundingClientRect();
    const b = document.createElement('div');
    b.dataset.qaMark = '1';
    b.textContent = String(i + 1);
    b.title = m.label;
    Object.assign(b.style, {
      position: 'fixed', left: (r.left - 6) + 'px', top: (r.top - 6) + 'px',
      zIndex: 2147483647, width: '22px', height: '22px', borderRadius: '50%',
      background: '#e11d48', color: '#fff', font: '700 12px/22px system-ui',
      textAlign: 'center', boxShadow: '0 0 0 2px #fff'
    });
    document.body.appendChild(b);
    found.push({ n: i + 1, label: m.label, selector: m.sel, rect: { x: r.x, y: r.y, w: r.width, h: r.height } });
  });
  return found;
}
```

`evaluate_script` pide aprobación por defecto: es normal. No busques otra vía para saltarla.

### B. Entrega la captura como artifact
- Guarda la captura en los artifacts de la conversación. **Una captura suelta no es artifact y no permite comentar.**
- Escribe la leyenda: "Selecciona la zona con el mouse, escribe tu comentario y pulsa **Add Comment**. Los comentarios se envían con tu siguiente mensaje o con **Review**."
- Enumera los hallazgos `1)`, `2)`… mapeados al badge, para que el comentario no dependa de adivinar.

### C. Lee y resuelve los comentarios
- Antes de actuar, revisa **comentarios pendientes**. Son instrucciones del usuario, no ruido.
- Mapea la región comentada al elemento real. Si el comentario viene de una imagen, convierte coordenadas:

```js
({ x, y, shotW, shotH }) => {
  const vw = innerWidth, vh = innerHeight;
  const px = x * (vw / shotW), py = y * (vh / shotH);
  const el = document.elementsFromPoint(px, py).find(e => !e.dataset.qaMark);
  if (!el) return null;
  const parts = []; let n = el;
  while (n && n.nodeType === 1 && parts.length < 5) {
    let s = n.tagName.toLowerCase();
    if (n.id) { parts.unshift(s + '#' + n.id); break; }
    const cls = [...n.classList].filter(c => !c.startsWith('qa-')).slice(0, 3);
    if (cls.length) s += '.' + cls.join('.');
    parts.unshift(s); n = n.parentElement;
  }
  return { selector: parts.join(' > '), tag: el.tagName, text: (el.innerText || '').trim().slice(0, 120) };
}
```

- Confirma en voz alta: "comentario 1 → `main form > button.primary`". Si hay ambigüedad, pregunta antes de tocar código.
- Corrige, vuelve a capturar **en el mismo viewport**, y responde comentario por comentario: qué cambió y evidencia nueva.
- Si la superficie no tiene UI de comentarios por artifact, dilo y usa el fallback: lista numerada + selector + "responde `1: …`". Nunca afirmes que habilitaste comentarios si no existen.

## Plantilla de informe

```md
## Prueba — <página o feature>
Superficie: Antigravity App | IDE · URL · viewport
Resultado: PASS | FAIL | NO VERIFICADO
Evidencia: <artifact 1>, <artifact 2>
Consola: 0 errores / N (detalle)
Red: 0 fallos nuevos / N (url → status)
Hallazgos:
1. `<selector>` — problema — severidad — comentario vinculado
2. ...
Corregido y re-verificado: sí/no — evidencia
No verificado: <qué y por qué>
```

## Antipatrones (prohibidos)

- Abrir Chrome, Playwright o `browser-pilot` para una captura o para "mostrar" la app.
- Decir "mira la captura" sin artifact ni badges.
- Señalar con palabras ("el botón de arriba") sin marcar la sección.
- Ignorar comentarios pendientes o responder sin re-capturar.
- Declarar PASS sin consola y red revisadas.
- Probar solo 1440 px.
- Usar producción, datos reales o acciones con efecto real sin permiso explícito.

## Referencias

- [Browser overview (IDE)](https://antigravity.google/docs/ide/browser/)
- [/browser y subagente](https://antigravity.google/docs/commands/browser)
- [Chrome integrado vs Chrome local](https://antigravity.google/docs/ide/separate-chrome-profile)
- [Screenshots y comentarios por región](https://antigravity.google/docs/screenshots)
