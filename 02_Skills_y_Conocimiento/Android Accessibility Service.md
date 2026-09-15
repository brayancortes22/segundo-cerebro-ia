# 📱 Android Accessibility Service — Conceptos Clave

- **Área:** Desarrollo Android / Sistemas Embebidos / TV Box
- **Proyectos que lo usan:** [[Netflix TV Bridge]]
- **Relacionado:** [[00_Centro_de_Mando]]

---

## 📌 ¿Qué es y para qué sirve?
El `AccessibilityService` de Android es una API de nivel de sistema diseñada para asistir a usuarios con discapacidades, pero en ingeniería inversa y automatización se utiliza para:
1. **Capturar eventos de teclado globales:** Interceptar teclas físicas como `KEYCODE_DPAD_UP`, `KEYCODE_DPAD_DOWN`, `KEYCODE_DPAD_CENTER` antes de que la app en primer plano las reciba.
2. **Inspeccionar el árbol de vistas:** Navegar por la jerarquía de `AccessibilityNodeInfo` (títulos, carátulas, botones, scrollviews).
3. **Inyectar acciones táctiles (`dispatchGesture`):** Realizar toques (`click`) y deslizamientos suaves (`scroll/swipe`) de manera programática en coordenadas exactas `(x, y)`.

---

## 🔑 Patrones Usados en Nuestro Proyecto
* **Recorrido por Matriz Geométrica:** Para carruseles horizontales, calculamos distancias euclidianas entre centros de nodos `(x, y)` para decidir cuál es el siguiente elemento a la derecha o izquierda.
* **Auto-Centrado:** Si una fila está muy arriba o muy abajo del centro de visión (`y = 360px` en 720p), calculamos un `GestureDescription` que arrastra verticalmente la pantalla para acomodarla.
