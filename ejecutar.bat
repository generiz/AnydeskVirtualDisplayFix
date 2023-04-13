@echo off
cd /d %~dp0
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& { "%~dp0\datos\solucion.ps1 }"


