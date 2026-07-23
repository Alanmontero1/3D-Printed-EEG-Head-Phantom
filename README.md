# Desarrollo de un Fantoma Anatómico de Cabeza Humana para Electroencefalograma

**Autor:** Alan Montero  
**Institución:** Universidad Técnica Federico Santa María (UTFSM) - Departamento de Electrónica  
**Proyecto:** Memoria de Titulación  

## 📄 Descripción del Proyecto

Este repositorio contiene los archivos de diseño 3D, configuraciones de fabricación y entornos de simulación desarrollados para la Memoria de Titulación: **"Desarrollo de un Fantoma Anatómico de Cabeza Humana para Electroencefalograma"**.

El presente trabajo aborda las limitaciones de las plataformas experimentales previas mediante el desarrollo de un fantoma antropomórfico de cabeza humana fabricado íntegramente mediante impresión 3D por deposición de material fundido (FDM) utilizando PLA conductivo. A diferencia de otros enfoques, se realiza una caracterización experimental sistemática del material evaluando la influencia de los parámetros de impresión sobre su resistividad, aplicando dichos resultados en una estructura multicapa que representa el cerebro, el cráneo y el cuero cabelludo. Adicionalmente, el modelo incluye un sistema de 32 electrodos distribuidos según el Sistema Internacional 10–20 para la validación de la propagación de potenciales eléctricos.

## 🎯 Objetivos Específicos

* **Diseño y Fabricación:** Diseñar y fabricar un modelo tridimensional de cabeza humana a partir de datos médicos abiertos, considerando las capas correspondientes al cerebro, cráneo y cuero cabelludo, estudiando la influencia de distintos parámetros de impresión sobre las propiedades eléctricas del material.
* **Sistema de Electrodos:** Diseñar e implementar un sistema de electrodos de medición e inyección distribuido según el sistema internacional 10–20, permitiendo la aplicación controlada de señales eléctricas para la caracterización experimental del fantoma.
* **Caracterización Experimental:** Caracterizar el comportamiento eléctrico del fantoma y evaluar su capacidad para reproducir distribuciones espaciales de potencial representativas de señales EEG bajo distintas configuraciones de excitación.

## 📊 Aporte y Hallazgos Principales

* **Plataforma Reproducible:** Proporciona un modelo físico con 32 canales validados bajo el estándar 10–20, ideal para el estudio de propagación de bioseñales y validación de sistemas relacionados con EEG.
* **Optimización FDM con Material Único:** Demuestra cómo modificar la resistividad efectiva del PLA conductivo variando el porcentaje de relleno y patrones geométricos por región anatómica debido a las limitaciones de un único extrusor.
* **Validación Numérica y Experimental:** Contiene la infraestructura para contrastar mediciones físicas con simulaciones de elementos finitos (Ansys Maxwell / EIDORS).

## 📂 Estructura del Repositorio

La organización del repositorio sigue la estructura de trabajo del proyecto:

```text
/
├── Modelos 3D/                     # Archivos de diseño CAD y ensamblaje (.f3z, .f3d)
│   ├── Fantoma_modificado.f3z
│   ├── Parte_Conductiva_Fantoma.f3z
│   ├── Probeta_Experimento_4_Puntas.f3d
│   ├── Probeta_Multicapa.f3d
│   └── Referencia_Original_Reescalada.f3d
│
└── Simulacion_Ansys/               # Archivos de simulación numérica y elementos finitos