@echo off
:: Verificar si se ejecuta como administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Ejecutando como administrador.
) else (
    echo Error: Este script requiere permisos de administrador.
    echo Por favor, ejecute este script como administrador.
    pause
    exit
)
cd /d %~dp0
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& { "%~dp0\datos\solucion.ps1 }"

