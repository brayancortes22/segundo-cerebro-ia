# 🚀 Desarrollo Limpio con Frameworks (React, Angular, Laravel)

- **Área:** Frontend & Backend Moderno
- **Relacionado:** [[Clean Code y SOLID]], [[Arquitectura Limpia y Patrones de Arquitectura]]

---

## ⚛️ 1. React Limpio (Clean React)

### Principios Clave:
* **Separación de Lógica y Presentación (Smart vs Dumb Components):**
  - Los componentes visuales solo reciben `props` y renderizan JSX.
  - La lógica de negocio, llamadas a APIs y estados complejos se encapsulan en **Custom Hooks** (ej. `useUserCart()`, `useProductFilter()`).
* **Inmutabilidad Estricta:**
  - Nunca mutar el estado directamente (`state.items.push(x)` ❌). Siempre usar copias inmutables (`[...state.items, x]` ✅).
* **Arquitectura por Características (Feature-Driven):**
  ```text
  src/
  ├── features/
  │   ├── auth/
  │   │   ├── components/
  │   │   ├── hooks/
  │   │   └── services/
  │   └── catalog/
  └── shared/ (componentes y utilidades comunes)
  ```
* **Renderizado Eficiente:** Uso justificado de `useMemo` y `useCallback` solo ante cálculos pesados o referencias estables para `React.memo`.

---

## 🅰️ 2. Angular Limpio (Clean Angular)

### Principios Clave:
* **Componentes Standalone:** Deja atrás los `NgModules` pesados y utiliza componentes independientes (`standalone: true`) para árboles de dependencias limpios y tree-shaking óptimo.
* **Signals y Reactividad Moderna:**
  - Emplea **Angular Signals** (`signal()`, `computed()`, `effect()`) para un flujo de estado granular y sin sobrecarga de detección de cambios de Zone.js.
  - Combina con RxJS cuando se manejan flujos asíncronos complejos o eventos con operadores (`switchMap`, `debounceTime`).
* **Inyección de Dependencias Limpia:**
  - Uso de `inject()` moderno en lugar de constructores inflados.
  - Servicios con responsabilidad única (`providedIn: 'root'`).
* **Presentational vs Container Components:** Controladores inteligentes que consumen servicios e inyectan datos mediante `input()` a componentes tontos que emiten `output()`.

---

## 🐘 3. Laravel Limpio (Clean Laravel)

### Principios Clave:
* **Controladores Delgados (Skinny Controllers):**
  - Un controlador solo debe recibir la petición, delegar la ejecución y retornar una respuesta. No debe contener lógica de negocio ni consultas SQL complejas.
* **Patrón Acción (Action Pattern) / Service Layer:**
  - Encapsula cada caso de uso en una clase con un único método (`CreateOrderAction::execute(OrderDTO $dto)`).
* **Form Requests para Validación:**
  - Nunca valides en el controlador con `$request->validate([...])`. Crea clases `StoreProductRequest` dedicadas.
* **DTOs (Data Transfer Objects):**
  - Tipado fuerte entre el controlador y los servicios para evitar transportar arrays asociativos sin esquema claro.
* **Eloquent Limpio y Query Scopes:**
  - Evita queries encadenadas kilométricas en controladores. Usa scopes locales en el modelo (`Product::available()->inStock()->get()`).
  - Previene siempre el problema N+1 usando Eager Loading (`with(['category', 'tags'])`).
