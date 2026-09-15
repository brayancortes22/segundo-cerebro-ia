# 🛡️ Seguridad de Datos, Habeas Data y Blindaje Legal (Anti-Demandas)

## 📌 Contexto y Fundamentación Legal
En el desarrollo de software comercial, SaaS y plataformas transaccionales (especialmente con facturación electrónica y pasarelas de pago), la seguridad técnica y el cumplimiento legal de privacidad no son características opcionales: **son una obligación legal estricta**.

Ignorar esta normativa expone a la empresa, a sus socios y a los desarrolladores a:
1. **Demandas civiles y laborales** por filtración de datos sensibles.
2. **Sanciones de la Superintendencia de Industria y Comercio (SIC)** de hasta **2.000 SMMLV** (más de 2.600 millones de pesos colombianos).
3. **Cierre temporal o definitivo** del establecimiento o del servicio en la nube.
4. **Sanciones penales** por delitos informáticos (Ley 1273 de 2009 en Colombia: violación de datos personales, acceso abusivo a sistemas informáticos).

---

## 🏛️ 1. Normativa en Colombia (Ley 1581 de 2012 y Decreto 1377 de 2013)

### A. Principio de Legalidad y Consentimiento Previo, Expreso e Informado
- **PROHIBIDO:** Capturar nombres, cédulas, números telefónicos o correos electrónicos de clientes para facturación o reservas sin su consentimiento explícito y demostrable.
- **OBLIGATORIO:**
  - El usuario debe marcar voluntariamente (o confirmar en pantalla/ticket) la aceptación del tratamiento de datos.
  - El sistema debe almacenar la evidencia: `consent_granted_at` (timestamp), `consent_ip` y la versión de la política aceptada.
  - **Fórmula de Consentimiento Estándar:**
    > *"Autorizo de manera previa, expresa e informada a [Nombre del Restaurante / Tenant] el tratamiento de mis datos personales según su Política de Tratamiento de la Información, para emisión de facturas electrónicas ante la DIAN, soporte del servicio y notificaciones de pedidos. Conozco mis derechos de consulta, actualización y supresión mediante el correo legal@[dominio.com]."*

### B. Derechos ARCO del Titular
1. **Acceso:** Consultar qué datos tiene la plataforma sobre él.
2. **Rectificación:** Actualizar información desactualizada o errónea.
3. **Cancelación / Supresión:** Solicitar eliminación de sus datos.
   - *Excepción Tributaria Vital:* Si el cliente pide borrar sus datos pero tiene facturas electrónicas emitidas, la ley colombiana (Art. 632 Estatuto Tributario) exige conservar los registros fiscales por **5 años**. En ese caso, los datos se conservan en un archivo histórico bloqueado fiscalmente, pero se eliminan de marketing, promociones y listas activas.
4. **Oposición:** Negarse al uso de sus datos para finalidades no esenciales.

---

## 🔒 2. Medidas Técnicas de Seguridad en la Arquitectura de Software

### A. Cifrado en Reposo y en Tránsito
- **Tránsito:** Exigir siempre conexiones seguras con TLS 1.3 / HTTPS. HSTS (HTTP Strict Transport Security) activado.
- **Reposo (Base de Datos):**
  - Contraseñas con hashing de un solo sentido (`bcrypt` o `argon2id`). Prohibido MD5 o SHA-256 sin salting.
  - Secretos y llaves de APIs (Tokens de Factus para DIAN, llaves privadas de certificados digitales, credenciales de pasarelas) **deben almacenarse cifrados** utilizando `Crypt::encryptString()` o atributos cifrados de Eloquent (`'factus_api_token' => 'encrypted'`).

### B. Trazabilidad y Auditoría Inmutable (Audit Trail)
Cualquier modificación crítica debe dejar un registro forense:
- ¿Quién anuló una comanda o factura?
- ¿Quién modificó el precio de un plato o eliminó un ingrediente?
- ¿Desde qué dirección IP y a qué hora exacta (UTC) se realizó la operación?

### C. Prevención de Brechas y OWASP Top 10
1. **SQL Injection:** Uso estricto de ORMs y consultas preparadas (PDO). Cero interpolación manual de cadenas en queries.
2. **XSS (Cross-Site Scripting):** Sanitización y escape automático en el motor de plantillas (Blade/React).
3. **Rate Limiting & Anti-Brute Force:** Limitar intentos de autenticación en la API y endpoints públicos para evitar ataques de denegación de servicio o robo de credenciales.
4. **Desacoplamiento con API Resources:** Prohibido exponer modelos directamente en respuestas JSON para evitar filtrar hashes de contraseñas, tokens de sesión o datos internos de otros inquilinos.

---

## 📜 3. Documentos Legales Mandatorios en el SaaS / Restaurante
1. **Política de Tratamiento de Datos Personales (PTDP):** Documento público accesible por enlace web donde se explica quién es el responsable, qué datos se recopilan, para qué fines y el canal oficial de PQRS.
2. **Términos y Condiciones de Uso (T&C):** Contrato de adhesión que regula los límites de responsabilidad del software ante fallas de conectividad de la DIAN, caída de internet del restaurante y responsabilidades del usuario.
3. **Acuerdo de Nivel de Servicio y Confidencialidad (NDA / DPA - Data Processing Agreement):** Cuando el SaaS actúa como *Encargado del Tratamiento* de los datos que los restaurantes (*Responsables*) introducen de sus comensales.
