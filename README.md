# Generiz Virtual Display Manager

Generiz Virtual Display Manager es una herramienta para gestionar y mantener actualizado un display virtual en sistemas Windows. Esta utilidad crea un display virtual con un driver específico y lo reinstala cada vez que se reinicia el sistema. Es útil para solucionar problemas de visualización en aplicaciones como AnyDesk cuando no hay un monitor conectado a la computadora que se desea controlar.

## Instalación

1. Descargue o clone este repositorio en su computadora.
2. Asegúrese de tener todos los archivos necesarios en la carpeta `carpeta`:
   - Win32
   - x64
   - usbmmidd.bat
   - usbmmidd.cat
   - usbmmidd.inf
   - deviceinstaller.exe
   - deviceinstaller64.exe
   - tarea.bat
3. Ejecute el script `solucion.bat` con privilegios de administrador. El script instalará los controladores necesarios, creará una tarea programada y configurará el entorno.
4. Reinicie su computadora para que los cambios surtan efecto.

## Uso

Una vez instalado, Generiz Virtual Display Manager se ejecutará automáticamente cada vez que reinicie su computadora. El script de la tarea reinstalará el display virtual en cada reinicio, asegurándose de que siempre funcione correctamente.

Si desea desinstalar Generiz Virtual Display Manager y eliminar las tareas asociadas, ejecute nuevamente el script `solucion.bat` con privilegios de administrador. El script detectará que el programa ya está instalado y le preguntará si desea eliminarlo y borrar todas las tareas asociadas.

## Licencia

Generiz Virtual Display Manager es un software de código abierto bajo la licencia MIT. Consulte el archivo `LICENSE` para obtener más detalles.
