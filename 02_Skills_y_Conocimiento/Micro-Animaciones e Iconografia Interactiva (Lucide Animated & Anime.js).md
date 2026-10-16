# 🎬 Micro-Animaciones e Iconografía Interactiva — Lucide Animated & Anime.js

- **Propósito:** Guía de arquitectura y patrones de código para implementar micro-interacciones de élite, iconografía reactiva y orquestación fluida a 60 FPS con **Lucide Animated** ([lucide-animated.com](https://lucide-animated.com/)) y **Anime.js** ([animejs.com](https://animejs.com/)).
- **Relacionado:** [[00_Centro_de_Mando]], [[Catalogo de Skills (Antigravity)]], [[Spline 3D (Diseno Web Interactivo)]], [[Frontend_Design_Engineering_UI_Skills]], [[Diseno_Web_UI_UX_Profesional]]
- **Skill Asociada:** `web-motion-animation`

---

## 🌟 1. El Rol de las Micro-Interacciones en Interfaces Refero AAA

Siguiendo la **Regla 12 de GEMINI.md (Estándar de Diseño Refero AAA)**, una interfaz de usuario pasa de parecer una maqueta genérica a sentirse como un producto de élite (Linear, Apple, Spotify, Raycast) cuando incorpora **movimiento con propósito**:
* **Feedback Inmediato:** El usuario siente que el botón "responde" al contacto físico.
* **Continuidad Espacial:** Las tarjetas y menús se transforman de forma orgánica sin saltos bruscos.
* **Jerarquía de Atención:** Guiar la vista del usuario hacia los datos críticos (contadores de estadísticas, estados de pago, alertas).

---

## ⚡ 2. `lucide-animated` — Iconografía Reactiva

Colección open-source (MIT) de más de 350 iconos vectoriales interactivos para React / Next.js creados sobre `motion/react`.

### Instalación vía shadcn CLI
```bash
npx shadcn@latest add @lucide-animated/bell
npx shadcn@latest add @lucide-animated/check
npx shadcn@latest add @lucide-animated/shopping-cart
```

### Ejemplo en Componente de Tarjeta de Acción:
```tsx
import { ShoppingCart } from '@/components/icons/shopping-cart';
import { useState } from 'react';

export function AddToCartButton() {
  const [added, setAdded] = useState(false);

  return (
    <button 
      onClick={() => setAdded(!added)}
      className="group flex items-center gap-2 px-4 py-2.5 rounded-xl bg-white/5 hover:bg-white/10 text-white border border-white/10 transition-all duration-150 active:scale-95"
    >
      <ShoppingCart className="size-5 text-emerald-400 transition-transform group-hover:scale-110" />
      <span className="text-sm font-medium">{added ? 'En el carrito' : 'Agregar'}</span>
    </button>
  );
}
```

---

## 🚀 3. `Anime.js` (v4) — Orquestación de Layouts y Vectores

Motor ultraliviano (~10KB) para animar CSS, SVG, Canvas y variables de JavaScript sin dependencias pesadas.

### A. Animación Escalonada (Stagger) de Tarjetas Bento
```javascript
import anime from 'animejs';

export function animateBentoGrid() {
  anime({
    targets: '.bento-card',
    translateY: [40, 0],
    opacity: [0, 1],
    scale: [0.95, 1],
    delay: anime.stagger(100, { start: 200 }), // 100ms entre tarjetas
    easing: 'spring(1, 80, 12, 0)', // Simulación física de resorte
  });
}
```

### B. Contadores Numéricos Suaves para Dashboards
```javascript
export function animateMetric(elementId, endValue) {
  const state = { value: 0 };
  const target = document.getElementById(elementId);

  anime({
    targets: state,
    value: endValue,
    round: 1,
    duration: 1600,
    easing: 'easeOutExpo',
    update: () => {
      if (target) target.textContent = `$${state.value.toLocaleString()}`;
    }
  });
}
```

---

## 🛡️ 4. Principios de Rendimiento y Prevención de Reflows (60 FPS)

1. **Solo Composición de GPU:** Animar exclusivamente `transform` y `opacity`. El navegador resuelve estas propiedades en el hilo del compositor sin recalcular geometría.
2. **Curva Bezier Estándar:** `cubic-bezier(0.16, 1, 0.3, 1)` para transiciones de UI elegantes y reactivas.
3. **Respeto a `prefers-reduced-motion`:**
   ```css
   @media (prefers-reduced-motion: reduce) {
     *, ::before, ::after {
       animation-duration: 0.01ms !important;
       transition-duration: 0.01ms !important;
     }
   }
   ```

---

> 💡 **Cómo activar en Antigravity:** Al solicitar: *"Agrega micro-animaciones en hover a los botones de navegación"* o *"Anima la entrada de las tarjetas del dashboard con stagger"*, el asistente aplicará automáticamente los patrones de `web-motion-animation` con Lucide Animated y Anime.js.
