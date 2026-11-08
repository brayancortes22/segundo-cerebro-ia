# 🏔️ Pipeline Fotorrealista de Entornos, Nieve SSS y Arquitectura 3D en Blender

> **Aplicación:** Ecosistema 3D de **Aurora Cero** y **Aurora Engine** en **Blender 5.2.2 LTS** mediante **Blender Production MCP**.  
> **Área:** Entornos alpinos subárticos, shaders PBR procedurales, dispersión subsuperficial (SSS), relieves Voronoi y reglas arquitectónicas anti-glitch.

---

## 🧭 Lecciones Críticas del Proceso (Lessons Learned)

Durante la producción procedural de la **Suite de 10 Cabañas de Supervivencia Táctica**, se identificaron y solucionaron fallos críticos de iluminación, espacios de color, colisiones poligonales y topología. Este documento consolida las reglas obligatorias de diseño.

---

## 1. Gestión de Color AgX y Evitación del Look "Deslavado / Pastel"

### El Problema
Al iluminar escenas con cielo físico (`MULTIPLE_SCATTERING` / Nishita) a pleno sol o atardecer alpino, los valores lineales de color de los shaders por encima de `0.20` se reflejan en el render con tonalidades durazno, salmón o aspecto de yeso blanquecino, destruyendo la densidad visual del material.

### La Solución Calibrada
1. **Espacio de Color AgX:**
   - `view_transform = 'AgX'`
   - `look = 'AgX - Medium High Contrast'`
   - `exposure = -0.65` (previene sobreexposición en mantos de nieve y madera exterior).
2. **Fórmulas de Color Lineal Profundo:**
   * **Madera Nórdica Envejecida (`PBR_Wood_Log_Realistic`):**
     - Corteza profunda / grietas: `(0.012, 0.008, 0.005, 1.0)`
     - Corazón de pino denso: `(0.055, 0.032, 0.018, 1.0)`
     - Albura envejecida expuesta: `(0.095, 0.065, 0.042, 1.0)`
   * **Mampostería Basáltica y Granito Alpino (`PBR_Glacial_Stone_Masonry`):**
     - Juntas y grietas de mortero: `(0.012, 0.013, 0.015, 1.0)`
     - Roca intermedia: `(0.042, 0.045, 0.048, 1.0)`
     - Pátina exterior expuesta: `(0.088, 0.092, 0.096, 1.0)`

---

## 2. Relieve Táctil Profundo (Dual Normal Bump)

Una malla volumétrica plana sin relieve parece una maqueta barata de cartón piedra. El realismo AAA exige micro-sombras y volumen superficial:

* **Madera con Vetado:** Nodo `Wave Texture` (tipo `RINGS` o `BANDS`) mezclado con `Noise Texture` de alta frecuencia conectado a un nodo `Bump` (`Strength = 0.92`, `Distance = 0.10 m`).
* **Piedra Ciclopea:** Nodo `Voronoi Texture` (modo `SMOOTH_F1`, `Scale = 3.8`) combinado con `Noise Texture` (`Scale = 26.0`) conectado a `Bump` (`Strength = 0.95`, `Distance = 0.14 m`).

---

## 3. Dispersión Subsuperficial (SSS) en Climas Sub-Cero

La nieve y el hielo no son superficies reflectantes opacas; la luz penetra en el volumen y se dispersa internamente con un matiz frío:

* **Nieve Volumétrica Alpina (`PBR_Snow_Volumetric_SSS`):**
  - `Base Color`: `(0.92, 0.94, 0.97, 1.0)` (leve tinte frío)
  - `Subsurface Weight`: `0.92`
  - `Subsurface Radius`: `(0.35, 0.55, 0.85)` (alta absorción en rojo, fuerte dispersión azul-cian en penumbra)
  - `Subsurface IOR`: `1.31` (índice de refracción del hielo)
  - `Roughness`: `0.62` con micro-escarcha procedural (`Noise Scale = 65.0`, `Bump Strength = 0.22`).
* **Hielo Glacial Translúcido (`PBR_Glacial_Ice_Turquoise`):**
  - `Base Color`: `(0.28, 0.68, 0.82, 1.0)`
  - `Transmission Weight`: `0.82`, `Roughness`: `0.12`, `IOR`: `1.31`.

---

## 4. Reglas Arquitectónicas Anti-Glitch en Modelado Procedural

Para garantizar que los modelos carezcan de colisiones visuales ("AI slop") o mallas superpuestas:

1. **Regla de la Cumbrera Selladora (`Ridge Cap Beam / Log`):**
   - Dos faldones de cubierta a dos aguas con grosor y mantos de nieve crean una costura recortada y abierta en el ápice superior.
   - **Solución:** Incorporar obligatoriamente una viga cumbrera cilíndrica o angular horizontal a lo largo del ápice que sella el encuentro y previene solapamientos visibles.
2. **Regla del Hastial Escalonado (Anti-Daylighting):**
   - La pared perimetral no puede terminar horizontal si el tejado es inclinado, ya que filtra la luz exterior (*daylighting*).
   - **Solución:** Construir hastiales triangulares cerrados mediante hiladas de troncos escalonados adaptativos (`step_i`) hasta el vértice superior.
3. **Regla de la Viga Solera en Porches (`Header Beam`):**
   - Los postes verticales no pueden terminar flotando en el aire ni penetrar directamente en el tejado.
   - **Solución:** Se intercala una viga solera horizontal (`Header Beam`) que une las cabezas de los pilares y sirve de apoyo a las vigas de la cubierta.
4. **Regla de la Cimentación Continua:**
   - El zócalo o cimiento de mampostería debe extenderse bajo la tarima de porche o áreas de entrada para evitar que el suelo de madera quede flotando sobre el lecho de nieve.
5. **Regla de Orientación de Pendientes (Anti-Butterfly Roof):**
   - Al aplicar simetría a faldones con el multiplicador `sign` (-1 y +1), verificar la rotación de Euler: `rotation_euler = (-sign * pitch, 0, 0)`. Un signo invertido genera un techo cóncavo en "V" (mariposa) donde la nieve se acumula en el centro en vez de deslizar.

---

## 5. Invariantes Técnicos de la API Python de Blender 5.2.2 LTS

* **ColorRamp:** En Blender 5.2, el identificador de nodo en Python es `ShaderNodeValToRGB` (no `ShaderNodeColorRamp`).
* **Cielo Físico:** `ShaderNodeTexSky` opera con `sky_type = 'MULTIPLE_SCATTERING'` y propiedades `air_density`, `aerosol_density` (no `dust_density`), `ozone_density`.
* **ShaderNodeMix (RGBA):** Las entradas de color son `inputs[6]` ('A') e `inputs[7]` ('B'), y la salida de color es `outputs[2]` ('Result').
* **Desvinculación Segura de Colecciones:** Nunca ejecutar `scene.collection.objects.unlink(obj)`. Se debe usar siempre el desacoplador seguro:
  ```python
  def _link_to_collection(obj, target_col):
      if obj.name not in target_col.objects:
          target_col.objects.link(obj)
      for c in list(obj.users_collection):
          if c != target_col:
              c.objects.unlink(obj)
  ```

---

## 6. Protocolo de Verificación Visual y Puertas de Calidad (Quality Gates)

* **Prohibición de Verificación Ciega:** Nunca dar por terminado un asset porque el script no arrojó excepciones (`exit code 0`).
* **Pasada de Render de Verificación:** Cada estructura debe renderizarse con su cámara Hero dedicada utilizando **Cycles OptiX GPU** (64 muestras + OpenImageDenoise).
* **Auto-Crítica Óptica:** Inspeccionar la imagen generada: ¿el encuadre abarca toda la altura del edificio? ¿los colores se ven densos y naturales? ¿hay elementos flotantes o colisiones de planos?
* **Punto de Restauración MCP:** Ejecutar `production.scene_audit` y registrar un checkpoint inmutable mediante `production.create_checkpoint`.

---

## 7. Kit de Carpintería y Elementos Constructivos Modulares de Alta Fidelidad (Architecture Kit)

Basado en los manuales formales de modelado de Blender (*Blender 3D: Noob to Pro*, Caps. 27 y 63, y *Blender Basics* de James Chronister):

1. **Carpintería Perimetral con Vano Abierto (Prohibición de Cubos Sólidos Ciegos):**
   * Un marco de ventana o casing **nunca debe ser un cubo sólido**. Debe modelarse con 4 piezas perimetrales (dintel superior, jambas laterales y base) dejando el vano central libre para el cristal.
   * El cristal (`Window_Glow`) debe alojarse en el vano libre con shader emisivo cálido (`Emission Strength = 8.5W`), subdividido por maineles en cruz (mullions de 4x6 cm).
2. **Alféizar Inclinado Saliente (Window Sill):**
   * El alféizar debe sobresalir entre +8 cm y +14 cm hacia afuera del muro y contar con una pendiente hacia abajo de **8° a 10°** para simular la escorrentía real de agua de lluvia y nieve derretida.
3. **Escala y Compensación de Umbrales en Cimientos Sobreelevados:**
   * Si la cabaña se asienta sobre cimientos de piedra de altura $H$ (ej. 1.40 m), el umbral de la puerta no puede colocarse a $Z=0$; debe situarse en la cota superior del cimiento ($Z = H$).
   * Se debe generar una escalera compensada de piedra labrada descendente ($N = \lceil H / 0.16 \rceil$ peldaños) con huella de 34 cm y contrahuella de 16 cm (fórmula ergonómica de Blondel: $2R + T = 66\text{ cm}$).
4. **Cabios Vistos bajo los Aleros (Rafter Tails):**
   * Toda cubierta inclinada rústica debe proyectar vigas de soporte rítmicas (paso de 0.75 m a 0.85 m) bajo los aleros con bisel protector (`Bevel = 0.015 m`) para proyectar sombras de contacto volumétricas en la fachada.
5. **Balaustradas Modulares en Pasarelas y Miradores:**
   * Las plataformas elevadas deben contar con pasamanos superior a cota de 0.90 m - 0.95 m (altura óptima de apoyo de armas en FPS tácticos), riel inferior a 0.12 m y balaustres verticales espaciados a no más de 0.18 m para evitar caídas y puntos ciegos.
6. **Sellado Hermético de Hiladas (Anti-Light Bleeding & Anti-Wallbang):**
   * El paso vertical entre troncos debe coincidir exactamente con el espesor de la pieza (paso 0.38 m = grosor 0.38 m). Dejar holguras de 2 cm permite fugas de luz parásita (*light bleeding*) y permite que los raycasts de disparo en shooters tácticos atraviesen paredes sólidas (*wallbang glitch*).
7. **Contraste Tonal de Materiales:**
   * Las carpinterías (marcos, dinteles, balaustres y jambas) deben utilizar un material de madera oscuro (`Dark_Timber` en nogal o alerce carbonizado con albedo `0.045, 0.026, 0.015`) para contrastar nítidamente con los troncos claros de las paredes y la nieve SSS.

---

## 8. Arquitectura de Interiores Transitables (Anti-Catapult & Muros Perimetrales Huecos)

1. **Prohibición de Bloques Sólidos en Cuerpos de Edificio (Regla Anti-Catapult Glitch):**
   * Crear la planta baja o cimientos con un único `primitive_cube_add` masivo rellena el interior de geometría sólida. En motores físicos (Godot Jolt / PhysX / Chaos), si el personaje cruza la puerta colisionará con el centro de una masa sólida y será eyectado a velocidades supersónicas (*Catapult Glitch*).
   * **Obligatorio:** Modelar siempre 4 muros perimetrales huecos (`_create_wall` con espesor de 0.25 m a 0.30 m) y reservar el vano de paso libre para puertas y ventanas.
2. **Entarimado Flotante Sobrelevado:**
   * El suelo interior debe modelarse como una entidad independiente (`Floorboards`) colocada a la cota del umbral ($Z = 0.05$ m sobre el cimiento o terreno) para permitir intercambiar acabados (madera, piedra pulida o baldosas) sin alterar la envolvente exterior.
3. **Vigas Maestras de Techo Vistas (Master Ceiling Beams):**
   * En estructuras de madera, el forjado superior requiere vigas maestras vistas en madera oscura (`Dark_Timber`) espaciadas rítmicamente cada 1.2 m a 1.3 m a lo largo del vano menor. Rompen el plano plano del techo y aportan sombras de oclusión ambiental (*Ambient Occlusion*) realistas.
4. **Circulación Vertical Segura en Torres y Altillos:**
   * Las escalas interiores (`build_access_ladder`) deben proyectar largueros de 7x8 cm y peldaños cilíndricos cada 30-32 cm, garantizando un gálibo libre de paso de al menos 0.60 m respecto a la pared opuesta.

---

## 9. Shaders PBR de Interiores de Alta Fidelidad (Blender 3D: Noob to Pro)

1. **Entarimado de Roble con Juntas en Bajorrelieve (`PBR_Interior_Floorboards`):**
   * Para evitar el defecto de ondulación continua ("techo de chapa corrugada"), se desacopla el mapeo de color del mapa de normales:
     * **Mapeo:** Escala anisotrópica `(1.4, 0.1, 1.0)` orientada con las tablas.
     * **Onda:** `ShaderNodeTexWave` (tipo `BANDS`, distorsión sutil `0.05`).
     * **Relieve Escalonado:** Nodo `ShaderNodeValToRGB` con meseta plana en `1.0` (posiciones `0.04` a `0.96`) y caída brusca a `0.0` en los extremos (`0.0` y `1.0`). La fuerza de `Bump` debe moderarse a `0.22` con distancia `0.01` m.
     * **Acabado Satinado:** `Roughness = 0.38`, `Specular IOR Level = 0.55` (madera barnizada/pulida que refleja las luces interiores).
2. **Hogar con Ascuas Incandescentes Voronoi (`PBR_Hearth_Fire_Embers`):**
   * El fuego refractario se modela combinando `TexVoronoi` (`Scale = 14.0`) con una rampa de color desde carbón apagado `(0.05, 0.01, 0.005)` hasta brasa incandescente `(1.0, 0.38, 0.06)`.
   * Parámetro de emisión en Principled BSDF: `Emission Strength = 14.0`, complementado con una luz puntual física de **2600W** (color `1.0, 0.46, 0.10`, radio de sombra suave `0.35` m) más una luz de relleno de estancia suave (**950W**).
3. **Metal Táctico Militar Mate (`PBR_Tactical_Gear_Metal`):**
   * Albedo verde oliva mate `(0.075, 0.085, 0.065)`, `Metallic = 0.75`, `Roughness = 0.48`. Se emplea en radios de campaña, antenas, estufas de hierro y herrajes.
4. **Tejidos Térmicos con Resplandor Aterciopelado (`PBR_Fabric_Wool_Blanket`):**
   * Lana roja oscura `(0.42, 0.14, 0.10)` con `Sheen Weight = 0.85` y `Roughness = 0.95` para dispersar la luz en los ángulos rasantes simulando microfibras textiles.
