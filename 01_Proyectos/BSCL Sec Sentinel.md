# 🛡️ BSCL Sec Sentinel — Suite Universal de Auditoría Defensiva

* **Ubicación Local:** `bscl-sec-sentinel`
* **Estado:** 🟢 Activo · CLI de Auditoría del Workspace
* **Lead DevSecOps Engineer:** Brayan Stid Cortés Lombana (`bscl`)
* **Stack Tecnológico:** TypeScript, Node.js, CLI Modular, Reglas OWASP ASVS 5.0 & Ley 1581 (Habeas Data)

---

## ⚡ Descripción y Funcionamiento

Motor modular de análisis estático de seguridad (**SAST**), postura arquitectónica y cumplimiento legal (**Ley 1581 de 2012 / Habeas Data Colombia y GDPR**) diseñado para escanear y certificar cualquier proyecto del workspace (`Laravel/PHP`, `TypeScript/Node.js`, `React`, `Python`, `GitHub Actions`).

---

## 🚀 Arquitectura Modular (6 Motores Especializados)

El flujo de dependencias sigue estrictamente el patrón unidireccional: `Types ➔ Config ➔ Scanners ➔ Core ➔ Reporters ➔ CLI`.

| Motor | Dominio | Controles Auditados | Referencia Estándar |
| :--- | :--- | :--- | :--- |
| **Motor 1** | `SECRETS_HARDCODING` | API Keys, tokens en código, llaves PEM, `.env` expuestos sin `.gitignore`, IDs mágicos quemados (`$user->id == 1`). | `ASVS-v5.0-V6.4.1`, Regla 6 |
| **Motor 2** | `INJECTION_SAST` | SQL Injection (`DB::raw`, strings sin preparar), XSS (`{!! !!}`, `dangerouslySetInnerHTML`), `eval`/`exec`, deserialización insegura. | `ASVS-v5.0-V1.2`, `V1.3`, `V5.3` |
| **Motor 3** | `API_ANTIBOT` | Rutas de mutación (`POST`, `PUT`, `DELETE`) sin `throttle`/Rate-Limiting ni trampas Honeypot, Mass Assignment (`$guarded = []`). | `ASVS-v5.0-V2.4.1`, `V4.2.2`, Regla 8 |
| **Motor 4** | `CRYPTO_CONFIG` | Hashing débil (`md5`, `sha1`), JWT con algoritmo `none`, CORS permisivo (`*`), TLS desactivado, cookies sin flag `HttpOnly`. | `ASVS-v5.0-V3.3`, `V9.1`, `V11.2`, `V12.2` |
| **Motor 5** | `PRIVACY_HABEAS_DATA` | Tokens fiscales o PII sin cast `encrypted`, fugas de credenciales en `console.log` o logs de servidor, falta de checkboxes de consentimiento. | `ASVS-v5.0-V14.2.1`, `V16.3.1`, Ley 1581 |
| **Motor 6** | `SUPPLY_CHAIN` | Acciones de GitHub sin fijar a commit hash (`@main` o `@latest`), permisos excesivos (`permissions: write-all`), dependencias vulnerables. | `ASVS-v5.0-V15.1.2`, `V15.1.3` |

---

## 🛠️ Comandos de Ejecución

```bash
# Auditar un proyecto específico
npm run scan -- --target=../restaurante-bigpollo

# Auditar con reporte SARIF / JSON para CI/CD
npm run scan -- --target=../banking-transaction-core-api --format=json
```
