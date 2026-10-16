---
name: web-motion-animation
description: Diseño, orquestación e implementación de micro-interacciones, animaciones de interfaz fluidas a 60 FPS, iconografía viva con Lucide Animated (lucide-animated.com) y orquestación con Anime.js v4 (animejs.com). Aplica para transiciones de estado, Bento grids escalonados, morphing SVG y feedback háptico visual.
metadata:
  version: "2.0.0"
  reviewed: "2026-10-16"
---

# Web Motion & Interactive Animation Suite

Esta habilidad guía la creación de interfaces vivas, dinámicas y con **Factor WOW** mediante el tándem de **Lucide Animated** (iconografía reactiva) y **Anime.js** (orquestación avanzada de layouts y vectores SVG).

---

## 🌟 1. Los Tres Niveles de la Pirámide de Motion

| Nivel | Herramienta Estándar | Propósito Principal |
| :--- | :--- | :--- |
| **Micro-Interacciones (Detalle)** | **`lucide-animated`** ([lucide-animated.com](https://lucide-animated.com/)) | Iconos vivos en botones, barras de navegación y confirmaciones que reaccionan al hover y click mediante `motion/react`. |
| **Orquestación de Layouts (Estructura)** | **`Anime.js`** ([animejs.com](https://animejs.com/)) | Entradas escalonadas (*Stagger*), contadores de números animados, transiciones entre páginas y morphing de SVG. |
| **Escenas Inmersivas 3D (Fondo / Hero)** | **`Spline 3D`** ([spline.design](https://spline.design/)) | Modelos 3D interactivos con WebGL que reaccionan al mouse y al scroll. |

---

## ⚡ 2. Implementación de `lucide-animated`

### Instalación vía CLI shadcn/ui
Compatible directamente con el registro de componentes shadcn:
```bash
# Ejemplo instalando iconos individuales listos para usar
npx shadcn@latest add @lucide-animated/bell
npx shadcn@latest add @lucide-animated/arrow-down
npx shadcn@latest add @lucide-animated/check
```

### Patrón de Componente de Acción (React / Next.js)
```tsx
import { ArrowDown } from '@/components/icons/arrow-down';
import { useState } from 'react';

export function DownloadButton() {
  const [downloading, setDownloading] = useState(false);

  return (
    <button 
      onClick={() => setDownloading(true)}
      className="group relative inline-flex items-center gap-2 rounded-xl bg-emerald-500/10 px-4 py-2.5 text-sm font-medium text-emerald-400 border border-emerald-500/20 hover:bg-emerald-500/20 transition-all duration-200"
    >
      <ArrowDown className="size-5 transition-transform group-hover:translate-y-0.5" />
      <span>{downloading ? 'Descargando...' : 'Descargar Reporte'}</span>
    </button>
  );
}
```

---

## 🎬 3. Implementación de `Anime.js` (v4)

### A. Animación en Cascada (Stagger) para Bento Grid
Aparición fluida de tarjetas con física elástica natural sin recargar la GPU:
```javascript
import anime from 'animejs';

export function animateBentoGrid() {
  anime({
    targets: '.bento-card',
    translateY: [35, 0],
    opacity: [0, 1],
    scale: [0.96, 1],
    delay: anime.stagger(100, { start: 150 }), // 100ms de retraso entre tarjetas
    easing: 'spring(1, 85, 12, 0)', // Masa=1, Rigidez=85, Damping=12
  });
}
```

### B. Contador Progresivo de Métricas (Dashboard / SaaS)
```javascript
export function animateCounter(elementId, targetValue) {
  const obj = { count: 0 };
  const targetElement = document.getElementById(elementId);

  anime({
    targets: obj,
    count: targetValue,
    round: 1, // Redondeo a números enteros
    duration: 1800,
    easing: 'easeOutExpo',
    update: () => {
      if (targetElement) {
        targetElement.textContent = obj.count.toLocaleString();
      }
    }
  });
}
```

### C. Morphing de Formas SVG
Transformar un icono o trazado SVG suavemente hacia otro:
```javascript
anime({
  targets: '#morph-path',
  d: [
    { value: 'M 10 10 H 90 V 90 H 10 L 10 10' }, // Cuadrado inicial
    { value: 'M 50 10 L 90 90 L 10 90 Z' }       // Triángulo destino
  ],
  duration: 1200,
  easing: 'easeInOutQuad',
  direction: 'alternate',
  loop: true
});
```

---

## 🛡️ 4. Reglas de Oro de Rendimiento y Accesibilidad (60 FPS)

1. **Aceleración por Hardware Obligatoria:** Animar exclusivamente `transform` (`translate`, `scale`, `rotate`) y `opacity`. PROHIBIDO animar propiedades de layout como `width`, `height`, `top`, `left` o `margin` que disparan reflujos (*reflow*).
2. **Respeto a `prefers-reduced-motion`:**
   ```css
   @media (prefers-reduced-motion: reduce) {
     *, ::before, ::after {
       animation-duration: 0.01ms !important;
       animation-iteration-count: 1 !important;
       transition-duration: 0.01ms !important;
       scroll-behavior: auto !important;
     }
   }
   ```
3. **Curvas Bezier Ergonómicas (Refero AAA):**
   * Entrada de elementos: `cubic-bezier(0.16, 1, 0.3, 1)` (snappy & natural).
   * Micro-hover en botones: Elevación de 2-4px en 150ms.
