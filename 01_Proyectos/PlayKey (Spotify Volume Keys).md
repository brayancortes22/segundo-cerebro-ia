# 🎵 PlayKey — Spotify Volume Keys

- **Tipo:** Utilidad Nativa Android para Control Multimedia Físico
- **Estado:** 🟢 Compilación Validada & APK Generado (`app-debug.apk`)
- **Ubicación en disco:** `c:\Users\NITRO ACER\Desktop\proyectos con ia\spotify-volume-keys\`
- **Binario compilado:** `app\build\outputs\apk\debug\app-debug.apk`
- **Stack Tecnológico:** Android Java puro (sin librerías pesadas / ~20 KB), `AccessibilityService` con `FLAG_REQUEST_FILTER_KEY_EVENTS`, `NotificationListenerService` para `MediaSessionManager` y Android SDK Platform 36 (Java 17).
- **Desarrollador:** Brayan Stid Cortés Lombana (`bscl`)

---

## 🎯 ¿Cómo funciona?

1. **Mantener presionado Volumen Arriba:** Pasa a la siguiente canción (`skipToNext()`).
2. **Mantener presionado Volumen Abajo:** Vuelve a la canción anterior (`skipToPrevious()`).
3. **Pulsación corta:** Regula el volumen multimedia normal como de costumbre (`AudioManager.adjustStreamVolume`).
4. **Pantalla Bloqueada:** Opera incluso con la pantalla apagada/bloqueada según el soporte de filtrado global del fabricante.
5. **Cero consumo o APIs privadas:** No requiere inicio de sesión en Spotify ni credenciales OAuth; interactúa directamente con la sesión multimedia pública del sistema operativo Android (`com.spotify.music`).

---

## 🔧 Componentes del Sistema

* **`MainActivity.java`:** Panel de control para configurar umbral de pulsación (milisegundos), invertir orden de pistas y verificar permisos.
* **`VolumeKeyAccessibilityService.java`:** Servicio de accesibilidad que intercepta `KEYCODE_VOLUME_UP` y `KEYCODE_VOLUME_DOWN` sin leer el contenido de las pantallas del usuario.
* **`SpotifySessionController.java`:** Localiza y enlaza la sesión activa de Spotify mediante `MediaSessionManager.getActiveSessions()`.
* **`PlaybackNotificationListener.java`:** Declara permiso a nivel de sistema para descubrir sesiones multimedia activas sin leer notificaciones privadas.

---

## 📱 Pasos para Probar en el Teléfono

1. **Instalación:** Copiar e instalar el archivo `app-debug.apk` o instalar vía ADB (`adb install -r app-debug.apk`).
2. **Paso 1 en la App:** Tocar **"Abrir acceso multimedia"** y activar PlayKey en la lista.
3. **Paso 2 en la App:** Tocar **"Abrir ajustes de accesibilidad"** y encender **"PlayKey · teclas de volumen"**.
4. **Paso 3 en la App:** Activar el interruptor **"Controlar Spotify con volumen"**.
5. **Prueba:** Abrir Spotify, reproducir cualquier canción, y mantener presionado el botón de volumen para cambiar de pista.
