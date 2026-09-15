# 🧠 Redes Neuronales & Deep Learning

- **Área:** Inteligencia Artificial / Aprendizaje Profundo / Machine Learning
- **Relacionado:** [[Gemini AI Ecosystem]], [[Camara Sony Cyber-shot]], [[Colaboracion con IA (Antigravity)]]

---

## ⚡ 1. Fundamentos de una Neurona Artificial (Perceptrón)

Una red neuronal es un aproximador universal de funciones matemáticas. Cada neurona realiza una operación lineal seguida de una activación no lineal:

$$\hat{y} = f\left(\sum_{i=1}^n w_i \cdot x_i + b\right)$$

* $x_i$: Entradas (píxeles, palabras, números).
* $w_i$: **Pesos (Weights)** — La fuerza o importancia de cada conexión (lo que el modelo aprende).
* $b$: **Sesgo (Bias)** — Permite desplazar la función de activación para ajustarse mejor a los datos.
* $f$: **Función de Activación** (introduce no-linealidad):
  - **ReLU ($max(0, x)$):** Estándar en capas intermedias por su velocidad y evitar el desvanecimiento de gradiente.
  - **GELU / SiLU:** Usadas en transformers y LLMs modernos (Gemini, Llama).
  - **Sigmoid / Softmax:** Convierte salidas en probabilidades (0 a 1) para clasificación.

---

## 🔄 2. Cómo Aprende una Red: Backpropagation y Descenso de Gradiente

```mermaid
graph LR
    Input["Entrada (X)"] -->|Forward Pass| Pred["Predicción (ŷ)"]
    Pred --> Loss["Función de Pérdida (Loss)"]
    Loss -->|Backpropagation (Gradientes)| Weights["Ajuste de Pesos (Optimizador: AdamW)"]
```

1. **Pase hacia adelante (Forward Pass):** Los datos viajan por las capas y generan una predicción.
2. **Cálculo de Pérdida (Loss Function):** Mide el error entre lo que predijo la red y la respuesta real (ej. *Cross-Entropy* para clasificación, *MSE* para regresión).
3. **Pase hacia atrás (Backpropagation):** Mediante la regla de la cadena del cálculo, calcula qué tanto contribuyó cada peso individual al error total (**Gradiente**).
4. **Actualización (Optimizador Adam / AdamW):** Modifica los pesos en dirección opuesta al gradiente con una tasa de aprendizaje (*Learning Rate*).

---

## 🏗️ 3. Principales Familias de Redes Neuronales

### 📸 Redes Convolucionales (CNN) — Visión por Computadora
* Utilizan **filtros/kernels** que se deslizan sobre la imagen para extraer características jerárquicas (bordes -> texturas -> formas -> objetos completos).
* Conectado con: [[Camara Sony Cyber-shot]] para clasificación de fotos, eliminación de ruido o escalado inteligente.

### 🔤 Redes Recurrentes (RNN / LSTM) — Secuencias Temporales
* Poseen memoria interna para procesar datos secuenciales paso a paso (series de tiempo, audio).

### 🤖 Transformers & Mecanismo de Atención (El Núcleo de los LLMs)
* Introducidos en *"Attention Is All You Need"* (Google Brain, 2017).
* **Self-Attention (Auto-Atención):** Permite a cada palabra de una frase calcular su relevancia respecto a todas las demás palabras en paralelo (no secuencial como las RNN).
* Es la arquitectura base de los modelos más avanzados del mundo: **Gemini**, **Gemma**, **GPT** y modelos de difusión de imágenes.

---

## ⚙️ 4. Técnicas Modernas de IA Práctica

* **Transfer Learning & Fine-Tuning:**
  - En lugar de entrenar un modelo desde cero con millones de dólares, tomas un modelo base preentrenado (como Gemma o ResNet) y ajustas solo las últimas capas con tus datos específicos.
  - **LoRA / QLoRA:** Técnica eficiente que congela el modelo original y solo entrena pequeñas matrices adicionales, reduciendo el consumo de VRAM en un 80%.
* **Cuantización (Quantization):**
  - Reducir la precisión de los pesos (de `FP16` a `INT8` o `INT4` con formatos como **GGUF** o **AWQ**) para ejecutar modelos gigantes en laptops o tarjetas gráficas convencionales sin perder calidad perceptible.
* **Inferencia Local vs Cloud:**
  - **Local:** Herramientas como Ollama, ONNX Runtime, llama.cpp.
  - **Cloud:** APIs de alta velocidad como [[Gemini AI Ecosystem]].
