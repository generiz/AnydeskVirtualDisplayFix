# Verifica si el dispositivo de visualización virtual existe
$virtualDisplay = Get-WmiObject -Query "SELECT * FROM Win32_PnPEntity WHERE PNPClass='DISPLAY' AND Name LIKE '%Virtual Display%'"

if ($virtualDisplay) {
    Write-Host "Virtual Display encontrado. Desinstalando..."
    Set-Location "c:\generiz\"
    .\deviceinstaller64.exe enableidd 0
    .\deviceinstaller64.exe remove usbmmidd.inf usbmmidd
}

Write-Host "Instalando Virtual Display..."
Set-Location "c:\generiz\"
.\deviceinstaller64.exe install usbmmidd.inf usbmmidd
.\deviceinstaller64.exe enableidd 1

Write-Host "Virtual Display reinstalado correctamente."
