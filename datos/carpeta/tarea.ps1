$generizPath = "c:\generiz"
Set-Location $generizPath

# Verifica si el dispositivo de visualización virtual existe
$virtualDisplay = Get-WmiObject -Query "SELECT * FROM Win32_PnPEntity WHERE PNPClass='DISPLAY' AND Name LIKE '%Virtual Display%'"

# Verificar monitores adicionales
$additionalMonitors = Get-WmiObject -Query "SELECT * FROM Win32_PnPEntity WHERE PNPClass='DISPLAY' AND Name NOT LIKE '%Virtual Display%'"

if ($additionalMonitors) {
    Write-Host "Detectado monitor adicional."

    if ($virtualDisplay) {
        Write-Host "Virtual Display encontrado. Deshabilitando..."
        .\deviceinstaller64.exe enableidd 0
        .\deviceinstaller64.exe remove usbmmidd.inf usbmmidd
        Write-Host "Virtual Display deshabilitado."
    } else {
        Write-Host "No hay Virtual Display para deshabilitar."
    }
} else {
    if ($virtualDisplay) {
        Write-Host "Virtual Display encontrado. Desinstalando..."
        .\deviceinstaller64.exe enableidd 0
        .\deviceinstaller64.exe remove usbmmidd.inf usbmmidd
    }

    Write-Host "Instalando Virtual Display..."
    .\deviceinstaller64.exe install usbmmidd.inf usbmmidd
    .\deviceinstaller64.exe enableidd 1
    Write-Host "Virtual Display reinstalado correctamente."
}
