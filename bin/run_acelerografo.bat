@echo off
title Ejecutar Analisis Acelerografos - RSA
:: Cambia el directorio activo de la consola a la raíz del repositorio (un nivel arriba de bin/)
cd /d "%~dp0.."

echo ====================================================
echo  Buscando gestor de entornos (micromamba/conda)...
echo ====================================================

:: Inicializar la variable del ejecutable
set "MAMBA_EXE="

:: 1. Comprobar si 'micromamba' está en el PATH
where micromamba >nul 2>nul
if %errorlevel% equ 0 (
    set "MAMBA_EXE=micromamba"
    goto launch
)

:: 2. Comprobar ubicaciones comunes de micromamba en el perfil del usuario activo
if exist "%USERPROFILE%\micromamba.exe" (
    set "MAMBA_EXE=%USERPROFILE%\micromamba.exe"
    goto launch
)
if exist "%USERPROFILE%\micromamba\micromamba.exe" (
    set "MAMBA_EXE=%USERPROFILE%\micromamba\micromamba.exe"
    goto launch
)

:: 3. Comprobar ruta específica del trabajo (Milton RSA) para compatibilidad
if exist "C:\Users\miltonrsa\micromamba.exe" (
    set "MAMBA_EXE=C:\Users\miltonrsa\micromamba.exe"
    goto launch
)

:: 4. Comprobar si 'conda' está en el PATH como alternativa
where conda >nul 2>nul
if %errorlevel% equ 0 (
    set "MAMBA_EXE=conda"
    goto launch
)

:launch
if "%MAMBA_EXE%"=="" (
    echo [ERROR] No se encontro 'micromamba' ni 'conda' en el PATH ni en las rutas comunes.
    echo Por favor, instala micromamba/conda y asegurate de agregarlo al PATH del sistema.
    echo Ubicaciones buscadas:
    echo   - PATH ^(micromamba, conda^)
    echo   - %%USERPROFILE%%\micromamba.exe
    echo   - C:\Users\miltonrsa\micromamba.exe
    echo.
    pause
    exit /b 1
)

echo Usando ejecutable: %MAMBA_EXE%
echo Cargando Entorno Virtual 'rsa_acelerografo'...
echo ====================================================

:: Ejecuta el script usando el entorno rsa_acelerografo
call "%MAMBA_EXE%" run -n rsa_acelerografo python src/acelerografos/main.py

echo ====================================================
echo  Ejecucion finalizada.
echo ====================================================
pause
