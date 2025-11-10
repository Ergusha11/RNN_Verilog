# Implementación de una Red Neuronal Recurrente (RNN) en Verilog

## Descripción General

Este proyecto consiste en el diseño e implementación de una Red Neuronal Recurrente (RNN) utilizando el lenguaje de descripción de hardware Verilog. El objetivo principal es crear un modelo de RNN funcional que pueda ser sintetizado en hardware (como FPGAs), explorando optimizaciones para su implementación eficiente.

## Características Principales

- **Diseño en Verilog:** Toda la lógica de la RNN, incluyendo las neuronas, las conexiones y las funciones de activación, está descrita en Verilog.
- **Multiplicación Matriz-Vector (MCM) con Spiral:** Se utilizan módulos de multiplicación matriz-vector generados por **Spiral**. Spiral es un generador de programas que produce código de alto rendimiento para transformadas lineales. En este proyecto, se aprovecha para generar hardware eficiente para las operaciones de multiplicación de matrices de pesos, que son el núcleo de la RNN.
- **Aproximaciones de Funciones de Activación:** Para optimizar el uso de recursos en hardware, se implementan aproximaciones de las funciones de activación comunes como `tanh` y `sigmoid`. Esto permite un cálculo más rápido y con menor coste de área en comparación con las implementaciones de punto flotante o de alta precisión.
- **Simulación y Verificación:** Se incluyen bancos de pruebas (testbenches) para simular y verificar el comportamiento de los diferentes módulos de la RNN.

## Estructura del Proyecto

El repositorio está organizado de la siguiente manera:

- `data/`: Contiene los datos de entrada y los pesos de la red.
  - `Weights/`: Almacena los pesos para las diferentes capas de la red (entrada a oculta, oculta a oculta, oculta a salida).
- `src/`: Contiene el código fuente en Verilog de la RNN.
  - `Spiral_15B/`, `Spiral_20B/`: Módulos de hardware para la multiplicación matriz-vector (MCM) generados con Spiral para diferentes tamaños de bits.
  - `Activate.v`, `SigmoidPLAN.v`, `Tanh.v`: Implementaciones de las funciones de activación.
  - `Matrix.v`: Módulos relacionados con operaciones de matrices.
- `tb/`: Contiene los bancos de pruebas (testbenches) para la simulación de los módulos Verilog.

## Funcionamiento

1.  **Pesos y Datos:** Los pesos de la red neuronal, pre-entrenados, se encuentran en el directorio `data/Weights`. Estos pesos se cargan en los módulos de memoria correspondientes en la implementación de hardware.
2.  **Operaciones de la RNN:** La entrada es procesada por la capa de entrada a oculta. El estado oculto se actualiza en cada paso de tiempo mediante una multiplicación con la matriz de pesos recurrentes (`h2h`) y la aplicación de una función de activación.
3.  **Generación de Salida:** La capa de salida produce el resultado final a partir del estado oculto.
4.  **Simulación:** Los testbenches en el directorio `tb/` permiten simular el comportamiento del diseño, verificando que la lógica de la RNN y las aproximaciones funcionen como se espera.
