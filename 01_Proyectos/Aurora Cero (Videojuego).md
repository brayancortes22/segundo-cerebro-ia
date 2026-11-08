---
tags:
  - proyecto
  - videojuego
  - unreal-engine
  - fps
  - elena
  - aurora-cero
estado: En Desarrollo Activo
fecha_inicio: 2026-10-19
---

# Aurora Cero (FPS Cooperativo AAA)

## 1. Visión General del Producto
* **Género:** FPS cooperativo táctico para 4 jugadores (inspirado en la dinámica y cooperación de *Left 4 Dead 2*, con mecánicas modernas de supervivencia y balística).
* **Motor:** **Unreal Engine 5.8**.
* **Objetivo Visual:** Rostros y personajes fotorrealistas de nivel **Triple A (AAA)** para renders, cinemáticas y posterior versión optimizada para gameplay (low-poly, LODs, rig facial y corporal).
* **Decisión Clave de Diseño:** *MetaHuman* queda completamente descartado para mantener una dirección de arte y topología personalizada e independiente.

---

## 2. Personaje Principal: Elena
* **Rol:** Médico Táctico (*Tactical Medic*).
* **Estatura:** 1.70 m.
* **Escultura Facial:** Realizada en **ZBrush 2027** (versión actual *07b*, 5.75 millones de vértices).
* **Topología:** Malla con UV única (`UV_Cabeza_v25`), densidad de 14.3 px/mm a 4096 (50 px = 3.51 mm en mejilla).
* **Cabello:** 249.959 curvas (14.96 millones de puntos), sombreador *Principled Hair* modelo **Huang** modulado por melanina y transición de borde en la línea de nacimiento.
* **Ojos:** Globo ocular con limbo, córnea con refracción de vidrio (IOR 1.336), iris con relieve 3D real y esclerótica multicapa.

---

## 3. Pipeline de Arte y Producción 3D
1. **ZBrush 2027:** Escultura anatómica de alta frecuencia (orejas, nariz, labios, pliegues).
2. **Substance Painter 12:** Texturizado multicanal por capas biológicas (Base Color, Roughness, Normal, Height, Scattering).
3. **Blender 5.2.2 LTS / Cycles:** Motor oficial de renderizado de verificación con GPU NVIDIA RTX (OptiX) y shader *Random Walk (Skin)*.
4. **Unreal Engine 5.8:** Integración final con Shading Model *Subsurface Profile* y empaquetado de texturas ORM/SSS.

---

## 4. Estado Actual (Elena 08)
* Paquete montado oficial: `personajes juego blender/Elena_08_Cabeza_para_texturizar_2026-10-19/Blender/Elena_08_Cabeza_Montada.blend`.
* Ojos, boca, pestañas, cejas y pelo aprobados y montados.
* **Cuello de botella en resolución:** La piel lisa provisional requiere la aplicación del nuevo pipeline de escaneo polarizado + alfas de microporos reales para eliminar el efecto "plastilina".

---

## 5. Mapas y Entornos de Juego: Suite Maestra de 10 Cabañas de Supervivencia Táctica (Sector Cero)
* **Ficha Técnica Detallada:** [[Aurora Cero - Suite Cabanas Sector Cero]]
* **Ubicación:** `aurora-cero-mapa-cabana/aurora_cero_cabana_map.blend`.
* **Catálogo Físico PBR:** Integración de `pbr_realworld_catalog.py` con coeficientes IOR reales, conversión sRGB a lineal y flujo obligatorio de baking a mapas ORM (Occlusion-Roughness-Metallic) para optimización a 60 FPS.
* **Concepto:** Conjunto de 10 cabañas tácticas de montaña y puestos de avanzada para 4 operadores en un clima alpino sub-cero, diseñadas proceduralmente en Blender 5.2.2 LTS con arquitectura interior/exterior 100% explorable.
* **Métricas Técnicas Certificadas (MCP Scene Audit):**
  * **Objetos Totales:** 460 (436 Mallas, 14 Luces, 10 Cámaras Hero dedicadas).
  * **Materiales PBR Procedurales:** 23 materiales configurados con SSS, relieves Voronoi y pátina nórdica.
  * **Escalas:** 100% unitarias `(1.0, 1.0, 1.0)` (0 warnings de escala no uniforme).
  * **Motor de Render:** Cycles con GPU OptiX (NVIDIA RTX 4050 Laptop) y OpenImageDenoise.
  * **Auditoría MCP:** Checkpoint de integridad SHA256 `2cee40221a81f6c28b8f812526a0b8d84e8321df8573e8573709f14a8d01d764` generado con `blender-production-mcp`.

### Catálogo de las 10 Cabañas del Sector Cero
1. **`01_CABIN_A_FRAME` (Refugio Nórdico A-Frame):** Inclinación de 58°, hastial frontal totalmente acristalado con hogar central, zócalo de piedra ciclópea y manto de nieve SSS.
2. **`02_CABIN_LOG_FORTRESS` (Fortaleza de Troncos Masivos):** Troncos horizontales entrelazados, viga cumbrera de remate superior, viga solera horizontal en porche y cimiento continuo.
3. **`03_CABIN_MILITARY_OUTPOST` (Puesto Táctico Blackout):** Módulos de paneles compuestos gris pizarra, troneras blindadas, mástil de comunicaciones y generador exterior.
4. **`04_CABIN_EARTH_SHELTERED` (Cabaña Semienterrada Glaciar):** Muro ciclópeo de contención de basalto, cubierta vegetal y manto de nieve con claraboya integrada.
5. **`05_CABIN_ALPINE_LOOKOUT` (Observatorio Elevado sobre Pilares):** Pilares estructurales de alerce, arriostramiento en 'X', pasarela perimetral con tornapuntas y mirador 360°.
6. **`06_CABIN_MOUNTAIN_HUNTER` (Refugio de Cazador de Alta Montaña - Interior Completo AAA):** Muros perimetrales huecos transitables, entarimado de roble con veta longitudinal y juntas biseladas, vigas maestras vistas en techo, hogar de piedra con ascuas incandescentes Voronoi (2600W de emisión cálida), literas militares de 2 niveles con mantas de lana térmica, mesa de transmisiones con radio táctica y lámpara de queroseno, leñera exterior y chimenea de pizarra.
7. **`07_CABIN_FROZEN_WATERMILL` (Molino de Riachuelo Congelado - Interior Completo AAA):** Cimientos de ribera de 1.4m con escalinata de 8 peldaños, vanos abiertos con carpinterías cálidas, maquinaria interior de molienda funcional (eje de transmisión pasante de 3.2m, rueda de corona con dientes radiales, juego de muelas de granito y tolva de grano con sacos), rueda hidráulica exterior gigante de 4.6m con carámbanos de hielo turquesa y canaleta superior.
8. **`08_CABIN_HYBRID_BUNKER` (Búnker Híbrido Anti-Ventiscas):** Núcleo de hormigón armado brutalista, compuerta blindada de acero con volante de presión, lamas protectoras y baliza roja de emergencia.
9. **`09_CABIN_TWIN_PAVILIONS` (Pabellones Gemelos con Puente Techado):** Dos módulos independientes (habitacional y arsenal) conectados por una galería acristalada elevada sobre un pilar central de piedra.
10. **`10_CABIN_RIDGE_WATCHTOWER` (Puesto Vigía de Cresta y Observatorio - Interior Completo AAA):** Puesto de guardia base transitable con suelo de madera, literas tácticas, estufa de hierro fundido con tiro vertical y brasa incandescente, torre vigía hueca de 14m con escala vertical interior de acceso directo a pasarela perimetral cerrada por balaustrada modular, cúpula acristalada 360° y reflector de búsqueda direccional de 1200W.

---

## 6. Auditorías Multidisciplinares Certificadas (Ciclo Completo bscl)
* **Kits de Arquitectura e Interiores Modulares:**
  * `architecture_kit_modular.py` (176 líneas): Puertas con aldabas, ventanas con alféizares a 10°, cabios vistos y balaustradas.
  * `interior_builder_kit.py` (148 líneas): Entarimados, vigas maestras, hogares con fuego, literas y mesas tácticas.
  * `interior_machinery_kit.py` (125 líneas): Corona y engranajes de molino, muelas de granito, estufas alpinas y escalas verticales.
  * `shaders_interior_pbr.py` (166 líneas): Entarimados de roble plano con juntas en bajorrelieve, ascuas Voronoi y metal táctico.
* **Hashes SHA256 Renders de Verificación (Interiores & Exteriores Cycles OptiX):**
  * `live_check_cabin_6_hunter_interior.png`: `BB792B2BFA36F6D386B11B2FC49684E398D5FD51E4032AB502AAC2A9444C2E33`
  * `live_check_cabin_6_mountain_hunter.png`: `38B40A9D09BEF43DA65E5F32D157F161586E84D339C5E19D778DA151F3DA6032`
  * `live_check_cabin_7_watermill_interior.png`: `20A9AFF1F99FB4ABB40EBC14699C50C0BDEEBD4A305B78FED2AC26F6DECC124F`
  * `live_check_cabin_7_frozen_watermill.png`: `2FA7CB7AAB61C61627A0D2994667CF77815A2909901021646331D4AD0E2C1D15`
  * `live_check_cabin_10_watchtower_interior.png`: `25CD0A182D0B6AA2B7F92A9D257506749A3428707A555D1C99F28692E69E2BBD`
  * `live_check_cabin_10_ridge_watchtower.png`: `17C80B4F8F72470F605FD0238AEFE209934C8582CD0EEA6F3BB09F472D33ABD8`
* **Auditoría Legal y Anti-Demandas:** `aurora-cero-mapa-cabana/LEGAL_COMPLIANCE_AUDIT.md` (Licencias CC BY-SA 3.0 / Fair Use de manuales técnicos, Blender® trademark compliance, GPL output ownership y Habeas Data Ley 1581).
* **Auditoría DevSecOps:** Blindaje de `.gitignore` para exclusión de binarios >100MB (`manuals/*.pdf`) y prevención de fuga de credenciales.
* **Auditoría de Pentesting de Mallas:** `GEOMETRY_COLLISION_PENTEST_AUDIT.md` (Verificación de muros huecos perimetrales para evitar glitches de expulsión física *Catapult Glitch*, vanos libres para colisiones Jolt y cotas tácticas para FPS).
* **Veredicto Táctico:** 9.6/10 de calificación por el Diseñador Táctico (interiores habitables con cobertura en esquinas, líneas de tiro limpias a través de ventanas modulares y puestos de vigía con escala vertical).

* **Documentación Técnica y Pipeline de Entornos:** Véase [[Pipeline_Entornos_PBR_SSS_Arquitectura_3D_Blender|Pipeline Fotorrealista de Entornos, Nieve SSS y Arquitectura 3D]].
