@echo off
title Ejecutar Analisis Acelerografos - RSA
:: Cambia el directorio activo de la consola a la raíz del repositorio (un nivel arriba de bin/)
cd /d "%~dp0.."

echo ====================================================
echo  Cargando Entorno Virtual 'rsa_acelerografo'...
echo ====================================================

:: Ejecuta el script de Python usando el entorno limpio rsa_acelerografo
call C:\Users\miltonrsa\micromamba.exe run -n rsa_acelerografo python src/acelerografos/main.py

echo ====================================================
echo  Ejecucion finalizada.
echo ====================================================
pause
