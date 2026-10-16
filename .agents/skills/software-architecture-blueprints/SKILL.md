---
name: software-architecture-blueprints
description: Guía definitiva y matriz de decisión de arquitecturas de software y estructuras de carpetas estándar (Clean Architecture, Hexagonal, Feature-Sliced Design, ADR/Action Classes en Laravel, Modular Monolith, FastAPI, Godot/Aurora Engine). Activar para diseñar, estructurar, refactorizar o auditar la organización de código de cualquier proyecto.
---

# Software Architecture & Folder Structure Blueprints

Esta habilidad provee la **matriz de decisión arquitectónica**, los **árboles de carpetas estándar** y las **reglas de desacoplamiento** para seleccionar y aplicar la arquitectura óptima según el tipo de proyecto, lenguaje y escala.

---

## 🎯 1. Matriz de Decisión: ¿Qué Arquitectura Elegir?

| Tipo de Proyecto | Escala / Complejidad | Arquitectura Recomendada | Estructura Principal |
| :--- | :--- | :--- | :--- |
| **Frontend Web Complejo** (React, Next.js, Vue) | Media a Alta | **Feature-Sliced Design (FSD)** | `app/`, `pages/`, `widgets/`, `features/`, `entities/`, `shared/` |
| **Backend Laravel / PHP 8.3** (SaaS, POS, APIs) | Media a Enterprise | **Action-Domain-Responder (ADR) + Service Layer** | `Actions/`, `Services/`, `Http/Requests/`, `DTOs/`, `Enums/`, `Models/` |
| **Backend Node / NestJS / Go / FastAPI** | Alta / Lógica Crítica | **Clean Architecture / Hexagonal (Ports & Adapters)** | `domain/`, `application/`, `infrastructure/`, `interfaces/` |
| **Microservicios / Backend Ágil** | Baja a Media | **Layered / Screaming by Domain** | `modules/<dominio>/{handlers, services, repos, models}` |
| **Motor o Juego Godot 4 / Aurora Engine** | Cualquier escala | **Domain-Driven Game Engine Hierarchy** | `core/`, `systems/`, `entities/`, `autoloads/`, `scenes/`, `resources/` |
| **Monorepo Multi-Paquete** (SaaS + Mobile + Landing) | Alta | **Turborepo / pnpm Workspaces** | `apps/{web, api, docs}`, `packages/{ui, config, database, types}` |

---

## 🏛️ 2. Estructuras de Carpetas Estándar (Ready to Use)

### A. Frontend: Feature-Sliced Design (FSD 2.1)
Estándar estricto para React / Next.js / Vue. Cada nivel solo puede importar de niveles inferiores.
```
src/
├── app/                  # Proveedores globales, enrutador raíz, estilos globales
├── pages/                # Vistas de página completas (composición de widgets)
├── widgets/              # Bloques autónomos complejos (Header, Sidebar, Feed, CheckoutPanel)
├── features/             # Casos de uso interactivos con valor de negocio (AddToCart, FilterProducts)
├── entities/             # Modelos de negocio y estado del dominio (UserCard, ProductItem, OrderSummary)
└── shared/               # Componentes UI atómicos, utilidades, hooks base, APIs, tokens
    ├── ui/               # Botones, inputs, modales, diseño base
    ├── api/              # Cliente HTTP, endpoints base
    └── lib/              # Helpers puros, formateadores de fecha/moneda
```
*Regla de Importación:* `app ➔ pages ➔ widgets ➔ features ➔ entities ➔ shared` (Unidireccional estricto).

---

### B. Backend Laravel 11 / PHP 8.3 (Regla Anti God-Class y ADR)
En cumplimiento estricto de la **Regla 5 de GEMINI.md**:
```
app/
├── Actions/              # UN caso de uso por clase (ej: CreateOrderAction, ProcessPaymentAction)
│   └── Orders/
│       ├── CreateOrderAction.php
│       └── CancelOrderAction.php
├── Services/             # Integración con servicios externos o lógica multi-acción
│   ├── FactusInvoiceService.php
│   └── PaymentGatewayService.php
├── DTOs/                 # Data Transfer Objects fuertemente tipados
│   └── OrderData.php
├── Enums/                # PHP 8.3 Backed Enums (cero strings o magic numbers quemados)
│   ├── OrderStatus.php
│   └── PaymentMethod.php
├── Http/
│   ├── Controllers/      # Skinny Controllers (<80 líneas, solo delegan a Actions)
│   ├── Requests/         # Form Requests para validación aislada
│   └── Resources/        # API Resources para formateo JSON desacoplado
├── Models/               # Modelos Eloquent con relaciones y scopes (sin lógica pesada)
└── Policies/             # Autorización y permisos granulares
```

---

### C. Clean Architecture / Hexagonal (Backend Node / Python / Go)
Desacoplamiento total de frameworks, bases de datos y transporte.
```
src/
├── domain/               # El núcleo puro (cero dependencias externas)
│   ├── entities/         # Entidades de negocio con invariantes
│   ├── exceptions/       # Excepciones del dominio
│   └── repositories/     # Interfaces/Contratos abstractos (Ports)
├── application/          # Casos de uso de la aplicación
│   ├── use-cases/        # Execute / Handle de cada requerimiento
│   └── dtos/             # Entradas y salidas de los casos de uso
├── infrastructure/       # Implementación tecnológica (Adapters)
│   ├── persistence/      # Implementación SQL / Mongo / Prisma de repositorios
│   ├── http/             # Clientes axios/fetch, llamadas a APIs externas
│   └── messaging/        # Queues, WebSockets, Kafka, RabbitMQ
└── interfaces/           # Puntos de entrada al sistema
    ├── http/             # Rutas, controladores Express/Fastify/FastAPI
    └── cli/              # Comandos de consola o jobs cron
```

---

### D. Arquitectura para Videojuegos (Godot 4 / Aurora Engine)
Estructura desacoplada para evitar dependencias circulares entre nodos.
```
res://
├── core/                 # Sistemas fundamentales agnósticos
│   ├── state_machine/    # Máquinas de estado genéricas
│   ├── save_system/      # Persistencia y serialización
│   └── event_bus.gd      # Señales globales desacopladas (Autoload)
├── entities/             # Actores del juego con lógica modular
│   ├── player/           # Escena, scripts, animaciones y state de Player
│   └── enemies/          # Variantes de enemigos heredando de BaseEnemy
├── systems/              # Subsistemas del juego
│   ├── inventory/
│   ├── combat/
│   └── dialogue/
├── ui/                   # Interfaz de usuario desacoplada
│   ├── hud/
│   └── menus/
└── assets/               # Texturas, modelos 3D, shaders y audios
```

---

## 🚫 3. Anti-Patrones Estructurales a Detectar y Corregir

1. **God Folder / Utils Basurero:** Un `utils/` o `helpers/` con decenas de archivos sin cohesión.  
   *Solución:* Mover cada función utilitaria al dominio que le corresponde o dividir en módulos específicos (`date-helpers`, `formatters`, `math`).
2. **Skinny Domain, Fat Controller:** Controladores de 500 líneas con validaciones, consultas a BD y llamadas HTTP directas.  
   *Solución:* Aplicar **Action Classes** (un caso de uso por archivo) y **Form Requests**.
3. **Fuga de Dependencias (Dependency Leakage):** La capa de dominio importando librerías de infraestructura (ej. un modelo de dominio importando `mongoose` o `express`).  
   *Solución:* Usar interfaces (Inversión de Dependencias - DIP).
4. **Acoplamiento Circular:** Archivo A importa B y B importa A.  
   *Solución:* Extraer el tipo o contrato compartido a un archivo en `shared/` o `domain/`.
5. **Archivos Monolíticos (>200 líneas):** Componentes o clases con demasiadas responsabilidades (violación SRP).  
   *Solución:* Dividir en subcomponentes, custom hooks o servicios especializados.
