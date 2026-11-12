# 🎵 bscl music (Sonora) — Reproductor Web, PWA y APK

* **En Vivo:** [bscl-music.vercel.app](https://bscl-music.vercel.app)
* **APK:** `https://bscl-music.vercel.app/downloads/bscl-music-latest.apk` (v1.8.0, firmado)
* **Repo:** [github.com/brayancortes22/bscl-music](https://github.com/brayancortes22/bscl-music) (privado)
* **Estado:** 🟢 En Producción · Web v1.13.1 · APK v1.8.0
* **Stack:** React 19, TypeScript, Vite 8, Tailwind v4, Capacitor 8, Vercel (serverless)

---

## ⚡ Descripción

Reproductor de música completo: busca en YouTube, reproduce radio colombiana en vivo, abre álbumes y playlists de YouTube/Spotify, descarga para escuchar sin internet, muestra letras sincronizadas y tiene un DJ con IA. Empaquetado como PWA y como APK Android.

---

## 🏗️ Arquitectura (100% servicios gratuitos)

| Capa | Servicio | Uso |
| :--- | :--- | :--- |
| Hosting + funciones | **Vercel** | App, `/api/search`, `/api/spotify`, `/api/dj`, `/api/audio-source` |
| Búsqueda musical | **CarBeat** (propio) | `/api/yt/search` y `/api/yt/related` |
| Respaldo búsqueda | Invidious (3 instancias) | `/api/search` propio |
| Audio de descargas | Mirrors Invidious | `itag=140` con `Range` |
| Letras | LRCLIB | Sincronización |
| Radio | radio-browser + StreamTheWorld | ~340 emisoras |
| IA del DJ | Gemini (opcional) | Sin créditos hoy; respaldo local |

> **Google Cloud Run fue eliminado** (servicio, imagen y buckets borrados). Ya no existe ningún backend de pago ni dependencia de facturación.

---

## 🌟 Módulos

### Radio Colombia
- Directorio en vivo (~340 emisoras) + 21 emisoras curadas con stream verificado (**La Mix Neiva 94.8 FM**, Olímpica Neiva, W Radio, Blu, Tropicana, Candela, La Mix Bogotá/Cali/Barranquilla/Manizales…).
- Filtro por departamento (ciudades normalizadas) y paginación "Ver más emisoras".
- `<audio>` nativo independiente: **sigue sonando con la pantalla apagada** (verificado con adb: `PlaybackState=PLAYING`).

### Álbumes y playlists
- YouTube: búsqueda de playlists de la comunidad (Invidious) o pegar enlace `?list=`.
- Spotify: importación **completa** por enlace (ver decisión técnica abajo).

### Descargas offline
- **Pool de 3** canciones simultáneas, con progreso por pista (%, MB, errores).
- Guardado en IndexedDB (metadata y blobs separados).
- **Auto-sync**: descarga en segundo plano las canciones nuevas de una lista marcada.
- Archivos reales: `Descargas/bscl-music/` (APK, MediaStore) o carpeta elegida (escritorio, File System Access API).
- Guardado verificado: `/sdcard/Download/bscl-music/Bad Bunny - NUEVAYoL.m4a`.

### DJ IA
- Motor local (`djIntent.ts`): detecta género (15), ánimo (6), artista, era (80s/90s/clásico/nuevo) y adjetivos.
- Cerebro Gemini (`/api/dj`) cuando hay créditos; si falla, cae al motor local.
- Completa la tanda con `/api/yt/related` de CarBeat.
- Voz con `speechSynthesis` en `es-CO`.

### Ecualizador
- 5 bandas: 60 Hz (graves), 230, 910, 3.6 kHz, 14 kHz + compresor.
- 6 presets + sliders manuales; persiste en `localStorage`.
- **Solo aplica a audio nativo** (descargas, MP3, respaldo de YouTube). No a radio ni al iframe de YouTube (cross-origin).

### Sesión persistente
- Guarda cola (60 pistas), canción, minuto, volumen, mute, shuffle y repeat.
- Restaura sin autoplay y continúa desde el minuto guardado.

---

## 🔑 Decisiones Técnicas Clave

### 1. Spotify completo sin Premium (técnica pathfinder)
- El embed solo entrega 100 canciones. La API con client credentials exige **Premium del dueño** ("Active premium subscription required").
- Solución (la misma que usa `spotify_scraper` en Python): del `__NEXT_DATA__` del embed se extrae un **accessToken anónimo**, y con él se pagina `api-partner.spotify.com/pathfinder/v1/query` (operación `fetchPlaylist`, sha256 `a65e12…`, variable `enableWatchFeedEntrypoint=false`).
- Resultado real: **177 de 179** pistas (2 locales/no reproducibles).
- ⚠️ El sha256 puede rotar: si deja de funcionar, se actualiza en `api/_spotify-core.mjs`.

### 2. Una sola fuente de audio a la vez
- `youtubePlayerBridge.stop()` marca `hasActiveVideo=false`; `backgroundAudioService` ya no puede revivir el iframe al volver de segundo plano.
- Elementos separados: canción (`crossOrigin`, con EQ), radio, y respaldo de YouTube (sin CORS).

### 3. Respaldo de audio para videos no insertables
- Error 101/150 de YouTube → se reproduce como audio nativo por mirror Invidious.
- Tope de 3 fallos consecutivos con aviso, para no saltar la cola en silencio.

### 4. APK como contenedor remoto
- `server.url = https://bscl-music.vercel.app`: **los cambios web llegan sin reinstalar**.
- El APK solo se actualiza cuando cambia código nativo, con aviso in-app + instalador del sistema.
- Límites de Android: no hay instalación silenciosa; Play Protect puede bloquear apps autofirmadas.

---

## 📱 APK

```powershell
# Compilar, firmar y publicar (actualiza public/downloads + version.json)
powershell -ExecutionPolicy Bypass -File scripts/build-apk.ps1 -VersionName 1.9.0 -VersionCode 9 -Notes "..."
```
- Firma: `~/.secrets/bscl-music.keystore` (**no perderla**).
- Iconos: `scripts/make-icons.ps1` desde `public/bscl-logo.jpg`.
- Plugin nativo `NativeTools`: `saveToDownloads` (MediaStore), `getVersion`, `installApk`.

---

## 🌿 Ramas y Despliegue

* `development` → `qa` → `main` (merge `--no-ff`).
* `main` despliega automático en Vercel.
* Funciones desplegadas: `/api/search`, `/api/spotify`, `/api/dj`, `/api/audio-source`.

---

## 📌 Pendientes

- [ ] Rotar/eliminar la app de Spotify en el dashboard (el secret se expuso en un chat; ya no se usa).
- [ ] Canciones nuevas en Spotify: el pathfinder pagina hasta 1000; evaluar listas gigantes.
- [ ] Play Store (internal testing) si se quiere actualización 100% automática del APK.
- [ ] Reducir peso del repo (APK de ~14 MB por release).

---

## 🔗 Relacionado
- [[Carbeat]] — motor de búsqueda y afines que consume la app.
- [[PlayKey]] — control de Spotify por botones (otro proyecto del ecosistema).
