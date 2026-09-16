---
name: ui-ux-designer
description: >-
  Diseño de interfaces web y móviles profesionales de nivel élite (UI/UX).
  Aplica sistemas de diseño modernos, paletas cromáticas armónicas, glassmorphism,
  micro-animaciones, tipografía fluida, modo oscuro premium y experiencia de usuario WOW.
---

# UI/UX Designer Pro — Estándar de Excelencia Visual y Experiencia de Usuario

Utiliza esta skill siempre que se diseñen, construyan o refactoricen interfaces de usuario (Frontend, Blade, React, Vue, HTML/CSS o vistas móviles) para garantizar que los proyectos luzcan con un acabado ultra profesional, moderno, sofisticado y de calidad comercial internacional.

---

## 🎨 1. Filosofía Visual: El Factor "WOW"

Queda terminantemente prohibido construir interfaces planas, genéricas, estilo plantilla escolar o con colores primarios saturados sin calibrar (rojo puro `#FF0000`, verde `#00FF00`, azul `#0000FF` ❌).

### A. Paletas de Color Curadas y Elevaciones Tonales
- **Fondo Oscuro Premium (Dark Mode):** Nunca usar negro absoluto (`#000000`) para fondos completos. Usar tonos profundos con matiz:
  - Surface 0 (Base): `#0B0F17` o `#0F172A` (Slate oscuro)
  - Surface 1 (Cards/Cards Elevadas): `#1E293B`
  - Surface 2 (Modales/Popups): `#334155`
  - Bordes sutiles: `rgba(255, 255, 255, 0.08)`
- **Acentos y Colores de Estado:**
  - Primario / Brand: Violeta eléctrico (`#6366F1` o `#4F46E5`), Esmeralda (`#10B981`) o Ámbar dorado (`#F59E0B`).
  - Éxito / Pagado / Libre: Esmeralda `#10B981` con fondo traslúcido `rgba(16, 185, 129, 0.15)`.
  - Alerta / En Cocina / Ocupado: Ámbar `#F59E0B` con halo cálido.
  - Peligro / Cancelado / Demorado: Rosa carmesí `#F43F5E` o Rojo rubí `#EF4444`.

### B. Tipografía de Alta Gama
- Usar familias tipográficas modernas mediante Google Fonts:
  - **Primaria (UI & Body):** `Plus Jakarta Sans`, `Inter`, `Outfit` o `Geist`.
  - **Números / Moneda / Precios (Display):** Tipografía tabular con espaciado uniforme `font-variant-numeric: tabular-nums;`.
- **Reglas Tipográficas:**
  - Títulos H1/H2 con tracking negativo sutil: `letter-spacing: -0.025em; font-weight: 700;`.
  - Interlineado generoso para lectura descansada: `line-height: 1.6;` en párrafos.
  - Contraste de texto: Título `#F8FAFC`, Secundario `#94A3B8`, Muted `#64748B`.

---

## ✨ 2. Efectos Visuales y Profundidad

### A. Glassmorphism Refinado
Para barras de navegación, encabezados fijos y paneles flotantes:
```css
.glass-panel {
  background: rgba(30, 41, 59, 0.7);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
}
```

### B. Sombras Multicapa (Soft Elevated Shadows)
Evitar sombras duras y negras. Usar sombras difusas multicapa:
```css
.elevated-card {
  box-shadow:
    0 1px 2px 0 rgba(0, 0, 0, 0.05),
    0 4px 12px 0 rgba(0, 0, 0, 0.15),
    0 16px 32px -4px rgba(0, 0, 0, 0.2);
}
```

### C. Micro-interacciones y Estados Hover Reactivos
- **Botones y Acciones:**
  - Transición fluida: `transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);`.
  - Hover: Elevación sutil `transform: translateY(-2px);` e incremento del resplandor de la sombra.
  - Active (Click): `transform: scale(0.98);` (feedback táctil visual).
- **Indicadores Pulsantes en Vivo (Badges):**
  Para órdenes en cocina o mesas ocupadas, usar un punto con animación de pulso (`pulse` keyframe) para dar sensación de aplicación viva y en tiempo real.

---

## 📱 3. Estándares para Módulos de Restaurante (POS, Mesero y Cocina KDS)

### A. Comandero Móvil (Mesero Mobile-First)
- **Zonas Táctiles:** Botones con altura mínima de `48px` para evitar toques erróneos en dispositivos móviles.
- **Grilla de Mesas:**
  - Tarjetas grandes con número de mesa visible a 2 metros de distancia.
  - Código cromático instantáneo: Verde (Libre), Naranja (Ocupada con tiempo), Azul (Cuenta solicitada).
- **Selector de Productos:** Búsqueda instantánea con auto-filtrado, fotos de alta calidad y selector de cantidad con botones `+` y `-` amplios.

### B. Kitchen Display System (KDS - Pantalla de Cocina)
- **Tema Oscuro de Alto Contraste:** Optimizado para pantallas de cocina con iluminación mixta.
- **Temporizador de Comanda con Semáforo:**
  - `0 - 10 min`: Badge verde (Normal).
  - `10 - 20 min`: Badge amarillo (Atención).
  - `> 20 min`: Badge rojo parpadeante (Urgente).
- **Acciones Rápidas con 1 Toque:**
  - Botón "Comenzar Preparación" y "Plato Listo" grandes y directos sin confirmaciones intermedias molestas.

---

## 🏛️ 4. Estructura Comercial Completa: Header, Body y Footer Ejecutivo

Toda plataforma web o SaaS debe contar con una estructura trifásica profesional:
1. **Header / Navbar con Personalidad de Marca:**
   - Logotipo e insignia comercial de alto impacto con tipografía distintiva.
   - Navegación rápida con estados activos claros e indicadores pulsantes de actividad en vivo.
   - Botón visible y accesible de **"📖 Guía de Uso / Tutorial"**.
2. **Body Ergonómico:**
   - Contenedor con ancho máximo balanceado (`max-width: 1400px`).
   - Espaciado generoso y distribución en tarjetas elevadas (`--surface-1`, `--surface-2`).
3. **Footer Corporativo y Sellos de Confianza:**
   - **Información del Negocio:** Razón social, NIT, dirección física, horario de atención y correo oficial.
   - **Sellos de Cumplimiento Legal:** Distintivo de cumplimiento de **Habeas Data (Superintendencia de Industria y Comercio - SIC)**.
   - **Monitoreo de APIs Externas:** Indicador en vivo de estado de conectividad (ej. `🟢 Factus API DIAN: Conectado & Operativo`).
   - **Atribución Profesional:** Créditos de autoría y derechos de autor.

---

## 🎓 5. Onboarding y Tutoriales Integrados (Self-Explaining UI)

Para evitar que el desarrollador o dueño deba capacitar manualmente a cada empleado nuevo:
- **Regla de Oro:** La interfaz debe explicarse sola en menos de 2 minutos.
- **Componente de Tutorial Obligatorio:**
  - Botón fijo o en el header para abrir la **Guía Rápida**.
  - Pestañas o pasos clasificados por rol (**Mesero**, **Cocina KDS**, **Caja POS**, **Administrador**).
  - Tarjetas ilustradas con lenguaje directo, pasos numerados (1, 2, 3) y cero jerga técnica innecesaria.

---

## 🧼 7. Prohibición Total de Estilos en Línea y Modularidad CSS (Anti-Monolito)

Queda **terminantemente prohibido** el uso de atributos `style="..."` regados dentro del código HTML/Blade/JSX en producción.
- **Motivo Técnico:**
  1. Destruye la coherencia del Design System e impide la reutilización de clases y tokens (`var(--...)`).
  2. Aumenta el payload HTML transferido en la red.
  3. Convierte las plantillas en archivos monolíticos ingobernables ("God Views"), violando la separación de responsabilidades (SoC).
- **Obligaciones Arquitectónicas:**
  - **Hojas de Estilo Dedicadas:** Todo módulo o vista principal debe desacoplar sus estilos a su propio archivo CSS en `public/css/[modulo].css` (ej. `waiter.css`, `pos.css`, `kds.css`).
  - **Límites de Líneas por Plantilla:** Mantener las vistas Blade/JSX en menos de **150 a 200 líneas**, puramente semánticas y declarativas.
  - **Nomenclatura Semántica / BEM:** Usar nombres de clase descriptivos que revelen intención de negocio (ej. `.btn-op-addition`, `.table-cards-grid`, `.cart-summary-box`), nunca utilidades crudas o estilos ad-hoc.
  - **Separación de la Tríada:** Estructura (HTML/Blade) + Presentación (CSS) + Comportamiento (JS en `public/js/`).

---

## 🛡️ 8. Ubicación Canónica de Políticas y Cumplimiento Legal (Solo Footer)

- **Regla del Header Operativo:** La barra de navegación superior (`navbar`) está reservada **exclusivamente para la operación del negocio** (accesos a comanderos, cocina, caja, administración, tour guiado y perfil de usuario).
- **PROHIBIDO** saturar el navbar con botones legales como "Habeas Data (SIC)", "Términos y Condiciones" o "Política de Cookies".
- **OBLIGATORIO en el Footer:**
  - Los enlaces de Habeas Data, Ley 1581 de 2012, PTDP y términos de servicio deben ubicarse con distinción en la columna de seguridad y en la barra inferior de derechos de autor (`.footer-bottom`).

---

## ⚡ 9. Ergonomía Táctil y Búsqueda en Horas Pico (Mobile-First)

En entornos de alta demanda (restaurantes, almacenes o retail) donde los clientes dictan pedidos con rapidez:
1. **Touch Targets de Mínimo 48x48px:**
   - Todo botón interactivo debe tener un área táctil de al menos `48x48px` y una separación mínima de `8px` para evitar pulsaciones erróneas de pulgares anchos (Ley de Fitts).
2. **Búsqueda Táctil en 0ms (En Memoria):**
   - Implementar barras de búsqueda que filtren colecciones precargadas en el cliente en milisegundos (`input` event instantáneo) con botón de limpieza rápida (✕), sin esperas de red.
3. **Marcado a 1-Toque y Badges en Vivo:**
   - La pulsación de la tarjeta debe registrar la unidad inmediatamente.
   - La tarjeta debe exhibir un indicador visible en tiempo real (`x2`, `x3 en orden`) para que el usuario verifique la comanda sin abrir el carrito.
4. **Confirmación Táctil con Micro-Vibración (Háptica):**
   - Utilizar `navigator.vibrate?.(35)` y micro-rebote visual elástico (`transform: scale(0.96)`) para certificar que la orden se registró mientras el operario mantiene contacto visual con el cliente.

---

## 📐 10. Checklist Obligatorio de Entrega Visual y Código Limpio
- [ ] ¿La interfaz luce moderna, limpia y atractiva a primer golpe de vista?
- [ ] ¿Tiene Header con identidad de marca, Body estructurado y Footer corporativo con sellos de confianza?
- [ ] ¿CERO estilos en línea (`style="..."`) en las vistas HTML/Blade?
- [ ] ¿Estilos desacoplados en archivos `.css` modulares y JS desacoplado en `.js`?
- [ ] ¿Las vistas se mantienen concisas y legibles (idealmente < 150-200 líneas)?
- [ ] ¿Los enlaces legales y de Habeas Data están en el footer y no estorban en el navbar?
- [ ] ¿Los botones móviles tienen tamaño táctil mínimo de 48px y espaciado anti-error?
- [ ] ¿Incluye botón y modal de Tutorial / Guía rápida para nuevos empleados?
- [ ] ¿Los botones tienen hover, focus y active states con transiciones suaves?
- [ ] ¿Se utilizan fuentes elegantes (Plus Jakarta Sans / Inter / Outfit)?
- [ ] ¿El diseño es completamente responsivo (móvil, tablet y escritorio)?
- [ ] ¿Los estados vacíos (Empty States) tienen iconos y llamadas a la acción claras?

