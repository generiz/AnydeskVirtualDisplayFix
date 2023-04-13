$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$generizPath = "c:\generiz"

# Función para verificar si un directorio está vacío
function Test-DirectoryEmpty($path) {
    return @(Get-ChildItem -Path $path -Force).Count -eq 0
}

if ((Test-Path $generizPath) -and (-not (Test-DirectoryEmpty $generizPath))) {
    Write-Host "Ya esta instalado."
    $userChoice = Read-Host "Desea eliminar el programa y todas las tareas asociadas (S/N)"
    if ($userChoice -eq "S") {
        # Deshabilita el Virtual Display antes de eliminar la tarea y el directorio
        $virtualDisplay = Get-WmiObject -Query "SELECT * FROM Win32_PnPEntity WHERE PNPClass='DISPLAY' AND Name LIKE '%Virtual Display%'"
        if ($virtualDisplay) {
            Write-Host "Virtual Display encontrado. Deshabilitando..."
            Set-Location $generizPath
            .\deviceinstaller64.exe enableidd 0
            .\deviceinstaller64.exe remove usbmmidd.inf usbmmidd
            Start-Sleep -Seconds 5
        }

        Write-Host "Deteniendo y eliminando tarea programada..."
        $taskService = New-Object -ComObject "Schedule.Service"
        $taskService.Connect()
        $rootFolder = $taskService.GetFolder("\")
        $task = $rootFolder.GetTask("generiz")
        if ($task) {
            $task.Enabled = $false
            $task.Stop(0)
            Start-Sleep -Seconds 5
            Unregister-ScheduledTask -TaskName "generiz" -Confirm:$false
            Write-Host "La tarea 'generiz' ha sido eliminada."
        }
        else {
            Write-Host "La tarea 'generiz' no existe."
        }

        Write-Host "Eliminando directorio generiz..."

        # Crear archivo por lotes para eliminar la carpeta 'C:\generiz' usando RmDir
       
$batchFilePath = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName() + ".bat")
Set-Content -Path $batchFilePath -Value @"
@echo off
echo Eliminando datos del programa...
timeout /t 5
RmDir /S /Q $generizPath
"@ -Encoding ASCII


        # Ejecutar el archivo por lotes en una nueva ventana del símbolo del sistema
        Start-Process -FilePath "cmd.exe" -ArgumentList "/C $batchFilePath"

        Write-Host "datos del programa y las tareas asociadas han sido eliminadas."
        Read-Host "Programa desinstaldo con exito"
        exit
 
    }
} else {
    # Copiar archivos a c:\generiz (reemplace "carpeta" con la ruta de origen correcta)
    New-Item -Path $generizPath -ItemType Directory -Force
    Copy-Item "$scriptPath\carpeta\Win32" "$generizPath\" -Recurse
    Copy-Item "$scriptPath\carpeta\x64" "$generizPath\" -Recurse
    Copy-Item "$scriptPath\carpeta\usbmmidd.bat" "$generizPath\"
    Copy-Item "$scriptPath\carpeta\usbmmidd.cat" "$generizPath\"
    Copy-Item "$scriptPath\carpeta\usbmmidd.inf" "$generizPath\"
    Copy-Item "$scriptPath\carpeta\deviceinstaller.exe" "$generizPath\"
    Copy-Item "$scriptPath\carpeta\deviceinstaller64.exe" "$generizPath\"
    Copy-Item "$scriptPath\carpeta\tarea.ps1" "$generizPath\"

    Write-Host "Instalando drivers..."
    Set-Location $generizPath
    .\deviceinstaller64.exe install usbmmidd.inf usbmmidd
    .\deviceinstaller64.exe enableidd 1

	 Write-Host "Creando tarea..."
    $action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $generizPath\tarea.ps1"
    $trigger = New-ScheduledTaskTrigger -AtStartup -RandomDelay (New-TimeSpan -Minutes 1)
    $settings = New-ScheduledTaskSettingsSet -Priority 4
	  $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    Register-ScheduledTask -TaskName "generiz" -Action $action -Trigger $trigger -Settings $settings -Principal $principal

    Read-Host "Todo fue instalado con exito!"
}
#dudas y comentarios https://www.linkedin.com/in/nicolaspintos/