---
name: spline-3d-design
description: Diseño, integración y optimización de experiencias 3D interactivas para la web con Spline (spline.design). Usa para crear micro-interacciones 3D, heroes inmersivos, Bento grids con modelos 3D flotantes, eventos interactivos (hover, click, scroll, mouse-look) y componentes React/Vanilla de alto rendimiento (60 FPS).
---

# Spline 3D Interactive Design Skill

Esta habilidad guía el diseño, integración técnica y optimización de escenas 3D interactivas en aplicaciones web modernas utilizando **Spline 3D** ([spline.design](https://spline.design/)).

---

## 🎯 1. Cuándo Usar Spline 3D

* **Landing Pages con Factor WOW:** Heroes con objetos 3D que reaccionan al movimiento del cursor (*Mouse Look*) o al scroll.
* **Componentes Bento Grid 3D:** Tarjetas interactivas con maquetas de producto o iconos 3D flotantes que reaccionan al hover.
* **Showcase Interactivo de Producto:** Visualizadores 3D donde el usuario puede rotar, hacer zoom e inspeccionar características (gadgets, calzado, packaging, layout de mesas).
* **Micro-Interacciones Lúdicas:** Botones o toggles con animación 3D física al hacer click.

> [!TIP]
> **Spline vs. Blender:** Usa Spline para diseño de interfaz web interactiva rápida, liviana y nativa en el navegador. Usa Blender cuando requieras mallas con millones de polígonos, esqueletos complejos de personajes (IK/FK) o cinemáticas para videojuegos (Aurora Engine).

---

## 💻 2. Patrones de Integración en Código

### A. React & Next.js (`@splinetool/react-spline`)
Instalación:
```bash
npm install @splinetool/react-spline @splinetool/runtime
```

Componente con Lazy Loading y Manejo de Carga:
```tsx
import React, { Suspense, useRef } from 'react';
const Spline = React.lazy(() => import('@splinetool/react-spline'));

interface SplineHeroProps {
  sceneUrl: string;
}

export function SplineHero({ sceneUrl }: SplineHeroProps) {
  const splineRef = useRef<any>(null);

  function handleLoad(splineApp: any) {
    splineRef.current = splineApp;
    // Acceso directo a nodos 3D por su nombre en Spline:
    // const targetObject = splineApp.findObjectByName('InteractiveButton');
  }

  function trigger3DAnimation() {
    if (splineRef.current) {
      // Disparar evento o cambiar variable en el runtime
      splineRef.current.emitEvent('mouseHover', 'InteractiveButton');
    }
  }

  return (
    <div className="relative w-full h-[600px] overflow-hidden rounded-2xl bg-slate-950/40 border border-white/10 backdrop-blur-md">
      <Suspense fallback={
        <div className="flex h-full w-full items-center justify-center text-sm text-slate-400">
          <div className="h-6 w-6 animate-spin rounded-full border-2 border-emerald-500 border-t-transparent mr-2" />
          Cargando experiencia 3D...
        </div>
      }>
        <Spline 
          scene={sceneUrl} 
          onLoad={handleLoad} 
          className="w-full h-full"
        />
      </Suspense>
    </div>
  );
}
```

### B. Vanilla Web Component (HTML / Blade / PHP)
Para sitios estáticos o plantillas Blade en Laravel:
```html
<!-- Enlace al runtime CDN -->
<script type="module" src="https://unpkg.com/@splinetool/viewer@latest/build/spline-viewer.js"></script>

<!-- Visor 3D nativo -->
<div class="spline-container" style="width: 100%; height: 500px;">
  <spline-viewer 
    loading-anim-type="spinner-small-light" 
    url="https://prod.spline.design/TU_ID_DE_ESCENA/scene.splinecode">
  </spline-viewer>
</div>
```

---

## ⚡ 3. Directrices de Rendimiento y Garantía 60 FPS

1. **Presupuesto Geométrico (Polycount):**
   * Desktop: Mantener por debajo de 50,000 triángulos por escena completa.
   * Mobile: Mantener por debajo de 20,000 triángulos.
2. **Sombras y Luces:**
   * Evitar más de 2 luces con sombras dinámicas activas. Preferir iluminación ambiental o *baked shadows* en texturas.
3. **Control de Eventos Puntero (`pointer-events`):**
   * Si la escena 3D es solo decorativa (un fondo animado que no requiere clicks), aplicar `pointer-events: none` en CSS para no ralentizar los eventos táctiles y de scroll de la página.
4. **Lazy Loading Viewport:**
   * Cargar el componente Spline solo cuando se encuentre a 200px del viewport utilizando `IntersectionObserver` o `Suspense`.

---

## 🎨 4. Sinergia con la Suite de Diseño Antigravity

* **`ui-ux-pro-max`:** Provee la paleta cromática armónica y el estilo de interfaz (Glassmorphism, Bento, Dark Elegance) para que la escena 3D combine perfectamente con el resto del sitio.
* **`impeccable`:** Audita el balance visual entre los elementos 2D (tipografía, botones, espaciado) y la escena 3D, garantizando que el modelo 3D no eclipse la jerarquía del mensaje.
* **`taste-skill`:** Ajusta diales de densidad y contraste para evitar que el 3D parezca un juguete descolocado o un render genérico de IA.
