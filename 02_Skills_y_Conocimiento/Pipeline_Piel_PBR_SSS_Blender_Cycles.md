---
tags:
  - 3d
  - shader
  - pbr
  - sss
  - cycles
  - blender
  - substance-painter
  - fotorrealismo
reviewed: 2026-10-19
---

# Pipeline Fotorrealista de Piel: PBR, Micro-Poros y SSS

## 1. El Diagnóstico Crítico: ¿Por qué la piel parece "plastilina"?
El cerebro humano detecta con facilidad patrones algorítmicos. En Elena 08, la piel se veía como cera o goma por cuatro fallos de origen:
1. **Ruidos procedurales puros (Worley / Python):** Generan una dispersión matemática homogénea sin variación biológica real.
2. **Ausencia de Normal Map de alta frecuencia:** Sin microporos asimétricos, la luz especular forma gradientes lisos y gomosos en lugar de romperse.
3. **Roughness plana sin capa lipídica:** Una rugosidad fija hace que la cara refleje de forma uniforme, perdiendo la distinción entre la zona T (grasa/sebo con IOR 1.45) y las mejillas mates.
4. **Escala de SSS desfasada:** El Subsurface Scattering debe calcularse a la escala métrica real de la cabeza (2.2 mm a 2.8 mm de penetración). A 30 mm, la luz atraviesa el cráneo como si fuera cera de vela.

---

## 2. Los Cuatro Pilares del Estándar AAA

```
[ARQUITECTURA DE CAPAS BIOLÓGICAS - PAINTER]
├── 04_EPIDERMIS_STRESS    (Pecas, manchas solares asimétricas, micro-capilares)
├── 03_FACIAL_ZONES        (Frente marfil, mejillas/nariz carmesí, mandíbula neutra)
├── 02_SUBDERMAL_BASE      (Capa de hemoglobina profunda, tono sangre rica)
└── 01_PORES_XYZ           (Alfas de poros reales orientados por líneas de Langer)
```

1. **Albedo Cross-Polarized:** Captura melanina pura y vascularización sin brillos especulares quemados.
2. **Alfas Multicanal (TexturingXYZ / VFace):** 
   * *Canal R:* Macro-arrugas y pliegues faciales.
   * *Canal G:* Poros individuales y orificios foliculares.
   * *Canal B:* Micro-relieve celular que atrapa la luz rasante.
3. **Roughness modulada por Cavidad:** El borde del poro brilla sutilmente; el fondo del poro dispersa la luz.
4. **Thickness Map para SSS:** Controla la traslucidez en orejas, aletas de la nariz y labios.

---

## 3. Calibración Exacta en Blender 5.2 / Cycles (Principled BSDF)

| Entrada del Shader | Valor Calibrado | Función Biológica |
| :--- | :--- | :--- |
| **Subsurface Method** | `RANDOM_WALK_SKIN` | Algoritmo de dispersión multicapa (grasa + sangre). |
| **Subsurface Weight** | `0.45 - 0.55` | Porcentaje de luz difusa que penetra la superficie. |
| **Subsurface Radius** | `(1.0, 0.32, 0.12)` | Radio espectral: el rojo viaja profundo, el azul es absorbido. |
| **Subsurface Scale** | `0.0022 - 0.0028 m` | **2.2 a 2.8 mm reales** (evita el aspecto lechoso/plástico). |
| **Subsurface IOR** | `1.40` | Refracción del tejido celular humano. |
| **Subsurface Anisotropy** | `0.80` | Dispersión frontal de los fotones dentro de la carne. |
| **Specular IOR Level** | `0.50` | Equivalente a IOR 1.45 (capa lipídica superficial). |
| **Roughness Map** | `0.28 (sebo) - 0.65 (seco)` | Modulada por mapa de cavidad / mapa especular invertido. |
