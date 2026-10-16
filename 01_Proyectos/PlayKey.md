# 🎵 PlayKey — Control de Spotify con Botones de Volumen

* **Repositorio GitHub:** [brayancortes22/playkey](https://github.com/brayancortes22/playkey)
* **Descarga APK:** [Release Oficial v1.0.0](https://github.com/brayancortes22/playkey/releases/tag/v1.0.0)
* **Estado:** 🟢 En Producción · v1.0.0 Estable
* **Autor:** Brayan Stid Cortés Lombana (`bscl`)

---

## ⚡ Descripción y Funcionamiento

PlayKey es una aplicación nativa para Android (~28 KB, ultra liviana, sin frameworks pesados ni analíticas de terceros) diseñada para cambiar canciones en Spotify usando las teclas físicas de volumen, incluso con la **pantalla apagada y el teléfono bloqueado en el bolsillo**.

### Modos de Operación
1. **Pantalla Encendida:**
   - Usa `AccessibilityService` con la bandera `FLAG_REQUEST_FILTER_KEY_EVENTS`.
   - Permite pulsaciones cortas para subir/bajar volumen de forma normal.
   - Si la tecla se mantiene pulsada por el umbral configurado (350 ms a 1150 ms), salta a la siguiente o anterior canción.
2. **Pantalla Apagada (Modo Bolsillo):**
   - En Android 14+ los eventos de accesibilidad se pausan con la pantalla apagada.
   - PlayKey implementa un Dynamic Proxy reflexivo sobre la API oculta de Android: `MediaSessionManager.setOnVolumeKeyLongPressListener`.
   - Al detectar una pulsación sostenida con la pantalla bloqueada, Android despacha el evento directamente a PlayKey.
   - Emite `skipToNext()` o `skipToPrevious()` sobre la sesión activa de Spotify y dispara una **vibración háptica de 50 ms** como confirmación táctil en el bolsillo.

---

## 🛠️ Comandos de Configuración Rápida (ADB)

```bash
# Conceder permiso de desarrollo para escuchar teclas con pantalla apagada
adb shell pm grant com.bscl.spotifyvolumekeys android.permission.SET_VOLUME_KEY_LONG_PRESS_LISTENER

# Eximir a la app del ahorro de batería agresivo (Doze Mode)
adb shell dumpsys deviceidle whitelist +com.bscl.spotifyvolumekeys
```

---

## 🌿 Flujo de Ramas (Estrategia de 3 Ramas)

* `development`: Rama de desarrollo activo donde se añaden nuevas funcionalidades.
* `qa`: Rama de aseguramiento de calidad y staging.
* `main`: Rama de producción oficial vinculada a los tags y releases.
