# La terminal de Linux

## Qué es?

La terminal de Linux es una interfaz de línea de comandos que permite a los
usuarios interactuar con programas mediante la ejecución de comandos
escritos en texto, proporcionando un medio _eficiente y versátil_ para
realizar tareas de administración, gestión de archivos y programación.

## Ventajas

Entre las principales ventajas de trabajar con una terminal se encuentran:

- Flexibilidad y personalización
- Eficiencia en gestión de archivos y tareas
- Automatización
- Acceso remoto

## Terminal

## Ejecución de comandos

Un comando de terminal tiene la siguiente estructura

```bash
comando argumento1 argumento2 --flag1 --flag2 -f1
```
- Comando: El nombre del programa que se ejecuta.
- argumento[12]: Los argumentos que recibe el programa.
- --flag1: Se llaman "flags" o "switches", suelen ser opciones particulares.
- -f: Las flags suelen tener abreviaciones.


A modo de ejemplo podemos ejecutar el comando de calendario:

```bash
cal
```

```bash
cal --three
```

```bash
cal --help
```

## Comandos más importantes

### Navegación
- `pwd`: Nos muestran donde estamos parados.
- `ls` : Nos muestra
- `cd` : "Cambiar directorio"

### Manipulación de archivos y directorios
- `mkdir`: Crear directorio
- `mv` : Mover
- `cp` : Copiar
- `cat`: Mostrar contenido de archivo
- `head` y `tail`: Mostrar comienzo o fin de un archivo
- `grep`: Buscar texto en archivo

### Trabajo con texto
- `sort`
- `uniq`
- `wc`
- `sed`
- `awk`

### Redirecciones
- `>`: Enviar los prints a un archivo.
- `|`: Redirigir los prints a un comando.
- `<`: Redirigir los contenidos de un archivo a un comando.

## Scripts
