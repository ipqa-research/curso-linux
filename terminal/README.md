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

![Terminal](figs/term_1.png)

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
- `ls` : Nos muestra los archivos de donde estamos.
- `cd` : "Cambiar directorio"

### Manipulación de archivos y directorios
- `mkdir`: Crear directorio
- `mv` : Mover
- `cp` : Copiar
- `cat`: Mostrar contenido de archivo
- `head` y `tail`: Mostrar comienzo o fin de un archivo
- `grep`: Buscar texto en archivo

### Trabajo con texto
- `sort`: Ordenar (usar `sort -n` para números)
- `uniq`: Dejar solo valores únicos
- `wc`: Contar palabras, líneas y letras
- `sed`: Modificar texto
- `awk`: Manipular columnas

### Redirecciones
- `>`: Enviar los prints a un archivo.
- `|`: Redirigir los prints a un comando.
- `<`: Redirigir los contenidos de un archivo a un comando.

## Aliases
A veces un comando se utiliza mucho y tiene sentido resumirlo. Esto se hace
mediante un alias. Por ejemplo quiero un comando que abra `vscode` en un lugar
particular.

```bash
alias eos="code docs/research/thermo/algos/yaeos"
```

Los aliases solo duran durante la sesión de la terminal. Para hacerlos permanentes
es necesario agregarlos al archivo `.bashrc`. El archivo donde se guardan
las configuraciones de la terminal.

```bash
# Se agregan escapes a las comillas
echo alias eos=\"code docs/research/thermo/algos/yaeos\" > ~/.bashrc
```

## Scripts
A veces queremos resumir una secuencia de comandos, no un único comando.
Para esto se puede realizar un script. Un script es un archivo que contiene
una secuencia de comandos a realizar.

```bash
#!/bin/bash
# ~/.local/bin/fortran_project.sh

nombre=$1  # Primer argumento

# Crea una carpeta 
fpm new "$nombre"

# Ir a la nueva carpeta
cd "$nombre"

# Añade configuraciones generales de vscode al proyecto
git submodule add "git@github.com:ipqa-research/vscode-fortran.git" .vscode
```

# Tarea y referencias extra

- [Ejercicios *simples* de terminal](https://linuxjourney.com/lesson/the-shell)
- [Video sobre uso de terminal](https://www.youtube.com/watch?v=W4gE8k2RE_s&t=1581s)
