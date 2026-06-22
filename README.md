# RSA-Analisis-Datos

Repositorio institucional de la Red Sísmica del Austro (RSA) dedicado al análisis, procesamiento de señales acelerográficas y visión artificial.

Este repositorio está estructurado para soportar múltiples proyectos y entornos virtuales independientes según el tipo de datos a analizar.

---

## 📂 Estructura de Entornos (`envs/`)

Los entornos virtuales se encuentran organizados por temática en el directorio `envs/`:
*   `envs/acelerografo/`: Entorno para el análisis y procesamiento de señales sísmicas/acelerográficas.
*   *(Próximamente)* `envs/coordinometro/`: Entorno para visión artificial y tracking en coordinómetros.

---

## 🛠️ Configuración de Entornos Virtuales (Windows 11)

Debido a las restricciones de red y políticas de grupo (GPO) corporativas en Windows 11 que bloquean la ejecución de scripts en PowerShell, la configuración y activación de entornos se realiza mediante **CMD** utilizando **Micromamba**.

### Proyecto: Acelerógrafo (Señales Sísmicas)

#### Paso 1: Creación del Entorno
Desde una terminal **CMD**, ejecuta el siguiente comando apuntando a la configuración específica del proyecto:

```cmd
C:\Users\miltonrsa\micromamba.exe env create -f envs/acelerografo/environment.yml
```

#### Paso 2: Instalación de Dependencias
Una vez creado el entorno, instala los paquetes definidos en su archivo de dependencias de pip:

```cmd
C:\Users\miltonrsa\micromamba.exe run -n rsa_acelerografo pip install -r envs/acelerografo/requirements.txt
```

---

## 🚀 Ejecución de la GUI en Windows 11

Dependiendo del nivel de restricciones aplicadas en tu terminal, tienes tres métodos para activar el entorno y ejecutar la interfaz gráfica (`src/gui/main.py`):

### Método 1: Activación Estándar (Recomendado en CMD)
Si inicializaste Micromamba correctamente para CMD, ejecuta:

```cmd
:: 1. Activar el entorno específico
micromamba activate rsa_acelerografo

:: 2. Lanzar la aplicación
python src/gui/main.py
```

### Método 2: Ejecución Directa de Respaldo (`micromamba run`)
Si la activación del entorno falla o está bloqueada por políticas del shell padre, utiliza el mecanismo de ejecución directa:

```cmd
C:\Users\miltonrsa\micromamba.exe run -n rsa_acelerografo python src/gui/main.py
```

### Método 3: Script de Lote de Inicio Rápido (`run_gui.bat`)
Para un acceso directo de doble clic, puedes crear un archivo llamado `run_gui.bat` en la raíz del repositorio con el siguiente contenido:

```batch
@echo off
title Ejecutar GUI - RSA Analisis Datos
echo Activando entorno virtual 'rsa_acelerografo' y ejecutando la GUI...
call C:\Users\miltonrsa\micromamba.exe run -n rsa_acelerografo python src/gui/main.py
pause
```

---

## 💻 Integración con VS Code

Para depurar y trabajar en el código sin dependencias de la inicialización de la terminal en VS Code:
1. Abre el repositorio en VS Code.
2. Selecciona como intérprete de Python la ruta física directa del entorno del acelerógrafo:
   `C:\Users\miltonrsa\micromamba\envs\rsa_acelerografo\python.exe`
