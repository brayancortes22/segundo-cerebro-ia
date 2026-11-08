# 🖥️ Screen Streamer Ultra — Extensión de Pantalla PC a Tablet

* **Ubicación Local:** `screen-streamer`
* **Estado:** 🟢 Activo · Herramienta de Productividad
* **Lead Developer:** Brayan Stid Cortés Lombana (`bscl`)
* **Capacidades:** Latencia ultra-baja (<25 ms), 60 FPS por cable USB (ADB) o Wi-Fi local

---

## ⚡ Descripción y Funcionamiento

Sistema de transmisión y extensión de pantalla que convierte cualquier tablet Android en un **segundo monitor real e independiente** para Windows, permitiendo arrastrar ventanas de desarrollo, terminales o vistas previas directamente a la tablet.

---

## 🛠️ Arquitectura y Modos de Uso

1. **Driver de Pantalla Virtual:**
   - Registra una pantalla virtual nativa en Windows (`instalar_pantalla_virtual.exe`) permitiendo la selección del modo "Extender" (`Win + P`).
2. **Conexión de Alta Velocidad por Cable USB o Red:**
   - Script de arranque rápido `iniciar.bat` con detección automática de dispositivo vía Android Debug Bridge (ADB).
3. **Controles Táctiles en la Tablet:**
   - Alternancia en caliente entre Monitor 1 (Espejo) y Monitor 2 (Extendido).
   - Modo de pantalla completa con doble toque.
   - Selector dinámico de compresión: *Rendimiento (60%)*, *Equilibrado (75%)* y *Ultra (90%)* sin reiniciar la transmisión.
