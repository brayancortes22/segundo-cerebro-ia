# ☕ Glac Tinto Virtual Studio — Campus Virtual Interactivo 2D

* **Ubicación Local:** `glac-tinto-virtual-studio` (Puerto local `3456`)
* **Estado:** 🟢 Estable · Clean-Room IP Certificada
* **Lead Developer:** Brayan Stid Cortés Lombana (`bscl`)
* **Stack Tecnológico:** HTML5 Canvas 2D nativo, Vanilla JavaScript ES6 Modular, CSS3, Express Server

---

## ⚡ Descripción y Funcionamiento

Campus virtual y oficina interactiva en 2D continua ($4676 \times 2738$ px) para el equipo de desarrollo de Glac Tinto Games. Permite el desplazamiento de avatares con movimiento WASD y clic en el suelo estilo *Soul Knight* y *Stardew Valley*, con 6 salas temáticas interconectadas por pasadizos continuos, radar HUD en tiempo real y bots interactivos de IA (Gemini, Claude, Diego y Valentina).

---

## 🏛️ Arquitectura Modular (<150 líneas por módulo)

Se erradicó por completo el código monolítico previo (`preview.js`), dividiendo el motor en 12 módulos desacoplados bajo `preview/src/`:

1. `worldMap.js`: Matriz del mundo contiguo ($4676 \times 2738$ px) con 6 salas (Recepción, Sala Principal, Sala de Juegos, Cafetería, Jardín y Salón de IA) y NavMesh de colisiones.
2. `camera.js`: Cámara virtual 2D suave con seguimiento Lerp (`0.08`) y clamping perimetral.
3. `corridorsRenderer.js`: Renderizado de los 6 pasadizos temáticos con detalles de baldosas y transiciones.
4. `minimap.js`: Radar HUD en la esquina superior con blip dinámico de posición y campo de visión.
5. `entities.js`: Spritesheets fieles a los personajes de referencia, bots Gemini/Claude y compañeros en la cafetería.
6. `physics.js`: Movimiento WASD/clic a 10 FPS de animación con cadencia de 4 pasos `[0, 1, 2, 1]` y anclaje inferior $Y=58$.
7. `renderer.js`: Matriz de cámara y ordenamiento dinámico por profundidad Y (Y-Depth Sorting) para solapamiento correcto.
8. `controls.js`: Controles de teclado, clic en el suelo con conversión de coordenadas pantalla-a-mundo y hotkey `[E]`.
9. `security.js`: Módulo DevSecOps con saneador anti-XSS y limitador de velocidad de eventos.
10. `particles.js`: Humo de tinto caliente, lluvia en ventanales, fogata andina y nubes animadas del Huila.
11. `state.js`: Estado reactivo centralizado y despachador de eventos.
12. `main.js`: Bucle de juego desacoplado corriendo a 60 FPS estables.

---

## 🛡️ Blindaje Legal de Sala Limpia (Clean-Room)

* **Zero AGPLv3:** No se copió, importó ni vinculó código o librerías de WorkAdventure. El motor corre en Canvas 2D nativo HTML5 puro sin dependencias externas infecciosas.
* **IP 100% Propietaria:** Todo el código fuente, sprites y lógica pertenecen exclusivamente a Glac Tinto Games.

---

## 🌿 Flujo de Ramas
* `development`: Rama de desarrollo activo.
* `qa`: Rama de aseguramiento de calidad visual y testing de colisiones.
* `main`: Producción lista para integración en portal web corporativo.

---

## 📝 Bitácora Técnica de Sincronización (Regla 9)

### 📅 23 de Octubre, 2026 — Interacciones Modulares de Campus y Diagnóstico
* **Hotspots Modulares (`preview/src/interactions.js`):** Nuevo subsistema de 83 líneas para disparar eventos interactivos sin saturar los controles base.
* **Minijuego de Arcade y Barista:** Integración de partículas de vapor de café caliente y activación de minijuego interactivo en el salón recreativo.
* **Diagnósticos del Servidor:** Telemetría ligera embebida para inspeccionar estado de conexión y FPS sin penalizar el ciclo de renderizado.
* **Refactor Ponytail (<150 líneas):** Se desacopló la detección de pulsaciones de `physics.js` y `controls.js`, manteniendo los módulos concisos y respetando SRP.
