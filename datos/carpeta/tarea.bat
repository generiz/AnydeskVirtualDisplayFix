@echo off

REM Verifica si el dispositivo de visualización virtual existe
WMIC path Win32_PnPEntity where "PNPClass='DISPLAY' AND Name LIKE '%%Virtual Display%%'" get DeviceID | findstr /R /C:".*" >nul
if %errorlevel% equ 0 (
    echo Virtual Display encontrado. Desinstalando...
    cd c:\generiz\
    deviceinstaller64 remove usbmmidd.inf usbmmidd
)

echo Instalando Virtual Display...
cd c:\generiz\
deviceinstaller64 install usbmmidd.inf usbmmidd
deviceinstaller64 enableidd 1

echo Virtual Display reinstalado correctamente.
