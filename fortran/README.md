# Trabajar con Fortran

![frotan](figs/frotan.png)

## Pasos previos
- Se asumen que se cumplieron los [requisitos principales del curso](../README.md#Requisitos)
- Realizar la instalación de las [herramientas adicionales para Fortran](https://github.com/ipqa-research/fortran-setup) como se explica en
  el repositorio mismo.

## Qué vamos a ver hoy?
- Estructurar un proyecto.
- Ejecutar códigos Fortran.
- Formatear consistentemente el código.
- Documentar código.

## Que **no** vamos a ver hoy
Syntaxis de Fortran, no vamos a meternos en el lenguaje en sí, sino en todo lo
que lo rodea. Eso queda para otro día.

## Caso de aplicación
Vamos a ver lo más importante con un ejemplo aplicado, queremos correr unos
flashes para un sistema binario.

### Generar un nuevo proyecto
Empezamos generando nuestro nuevo proyecto Fortran.

```bash
# El nombre de proyecto _no_ puede tener espacios!
fortran_project new "nombre_projecto"
```

Todos los proyectos se generan por defecto en `~/codes`, cada uno en una nueva
carpeta.

### Abrimos el proyecto
Para abrir nuestros proyectos simplemente ejecutamos

```bash
fortran_project work
```

Lo que nos mostrará una lista de los proyectos y podemos seleccionar en cual
deseamos trabajar. Similar a la siguiente:

![fzf](figs/fzf.png)

Donde se puede tanto seleccionar con un click o escribir el nombre del
proyecto.

Seleccionar el proyecto abrirá el mismo en `vscode`, ya listo para trabajar.

### Ejecución
Desde la terminal de `vscode` podemos ver que está abierto el directorio del
proyecto. Así que al proyecto lo podemos correr simplemente con: 

```bash
fpm run
```

### Agregar una dependencia
En la carpeta del proyecto existe un archivo `fpm.toml`, donde podemos
ver la configuración general del proyecto.

Se puede agregar una dependencia agregando al final del archivo:

```toml
[dependencies]
# Libreria estandar de Fortran, debería de ir _siempre_.
stdlib="*"
# Librería de ecuaciones de estado
yaeos = {git="https://github.com/ipqa-research/yaeos", tag="v0.1.0b2"}
```

Al aclarar `tag` estamos pidiendo una versión específica de la librería. Así
que si en un futuro la versión más nueva cambia bruscamente nuestro código
no se rompe.

### Flasheamos un poco
Ponemos esto en el archivo `app/main.f90`

```fortran
program main
    use yaeos, only: pr, EquilibriaState, flash, PengRobinson76, ArModel
    implicit none

    class(ArModel), allocatable :: model
    type(EquilibriaState) :: flash_result

    real(pr) :: tc(2), pc(2), w(2)

    real(pr) :: n(2), t, p, k0(2)
    integer :: iter

    n = [0.4, 0.6]
    tc = [190.564, 425.12]
    pc = [45.99, 37.96]
    w = [0.0115478, 0.200164]
    model = PengRobinson76(tc, pc, w)

    P = 60
    t = 294
    k0 = (PC/P)*exp(5.373*(1 + w)*(1 - TC/T))
    print *, "K0: ", k0

    print *, "Running Flash!"
    flash_result = flash(model, n, t=t, p_spec=p, k0=k0, iters=iter)

    print *, "X:", flash_result%x, sum(flash_result%x)
    print *, "Y:", flash_result%y, sum(flash_result%y)
    print *, "Vx: ", flash_result%Vx
    print *, "Vy: ", flash_result%Vy
    print *, "P: ", flash_result%p
    print *, "T: ", flash_result%T
end program
```

Corremos de nuevo con `fpm run`, y yatá. Podemos jugar con parámetros en el 
archivo main y volver a correr.

> Protip:
> `fpm run --profile release` hace que la compilación optimize el código
> y corra más rápido.


Listo, ya sabemos lo esencial para correr un código Fortran. No fue tanto
quilombo.

## Conceptos generales
Bueno, ahora nos toca meternos un poco más en lo que hicimos recién.

### Gestión de paquetes y fpm
Para empezar esto, es importante responder:

Si hasta recién yo estuve compartiendo mis códigos fuentes a
becarios/investigadores y ellos directamente lo ejecutan y modifican. 
¿De que me sirve usar gestión de paquetes?

Bueno, esa pregunta se responde con una serie de preguntas:

- Esos códigos compartidos, ¿En cuantas versiones distintas de archivos
  resultaron? (con sus respectivas mini-modificaciones)
- ¿Cómo mergearía todas esas versiones? (no podría)
- ¿Cuántos días productivos perdí hasta darme cuenta de que me falta `X` rutina?

Bueno, utilizar un gestor de paquetes ayuda a mitigar estos problemas.

El Fortran-Package-Manager `fpm` es el gestor de paquetes de `Fortran`.
Automatiza la tarea de:

- Compilación.
- Instalación de dependencias.
- Ejecución de programas.

![fpm](figs/fpm.png)

Más información de `fpm` en [su sitio web](https://fpm.fortran-lang.org/)

### Configuaraciones de `vscode`
Esto no es un curso de `vscode`, pero vamos a ver algo esencial:

`vscode` puede configurarse agregando archivos particulares en la carpeta
oculta `.vscode` del proyecto. Los archivos esenciales que hay que saber que
existen ante cualquier eventualidad son:

- `settings.json`: Configuración general.
- `tasks.json`: Tareas automatizadas.
- `launch.json`: Opciones de corrida/debuggeo de código.


Ni ustedes quieren ver esto, ni yo quiero darlo, pero es importante saber que
existen y tener esto como referencia ante alguna eventualidad.

Vamos a ver simplemente un ejemplo de `tasks.json` y `launch.json`.

#### tasks
Una tarea se estructura así:
```json
//task
...
{
  "label": "fpm: install", // Nombre que la describe
  "type": "shell",         // shell aclara que es un comando
  "command": "fpm",        // commando en si
  "args": [                // Lista de argumentos del comando
    "install",
    "--profile",
    "debug",
    "--prefix",
    "${workspaceRoot}/build/vscode"
  ],
  "group": {
    "kind": "build",
    "isDefault": true
  }
}

```

En este caso la tarea instala con opciones de debugging al programa principal,
en la carpeta `./build/vscode`, para luego poder debuggearlo.


#### launch
Solo es "esencial" entender `program` y `args`. En este caso vemos la
configuración que debuggea el archivo principal.

```json
{
  "name": "(gdb) Debug main",
  "type": "cppdbg",
  "request": "launch",
  // El archivo ejecutable que se va a debuggear, la task que vimos antes
  // lo instala en la carpeta ./build/vscode, y el ejecutable se localiza
  // en la subcarpeta bin, con el nombre del proyecto (que es igual al nombre
  // de la carpeta principal del proyecto)
  "program": "${workspaceFolder}/build/vscode/bin/${workspaceFolderBasename}",
  // Si el programa recive argumentos extra, se añaden aquí.
  "args": ["coso1", "--coso2", "coso2_valor"],
  "stopAtEntry": true,
  "cwd": "${workspaceFolder}",
  "environment": [],
  "externalConsole": false,
  "MIMode": "gdb",
  "setupCommands": [
    {
      "description": "Enable pretty-printing for gdb",
      "text": "-enable-pretty-printing",
      "ignoreFailures": true
    },
    {
      "description": "Set Disassembly Flavor to Intel",
      "text": "-gdb-set disassembly-flavor intel",
      "ignoreFailures": true
    }
  ],
  "preLaunchTask": "fpm: install"
}
```


### Script `fortran_project`
Bueno, todo lo que vimos recién era para entender que pasa de fondo, en
realidad está todo (en gran parte) encapsulado en un script muy originalmente
`fortran_project`. Podemos ver su uso general corriendo `fortran_project` sin
nada. `fortran_project` está pensado para ayudarnos a ordenarnos mejor sin
pensar mucho.

Básicamente lo que hace es:

- Genera proyectos nuevos siempre en la misma carpeta:
    - Por defecto en carpeta `~/codes`
    - Genera el proyecto base con `fpm`
    - Descarga automaticamente las configuraciones más actualizadas de `vscode`, que están alojadas en [nuestro repo](https://github.com/ipqa-research/vscode-fortran), estas configuraciones tienen:
        - Cosas generales básicas
        - Opciones de debuggeo
- Lista todos los proyectos existentes
- Abre `vscode` en un proyecto de mi elección.

```
fortran_project <new|list|work|update>

Manage your Fortran based projects locally with fpm and vscode.

USAGE:
    - fortran_project new <project_name>
        Create a new project.
        The default folder will be at ~/codes, but it can be set up with
        the environment variable FORTRAN_PROJECTS.
        If the directory doesn't exist, it will be created.

    - fortran_project list
        List all the existing Fortran projects.
    
    - fortran_project work
        Open vscode on the selected project directory.

    - fortran_project update
        Update the fortran_project script

```

## Bonus track
Cositas extra que son útiles

### Pre-procesadores de código
Es más fácil describir que quiero escribir que escribirlo en sí
