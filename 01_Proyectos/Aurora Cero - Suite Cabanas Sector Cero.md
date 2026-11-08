# 🌲 Aurora Cero: Suite Maestra de Cabañas (Sector Cero)

* **Ubicación Local:** `aurora-cero-mapa-cabana`
* **Archivo Maestro Blender:** `aurora_cero_cabana_map.blend`
* **Estado:** 🟢 Certificado por MCP Scene Audit · Producción Artística
* **Lead Developer & 3D Artist:** Brayan Stid Cortés Lombana (`bscl`)
* **Motor de Render:** Blender 5.2.2 LTS · Cycles OptiX en GPU NVIDIA RTX 4050 Laptop
* **Gestión de Color:** AgX (`AgX - Medium High Contrast`, exposición `-0.65 EV`)

---

## ⚡ Descripción Técnica

Suite completa de 10 cabañas fotorrealistas con arquitectura interior/exterior, materiales PBR procedurales con dispersión subsuperficial (SSS), relieves profundos (Normal Bumps de alta frecuencia) y 10 cámaras hero dedicadas para el videojuego AAA **Aurora Cero** ([[Aurora Cero (Videojuego)]]).

---

## 📊 Métricas Técnicas Certificadas (MCP Scene Audit)

* **Objetos Totales en Escena:** 460 (436 Mallas, 14 Luces, 10 Cámaras Hero)
* **Materiales PBR Procedurales:** 24 slots configurados (incluyendo `Dark_Timber` de alto contraste, alerce oscuro, pizarra volcánica y nieve con dispersión SSS)
* **Escalas Uniformes:** 100% unitarias `(1.0, 1.0, 1.0)` (0 warnings de escala no uniforme)
* **Sistema de Unidades:** Métrico estándar (`1 BU = 1.0 m`)
* **Módulo Arquitectónico:** `architecture_kit_modular.py` (Carpinterías con vano abierto, alféizares a 10°, cabios vistos, herrajes de forja y balaustradas perimetrales)

---

## 🏔️ Catálogo de las 10 Cabañas

1. `01_CABIN_A_FRAME`: Refugio Nórdico A-Frame (Inclinación 58°, hastial acristalado, zócalo de piedra, hogar central).
2. `02_CABIN_LOG_FORTRESS`: Fortaleza de Troncos Masivos (Troncos horizontales entrelazados, viga solera de porche, cumbrera sin colisiones).
3. `03_CABIN_MILITARY_OUTPOST`: Puesto Táctico Blackout (Paneles compuestos gris pizarra, troneras blindadas, mástil de comunicaciones).
4. `04_CABIN_EARTH_SHELTERED`: Cabaña Semienterrada Glaciar (Muro ciclópeo de contención, cubierta vegetal con manto de nieve SSS, claraboya).
5. `05_CABIN_ALPINE_LOOKOUT`: Observatorio Elevado sobre Pilares (Pilares de alerce sobre nieve, pasarela perimetral con tornapuntas, mirador 360°).
6. `06_CABIN_MOUNTAIN_HUNTER`: Refugio de Cazador de Alta Montaña (Base de pizarra volcánica, alerce oscuro, leñera adosada con leña apilada).
7. `07_CABIN_MINERS_SHACK`: Barracón Minero Abandonado (Chapa galvanizada envejecida con pátina de óxido, chimenea de forja).
8. `08_CABIN_RADIO_RELAY`: Estación de Retransmisión de Radio (Torre de celosía metálica, antenas parabólicas, caseta técnica con generador diésel).
9. `09_CABIN_MEDIC_STATION`: Puesto Médico de Campaña Avanzado (Carpas rígidas modulares, generadores, camillas tácticas y señalización de triaje).
10. `10_CABIN_COMMAND_BUNKER`: Búnker de Mando Subterráneo (Hormigón armado texturizado, compuertas hidráulicas herméticas y radar superior).

---

## 🛠️ Pipeline de Texturizado y Baking Físico PBR

* **Catálogo Medido:** Implementación de `pbr_realworld_catalog.py` con coeficientes reales de reflectancia y rugosidad.
* **Conversión sRGB a Lineal:** Calibración cromática estricta para evitar colores no físicos (negro puro o blanco puro que rompan el cálculo de rebote de luz).
* **Baking a Mapas ORM:** Empaquetado en canales únicos (Occlusion en Rojo, Roughness en Verde, Metallic en Azul) para optimizar draw calls y memoria VRAM al exportar hacia Unreal Engine 5.8 y Aurora Engine.
