@echo off
title Ejecutar MarkItDown - RSA
setlocal enabledelayedexpansion

echo ====================================================
echo  Buscando gestor de entornos (micromamba/conda)...
echo ====================================================

:: 1. Inicializar variable ejecutable
set "MAMBA_EXE="

where micromamba >nul 2>nul
if %errorlevel% equ 0 set "MAMBA_EXE=micromamba" & goto check_env

if exist "%USERPROFILE%\micromamba.exe" set "MAMBA_EXE=%USERPROFILE%\micromamba.exe" & goto check_env

if exist "%USERPROFILE%\micromamba\micromamba.exe" set "MAMBA_EXE=%USERPROFILE%\micromamba\micromamba.exe" & goto check_env

if exist "C:\Users\miltonrsa\micromamba.exe" set "MAMBA_EXE=C:\Users\miltonrsa\micromamba.exe" & goto check_env

where conda >nul 2>nul
if %errorlevel% equ 0 set "MAMBA_EXE=conda" & goto check_env

:check_env
if "%MAMBA_EXE%"=="" (
    echo [ERROR] No se encontro 'micromamba' ni 'conda' en el PATH ni en las rutas comunes.
    echo Por favor, instala micromamba/conda y asegurate de agregarlo al PATH del sistema.
    echo.
    pause
    exit /b 1
)

echo Usando ejecutable: %MAMBA_EXE%
echo.

:: 2. Verificar si el entorno 'markitdown_env' existe
"%MAMBA_EXE%" env list | findstr /i /c:"markitdown_env" >nul 2>nul
if %errorlevel% neq 0 (
    echo ====================================================
    echo [INFO] No se encontro el entorno 'markitdown_env'.
    echo Creando entorno virtual e instalando markitdown[all]...
    echo ====================================================
    call "%MAMBA_EXE%" create -n markitdown_env python=3.11 -y
    if !errorlevel! neq 0 (
        echo [ERROR] Error al crear el entorno virtual.
        pause
        exit /b 1
    )
    call "%MAMBA_EXE%" run -n markitdown_env pip install "markitdown[all]"
    if !errorlevel! neq 0 (
        echo [ERROR] Error al instalar markitdown[all].
        pause
        exit /b 1
    )
    echo ====================================================
    echo [INFO] Entorno 'markitdown_env' configurado exitosamente.
    echo ====================================================
)

:: 3. Evaluacion de Argumentos de Entrada

:: Si no hay primer argumento -> Mostrar ayuda
if "%~1" == "" goto show_help

:: Si hay solo 1 argumento (Drag & Drop o comando simple 'run_markitdown.bat archivo.ext')
if "%~2" == "" goto convert_single

:: Caso C: Argumentos multiples o avanzados (ej. run_markitdown.bat entrada.pdf -o salida.md)
call "%MAMBA_EXE%" run -n markitdown_env markitdown %*
goto final_check

:convert_single
if exist "%~f1" (
    set "OUTPUT_FILE=%USERPROFILE%\Desktop\%~n1.md"
    echo ====================================================
    echo [INFO] Convirtiendo archivo: "%~f1"
    echo [INFO] Salida en Escritorio: "!OUTPUT_FILE!"
    echo ====================================================
    call "%MAMBA_EXE%" run -n markitdown_env markitdown "%~f1" -o "!OUTPUT_FILE!"
    goto final_check
) else (
    echo ====================================================
    echo [ERROR] El archivo especificado no existe: "%~f1"
    echo ====================================================
    pause
    exit /b 1
)

:show_help
echo ====================================================
echo  MarkItDown CLI - Red Sismica del Austro (RSA)
echo  Entorno Virtual: markitdown_env
echo ====================================================
echo.
echo Modos de Uso:
echo   1. Arrastrar y soltar (Drag ^& Drop):
echo      Arrastra cualquier archivo (PDF, DOCX, XLSX, PPTX, HTML, TXT, etc.)
echo      sobre este icono .bat. El archivo .md resultante se guardara
echo      automaticamente en tu Escritorio (%USERPROFILE%\Desktop).
echo.
echo   2. Linea de comandos:
echo      run_markitdown.bat entrada.pdf
echo      (Guarda salida en %USERPROFILE%\Desktop\entrada.md)
echo.
echo      run_markitdown.bat entrada.pdf -o C:\ruta\personalizada.md
echo      (Guarda en la ruta especificada)
echo.
echo ====================================================
echo Ayuda Oficial de MarkItDown:
echo.
call "%MAMBA_EXE%" run -n markitdown_env markitdown --help
echo.
pause
exit /b 0

:final_check
if %errorlevel% equ 0 (
    echo.
    echo ====================================================
    echo  [EXITO] Procesamiento finalizado correctamente.
    echo ====================================================
) else (
    echo.
    echo ====================================================
    echo  [ERROR] Ocurrio un error durante la ejecucion.
    echo ====================================================
    pause
)
