# 🏦 Banking Transaction & Ledger Core API

* **Ubicación Local:** `banking-transaction-core-api`
* **Swagger OpenAPI:** `http://localhost:8080/swagger-ui.html`
* **Estado:** 🟢 Estable · Clean Architecture Certificada
* **Lead Backend Engineer:** Brayan Stid Cortés Lombana (`bscl`)
* **Stack Tecnológico:** Java 21 LTS, Spring Boot 3.4.2, Spring Data JPA / Hibernate, PostgreSQL 16, Docker, Swagger OpenAPI 3

---

## ⚡ Descripción y Propósito

Microservicio transaccional bancario y libro mayor contable (*Ledger*) de alta concurrencia y tolerancia a fallos, desarrollado bajo **Clean Architecture**, **principios SOLID** y los más recientes estándares de la industria financiera y Fintech internacional.

---

## 🛡️ Decisiones Críticas de Arquitectura e Ingeniería

### 1. Prevención de Condiciones de Carrera (*Race Conditions* / Doble Gasto)
* En operaciones financieras concurrentes, dos retiros simultáneos podrían dejar la cuenta con saldo negativo (*Double Spending*).
* **Solución Implementada:** Bloqueo Pesimista de Escritura (`@Lock(LockModeType.PESSIMISTIC_WRITE)`) a nivel de base de datos en `AccountRepository.findByAccountNumberForUpdate`, garantizando que únicamente un hilo a la vez adquiera el bloqueo exclusivo sobre la fila para mutar el balance.

### 2. Prevención de Interbloqueos (*Deadlock Prevention*)
* En transferencias bidireccionales concurrentes entre dos cuentas A y B, un hilo podría bloquear A esperando B, mientras otro bloquea B esperando A.
* **Solución Implementada:** Ordenamiento determinista de bloqueos. El sistema siempre adquiere el bloqueo primero sobre la cuenta con el ID alfanumérico menor (`min(accountA, accountB)`), erradicando matemáticamente el ciclo de espera circular (*Coffman conditions*).

### 3. Trazabilidad Inmutable del Libro Mayor (*Ledger Auditability*)
* Toda transacción genera un registro inmutable en el Ledger con UUID único, marca de tiempo ISO 8601, cuenta origen, cuenta destino, tipo de operación (Débito, Crédito, Transferencia) y balance resultante verificado.

---

## 🌿 Flujo de Ramas y Dockerización
* `development`: Desarrollo de casos de uso y endpoints REST.
* `qa`: Pruebas de carga concurrente y pruebas unitarias/integración con JUnit 5 y Testcontainers.
* `main`: Producción lista para empaquetado en imagen Docker optimizada con Eclipse Temurin JRE 21.
