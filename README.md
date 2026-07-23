# Desarrollo de un Fantoma Anatómico de Cabeza Humana para Electroencefalograma

**Autor:** Alan Montero  
**Institución:** Universidad Técnica Federico Santa María (UTFSM) - Departamento de Electrónica  
**Proyecto:** Memoria de Titulación: "Desarrollo de un Fantoma Anatómico de Cabeza Humana para Electroencefalograma"

## 📄 Descripción del Proyecto

El presente trabajo aborda las limitaciones de las plataformas experimentales previas mediante el desarrollo de un fantoma antropomórfico de cabeza humana fabricado íntegramente mediante impresión 3D por deposición de material fundido utilizando PLA conductivo. A diferencia de trabajos previos, se realiza una caracterización experimental sistemática del material, evaluando la influencia de distintos parámetros de impresión sobre su resistividad y utilizando estos resultados para definir las propiedades eléctricas de una estructura multicapa que representa el cerebro, el cráneo y el cuero cabelludo.

Adicionalmente, el trabajo valida experimentalmente la propagación de potenciales eléctricos mediante diferentes configuraciones de inyección, incluyendo excitaciones múltiples, y verifica la continuidad eléctrica de un fantoma antropomórfico con 32 electrodos distribuidos según el Sistema Internacional 10–20. Los resultados obtenidos permiten disponer de una plataforma experimental reproducible para el estudio de la propagación de bioseñales y la evaluación de sistemas relacionados con EEG.

## 🎯 Objetivos Específicos

* **Diseñar y fabricar** un modelo tridimensional de cabeza humana a partir de datos médicos abiertos, considerando las capas correspondientes al cerebro, cráneo y cuero cabelludo, y estudiar la influencia de distintos parámetros de impresión sobre las propiedades eléctricas del material.
* **Diseñar e implementar** un sistema de electrodos de medición e inyección distribuido según el sistema internacional 10–20, permitiendo la aplicación controlada de señales eléctricas para la caracterización experimental del fantoma.
* **Caracterizar experimentalmente** el comportamiento eléctrico del fantoma y evaluar su capacidad para reproducir distribuciones espaciales de potencial representativas de señales EEG bajo distintas configuraciones de excitación.

## 📊 Aporte y Resultados Clave

* **Plataforma Reproducible:** Modelo físico con 32 canales validados bajo el estándar 10–20 para el estudio de propagación de bioseñales.
* **Optimización FDM:** Ajuste de la resistividad efectiva del PLA conductivo mediante porcentajes de relleno y patrones geométricos por región anatómica debido a las limitaciones de extrusor único.
* **Validación Numérica:** Concordancia y análisis comparativo frente a modelos numéricos de elementos finitos (Ansys Maxwell / EIDORS).

## 📂 Estructura del Repositorio

```text
/
├── Codigo_Matlab/                  # Scripts de procesamiento, mapas de calor y comparaciones
│   
├── Modelos 3D/                     # Modelos CAD y archivos de diseño (.f3z, .f3d)
│
└── Simulacion_Ansys/               # Archivos de simulación numérica y elementos finitos
    ├── Parte_Conductiva_Fantoma/
    └── Probeta_Multicapa/
