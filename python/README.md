### Curso: "Empezar a usar Python bien"


### ADVERTENCIA
Se presume que el lector ha adquirido los conocimientos concernientes al curso
de terminal de este mismo repositorio.


### ¿Qué es este seminario?
Una guía orientativa para la correcta configuración de un entorno de trabajo
con el lenguaje Python, saludable, reproducible y que no nos mate en el
intento; orientada principalmente al sistema operativo Linux o a WSL en
Windows.


### ¿Qué NO es este seminario?
Un curso sobre el lenguaje Python. Se presume que el lector sabe Python o que
será capaz de asimilar los conocimientos sobre el "meta" uso de Python sin
necesidad de saber nada sobre el lenguaje (lo cual sería el mejor acercamiento
al lenguaje nunca antes visto).


### Historia
Wkipedia: 

Python es un lenguaje de alto nivel de programación interpretado cuya filosofía
hace hincapié en la legibilidad de su código, se utiliza para desarrollar
aplicaciones de todo tipo, por ejemplo: Instagram, Netflix, Spotify, Panda3D,
entre otros.2​ Se trata de un lenguaje de programación  multiparadigma, ya que
soporta parcialmente la orientación a objetos, programación imperativa y, en
menor medida, programación funcional. Es un lenguaje interpretado, dinámico y
multiplataforma.

El nombre del lenguaje proviene de la afición de su creador por los humoristas
británicos Monty Python.

Guido van Rossum es el principal autor de Python, y su continuo rol central en
decidir la dirección de Python es reconocido, refiriéndose a él como
Benevolente Dictador Vitalicio (en inglés: Benevolent Dictator for Life, BDFL)

![Guido](./figures/guido.jpg)

    Entonces, ¿qué van a hacer todos ustedes? ¿Crear una democracia? ¿Anarquía?
    ¿Una dictadura? ¿Una federación? -- Guido van Rossum

#### Versiones de Python
Las versiones de Python se encuentran divididas en dos, 2.x y 3.x. La última
versión de Python 2.x es 2.7, la cual ya está descontinuada. La versión más
moderna de Python es 3.12.


### Administrador de paquetes de Python (pip)

![pypi](./figures/pypi.png)

Pip es un sistema de gestión de paquetes utilizado en Python para instalar y
administrar bibliotecas y herramientas adicionales que no forman parte de la
biblioteca estándar de Python. 
    
Con Pip, los usuarios pueden instalar paquetes fácilmente desde el repositorio
PyPI (Python Package Index) o desde archivos locales.

Instalar pip

```shell
    sudo apt update

    sudo apt install python3-pip
```

Checkear la instalacion:

```shell
    pip3 --version
```


### Trabajar en entornos virtuales

Trabajar en entornos virtuales con Python es esencial para garantizar la
estabilidad, la consistencia y la portabilidad de tus proyectos. La falta de
ellos puede llevar a conflictos de dependencias y dificultades en la
colaboración y el mantenimiento a largo plazo.

Ventajas:

- Evita el conflicto de dependencias entre un proyecto y otro.
- Permite reproducir un entorno de trabajo (usar la misma versión de Python y
  misma versión de bibliotecas que se utilizaron en el pasado).
- Evita la pérdida de dependencias por sobrescritura (tan graves como las
  dependencias del sistema operativo).


### ¿Qué es un entorno virtual de Python?

Muchos estarán acostumbrados al concepto de máquina virtual; sin embargo, un
entorno virtual de Python no tiene nada que ver con eso.

Un entorno virtual, o virtual environment, es un intérprete de Python aislado
del intérprete del sistema y de los intérpretes de otros entornos virtuales.
Las bibliotecas instaladas en él son copias específicas para ese entorno.

Por ejemplo, si creamos dos entornos virtuales (ve1 y ve2) con una versión de
Python 3.11 e instalamos la biblioteca NumPy en ambos, estaríamos instalando
dos veces la biblioteca NumPy en nuestro sistema. Estas dos copias de NumPy
instaladas no tienen conocimiento de la existencia de la otra ni tienen
relación entre sí. Esa es la idea...


### ¿Cómo creo entornos virtuales de Python?

Se debe instalar la libreria `virtualenv` y además la librería
`virtualenvwrapper` con el administrador de paquetes de Python, que si bien es
opcional, no hará las cosas mas sencillas.

Desde una terminal:

```shell
    pip install --user virtualenv virtualenvwrapper
```

Editamos el archivo .bashrc añadiendo las lineas:

    export WORKON_HOME="$HOME/.virtualenvs"
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    source $HOME/.local/bin/virtualenvwrapper.sh

Esto permitirá que nuestras terminales puedan utilizar los comandos
proporcionados por `virtualenvwrapper`. No olvides reiniciar la terminal para
que surta efecto.


### Comandos para administrar nuestro entornos

- Crear entorno virtual (make virtual environment)
```shell
    mkvirtualenv nombre_entorno
```

Al crearse el entorno inmediatamente la terminal entrará en el. Esto será
indicado en el prompt de nuestra terminal:

![prompt](./figures/promopt.jpg)


- Salir de un entorno virtual

```shell
    deactivate
```

- Entrar en un entorno virtual
```shell
    workon nombre_entorno
```

- Borrar un entorno virtual (remove virtual environment)
```shell
    rmvirtualenv nombre_entorno
```

- Ver la lista de mis entornos virtuales creados
```shell
    workon
```

Existen funcionalidades más avanzadas de `virtualenv` que por el momento no son
necesarias (por ejemplo, crear un entorno con uan versión de Python especifica)


### Instalar librerías en un entorno

- Creamos un entorno de ejemplo:

```shell
    mkvirtualenv thermo
```

 Corroboramos que estemos dentro del entorno gracias a nuestra prompt o también
podemos hacer:

```shell
    which python3
```

- Instalamos una librería ejemplo que se encuentre en PyPi:

```shell
    pip install ugropy
```

- Para instalar librerías locales
```shell
    pip install path/to/library/directory
```

- Para instalar librerías locales en modo editable
```shell
    pip install -e path/to/library/directory
```

- Instalar librerías a partir de un archivo requirements.txt
```shell
    pip install -r requirements.txt
```

*Ver archivo ejemplo de requirements.txt del seminario

    matplotlib
    pandas == 2.2.0
    thermo >= 0.2.27

- Ver la lista de librerías instaladas en el entorno
```shell
    pip list
```

### Extensión de VScode
![extension](./figures/extension.jpg)