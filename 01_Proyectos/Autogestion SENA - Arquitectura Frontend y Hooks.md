# 🎨 Autogestión SENA — Arquitectura Frontend, Custom Hooks y ConfigApi

- **Proyecto Padre:** [[Autogestion SENA]]
- **Tecnologías:** React 19, TypeScript, Vite, Tailwind CSS, React Router, Jest, RTL
- **Objetivo:** Guía arquitectónica profunda del frontend, diseño de Custom Hooks modulares, gestión centralizada de endpoints y desacoplamiento de UI.
- **Relacionado:** [[00_Centro_de_Mando]], [[Clean Code y SOLID]], [[Arquitectura Limpia y Patrones de Arquitectura]]

---

## 📁 1. Estructura Modular del Proyecto

La estructura de directorios fue diseñada para separar rigurosamente la presentación, la lógica de negocio, la comunicación HTTP y la definición de tipos:

```
frontend/
├── public/                 # Recursos estáticos no procesados (favicon, logos SENA, placeholders)
├── src/
│   ├── Api/                # Capa de Comunicación HTTP
│   │   ├── config/         # Configuración centralizada de endpoints (ConfigApi.ts)
│   │   ├── Services/       # Servicios especializados por entidad (User, Form, Instructor, etc.)
│   │   └── types/          # Interfaces TypeScript de entidades y DTOs
│   │
│   ├── components/         # Componentes Presentacionales (Dumb Components)
│   │   ├── ui/             # Primitivas accesibles y reutilizables (Botones, Modales, Cards, Tables)
│   │   ├── ModuleSecurity/ # Componentes del módulo de roles, usuarios y permisos
│   │   ├── assing/         # Vistas de asignación de aprendices
│   │   └── MainLayout/     # Navbar, Sidebar, Modales de sesión y ProtectedRoute
│   │
│   ├── hook/               # Custom Hooks con la lógica de estado y negocio (Smart Layer)
│   │   ├── useAuth.ts      # Manejo de login, tokens y estado de sesión
│   │   ├── useApi.ts       # Hook genérico para llamadas API con loading/error/refetch
│   │   ├── useForms.ts     # Gestión de formularios y permisos
│   │   ├── useRoles.ts     # Control de roles y matriz de permisos
│   │   └── userIdleTimer.ts# Watchdog de expiración de sesión por inactividad
│   │
│   ├── pages/              # Vistas completas asociadas a rutas de navegación
│   │   ├── Login.tsx       # Inicio de sesión institucional con selector de cuentas demo
│   │   ├── Admin.tsx       # Panel de administración de seguridad
│   │   ├── Assign.tsx      # Gestión de solicitudes de asignación
│   │   └── ...
│   │
│   ├── Css/                # Estilos globales y módulos CSS específicos
│   ├── Testing/            # Scripts de automatización, suites de Jest y mocks
│   ├── App.tsx             # Enrutador principal y proveedores de contexto
│   └── main.tsx            # Punto de entrada de Vite
```

---

## 🌐 2. Patrón de Registro Centralizado de Endpoints (`ConfigApi.ts`)

Uno de los patrones más destacados del frontend es el **Endpoint Facade Pattern** implementado en `src/Api/config/ConfigApi.ts`:

### Principios del Diseño:
1. **Punto Único de Verdad (Single Source of Truth):** Ningún componente o servicio invoca URLs relativas o absolutas directamente. Todo el mapa de rutas de la API Django reside en `ConfigApi.ts`.
2. **Cero Código Quemado (Regla 6):** Si un endpoint cambia en el backend, la modificación se hace en una sola línea de este archivo.
3. **Resolución Inteligente de Entornos:**
   ```typescript
   const API_BASE_URL =
     import.meta.env.VITE_API_BASE_URL ||
     (import.meta.env.PROD
       ? "https://autogestion-sena-api.onrender.com/api/"
       : "http://localhost:8000/api/");
   ```
4. **Agrupación Jerárquica por Dominio (Namespacing):**
   ```typescript
   export const ENDPOINTS = {
     user: {
       validateLogin: `${API_BASE_URL}security/users/validate-institutional-login/`,
       validateSecondFactor: `${API_BASE_URL}security/users/validate-2fa-code/`,
       getUserId: `${API_BASE_URL}security/users/{id}/`,
       deleteUser: `${API_BASE_URL}security/users/{id}/soft-delete/`,
     },
     rol: {
       getRoles: `${API_BASE_URL}security/roles/`,
       postRolPermissions: `${API_BASE_URL}security/rol-form-permissions/create-role-with-permissions/`,
     },
     // ...
   };
   ```
5. **Arquitectura Espejo con el Cliente Móvil (.NET MAUI):**
   Este mismo enfoque se reflejó en `mobile/Const/Endpoints.cs`, garantizando que ambos clientes compartan idéntica estructura y nomenclatura para consumir la API.

---

## 🎣 3. La Filosofía de los Custom Hooks: Desacoplando Lógica de UI

El proyecto adoptó la arquitectura **Smart vs. Dumb Components** (Componentes Contenedores vs. Componentes Presentacionales) usando Custom Hooks:

* **Componentes UI (Dumb):** Solo reciben datos por `props`, emiten eventos (`onClick`, `onSubmit`) y renderizan JSX estilizado con Tailwind CSS. No conocen URLs, tokens ni llamadas de red.
* **Custom Hooks (Smart):** Encapsulan el estado reactivo (`useState`), los ciclos de vida (`useEffect`), las llamadas a servicios y las transformaciones de datos.

### Beneficios Técnicos Obtenidos:
- **Reutilización:** El mismo hook `useAuth` alimenta el formulario de login, la barra de navegación y las rutas protegidas.
- **Testabilidad:** La lógica de negocio puede probarse de forma aislada con `renderHook` de React Testing Library sin necesidad de montar interfaces complejas.
- **Mantenibilidad:** Los componentes visuales reducen su tamaño de más de 100 líneas a menos de 40 líneas de código limpio.

---

## 🛠️ 4. Catálogo de Custom Hooks Implementados

### 1. `useAuth` — Ciclo de Vida de Autenticación y 2FA
Gestiona el almacenamiento seguro del token JWT en `localStorage`, la verificación de expiración y el flujo de autenticación de dos factores:
```typescript
export const useAuth = () => {
  const [user, setUser] = useState<User | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(true);

  // Verificación inicial de sesión al montar
  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (token) {
      validateSession(token);
    } else {
      setLoading(false);
    }
  }, []);

  const login = async (credentials: LoginCredentials) => { ... };
  const verify2FA = async (code: string) => { ... };
  const logout = () => {
    localStorage.clear();
    setIsAuthenticated(false);
  };

  return { user, isAuthenticated, loading, login, verify2FA, logout };
};
```

---

### 2. `useApi<T>` — Cliente Genérico Reactivo
Abstracción para llamadas asíncronas que gestiona automáticamente los estados de `loading`, `error`, `data` y función de reintento `refetch`:
```typescript
export const useApi = <T>(apiCall: () => Promise<T>, dependencies: any[] = []) => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const execute = async () => {
    try {
      setLoading(true);
      setError(null);
      const result = await apiCall();
      setData(result);
    } catch (err: any) {
      setError(err.message || 'Error en la petición');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { execute(); }, dependencies);

  return { data, loading, error, refetch: execute };
};
```

---

### 3. `useSecurityForms` — Eliminación Lógica vs. Persistencial
Controla la administración de formularios del SENA implementando el estándar institucional de doble ciclo de vida:
* **Eliminación Lógica (`logical-delete`):** Marca el registro con `active = false`. El formulario se oculta de la interfaz operativa pero permanece en auditoría y es 100% recuperable.
* **Eliminación Persistencial (`persistential-delete`):** Asigna marca temporal `deleted_at` para purga definitiva según políticas de retención.

---

### 4. `useForm` & `useSenaValidation` — Validación Reactiva Institucional
Maneja el estado y los errores de formularios complejos, aplicando reglas de negocio específicas del SENA:
* **Dominio Institucional Obligatorio:** Aprendices deben ingresar correos `@soy.sena.edu.co` y funcionarios `@sena.edu.co`.
* **Tipos de Documento Válidos:** `CC`, `TI`, `CE`, `PEP`, `PPT`.
* **Periodo de Contrato:** Duración máxima permitida de 7 meses para etapa productiva.

---

### 5. `useIdleTimer` — Watchdog de Seguridad de Sesión
Protege los puestos de trabajo en centros de formación del SENA:
- Detecta inactividad del usuario monitoreando eventos globales del DOM (`mousemove`, `keydown`, `touchstart`).
- Al cumplirse el tiempo límite de inactividad, despliega `SessionExpiredModal` y elimina tokens de autenticación de forma segura para prevenir accesos no autorizados.

---

## 🧪 5. Estrategia de Testing

El proyecto cuenta con un entorno de pruebas robusto:
- **Jest:** Motor de ejecución de pruebas unitarias.
- **React Testing Library (RTL):** Validación de componentes orientada al comportamiento del usuario (*User-Centric Testing*).
- **MSW (Mock Service Worker):** Intercepción de llamadas HTTP de red para simular respuestas de Django en entornos aislados.
- **Suites Automatizadas:** Pruebas de integración para login, recuperación de contraseña, verificación de 2FA y modales de asignación.
