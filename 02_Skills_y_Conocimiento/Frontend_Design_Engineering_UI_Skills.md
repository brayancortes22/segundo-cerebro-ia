# 🎨 Frontend & Design Engineering (Estándar UI Skills)

- **Fuente Oficial:** [https://www.ui-skills.com/skills/frontend](https://www.ui-skills.com/skills/frontend)
- **Creadores & Curadores:** Julien Thibeaut (`@ibelick`), Addy Osmani, Emil Kowalski, Anthropic, Vercel Labs, Million.js.
- **Skill Antigravity:** `design-engineering` (`.agents/skills/design-engineering/`)
- **Relacionado:** [[00_Centro_de_Mando]], [[Catalogo de Skills (Antigravity)]], [[Diseno_Web_UI_UX_Profesional]], [[Modern Web & Chrome Extensions]], [[Desarrollo Limpio con Frameworks (React, Angular, Laravel)]]

---

## 🎯 Filosofía: La Fusión de Diseño de Alta Gama e Ingeniería de Precisión

El **Design Engineering** representa el puente entre el diseño de producto (UI/UX) y la arquitectura de frontend robusta. Este estándar elimina el código visual descuidado (*UI slop*), garantizando experiencias digitales interactivas, estéticamente impactantes y optimizadas a nivel de milisegundos.

```
       ┌────────────────────────┐         ┌────────────────────────┐
       │     Diseño UI/UX       │         │   Ingeniería Frontend  │
       │ (Tipografía, Espaciado │ ◄─────► │ (React 19, Three.js,   │
       │  Color, Ergonomía)     │         │  Vite, Web Workers)    │
       └───────────┬────────────┘         └───────────┬────────────┘
                   │                                  │
                   └───────────────► ◄────────────────┘
                                     │
                                     ▼
                       ┌───────────────────────────┐
                       │    Design Engineer Pro    │
                       │ • Baseline UI (Desloping) │
                       │ • Motion a 60 FPS (GPU)   │
                       │ • Core Web Vitals Élite   │
                       │ • WCAG 2.2 Accesibilidad  │
                       │ • React Doctor Audit      │
                       └───────────────────────────┘
```

---

## 📐 1. Baseline UI & "Desloping" Visual (`ibelick/baseline-ui`)

| Principio | Regla de Oro | Ejemplo / Aplicación |
| :--- | :--- | :--- |
| **Escala de Espaciado** | Múltiplos estrictos de 4px y 8px | Micro: `4px/8px`, Cards: `16px/24px`, Secciones: `32px/48px/64px`. |
| **Radios Concéntricos** | `Radio(hijo) = Radio(padre) - Padding(padre)` | Padre `rounded-2xl (16px)` con `p-3 (12px)` ➔ Hijo `rounded (4px)`. |
| **Alineación Óptica** | Compensación visual para iconos y badges | `inline-flex items-center gap-2`. Usar `tabular-nums` en contadores. |
| **Bordes de Elevación** | Contraste sutil en modo oscuro | `border: 1px solid rgba(255, 255, 255, 0.08)` sobre superficies oscuras. |

---

## ⚡ 2. Motion Performance a 60 FPS (`iart-ai/60fps-animation`)

1. **Aceleración por GPU Estricta:**
   - ✅ **Permitido:** Animar únicamente `transform` (`translate3d`, `scale`, `rotate`) y `opacity`.
   - ❌ **Prohibido:** Animar `width`, `height`, `margin`, `padding`, `top`, `left`. Disparan *reflow* y destruyen la fluidez en pantallas móviles.
2. **Curvas Físicas Naturales (Spring Physics):**
   - Curva recomendada para aperturas y modales: `cubic-bezier(0.16, 1, 0.3, 1)`.
3. **Guarda Accesible de Movimiento Reducido:**
   - Cumplir siempre con `@media (prefers-reduced-motion: reduce)`.

---

## 🏎️ 3. Core Web Vitals de Vanguardia (`addyosmani/core-web-vitals`)

- **LCP (Largest Contentful Paint) < 1.2s:**
  - Precargar fuentes primarias mediante `<link rel="preload" as="font" type="font/woff2" crossorigin>`.
  - Usar `fetchpriority="high"` en elementos hero / cabecera.
- **INP (Interaction to Next Paint) < 100ms:**
  - Delegar tareas intensivas (DuckDB, mallas 3D, cálculos climáticos) a **Web Workers** para no bloquear el hilo de render.
- **CLS (Cumulative Layout Shift) = 0.00:**
  - Reservar cajas con `aspect-ratio` explícito antes de recibir imágenes o datos de API.

---

## ♿ 4. Accesibilidad Inclusiva WCAG 2.2 Nivel AA

1. **Contraste de Color:** Ratios mínimos de `4.5:1` para texto estándar y `3:1` para elementos gráficos de interfaz.
2. **Navegación por Teclado:**
   - Preservar anillos de foco inconfundibles con `:focus-visible` (`outline: 2px solid #6366F1; outline-offset: 2px;`).
   - Prohibido `outline: none` sin un estado de reemplazo accesible.
3. **Target Táctil Móvil:** Área mínima táctil de `44x44px` en cualquier elemento interactivo.

---

## 🎨 5. CSS Moderno: Primitivas de Nueva Generación

### A. Container Queries (`@container`)
Permite que cada componente responda dinámicamente a las dimensiones de su caja contenedora (ideal para monorrepos y arquitecturas modulares):
```css
.card-wrapper {
  container-type: inline-size;
}

@container (min-width: 500px) {
  .card-content {
    display: flex;
    flex-direction: row;
  }
}
```

### B. Selector Relacional `:has()`
Elimina estados redundantes en JavaScript al permitir que los padres reaccionen al estado de sus hijos:
```css
/* Resaltar barra de navegación si un diálogo modal está abierto */
body:has(dialog[open]) .main-header {
  opacity: 0.4;
  pointer-events: none;
}
```

### C. Espacio de Color `oklch()`
Gradientes con interpolación perceptual uniforme que evitan bandas oscuras:
```css
background: linear-gradient(135deg, in oklch, oklch(0.65 0.28 295), oklch(0.75 0.22 170));
```

---

## 🩺 6. Auditoría con React Doctor (Oxlint)

- **Linter de Arquitectura React:** Basado en Rust (`millionco/react-doctor`).
- **Métricas:** Evalúa el *Health Score* (0 a 100).
- **Enfoque:** Prevención de cadenas de `useEffect`, eliminación de fugas en el ciclo de vida de React 19 y optimización de componentes compuestos.
- **Comando Local:** `npm run doctor` o `npx -y react-doctor@latest frontend --verbose`.
