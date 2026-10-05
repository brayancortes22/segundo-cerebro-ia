# 🛡️ Reglas de Validación y Anti-Patrones: 3D, Rigging, Animación y Pipelines IA

> **Origen:** Recopilación de los **100 Errores del Proceso** comprobados en producción real (Blender, pipelines de mallas, texturas y agentes de IA).  
> **Ubicación en el Monorrepo:** `docs/lessons_learned/Errores_del_proceso.md` en [aurora-engine](https://github.com/DABC-resource/aurora-engine).  
> **Aplicación:** Base de conocimiento obligatoria para **Aurora Intelligence**, **Blender Production MCP** y el **Validation Loop** de agentes.

---

## 🧭 ¿Por qué este documento ahorra meses de desarrollo?

Cuando un agente de IA (o un programador) genera o modifica mallas, rigs, animaciones o materiales, es muy común que **el código pase la validación técnica ("no arrojó error"), pero el resultado visual sea una aberración** (manos que agarran aire, normales invertidas, saltos en la interpolación o texturas quemadas).

Este documento compila **100 fallos de la vida real** agrupados en 10 áreas críticas, transformándolos en **reglas de validación programables** para Aurora Engine:

---

## 1. Geometría, Normales y Topología (Errores 1 al 11)

* **Anti-patrón #1 (Pérdida de Tangentes al separar piezas):** Separar mallas sin recalcular el espacio tangente (**MikkTSpace**) destruye el mapa normal, produciendo sombras negras y costuras rotas.
* **Anti-patrón #2 (Cierre de contornos no planos en un punto central):** Genera triángulos en abanico (*fan triangles*) con normales degeneradas y sombreado negro.
* **Anti-patrón #5 (Normales Invertidas en cubiertas):** Superficies interiores construidas con el bobinado de vértices (*winding order*) invertido.
* **Anti-patrón #11 (Diagnóstico apresurado de escala):** No ajustar la escala de un modelo uniformemente sin medir primero las proporciones eje por eje.

---

## 2. Rigging, Cinemática Inversa y Matemáticas (Errores 13 al 18, 75 al 85)

* **Anti-patrón #18 (Cuaterniones a Matrices sin Normalizar):** Interpolar cuaterniones (slerp/lerp) y convertirlos a matriz sin normalizarlos introduce micro-escalados no deseados y separación milimétrica en articulaciones.
* **Anti-patrón #75 (Pseudoinversa sin Amortiguación en IK):** Resolver cinemática inversa con la transpuesta o pseudoinversa de Jacobi cerca de singularidades (brazo totalmente estirado) causa giros violentos de $360^\circ$ y saltos incontrolables. **Solución:** Usar *Damped Least Squares* (Levenberg-Marquardt).
* **Anti-patrón #15 (Torsión de Muñeca Aislada):** Concentrar todo el giro en el hueso de la muñeca en vez de repartirlo de forma orgánica entre el radio, el cúbito y el codo.

---

## 3. Agarre de Manos, Contactos y Colisiones (Errores 19 al 35)

* **Anti-patrón #22 (Agarre respecto al Origen vs Geometría Real):** Colocar la mano respecto al pivote del objeto en lugar del *Mesh Collider* real provoca que la mano "agarre el aire".
* **Anti-patrón #25-#27 (Agarres de un solo dedo o canto):** La IA suele dar por bueno un agarre porque un solo nudillo hace colisión, mientras los demás dedos flotan o atraviesan la malla.
* **Anti-patrón #34-#35 (Apertura en bloque sin cadencia):** Soltar todos los dedos simultáneamente en un solo frame hace que la mano parezca una pinza robótica rígida.

---

## 4. Animación, Ritmo e Interpolación (Errores 36 al 57)

* **Anti-patrón #36 (Objetos animados con partes mecánicas rígidas):** Si un arma o herramienta se mueve o recarga, las piezas móviles (cerrojo, palanca, cargador) deben acompañar la inercia del movimiento.
* **Anti-patrón #49 (Discontinuidades Angulares en Euler):** Interpolar rotaciones con ángulos Euler produce giros largos innecesarios al cruzar $\pm 180^\circ$ (*Gimbal Lock* o camino más largo). Usar siempre rotación por cuaterniones en el camino más corto ($\cos \theta \ge 0$).
* **Anti-patrón #52 (Tangentes de entrada contaminantes):** Comprobar solo fotogramas enteros oculta que entre claves la mano se separa o penetra el objeto (*Subframe clipping*).

---

## 5. Texturas y Materiales PBR (Errores 64 al 74)

* **Anti-patrón #65 (Exportación de Normal Maps en canal único):** Almacenar normales comprimidas en 1 canal satura la imagen y destruye la información en $X$ e $Y$.
* **Anti-patrón #73 (Albedo Sucio con Iluminación Horneada):** Tratar una textura fotográfica o generada como albedo PBR sin eliminar sombras, luces directas y oclusión (*De-lighting* obligatorio).
* **Anti-patrón #66 (Conversión de 16-bit a 8-bit por recorte):** Truncar mapas de desplazamiento o HDR en lugar de remapear adecuadamente la curva tonal (*Tone-mapping* lineal).

---

## 6. Validación de Herramientas y Agentes de IA (Errores 86 al 93, 94 al 100)

* **Anti-patrón #86 (Validación Tautológica):** *"Validar una operación con la misma fórmula matemática que la construyó"*. La IA asume que su cálculo es correcto porque verifica contra su propio supuesto erróneo. **Regla:** Validar con pruebas geométricas independientes.
* **Anti-patrón #85 (Confundir Éxito Numérico con Calidad Visual):** Que un algoritmo devuelva `status: 200 OK` o `error: 0` no significa que el resultado visual sea creíble o ergonómico.
* **Anti-patrón #91 (Auditar Rig en Rest Pose en vez de Pose Evaluada):** Comparar la pose base contra sí misma produce un falso error cero.
* **Anti-patrón #95 (Cantar victoria antes de que el usuario vea el resultado):** Afirmar que un bug está resuelto basándose solo en métricas parciales antes de inspeccionar el viewport renderizado.

---

## 🛠️ Cómo se Aplica en AURORA ENGINE

1. **Guardrails en `Blender Production MCP`:** Todo script automatizado de Python que ejecute Blender para optimizar mallas, generar LODs o calcular IK debe verificar estas condiciones antes de exportar el asset.
2. **Pipelines de Importación en Godot:** El módulo `modules/aurora_core` calculará el espacio tangente MikkTSpace en cada importación y validará la escala no uniforme.
3. **Criterio de Aceptación del Orquestador:** El `Aurora Orchestrator` no dará por finalizada una tarea de animación o materiales sin verificar colisiones en sub-frames y conservación de normales evaluadas.
