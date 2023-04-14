# Anydesk Virtual Display Fix
Descripción del repositorio:

Este repositorio contiene una solución para abordar el problema de AnyDesk donde no se muestra el escritorio remoto cuando la computadora controlada no tiene un monitor conectado. La solución crea un "display virtual" en la computadora que se controla, permitiendo así que AnyDesk muestre correctamente el escritorio remoto.

Nota: Este proyecto está diseñado en y para Windows 11 tambien deberia de funcionar en Windows 10. Asegúrese de probar la solución en una máquina con Windows 10 antes de usarla en un entorno de producción.

Estructura del repositorio:


raíz
│   ejecutar.bat
│
└───carpeta_datos
    │   solucion.ps1
    │
    └───carpeta
        │   (archivos y subcarpetas)
Uso:

Descargue el repositorio y extraiga su contenido en una carpeta de su elección.
Haga clic con el botón derecho en ejecutar.bat y seleccione "Ejecutar como administrador".
Siga las instrucciones que aparecen en la ventana de la consola para instalar o desinstalar la solución.
Nota: Este proyecto está diseñado para funcionar en Windows 10. Asegúrese de probar la solución en una máquina con Windows 10 antes de usarla en un entorno de producción.


## Uso

Una vez instalado, Anydesk Virtual Display Fix se ejecutará automáticamente cada vez que reinicie su computadora. El script de la tarea reinstalará el display virtual en cada reinicio, asegurándose de que siempre funcione correctamente.

Si desea desinstalar Anydesk Virtual Display Fix y eliminar las tareas asociadas, ejecute nuevamente el script `ejecutar.bat` con privilegios de administrador. El script detectará que el programa ya está instalado y le preguntará si desea eliminarlo y borrar todas las tareas asociadas.

## Licencia

Anydesk Virtual Display Fix es un software de código abierto bajo la licencia MIT. Consulte el archivo `LICENSE` para obtener más detalles.
