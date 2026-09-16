---
name: data-security-privacy
description: >-
  Estándares de seguridad de datos, cifrado, cumplimiento normativo de Habeas Data
  (Ley 1581 de 2012 Colombia / SIC), GDPR, términos y condiciones, consentimiento
  informado y blindaje legal en software y APIs.
---

# Seguridad de Datos, Habeas Data y Cumplimiento Legal (Anti-Demandas)

Utiliza esta skill siempre que se diseñen bases de datos, APIs, flujos de autenticación, captura de datos de clientes, facturación electrónica o políticas de privacidad para blindar legal y técnicamente al software y a sus propietarios.

---

## 🏛️ 1. Marco Normativo y Prevención de Demandas

### A. Colombia: Ley 1581 de 2012 & Decreto 1377 de 2013 (Habeas Data)
La Superintendencia de Industria y Comercio (SIC) impone multas de hasta **2.000 SMMLV** y cierre de establecimientos por incumplimiento de:
1. **Principio de Libertad / Consentimiento Previo e Informado:**
   - Prohibido capturar datos de clientes (cédula, correo, teléfono, nombres) para facturación o marketing sin autorización explícita y almacenable (checkbox no pre-marcado o registro digital con timestamp e IP).
   - Texto de consentimiento obligatorio:
     > *"Autorizo de manera previa, expresa e informada el tratamiento de mis datos personales a [Nombre del Restaurante/SaaS] conforme a su Política de Tratamiento de la Información, para fines de facturación electrónica DIAN, atención al cliente y gestión del servicio. Conozco que puedo ejercer mis derechos de consulta y supresión mediante el correo [contacto@dominio.com]."*
2. **Derechos ARCO (Acceso, Rectificación, Cancelación y Oposición):**
   - El sistema debe ofrecer un mecanismo (vía endpoint o correo) para que el titular consulte o solicite la eliminación de sus datos.
   - **Excepción Tributaria DIAN:** Si el cliente solicita supresión de datos pero tiene facturas electrónicas emitidas, la información fiscal NO puede eliminarse durante **5 años** (Art. 632 del Estatuto Tributario), pero sí debe desactivarse para cualquier otro fin (marketing, fidelización).
3. **Registro Nacional de Bases de Datos (RNBD):**
   - Empresas con activos superiores a ciertos topes fijados por la SIC deben registrar sus bases de datos. El software debe permitir exportar metadatos del inventario de datos personales.

### B. Normativa Internacional: GDPR (Reglamento General de Protección de Datos UE)
Para clientes o usuarios internacionales:
- **Minimización de Datos:** Solo pedir lo estrictamente necesario.
- **Derecho al Olvido (Right to be Forgotten):** Anonimización de registros históricos cuando se extingue la relación legal.
- **Portabilidad de Datos:** Capacidad de exportar la información del usuario en JSON estructurado.

---

## 🛡️ 2. Seguridad Técnica en el Código (Laravel & SQL)

### A. Cifrado de Credenciales y Datos Sensibles (No Texto Plano)
- **Credenciales Externas:** Las llaves privadas, tokens de API de DIAN/Factus y passwords de bases de datos NUNCA van en texto plano en la BD ni en commits de Git.
- **Eloquent Encrypted Casts:**
  ```php
  // En el Modelo Tenant o Setting
  protected $casts = [
      'factus_api_token' => 'encrypted',
      'factus_refresh_token' => 'encrypted',
      'customer_tax_id' => 'encrypted', // opcional si se requiere máxima confidencialidad
  ];
  ```
- **Hashing Irreversible:** Contraseñas con `Hash::make()` usando Bcrypt o Argon2id con factor de coste balanceado.

### B. Auditoría y Trazabilidad Inmutable (Audit Trail)
Para defenderse ante cualquier litigio o reclamo de fraude:
- Registrar en una tabla de auditoría (`audit_logs` o `order_events`):
  - `user_id`: Quién ejecutó la acción.
  - `action`: `created`, `updated`, `cancelled`, `status_changed`, `invoice_emitted`.
  - `ip_address` y `user_agent`: Origen de la petición.
  - `payload_before` y `payload_after`: Estado previo y nuevo en JSON.
  - `created_at`: Timestamp UTC inalterable.

### C. Prevención de Fugas de Información (Data Leakage)
1. **API Resources Obligatorios:** Prohibido retornar modelos Eloquent directamente (`return response()->json($user)` ❌). Siempre usar JsonResource para filtrar `password`, `remember_token`, secretos o campos internos.
2. **Protección XSS & SQL Injection:**
   - Usar siempre consultas parametrizadas de PDO / Eloquent.
   - En vistas Blade, usar `{{ $dato }}` (que escapa con `htmlspecialchars`), nunca `{!! $dato !!}` salvo sanitización explícita con Purifier.
3. **Rate Limiting:** Proteger rutas de login y checkout contra ataques de fuerza bruta usando `RateLimiter::for('api', ...)`.

---

## 📋 3. Checklist de Protección Legal antes de Poner en Producción
- [ ] Enlace visible a la **Política de Tratamiento de Datos Personales (PTDP)** en el footer y pantallas de comanda/pago.
- [ ] Checkbox o aceptación de consentimiento registrado con `consent_accepted_at` y `consent_ip`.
- [ ] Encriptación de claves de Factus / pasarelas en base de datos.
- [ ] Endpoint o proceso para tramitar derechos de petición Habeas Data en menos de 15 días hábiles (plazo legal SIC).
- [ ] Registro de auditoría para anulaciones de pedidos y facturas.
- [ ] Cabeceras de seguridad HTTP activas (`X-Frame-Options`, `X-Content-Type-Options`, `Content-Security-Policy`).
