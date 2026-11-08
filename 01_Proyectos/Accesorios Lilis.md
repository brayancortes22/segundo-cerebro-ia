# 💍 Accesorios Lilís

- **Tipo:** Web Application / E-commerce Fullstack Artesanal
- **Estado:** 🟡 Frontend en producción; API detenida (servicio de Render suspendido por facturación) y base de datos ya migrada a Aiven
- **URL en Producción:** [accesorios-lilis-2026.vercel.app](https://accesorios-lilis-2026.vercel.app)
- **Ubicación en disco:** `c:\Users\NITRO ACER\Desktop\proyectos con ia\Accesorios lilis\`
- **Relacionado:** [[00_Centro_de_Mando]], [[Colaboracion con IA (Antigravity)]], [[Blindaje Anti-Bots y Proteccion de Recursos]], [[DevOps y CI-CD (GitHub Actions, Azure, Jenkins y Despliegues)]]

---

## 🎯 Descripción
Plataforma oficial de comercio electrónico y catálogo interactivo para el emprendimiento familiar de **Liliana Lombana Polanía** en **Algeciras (Huila, Colombia)**. Confección artesanal de aretes, collares, pulseras y bisutería 100% hecha a mano.

---

## 🏗️ Estructura del Proyecto
- `frontend/`: Cliente web (React 19 + TypeScript + Vite) desplegado en Vercel con diseño responsive, onboarding con avatar oficial (`driver.js`), zoom táctil (lightbox) y checkout conectado a WhatsApp.
  - `components/admin/`: panel administrativo modular (`AdminPage`, `AdminGuard`, secciones de catálogo/pedidos/categorías/equipo, `AdminModal` y hooks por dominio).
  - `hooks/useHashRoute.ts`: enrutador por hash sin dependencias para las rutas `#/admin/catalogo`, `#/admin/pedidos`, `#/admin/categorias` y `#/admin/equipo`.
  - `styles/admin-app.css`: shell a pantalla completa, barra inferior móvil, hojas inferiores y pantalla de acceso.
  - Iconografía: `lucide-react` como única fuente de iconos SVG en tienda y panel; sin emojis ni glifos de texto en la UI (los de los mensajes de WhatsApp se conservan por ser copy).
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

## 🗄️ Base de Datos e Infraestructura
- **Motor:** MySQL 8.4.11 en Aiven, servicio `accesorios-lilis-db` (plan `free-1-1gb`, nube `do-nyc`, estado `RUNNING`).
- **Conexión:** `accesorios-lilis-db-bscl20062007-7997.f.aivencloud.com:22810`, base `accesorios_lilis`, usuario `avnadmin`, TLS obligatorio (`SslMode=Required`).
- **Datos reales (2026-10-27):** 56 productos (todos con imagen y stock), 6 categorías (4 activas: `Bolsos y Carteras` y `pijamas` están inactivas), 7 pedidos, 7 ítems de pedido, 2 clientes y 10 usuarios; migración EF `20260901233700_InitialCreate` presente. La fuente autoritativa fue el volcado HeidiSQL `bd accesorios.sql` exportado de la Aiven anterior (`defaultdb`), no la base local de Windows.
- **Ojo con los datos de prueba:** la base local `accesorios_lilis` (Windows) tenía 112 productos de demo (`Aretes Candonga Baño en Oro`, etc.). Se restauraron por error en el primer intento y se reemplazaron por los 56 reales; ese set de demo quedó respaldado en `accesorios_lilis-2026-10-27_1556.sql`.
- **Credenciales:** `~/.secrets/integraciones.env` (fuera de todo repositorio, ACL restringida al usuario de Windows). Respaldo SQL de los datos reales en `~/.secrets/backups/accesorios_lilis-2026-10-27_1557.sql`.
- **Respaldos:** `~/.secrets/backup-accesorios-lilis.cmd` (doble clic) ejecuta `backup-accesorios-lilis.ps1`, que vuelca con `mysqldump`, verifica el archivo, conserva los últimos 14 y registra todo en `~/.secrets/backups/respaldo.log`. Para programarlo a diario: `-InstalarTarea -Hora 20:00`. Validado restaurando un volcado en una base temporal.
- **Cuenta Aiven anterior:** sin horas disponibles; su host DNS ya no resuelve, por lo que el volcado HeidiSQL del usuario fue la única copia recuperable.
- **Backend (migrado 2026-10-27):** la cuenta de Render anterior agotó las horas gratuitas, así que el servicio se recreó en la cuenta `bscl20062007@gmail.com` (workspace `proyectos`). Nuevo servicio `accesorios-lilis` → `srv-dbggkm3l550s73bgvtdg`, Docker, plan free, región `ohio`: **https://accesorios-lilis-arhi.onrender.com**. El servicio viejo (`srv-dabqjgajnfac73dvnbc0`) queda suspendido por facturación y sin uso.
- **Frontend:** el proyecto real es `frontend` en Vercel → **https://accesorios-lilis-2026.vercel.app**, con `VITE_API_URL=https://accesorios-lilis-arhi.onrender.com/api`. El proyecto `accesorios-lilis`/`accesorios-lilis.vercel.app` era un duplicado obsoleto y ya no existe.
- **Nombres de tabla:** quedaron en PascalCase (`Products`, `Orders`, `OrderItems`, `Users`...) porque en Linux MySQL distingue mayúsculas y EF Core los espera así. En Windows funcionaba por casualidad (`lower_case_table_names=1`); si se vuelve a restaurar un dump hecho en Windows hay que renombrar las tablas.
- **Plan free de Render:** el servicio se duerme tras 15 minutos sin tráfico y el primer request tarda ~30-60 s. No conviene mantenerlo despierto 24/7 con un ping: 744 h al mes consumirían casi las 750 h gratuitas.

---

## 📝 Próximos Pasos
- [x] Blindaje integral contra bots y agotamiento de inventario.
- [x] Pipeline CI/CD automatizado en 3 ramas a producción.
- [x] Panel administrativo a pantalla completa con rutas protegidas, navegación móvil y tour guiado de 8 pasos.
- [ ] Conexión de pasarela de pagos directa (Wompi / Bold / Bre-B QR dinámico).
- [ ] Panel analítico con métricas de ventas y gráficos en tiempo real.
- [ ] Eliminar el servicio suspendido `accesorios-lilis` de la cuenta vieja de Render cuando se confirme que todo opera en la nueva.
- [ ] Rotar los tokens que se compartieron por chat (Aiven, Vercel, Render y un PAT válido de GitHub).
- [ ] Revisar la política CORS: hoy acepta cualquier origen con credenciales (`SetIsOriginAllowed(_ => true)` + `AllowCredentials`).
