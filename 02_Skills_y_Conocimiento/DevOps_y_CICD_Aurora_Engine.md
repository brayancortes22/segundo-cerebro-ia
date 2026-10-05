# 🚀 DevOps, CI/CD y Automatización: Aurora Engine

> **Propósito:** Definición de la infraestructura de Integración Continua (CI), Despliegue Continuo (CD), control de calidad automático y gobernanza de ramas en **Aurora Engine**.  
> **Repositorio:** [aurora-engine-labs/aurora-engine](https://github.com/aurora-engine-labs/aurora-engine)  
> **Estándar:** Flujo de 3 ramas estrictas, caché distribuido de SCons, matrices multiplataforma y verificación de anti-patrones.

---

## 🏛️ 1. Arquitectura de Pipelines (GitHub Actions)

El ciclo de desarrollo de Aurora Engine se apoya en 3 workflows automatizados en `.github/workflows/`:

```
                                  [ DESARROLLADOR / AGENTE ]
                                              │
                     ┌────────────────────────┴────────────────────────┐
                     ▼                                                 ▼
            [ Push / PR a development ]                       [ PR a production ]
                     │                                                 │
                     ▼                                                 ▼
        ┌─────────────────────────┐                       ┌─────────────────────────┐
        │  ci.yml                 │                       │ branch-governance.yml   │
        │ • Quality Gate          │                       │ • Verifica que la fuente│
        │ • 100 Reglas Anti-Patrón│                       │   sea estrictamente 'qa'│
        │ • Cero Secretos/Keys    │                       │ • Bloquea commits direct│
        │ • SCons Windows + MSVC  │                       └────────────┬────────────┘
        │ • SCons Linux + GCC     │                                    │
        │ • SCons Cache Hit       │                                    ▼ (Aprobado)
        └────────────┬────────────┘                       ┌─────────────────────────┐
                     │                                    │ cd-release.yml          │
                     ▼ (Superado)                         │ • Genera Changelog      │
            [ Merge a qa ]                                │ • Empaqueta Editor      │
                     │                                    │ • Crea GitHub Release   │
                     ▼ (Validación QA)                    └─────────────────────────┘
            [ Merge a production ]
```

---

## 🛡️ 2. Workflows Implementados

### A. Integración Continua (`ci.yml`)
* **Triggers:** Pushes y Pull Requests sobre `development` y `qa`.
* **Jobs:**
  1. `sanity-and-quality-gate`:
     * Valida la presencia de `THIRD_PARTY.md` y el cumplimiento de las licencias de Godot Engine.
     * Valida que el documento de **100 Errores del Proceso** (`docs/lessons_learned/Errores_del_proceso.md`) esté intacto como base de pruebas.
     * Escaneo anti-fuga de credenciales (bloquea tokens de OpenAI, Anthropic o Gemini accidentales en el código).
  2. `build-check-windows`:
     * Runner: `windows-latest`.
     * Configuración de **MSVC x64** mediante `ilammy/msvc-dev-cmd`.
     * Compilación SCons con caché distribuido en `.scons_cache/`.
  3. `build-check-linux`:
     * Runner: `ubuntu-latest`.
     * Instalación de dependencias gráficas (`libx11`, `libgl1-mesa`, `libasound2`).
     * Compilación con GCC y SCons.

### B. Gobernanza Estricta de 3 Ramas (`branch-governance.yml`)
* **Regla Inquebrantable (Regla 4):**
  * Ningún Pull Request puede apuntar a `production` si la rama de origen no es `qa`.
  * Si un desarrollador o agente intenta hacer PR directo de `development` o una rama `feature/*` a `production`, el CI aborta con fallo crítico inmediato.

### C. Despliegue Continuo de Releases (`cd-release.yml`)
* **Triggers:** Push directo a `production` o tags `v*`.
* **Acciones:**
  * Genera automáticamente notas de versión y changelog basados en commits.
  * Publica un **Pre-Release / Release oficial** en GitHub con los binarios del motor.

---

## ⚡ 3. Optimización Crítica: El Caché de SCons

Compilar un fork de Godot desde cero toma entre **30 y 45 minutos** por runner.
Para evitar tiempos muertos:
* Implementamos `actions/cache@v4` con clave de hash sobre archivos de compilación (`SCsub`, `config.py`).
* La caché de objetos compilados (`.scons_cache/`, límite de 5000 MB) reduce las compilaciones subsecuentes a **menos de 4 minutos**, permitiendo feedback rápido para agentes y desarrolladores.

---

## 📋 4. Checklist para Nuevas Funcionalidades (Definition of Done)

Antes de fusionar cualquier código de Aurora:
1. [ ] Desarrollado en rama `feature/*` y fusionado a `development`.
2. [ ] CI ejecutado y en verde (Quality Gate + Compilación SCons).
3. [ ] Probado y estabilizado en `qa`.
4. [ ] Documentación sincronizada en el mismo ciclo (Regla 9).
5. [ ] PR de `qa` a `production` validado por el workflow de gobernanza.
