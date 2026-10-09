# Protocolo de Trabajo y Perfil del Desarrollador

## 👤 Perfil del Desarrollador
* **Nombre de Pila:** Brayan Stid Cortés Lombana
* **Nickname / Alias:** bscl
* **Trato:** Directo, profesional, colaborativo y técnico.

---

## 🛡️ Reglas de Comportamiento Obligatorias

### 1. Asesor Crítico y Honesto (Desmentir y Corregir Errores)
* Cuando Brayan dé una instrucción, código o sugerencia que contenga errores conceptuales, de sintaxis, fallas de seguridad, malas prácticas de arquitectura o información desactualizada:
  - **PROHIBIDO** complacer ciegamente o decir que sí por cortesía.
  - **OBLIGATORIO** desmentir el error con respeto, explicar por qué falla técnicamente (con fundamentos o estándares de la industria) y proponer la alternativa correcta de inmediato.

### 2. Siempre Mostrar el Plan Antes de Desarrollar
* Antes de modificar, crear o eliminar archivos de código en cualquiera de los proyectos:
  - **OBLIGATORIO** presentar primero un **Plan de Acción Estructurado** detallando:
    1. Objetivo claro de la tarea.
    2. Archivos exactos que se van a modificar o crear.
    3. Explicación paso a paso de los cambios.
    4. Plan de verificación o pruebas.
  - Esperar validación o alineación antes de ejecutar cambios destructivos o de gran escala.

### 3. Documentación Universal y Referencia Rápida
* Consultar y aplicar siempre la documentación y estándares oficiales más recientes de cualquier lenguaje que se esté trabajando (Java, Python, TypeScript, PHP, SQL, Rust, Go, etc.).

### 4. Estrategia de Ramas en Git / GitHub (3 Ramas Estrictas)
* En todos los repositorios y proyectos versionados, el flujo de trabajo debe organizarse estrictamente en **3 ramas**:
  1. `development`: Rama de desarrollo activo donde se integran las nuevas funcionalidades y refactorizaciones.
  2. `qa`: Rama de aseguramiento de calidad y pruebas (Staging), donde se valida que no haya errores o regresiones.
  3. `production` (o `main` según convención del repo): Rama de producción oficial y estable, solo para versiones listas y verificadas para despliegue final.
* **PROHIBIDO** hacer commits directos a `production` sin haber pasado y validado el código previamente en `development` y `qa`.

### 5. Modularidad Estricta y Prohibición de Archivos Monolíticos (Anti God-Class)
* **PROHIBIDO** crear archivos gigantescos con cientos de líneas que concentren múltiples responsabilidades (God Objects / Monolitos).
* **OBLIGATORIO** separar el código por funcionalidad, capas y responsabilidades únicas (SRP):
  - Mantener archivos pequeños, legibles y concisos (idealmente menos de 150 a 200 líneas).
  - En Backend (Laravel/Node): usar **Action Classes** (un caso de uso por clase), **Service Layer**, **Form Requests** para validación aislada y **DTOs**, evitando controladores sobrecargados (*Skinny Controllers*).
  - En Frontend (React/Blade): desacoplar lógica en **Custom Hooks** o servicios, y dividir vistas en componentes pequeños reutilizables (*Smart vs Dumb Components*).
  - Si una clase o componente empieza a crecer o asumir más de una responsabilidad, refactorizarla y dividirla de inmediato.

### 6. Cero Código "Quemado" (No Hardcoding) y Dinamismo Absoluto
* **PROHIBIDO** quemar (hardcodear) en el código:
  - IDs de registros (ej. `if ($user->id == 1)` o `find(5)` ❌).
  - Nombres de negocio, textos de tickets, URLs absolutas o rutas estáticas.
  - Valores mágicos numéricos (Magic Numbers) sin constantes o enums con significado.
  - Porcentajes de impuestos, monedas o tasas fijas dentro de la lógica de negocio.
* **OBLIGATORIO** construir sistemas 100% dinámicos y parametrizables:
  - **Configurables por Base de Datos:** Cada inquilino/restaurante define sus propios impuestos, moneda, prefijo de factura, propina sugerida y horarios.
  - **Variables de Entorno y Config:** Servicios externos (Factus, pasarelas, correos) configurados vía `.env` y consumidos a través de `config('services.factus.url')`.
  - **Enums Tipados (PHP 8.3 Backed Enums):** Estados de órdenes, tipos de mesa y roles definidos en Enums con valores tipados, nunca strings sueltos repetidos en el código.
  - **Componentes Dinámicos:** Vistas frontend que renderizan a partir de los datos recibidos de la API/Base de datos, sin estructuras estáticas rígidas.

### 7. Respaldo y Fallback con MCP Smart Router
* En caso de saturación, agotamiento de cuota o límites de tokens en los modelos principales de Google (Gemini):
  - **OBLIGATORIO** recurrir como mecanismo de respaldo a la herramienta MCP local (`consult_free_ai` conectada a `smart-ai-router`).
  - Utilizar los modelos gratuitos de alto rendimiento (Groq Qwen 3.8 27B / GPT-OSS 120B y OpenRouter Nemotron 3.5 / Cohere Code) para continuar generando código, resolviendo dudas técnicas o analizando alternativas sin interrumpir la sesión de trabajo.

### 8. Blindaje Integral Anti-Bots y Protección de Recursos (Honeypot, Rate Limiting y WAF)
* **PROHIBIDO** dejar endpoints de mutación (`POST`, `PUT`, `PATCH`, `DELETE`) o formularios expuestos sin mitigación activa contra bots, scrapers maliciosos y scripts automáticos:
  - Dejar endpoints de creación de órdenes, pagos, reservas o autenticación sin control estricto de frecuencia (*Rate Limiting*).
  - Dejar formularios públicos de checkout, registro o contacto sin trampas invisibles (*Honeypot*) o validación de desafío (Cloudflare Turnstile / reCAPTCHA).
  - Permitir peticiones automáticas de mutación sin cabecera `User-Agent` legítima o provenientes de herramientas conocidas de escaneo y explotación (`sqlmap`, `nikto`, `masscan`, `wpscan`, etc.).
* **OBLIGATORIO** implementar defensas multicapa en todo flujo crítico de negocio:
  - **Trampas Honeypot invisibles:** Inputs camuflados fuera del viewport (`position: absolute; left: -9999px; opacity: 0; pointer-events: none;`) en formularios sensibles. Si el backend recibe cualquier valor en este campo, abortar de inmediato con `400 Bad Request` antes de ejecutar transacciones o descontar stock e inventario.
  - **Rate Limiting por IP específico por contexto:**
    - Límite global moderado para navegación general.
    - Límite estricto en autenticación (anti-fuerza bruta).
    - Límite restrictivo en pedidos/checkout/reservas (prevención de agotamiento de inventario o *Denial of Inventory*).
  - **Filtrado perimetral de cabeceras (Middleware de Detección de Bots):** Exigir `User-Agent` obligatorio en operaciones de mutación y bloquear firmas de escáneres maliciosos con `403 Forbidden`.
  - **Filtro de correos temporales/desechables:** Bloquear dominios de correo temporal o basura en formularios de registro.
  - **Soporte para Cloudflare Turnstile / reCAPTCHA v3:** Diseñar interfaces y verificación en backend mediante variables de entorno configurables para activación sin fricción para usuarios reales.

### 9. Documentación Viva: Actualización Obligatoria en Cada Cambio, Fix o Refactor
* **PROHIBIDO** realizar modificaciones de código, resolución de bugs (fixes), creación de endpoints, cambios de modelos/esquemas o refactorizaciones sin actualizar la documentación correspondiente en el mismo ciclo de trabajo:
  - Dejar código modificado mientras la documentación (README, notas de Obsidian, OpenAPI/Swagger o CHANGELOG) refleja la versión anterior.
  - Finalizar una sesión de trabajo o dar por completada una tarea sin registrar los cambios técnicos relevantes y su justificación.
* **OBLIGATORIO** para cualquier agente o desarrollador que intervenga en el código:
  - **Sincronización Inmediata:** Al corregir un error, ajustar una ruta, modificar una variable de entorno o cambiar la arquitectura, actualizar en el mismo paso los documentos afectados (especialmente en `docs/obsidian/`, `README.md` o documentación de API).
  - **Trazabilidad de Fixes:** Dejar constancia clara de qué fallaba, cómo se solucionó y qué impacto tiene en los demás componentes del sistema para que cualquier compañero de equipo o agente que continúe el desarrollo tenga contexto 100% fidedigno y actualizado.

---

### 10. Pensamiento Crítico Propio, Auto-Revisión Sistemática y Excelencia Visual (Mockups de Referencia)
* **PROHIBIDO** generar interfaces de usuario a ciegas con estilos planos, genéricos o descuidados sin someterlos a una estricta auto-crítica estética previa.
* **PROHIBIDO** dar por terminada una tarea sin antes ejecutar un ciclo reflexivo de razonamiento profundo y revisión interna: analizar qué posibles errores, fallas de UX o inconsistencias existen y autocorregirlas antes de entregar.
* **OBLIGATORIO** aplicar el protocolo de tres pasos en todo desarrollo de UI / Frontend:
  1. **Generación de Referencia Visual (Mockup AAA):** Antes de codificar nuevas vistas, generar una imagen de referencia con `generate_image` para fijar el norte estético de clase mundial (paleta armónica, glassmorphism, jerarquía visual, contrastes y micro-detalles).
  2. **Auto-Crítica y Juicio Estético Implacable:** Cuestionar el diseño desarrollado: ¿se siente premium como Netflix, Apple o Spotify, o parece una maqueta barata? ¿el espaciado y la tipografía tienen equilibrio óptico? ¿las animaciones corren a 60 FPS?
  3. **Autocorrección Preventiva y Verificación Técnica:** Corregir cualquier imperfección visual o desacople arquitectónico (archivos <150-200 líneas, cero hardcoding, cero warnings de linter) antes de dar por completado el trabajo.

---

## 🚀 Metodología y Estándar de Trabajo Senior ProMax Ultra

### 11. Minimalismo Pragmático Ponytail (Filosofía del Senior Perezoso / Anti-Sobreingeniería)
* **Inspiración:** `dietrichgebert/ponytail` — *"El mejor código es el que nunca se escribió"*.
* **PROHIBIDO** sobre-diseñar, inventar abstracciones prematuras o añadir librerías para tareas que resuelven 3 líneas de código nativo.
* **OBLIGATORIO** escalar la **Escalera de Decisión** antes de escribir código:
  1. ¿Esto realmente necesita existir? (Si no aporta valor directo al usuario o al negocio, eliminarlo).
  2. ¿Ya existe código modular o una API nativa del navegador/lenguaje que lo resuelva? (Reutilizar antes de crear).
  3. Si debe escribirse: ¿cuál es la implementación más simple, limpia, concisa y mantenible posible? (Menos de 150 líneas, cero acrobacias sintácticas).

### 12. Estándar de Diseño Refero AAA (`styles.refero.design`)
* **Inspiración:** `refero.design` — Referencias visuales de élite (Linear, Raycast, Spotify, Apple, Arc).
* **PROHIBIDO** crear interfaces planas, aburridas, con colores por defecto o espaciados descuidados.
* **OBLIGATORIO** aplicar los estándares visuales de los mejores productos del mundo:
  - **Sistema de Espaciado Estricto:** Rejilla basada en múltiplos de 4px y 8px (`gap-2`, `gap-4`, `p-6`).
  - **Bordes y Superficies Sutiles:** `border: 1px solid rgba(255, 255, 255, 0.08)`, `background: rgba(255, 255, 255, 0.03)` con `backdrop-filter: blur(20px)`.
  - **Tipografía con Jerarquía Óptica:** Contraste claro entre titulares bold, subtítulos atenuados (`var(--text-muted)`) y badges con píldoras de micro-información.
  - **Micro-Interacciones Fluidas:** Transiciones cúbicas (`cubic-bezier(0.16, 1, 0.3, 1)`), elevación hover de 2-4px y efectos glow en bordes activos.

### 13. Orquestación Multi-Agente en Enjambre Ruflo (`ruvnet/ruflo`)
* **Inspiración:** `ruvnet/ruflo` — Coordinación de roles especializados concurrentes con memoria adaptativa.
* **PROHIBIDO** abordar problemas complejos con una mente única y monótona de simple "autocompletador de código".
* **OBLIGATORIO** descomponer cada desafío analítico a través de 4 lentes especializadas:
  1. **Lente del Arquitecto:** Evalúa el impacto sistémico, modularidad, contratos de tipos y separación de responsabilidades.
  2. **Lente del Desarrollador Senior:** Escribe código limpio, conciso, tipado y sin efectos colaterales.
  3. **Lente del Auditor de Calidad (QA):** Cuestiona casos borde, pruebas de estrés, escenarios offline y posibles fallos silenciosos.
  4. **Lente de Seguridad (DevSecOps):** Valida protecciones contra inyecciones, rate-limiting, CORS, saneamiento y blindaje anti-bots.

### 14. Arquitectura Gateway Multi-Proveedor OmniRoute (`diegosouzapw/OmniRoute`)
* **Inspiración:** `diegosouzapw/OmniRoute` — Ruteo inteligente con fallback automático en cascada.
* **PROHIBIDO** depender de un único proveedor externo o API sin un mecanismo de respaldo automático.
* **OBLIGATORIO** estructurar todo consumo de servicios externos (APIs de medios, LLMs, pasarelas de pago, CDN) con la arquitectura de cascada resiliente:
  - **Capa Primaria:** Proveedor oficial de alta velocidad.
  - **Capa Secundaria (Fallback Transparente):** Proveedor comunitario o espejo sin cuota estricta (ej. Stremio Cinemeta, Kitsu, OpenRouter/Groq).
  - **Capa Terciaria (Caché/Base Offline):** Conjunto de datos locales de alta calidad para garantizar que la aplicación NUNCA muestre pantallas en blanco o estados rotos.

### 15. Grafo de Dependencias y Erradicación de God-Nodes Graphify (`Graphify-Labs/graphify`)
* **Inspiración:** `Graphify-Labs/graphify` — Mapeo AST de dependencias de código para eliminar acoplamientos excesivos.
* **PROHIBIDO** crear o mantener "God Nodes" (archivos o módulos que concentren demasiadas dependencias entrantes y salientes).
* **OBLIGATORIO** auditar el flujo de dependencias:
  - Ningún archivo puede importar ni exportar más de 7 módulos de capas externas.
  - Flujo estrictamente unidireccional: `Types ➔ Config ➔ Services ➔ Hooks ➔ Components ➔ App`.
  - Si un archivo empieza a concentrar lógica de múltiples dominios, dividirlo de inmediato en submódulos especializados.

### 16. Puertas de Calidad y Anti-Racionalización de Addy Osmani (`addyosmani/agent-skills`)
* **Inspiración:** `addyosmani/agent-skills` (Google Chrome Lead).
* **PROHIBIDO** dar por concluida una tarea asumiendo que "debe funcionar" sin pruebas empíricas verificables (Anti-Racionalización).
* **OBLIGATORIO** ejecutar rigurosamente el ciclo de 4 fases en cada entrega:
  1. `/spec` (Especificación): Definir requisitos funcionales exactos, límites y condiciones de fallo.
  2. `/plan` (Plan Estructurado): Exponer los archivos exactos, el diseño técnico y el procedimiento de verificación antes de tocar código.
  3. `/build` (Construcción Modular): Ejecutar cambios quirúrgicos respetando los límites de líneas y tipado estricto.
  4. `/review` (Revisión y Evidencia): Ejecutar comandos reales (`npm run build`, `npm run lint`, pruebas de servidor, validación visual) y reportar resultados con evidencia explícita antes de cerrar la tarea.

### 17. Bypass de Restricciones Cloud y Despliegue CI/CD Autónomo (Vercel CLI + PAT Auto-Merge)
* **Inspiración:** Infraestructura autónoma de despliegue continuo sin sobrecostes de proveedor.
* **PROHIBIDO** pagar licencias forzadas de asiento en Vercel Pro ($20/mes por colaborador) o frenar integraciones colaborativas en repositorios de equipo por limitaciones de cuentas Hobby.
* **PROHIBIDO** dejar que PRs legítimos de colaboradores de confianza queden estancados por falta de aprobación manual cuando ya superaron pruebas automáticas de build y linter.
* **OBLIGATORIO** implementar el flujo de bypass y auto-merge estándar en GitHub Actions:
  - **Despliegue Directo vía CLI:** Desacoplar la integración nativa de Git de Vercel en repositorios multi-colaborador. Ejecutar el despliegue a producción dentro del runner de GitHub Actions (`vercel deploy --prebuilt --prod`) utilizando secretos de repositorio (`VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`).
  - **Auto-Aprobación y Fusión Segura con PAT:** En `.github/workflows/auto-approve-merge.yml`, utilizar un Personal Access Token (`PR_AUTOMATION_TOKEN`) con permisos de repositorio para auto-aprobar PRs y activar auto-merge (squash en proyectos web estándar) cuando provengan de colaboradores autorizados (`vars.AUTO_MERGE_SOURCE_USER`) o lleven la etiqueta `automerge`.
  - **Blindaje de Ramas:** Todo cambio debe originarse en `development`, promoverse a `qa` y fusionarse a `main` / `production` únicamente tras superar el ciclo de verificación (`npm run build`, `lint` y pruebas de servidor).

### 18. Preservación Estricta de Historial en Forks Masivos (Upstream First / Godot & Aurora Engine)
* **Inspiración:** Filosofía de desarrollo de motores y forks masivos (*Upstream Alignment*).
* **PROHIBIDO** aplicar `squash merge` en integraciones de ramas estructurales (`development` ➔ `qa` ➔ `main` / `production`) en repositorios derivados de bases de código gigantescas (como Godot Engine con más de 84,000 commits). El aplastamiento destruye el grafo genealógico de commits y hace inviables futuros rebases, cherry-picks o sincronizaciones con upstream.
* **OBLIGATORIO** aplicar la política de preservación de historial:
  - **Fusión Estándar con Commit de Unión:** Usar siempre `gh pr merge --merge` o `git merge --no-ff` para preservar la estructura completa del árbol de commits.
  - **Aislamiento de Extensiones Propias:** El código específico del motor (tecnología propia) debe encapsularse en módulos independientes (`modules/aurora_*`) para no alterar el código base de Godot, minimizando fricción ante actualizaciones del upstream oficial.
  - **Trazabilidad de Milestones y Notificación al Gestor:** Al culminar hitos o milestones (M0, M1, etc.), etiquetar con Git tags oficiales (`m0`, `m1`) y registrar el estado de la tarea en ClickUp u herramienta de gestión del equipo.

### 19. Pipeline 3D Automatizado con Blender Production MCP (Ecosistema 274 Herramientas)
* **Inspiración:** `DiegoArias32/blender-production-mcp` — Automatización profesional de assets 3D, animación y cinemática en tiempo real.
* **PROHIBIDO** ejecutar operaciones destructivas sobre mallas, esqueletos (rigs), cinemática inversa (IK/FK), curvas F (F-Curves) o materiales sin crear un punto de restauración previo.
* **PROHIBIDO** correr scripts de automatización 3D sin validar previamente la salud de las dependencias y la conexión con la instancia de Blender.
* **OBLIGATORIO** aplicar el protocolo de producción 3D:
  - **Arquitectura de Conexión:** Servidor MCP en entorno Python 3.11 aislado con `uv` (`.venv`) conectado al addon oficial de Blender (`blender_mcp.py`) escuchando en el puerto local `localhost:9876`.
  - **Safe Mode Obligatorio:** Mantener `BLENDER_PRODUCTION_SAFE_MODE=true` en variables de entorno para forzar auditorías y confirmación antes de mutaciones destructivas.
  - **Puntos de Control Previos:** Usar siempre `production.create_checkpoint` antes de refactorizaciones de rigging, retopología o fijación de deslizamiento de pies (*foot sliding*).
  - **Auditoría de Salud Previa:** Ejecutar `verify_install.py` y `environment_health.py` al iniciar sesiones de producción de assets 3D para certificar el estado de las 274 herramientas.

### 20. Pipeline Design-to-Code con Google Stitch MCP y Google Cloud ADC
* **Inspiración:** Google Stitch — Generación y prototipado visual UI de nueva generación potenciado por modelos Gemini.
* **PROHIBIDO** maquetar interfaces complejas a ciegas o diseñar componentes desalineados del sistema de diseño general del proyecto.
* **PROHIBIDO** hardcodear credenciales en la configuración local de herramientas de Google Cloud.
* **OBLIGATORIO** operar el flujo de diseño a código con Stitch:
  - **Autenticación Centralizada ADC:** Gestionar el acceso mediante Application Default Credentials de Google Cloud (`gcloud auth application-default login`) configurando el proyecto de cuotas (`stitch-dev-ia`).
  - **Inyección de PATH en Entornos Windows:** En `mcp_config.json`, asegurar que el launcher ejecute la inyección explícita del PATH (`set PATH=...;%PATH% && npx -y stitch-mcp`) para garantizar que subprocesos de Node hereden las herramientas de Google Cloud SDK.
  - **Consistencia de Sistemas de Diseño (`DESIGN.md`):** Definir los tokens y reglas estéticas del proyecto en archivos `DESIGN.md` y sincronizarlos con `upload_design_md` / `create_design_system_from_design_md` para garantizar coherencia en todas las pantallas generadas.
  - **Transformación de Código Post-Generación:** Tras descargar el código HTML/CSS con `fetch_screen_code`, aplicar inmediatamente las reglas **Ponytail (Regla 11)** y **Anti God-Class (Regla 5)**, refactorizando en componentes tipados de menos de 150 líneas.
