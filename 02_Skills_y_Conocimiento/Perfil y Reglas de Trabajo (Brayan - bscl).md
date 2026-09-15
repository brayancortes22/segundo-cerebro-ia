# 👤 Perfil y Reglas de Trabajo (Brayan - bscl)

- **Desarrollador:** Brayan Stid Cortés Lombana
- **Nickname / Alias:** `bscl`
- **Rol:** Lead Developer & Arquitecto de Software
- **Relacionado:** [[Colaboracion con IA (Antigravity)]], [[00_Centro_de_Mando]]

---

## 🛡️ Reglas de Oro de Colaboración con la IA

### 1. 🛑 Desmentir y Corregir Errores (Cero Complacencia Ciega)
* **Principio:** Si Brayan me da una instrucción que contiene un error técnico, conceptual, de arquitectura, de seguridad o basado en una premisa falsa:
  - **No debo decirle que sí ni complacerlo.**
  - **Debo desmentir el error inmediatamente con respeto**, explicar con argumentos técnicos sólidos por qué la solución propuesta fallará o traerá problemas, y plantear la alternativa óptima de la industria.
* **Objetivo:** Garantizar que cada línea de código y decisión de diseño sea de la más alta calidad profesional.

### 2. 📋 Mostrar Siempre el Plan Antes de Desarrollar
* **Principio:** Antes de escribir código, modificar archivos o ejecutar cambios en los proyectos:
  - **Debo presentar primero un Plan de Acción Estructurado:**
    1. 🎯 *Objetivo:* Qué se va a resolver.
    2. 📁 *Archivos involucrados:* Cuáles se crean, modifican o eliminan.
    3. 🪜 *Paso a paso:* La secuencia lógica de implementación.
    4. 🧪 *Verificación:* Cómo comprobaremos que funciona.
* **Objetivo:** Evitar cambios sorpresivos, mantener alineación total y dar visibilidad antes de tocar el código.

### 3. 🌿 Estrategia Obligatoria de 3 Ramas en GitHub
* **Principio:** Todo repositorio gestionado por Brayan (`bscl`) debe operar bajo el flujo estricto de 3 ramas:

```mermaid
gitGraph
    commit id: "Init"
    branch development
    checkout development
    commit id: "Feature 1"
    commit id: "Feature 2"
    branch qa
    checkout qa
    merge development id: "Merge a QA"
    commit id: "Smoke Tests OK"
    checkout main
    merge qa id: "Merge a Production"
    commit id: "v1.0.0 Deploy"
```

1. 💻 `development`: Rama de trabajo diario donde se desarrollan características y refactorizaciones.
2. 🔍 `qa`: Rama de aseguramiento de calidad (Staging), donde se ejecutan pruebas automáticas, manuales y de regresión.
3. 🚀 `production` (o `main`): Rama sagrada de producción. Solo código 100% probado en `qa` que pasa a despliegue final.
* **Prohibición:** Nunca hacer commits directos a `production` senza pasar previamente por `development` y `qa`.

### 4. 🧩 Modularidad Estricta y Prohibición de Archivos Monolíticos (Anti God-Class)
* **Principio:** Cero archivos kilométricos que concentren múltiples responsabilidades.
  * **Límite objetivo:** Archivos pequeños, atómicos y altamente legibles (generalmente menos de 150 a 200 líneas).
  * **En Backend (Laravel):**
    - Controladores delgados (*Skinny Controllers*) con máximo 3 a 5 líneas por método.
    - Casos de uso encapsulados en **Action Classes** (ej. `CreateOrderAction`, `EmitFactusInvoiceAction`).
    - Validaciones obligatoriamente en **Form Requests** dedicados (nunca dentro del controlador).
    - Transferencia de datos tipada mediante **DTOs**.
  * **En Frontend (React/Blade):**
    - Extraer toda la lógica de negocio y llamadas a API en **Custom Hooks**.
    - Componentes visuales pequeños y desacoplados (*Smart vs Dumb Components*).
* **Acción obligatoria:** En cuanto un archivo comience a acumular demasiada lógica o líneas, refactorizarlo y separarlo de inmediato.

### 5. ⚡ Cero Código Quemado (No Hardcoding) y Dinamismo Absoluto
* **Principio:** Prohibido quemar valores, textos, IDs fijos o porcentajes en el código fuente.
  * **Configuración por Inquilino:** Cada restaurante administra sus propios impuestos (IVA/Impoconsumo), monedas, textos de facturas, horarios y propinas desde la base de datos.
  * **Enums Tipados (PHP 8.3 Backed Enums):** Estados de mesas (`TableStatus`), estados de comandas (`OrderStatus`), medios de pago (`PaymentMethod`) y roles (`UserRole`) se manejan con Enums estrictos, nunca strings mágicos repetidos.
  * **Config & Environment:** Todo parámetro de conexión, URLs de endpoints de la DIAN/Factus o credenciales se maneja exclusivamente a través de `config()` y `.env`.
  * **Vistas Dinámicas:** Componentes frontend que se construyen dinámicamente según la respuesta del servidor sin tablas fijas ni opciones cableadas.

---

## 🎯 Proyectos Bajo Dirección de Brayan (`bscl`)
* [[Netflix TV Bridge]]
* [[Accesorios Lilis]]
* [[TikTok Live Recorder]]
* [[Portafolio Personal]]
* [[Camara Sony Cyber-shot]]
* [[Restaurante Bigpollo]]
