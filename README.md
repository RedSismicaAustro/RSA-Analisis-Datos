# RSA-Analisis-Datos

Repositorio institucional de la Red Sísmica del Austro (RSA) dedicado al análisis, procesamiento de señales acelerográficas y visión artificial.

Este repositorio está estructurado para soportar múltiples proyectos y entornos virtuales independientes según el tipo de datos a analizar.

---

## 📂 Estructura del Repositorio

*   **`bin/`**: Contiene scripts de lote (`.bat`) para el lanzamiento rápido de aplicaciones en Windows 11.
*   **`envs/`**: Aloja las recetas de entornos virtuales de Conda/Micromamba organizadas por proyecto:
    *   `envs/acelerografo/`: Entorno para el análisis y procesamiento de señales de acelerógrafos.
*   **`src/`**: Código fuente de los proyectos de análisis:
    *   `src/acelerografos/`: Scripts y módulos de análisis para acelerógrafos.

---

## 🛠️ Configuración de Entornos Virtuales (Windows 11)

Debido a las restricciones de red y políticas de grupo (GPO) corporativas en Windows 11 que bloquean la ejecución de scripts en PowerShell, la configuración y activación de entornos se realiza mediante **CMD** utilizando **Micromamba**.

### Proyecto: Acelerógrafo (Señales Sísmicas)

#### Paso 1: Creación del Entorno
Si no tienes el entorno creado, puedes construirlo desde una terminal **CMD** apuntando a la configuración del proyecto:

```cmd
C:\Users\miltonrsa\micromamba.exe env create -f envs/acelerografo/environment.yml
```

#### Paso 2: Instalación de Dependencias
Instala los paquetes definidos en su archivo de dependencias de pip:

```cmd
C:\Users\miltonrsa\micromamba.exe run -n rsa_acelerografo pip install -r envs/acelerografo/requirements.txt
```

---

## 🚀 Ejecución de Aplicaciones en Windows 11

Dependiendo del nivel de restricciones aplicadas en tu terminal, tienes tres métodos para activar el entorno y ejecutar los análisis (ej. `src/acelerografos/main.py`):

### Método 1: Lanzador de Inicio Rápido (Recomendado)
Puedes ejecutar directamente la aplicación haciendo doble clic sobre el script de lote en el Explorador de Archivos o ejecutándolo desde consola:

```cmd
bin\run_acelerografo.bat
```
*(Este script cambia automáticamente el directorio de trabajo a la raíz del repositorio y levanta el entorno de forma aislada utilizando `rsa_acelerografo`).*

### Método 2: Activación Estándar (CMD)
Si inicializaste Micromamba correctamente para CMD, ejecuta:

```cmd
:: 1. Activar el entorno específico
micromamba activate rsa_acelerografo

:: 2. Lanzar la aplicación
python src/acelerografos/main.py
```

### Método 3: Ejecución Directa de Respaldo (`micromamba run`)
Si la activación del entorno falla o está bloqueada por políticas del shell padre, utiliza el mecanismo de ejecución directa:

```cmd
C:\Users\miltonrsa\micromamba.exe run -n rsa_acelerografo python src/acelerografos/main.py
```

---

## 💻 Integración con VS Code

Para depurar y trabajar en el código sin dependencias de la inicialización de la terminal en VS Code:
1. Abre el repositorio en VS Code.
2. Selecciona como intérprete de Python la ruta física directa del entorno del acelerógrafo:
   `C:\Users\miltonrsa\micromamba\envs\rsa_acelerografo\python.exe`
