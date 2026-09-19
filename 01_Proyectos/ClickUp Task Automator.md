# 🛰️ ClickUp Task Automator (NASA Sync)

- **Tipo:** CLI Tool / Integración con ClickUp API v2 (Node.js + TypeScript)
- **Estado:** 🟢 Activo y en Producción
- **Ubicación en disco:** `c:\Users\NITRO ACER\Desktop\proyectos con ia\clickup-task-automator\`
- **Repositorio GitHub:** [github.com/brayancortes22/clickup-task-automator](https://github.com/brayancortes22/clickup-task-automator)
- **Ramas:** `development`, `qa`, `main` (Estrategia de 3 ramas)
- **Relacionado:** [[00_Centro_de_Mando]], [[NASA Earth System Trend Detective]], [[11-Trazabilidad-ClickUp-Sprint-1]]

---

## 🎯 Objetivo
Automatizar la creación, sincronización y asignación equilibrada de las tareas y subtareas del proyecto **NASA Earth System Trend Detective** a través de la API v2 de ClickUp, distribuyendo la carga de trabajo entre los 5 participantes según sus roles técnicos y manteniendo trazabilidad en tiempo real.

---

## 🏗️ Arquitectura y Capacidades
- **Conector ClickUp API v2:** Creación de listas, tareas padre y subtareas con metadatos completos (prioridades, horas estimadas, descripciones en Markdown y etiquetas).
- **Matriz de Sprints (4 Sprints):** 86 tareas estructuradas con criterios de aceptación y Definition of Done.
- **Distribuidor Equitativo de Roles:** Asignación automática por ID de usuario en ClickUp para July, Reving, Johan, Diego y Brayan.
- **Modo Simulación (`--dry-run`):** Validación previa sin llamadas a la API para verificar la asignación de horas y balance de equipo.

---

## ⚙️ Comandos de Uso

```bash
# Simulación sin tocar ClickUp
npm run dry-run

# Listar miembros y Workspace IDs
npm run teams

# Sincronización real en vivo
npm run sync
```
