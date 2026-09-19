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
