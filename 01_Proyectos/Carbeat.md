# 🚗 CarBeat — Collaborative In-Car Jukebox & DJ System

* **Despliegue en Vivo:** [carbeat-pi.vercel.app](https://carbeat-pi.vercel.app)
* **Estado:** 🟢 En Producción · v2.2.0 Oficial
* **Lead Developer:** Brayan Stid Cortés Lombana (`bscl`)
* **Stack Tecnológico:** React 19, TypeScript, Vite, Three.js, Tailwind CSS, Vercel

---

## ⚡ Descripción y Funcionamiento

Sistema colaborativo de música en tiempo real para vehículos y viajes por carretera. Convierte la pantalla del carro (Tablet, radio Android china, Android Auto o navegador) en un reproductor central (Host) y permite que los pasajeros se unan como DJs desde sus teléfonos móviles sin instalar aplicaciones pesadas para buscar, pedir, votar canciones y controlar el ambiente musical de la cabina en vivo.

---

## 🌟 Decisiones Clave de Arquitectura & Novedades v2.2.0

### 1. ⚡ Sonar Ya Dual (Buscador y Cola)
* **Buscador con Acciones Independientes:** Tanto en el host como en los pasajeros se presentan dos botones de acción:
  - `[▶ Sonar ya]`: Salta la cola y reproduce inmediatamente la pista en los parlantes del carro.
  - `[+ Cola]`: Encola la pista respetando el orden y los votos de los pasajeros.
* **Reproducción Directa en la Cola:** Cada ítem encolado dispone de `[▶ Sonar ya]` para adelantar turnos al instante.
* **Permisos de Sala Configurables:** El conductor puede habilitar o inhabilitar `passengerPlayNow` desde *Modos > Reglas de la sala*.

### 2. 🛡️ Blindaje WebGL 2D/3D & Soporte Radios Antiguas (Anti "Fallo en la cabina")
* **Detección Previa de Hardware (`graphics-detector.ts`):** Evalúa la capacidad real de compilación de shaders y memoria (`navigator.deviceMemory <= 2 GB`, CPUs de 4 núcleos lentas). En radios antiguas o sin GPU dedicada, conmuta automáticamente al **Modo 2D Ligero Atmosférico** (cero consumo GPU, carga instantánea, sin bloqueos).
* **Envoltorio `<ThreeErrorBoundary>`:** Protege la autopista 3D (`HighwayStrip.tsx`) y portada (`Landing.tsx`). Si la GPU pierde contexto durante el viaje, pasa silenciosamente a letreros planos 2D sin tumbar la música.
* **Auto-Recuperación en `ErrorBoundary.tsx`:** Persiste `setGraphicsPreference('2d')` en `localStorage` ante cualquier fallo gráfico inesperado, erradicando bucles de reinicio.

### 3. 🚪 Portada Limpia y Entrada de Pasajero
* Eliminación de precarga residual (`getLastRiderRoom()`). El campo de placa arranca limpio (`""`) con placeholder `"VIBE-7KQ3"`, permitiendo ingreso manual o escaneo de código QR.

---

## 🌿 Flujo de Ramas (Estrategia de 3 Ramas)
* `development`: Desarrollo de nuevas funciones y refactorizaciones.
* `qa`: Pruebas de estrés y validación en navegadores embebidos.
* `main`: Producción en Vercel con CI/CD autónomo vía Vercel CLI.
