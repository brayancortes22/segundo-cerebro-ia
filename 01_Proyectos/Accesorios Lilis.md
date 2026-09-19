# 💍 Accesorios Lilís

- **Tipo:** Web Application / E-commerce Fullstack Artesanal
- **Estado:** 🟢 En Producción (Vercel + ASP.NET Core Web API)
- **URL en Producción:** [accesorios-lilis-2026.vercel.app](https://accesorios-lilis-2026.vercel.app)
- **Ubicación en disco:** `c:\Users\NITRO ACER\Desktop\proyectos con ia\Accesorios lilis\`
- **Relacionado:** [[00_Centro_de_Mando]], [[Colaboracion con IA (Antigravity)]], [[Blindaje Anti-Bots y Proteccion de Recursos]], [[DevOps y CI-CD (GitHub Actions, Azure, Jenkins y Despliegues)]]

---

## 🎯 Descripción
Plataforma oficial de comercio electrónico y catálogo interactivo para el emprendimiento familiar de **Liliana Lombana Polanía** en **Algeciras (Huila, Colombia)**. Confección artesanal de aretes, collares, pulseras y bisutería 100% hecha a mano.

---

## 🏗️ Estructura del Proyecto
- `frontend/`: Cliente web (React 19 + TypeScript + Vite) desplegado en Vercel con diseño responsive, onboarding con avatar oficial (`driver.js`), zoom táctil (lightbox) y checkout conectado a WhatsApp.
- `backend/`: API REST en ASP.NET Core (.NET 10) con Entity Framework Core, MySQL, autenticación JWT con Cookies `HttpOnly`, y capa de servicios desacoplada.
- `tests/`: Batería completa de pruebas unitarias (.NET xUnit) y suites de integración en Python.
- `escalar.bat`: Script local de 1 solo clic para el pipeline escalonado de 3 ramas (`development -> qa -> main`).
- `accesorios-lilis-architecture.html`: Mapa interactivo del sistema generado con Archify.

---

## 🛡️ Blindaje de Seguridad y Anti-Bots Activo
1. **Trampa Honeypot Invisible en Checkout:** Campo trampa camuflado fuera del viewport. Si un script o bot automático lo rellena, el backend aborta la transacción con `400 Bad Request` antes de tocar inventario o MySQL.
2. **Rate Limiting Contextual:**
   - Global: 300 req / min.
   - Autenticación (`AuthLimit`): 30 req / min (anti-fuerza bruta).
   - Pedidos (`OrdersLimit`): 10 pedidos / 10 min por IP (prevención de agotamiento de stock / *Denial of Inventory*).
3. **`BotDetectionMiddleware`:** Bloqueo de peticiones de mutación sin cabecera `User-Agent` o con firmas de escáneres maliciosos (`sqlmap`, `nikto`, `masscan`, etc.) con `HTTP 403 Forbidden`.
4. **Soporte Cloudflare Turnstile / reCAPTCHA v3:** Validación en backend lista mediante `ICaptchaService`.
5. **Sanitización de Entradas (XSS):** Filtro exhaustivo con `InputSanitizer.cs`.
6. **Autenticación Criptográfica:** Hashing PBKDF2-SHA256 con 100.000 iteraciones y comparación en tiempo constante (`CryptographicOperations.FixedTimeEquals`).

---

## 📝 Próximos Pasos
- [x] Blindaje integral contra bots y agotamiento de inventario.
- [x] Pipeline CI/CD automatizado en 3 ramas a producción.
- [ ] Conexión de pasarela de pagos directa (Wompi / Bold / Bre-B QR dinámico).
- [ ] Panel analítico con métricas de ventas y gráficos en tiempo real.
