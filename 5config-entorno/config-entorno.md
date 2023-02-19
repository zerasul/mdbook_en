# 5. Configurar Entorno de Desarrollo

Ya hemos podido ver, el marco de trabajo o librerías que vamos a utilizar para desarrollar nuestros videojuegos para Sega Mega Drive. Sin embargo, para poder trabajar de forma más eficiente, necesitaremos instalar y configurar una serie de herramientas que nos ayudaran a acelerar el proceso de creación de nuestro juego.

En este capítulo, vamos a ver las herramientas que se pueden utilizar a la hora de crear no sólo el código de nuestro juego; sino también, todos los recursos necesarios para el mismo; como pueden ser las imágenes, sonidos, etc.

Las herramientas que comentamos en este capítulo, son opcionales ya que cada desarrollador tendrá sus herramientas, pero damos la recomendación de algunas de ellas a la hora de trabajar para crear nuestro juego casero.

Comenzaremos hablando del entorno de desarrollo, y posteriormente nos centraremos en otras herramientas como los emuladores, o incluso herramientas que podemos utilizar para manejar los gráficos.

El objetivo de este capítulo, es configurar un entorno de desarrollo de forma sencilla; por lo que no entraremos en detalle de como utilizar cada herramienta; si que daremos enlaces a manuales y recursos para cada una de las herramientas utilizadas, al final de este capítulo.

## Editor de Texto

A la hora de trabajar con código fuente, necesitaremos tener un editor de texto que nos ayude a la hora de estar con muchos ficheros fuente y que sea rápido y ligero para poder acelerar el máximo el tiempo que tardamos en codificar nuestro juego.

Aunque cada desarrollador utilizará distintas herramientas, en este libro vamos a recomendar el editor de texto _Visual Studio Code_; el cual utilizaremos en los ejemplos y capturas que podrás ver en este libro.

### Visual Studio Code

Visual Studio Code[^37] (no confundir con Visual Studio), es un editor de texto enriquecido que nos va a permitir desarrollar nuestro juego de forma sencilla.

Este editor tiene distintas características como:

* Resaltado de sintaxis.
* Autocompletado inteligente (usando intellisense[^38]).
* Depuración integrada (requiere configuración avanzada ver capítulo 16).
* Integración con sistemas de control de versiones (GIT).
* Ampliable y modularizable gracias a las distintas extensiones que se pueden instalar.

Visual Studio Code, tiene partes del código fuente con licencia Mit; y otras tiene licencia privativa de Microsoft. Puedes ver parte del código fuente de Visual Studio Code en su repositorio:

[https://github.com/Microsoft/vscode](https://github.com/Microsoft/vscode)

<div class="image">
<img id="arq" src="5config-entorno/img/vscode.png" alt="Visual Studio Code" title="Visual Studio Code"/> </div>
<p>Visual Studio Code</p>

Para aquellos que no estén familiarizados con este editor de texto, os dejamos un enlace al manual de VsCode:

[https://code.visualstudio.com/docs](https://code.visualstudio.com/docs)

Con Visual Studio code, se puede desarrollar fácilmente y se pueden ampliar sus funcionalidades de forma muy sencilla, gracias al repositorio de extensiones que incluye (o incluso instalándolas manualmente).

[^37]: Visual Studio Code es una marca registrada de Microsoft Corporation Ltd.
[^38]: intellisense es una marca registrada de Microsoft Corporation ltd.

En este libro, vamos a recomendar algunas de ellas; aunque es solo una recomendación; ya que pueden usarse las que más guste al lector.

* _Extensión oficial de C/C++_: Nos permitirá programar y activar intellisense para los lenguajes de programación C/C++.
* _Amiga Assembly_: Aunque este libro no se centra en el uso de ensamblador, si que puede ser interesante poder ver el código de ensamblador que haya escrito con sintaxis resaltada. En este caso, se trata de poder ver con la sintaxis ya coloreada, el ensamblador para Motorola 68000.
* _Genesis Code_: Este libro se centra en el uso de SGDK; y aunque podemos utilizar directamente SGDK a través de tareas y/o una terminal en el propio editor, suele ser bastante complicado configurar el entorno. Por ello, Genesis Code te simplifica el uso de SGDK a través de este editor. A continuación, nos centraremos en esta extensión.

#### Genesis Code

Genesis Code es una extensión para Visual Studio Code, que nos permitirá utilizar SGDK y sus herramientas, de forma sencilla. Genesis Code es código abierto y tiene una licencia MIT. Puedes encontrar su código fuente en la siguiente dirección:

[https://github.com/zerasul/genesis-code](https://github.com/zerasul/genesis-code)

Genesis Code, permite a partir de una serie de comandos, realizar distintas tareas con SGDK; estos comandos son:

* Compilar Nuestro Juego y Construir la ROM.
* Limpiar los ficheros de construcción.
* Ejecutar nuestro juego en un emulador.
* Compilar y ejecutar nuestro juego en un emulador.
* Crear un nuevo Proyecto.
* Compilar con opciones de depuración.
* Importar un fichero en formato TMX o Json para generar un fichero cabecera C. Este comando, utiliza el formato de la herramienta _TILED_ para importar mapas.

Además, Genesis Code incluye otras funcionalidades como resaltado de sintaxis para los ficheros de recursos de SGDK _.res_, autocompletado para los recursos o Visor de imágenes personalizado.

Si necesitas más información; acerca de Genesis Code, puedes consultar la documentación de la misma en:

[https://zerasul.github.io/genesis-code-docs](https://zerasul.github.io/genesis-code-docs)

**Instalación**

Para instalar Genesis Code en Visual Studio Code, puede hacerse a través del repositorio de extensiones. Para ello, pulsaremos en el 5º icono de la izquierda y buscaremos la extensión.

<div class="image">
<img id="arq" src="5config-entorno/img/genscode.png" alt="Genesis Code" title="Instalar Genesis Code"/> </div>
<p>Extensión Genesis Code</p>

Una vez localizada, pulsaremos el botón _install_ (o instalar), y la extensión quedará instalada.

Ademas, puede instalarse manualmente, descargando la última versión del repositorio del proyecto:

[https://github.com/zerasul/genesis-code/releases](https://github.com/zerasul/genesis-code/releases)

Una vez descargado el fichero con extensión _.vsix_, abriremos la consola de comandos de Visual Studio Code <kbd>ctrl</kbd>+<kbd>Mayus</kbd>+<kbd>p</kbd> y buscaremos la opción _Extension: Install from vsix..._; seleccionaremos el fichero vsix y esperaremos que acabe la instalación.

**Configuración**

Genesis Code, es compatible con las siguientes formas de utilizar SGDK:

* SGDK.
* GENDEV.
* MARSDEV.
* Docker.

Dependiendo de la instalación que tengamos de SGDK, tenemos que configurar Genesis Code de una forma u otra.

Para acceder a la configuración de Genesis Code, accederemos a las opciones de Visual Studio Code (menú File->preferences->settings o <kbd>ctrl</kbd>+<kbd>,</kbd>), y buscaremos las opciones de Genesis Code; las cuales mostramos una captura a continuación.

<div class="image">
<img id="arq" src="5config-entorno/img/settings.png" alt="Configuración Genesis Code" title="Configuración Genesis Code"/> </div>
<p>Configuración Genesis Code</p>

Las opciones disponibles son:

* custom-makefile: Permite usar un fichero MakeFile personalizado para generar la rom. Si no se especifica, utilizará el del propio SGDK.
* Docker Tag: Indica el nombre de la imagen Docker con SGDK. Si no se indica, se utilizará el nombre de _sgdk_.
* Doragasu Image: Comprueba que la imagen Docker utilizada esta basada en las creadas por _Doragasu_.
* GDK: sobrescribe la variable de entorno GDK apuntando a la instalación de SGDK (solo Windows).
* GENDEV: sobrescribe la variable de entorno GENDEV apuntando a la instalación de Gendev (solo Linux).
* Gens path: Indica la ruta del ejecutable donde se encuentre el emulador que se va a utilizar.
* MARSDEV: sobrescribe la variable de entorno MARSDEV apuntando a la instalación de MarsDev.
* Toolchain Type: Indica el tipo de herramienta que utilizará para usar SGDK; puede tener los siguientes valores:
    * sgdk/gendev: Utiliza SGDK o Gendev (windows o Linux).
    * marsdev: Utiliza MARSDEV como entorno para llamar a SGDK.
    * Docker: Utiliza un contenedor Docker para crear la ROM.

## Emulador

A la hora de desarrollar nuestro juego, es importante poder probar el progreso de este y aunque podemos usar un hardware real usando un cartucho FlashCart como _Everdrive_[^39], no es nada práctico, tener que estar transfiriendo la ROM cada vez a la tarjeta SD. Por ello, se utilizan emuladores para poder ejecutar la rom creada y ver los resultados.

Además, algunos de estos emuladores tienen herramientas que nos pueden ayudar a depurar nuestros juegos; como depuración tanto del 68K como del z80, visor de los gráficos en el VDP, visor de Planos o Sprites,etc.

Vamos a ver un par de ejemplos de emulador; es importante destacar que el lector, puede usar con el que mejor se maneje cuando este trabajando en su proyecto homebrew.

Es importante saber, que aunque usemos un emulador, nunca se podrá emular el hardware 100%; por lo que aunque podamos emular el juego, si es interesante poder probarlo en un hardware; es más, a ser posibles en distintos modelos de Mega Drive.

[^39]: Everdrive: es un Cartucho FlashCart con capacidad de poder cargar roms usando una tarjeta SD o MicroSD.

### Gens KMod

Gens, es un emulador de código abierto y gratuito con licencia GPL-2.0, que permite emular Sega Mega drive, Mega CD, 32X e incluso Master System. Este emulador ha tenido muchas versiones comenzando en una versión para el sistema operativo Windows, pero se han hecho muchos ports para distintos otros Sistemas Operativos.

Tiene distintas funcionalidades como puede ser el guardado de estados, soporte para conexión por internet, mejora de audio,etc. Existen distintas versiones como el llamado _gens Plus_ que añade más mejoras como distintos efectos o Shaders.

Para Microsoft Windows, existe una versión modificada, llamada Gens KMod, que añade distintas herramientas para desarrollo; como puede ser:

* depurador tanto para el Motorola 68000 como Z80.
* Depuración de la memoria
* Visor de Planos
* Visor de Sprites
* Visor de Tiles y paletas (VDP)
* Visor para Sonido YM2612 y PSG

<div class="image">
<img id="arq" src="5config-entorno/img/gens.png" alt="Gens KMod" title="Gens KMod"/> </div>
<p>Gens Kmod</p>

Puede descargarse de la siguiente dirección:

[https://segaretro.org/Gens_KMod](https://segaretro.org/Gens_KMod)

Para poder utilizarlo para nuestro desarrollo, si se tiene la extensión Genesis Code, Puede configurarlo para desarrollar; para ello, puede hacerlo de dos formas:

La primera es usar el comando _Genesis Code: set Gens Emulator Command Path_ que provee la extensión y añadir la ruta al fichero _gens.exe_ para poder ejecutar el comando.

La otra forma, es a partir de la configuración de Genesis Code podemos añadir la ruta de donde se encuentra el ejecutable del emulador.

### Blastem

Otro emulador conocido, es _Blastem_; este emulador, permite emular con bastante precisión, el hardware de la Mega Drive; además de tener una serie de herramientas como el visor de las paletas y colores del VDP. Blastem es Software libre bajo la licencia GNU GPL v3.

Este emulador tiene las siguientes características:

* Guardado y Carga de estados.
* Depurador Integrado y posibilidad de conectarlo a un depurador remoto.
* Soporte para Controlador (Joystick).
* Emulación de Mega/Sega Mouse.
* Soporte para teclado Saturn.
* Soporte para Lock con de Sonic & Knuckles y algunos mappers como Sega Standard Mapper.
* Soporte para mappers de distintos juegos Homebrew.
* Soporte para SRAM y EEPROM.
* Soporte para Shaders y otros filtros.

<div class="image">
<img id="arq" src="5config-entorno/img/blastem.png" alt="Blastem" title="Blastem"/> </div>
<p>Blastem</p>

Blastem, además, incluye algunas herramientas para desarrollo. Como puede ser el visor de las paletas del VDP o un depurador incluido en el propio emulador; tanto interno, como poder conectar uno externo.

Blastem, se puede descargar para los sistemas operativos más utilizados (Windows, MacOs, Linux...); tanto desde la siguiente dirección, como usando los repositorios de paquetería de algunas de nuestras distribuciones.

[https://www.retrodev.com/blastem/](https://www.retrodev.com/blastem/)

Al igual que con Gens, Blastem puede usarse con la extensión _Genesis Code_; por lo que pueden seguirse los mismos pasos descritos para configurarlo.

## Software de Manipulación Gráfica

A la hora de trabajar en un videojuego, es igualmente importante trabajar el código fuente del juego, como de los recursos que se van a utilizar (gráficos, sonido, mapas,etc.); por ello, vamos a revisar algunas herramientas que podemos utilizar para crear todos estos recursos.

### GIMP

GIMP (Gnu Image Manipulation Program), es un programa de edición de imágenes en forma de mapa de bits; este programa es de código abierto y tiene una licencia GPLv3.

La primera versión de este programa salió en el año 1995 en la universidad de Berkley; y desde entonces se ha convertido en parte del proyecto GNU [^40]. GIMP, nos va a ayudar a modificar las imagenes para poder usarlas en nuestros proyectos.

[^40]: Proyecto GNU: [https://www.gnu.org/home.es.html](https://www.gnu.org/home.es.html)

Permite modificar imágenes digitalizadas a través de sus muchas herramientas que trae integrado como pueden ser recortar, escalar, modificar las propiedades de la imagen (reordenar la paleta). GIMP, es compatible con muchos formatos de imágenes (BMP, PNG, JPG, TIFF, PSD); por lo que puede ser una buena herramienta para convertir en los formatos que necesitemos.

Además de las herramientas que trae integradas, se pueden añadir más herramientas gracias a la extensiones de este programa.

<div class="image">
<img id="arq" src="5config-entorno/img/GIMP2.png" alt="GIMP" title="GIMP"/> </div>
<p>GIMP</p>

Puede descargarse GIMP, desde su página web Oficial:

[https://www.gimp.org/](https://www.gimp.org/)

### Aseprite

A la hora de crear nuestro gráficos, con programas como GIMP, no son muy usables; por eso se utilizan otros programas para poder crear los Sprites o los patrones necesarios para nuestro juego.

Para ello, se utilizan programas como Aseprite el cual es un programa que nos va a permitir crear nuestros sprites y sus animaciones, de forma sencilla.

Además, también nos va a permitir manejar la paleta de colores para nuestros gráficos. Por lo que podremos ver en todo momento los colores que estamos utilizando para crear nuestros gráficos.

Además, Aseprite permite exportar nuestras animaciones de forma sencilla en distintos formatos, o crear un patron que podamos utilizar posteriormente en nuestro juego.

Aseprite no es código abierto, y tiene un coste de 19.99$; el cual se puede adquirir desde su página web.

[https://www.aseprite.org/](https://www.aseprite.org/)

Entre sus muchas características, podemos ver:

* Pre-visualizador de animaciones.
* Gestión de las paletas.
* Creación de Patrones.
* Crear Hojas de Sprites.
* Creación de pinceles personalizados.
* Suavizado de lineas al dibujar.

<div class="image">
<img id="arq" src="5config-entorno/img/asersprite.png" alt="Aseprite" title="Aseprite"/> </div>
<p>Aseprite</p>

### TILED

Por último, a la hora de crear nuestros juegos, muchas veces necesitaremos herramientas para poder crear nuestros niveles a partir de bibliotecas de elementos gráficos (también llamados TileSets); por ello, podemos recomendar la utilización de la herramienta Tiled.

Esta herramienta de código Abierto, nos va a permitir crear nuestros propios mapas, a partir de distintos elementos gráficos y posteriormente, podremos exportarlo a nuestros juegos.

TILED, tiene una licencia GPL, sin embargo, utiliza distintos componentes que tienen diferentes licencias; para más información, consultar la licencia en el repositorio de TILED.

[https://github.com/mapeditor/tiled/blob/master/COPYING](https://github.com/mapeditor/tiled/blob/master/COPYING)

TILED, nos permite generar mapas multicapa, para poder dibujar nuestros niveles de forma independiente cada capa; de esta forma, podemos añadir muchos más elementos de una forma más cómoda.

Además. TILED permite añadir objetos para poder añadir información a cada nivel y poder gestionarlo dentro de nuestro código fuente.

<div class="image">
<img id="arq" src="5config-entorno/img/TILED.png" alt="TILED" title="TILED"/> </div>
<p>TILED</p>

Si utiliza la extensión _Genesis Code_, puede exportar los datos de cada mapa a un fichero .h para utilizarlo en nuestros juegos. Veremos más adelante su uso en el capítulo 12.

Podemos descargar TILED, desde su página web oficial:

[https://www.mapeditor.org/](https://www.mapeditor.org/)

## Referencias

* Visual Studio Code: [https://code.visualstudio.com/](https://code.visualstudio.com/)
* Extensión Genesis Code: [https://marketplace.visualstudio.com/items?itemName=zerasul.genesis-code](https://marketplace.visualstudio.com/items?itemName=zerasul.genesis-code)
* Documentación Genesis Code: [https://zerasul.github.io/genesis-code-docs](https://zerasul.github.io/genesis-code-docs)
* Emulador Gens: [http://www.gens.me/](http://www.gens.me/)
* Gens KMod: [https://segaretro.org/Gens_KMod](https://segaretro.org/Gens_KMod)
* Blastem: [https://www.retrodev.com/blastem/](https://www.retrodev.com/blastem/)
* Gimp: [https://www.gimp.org/](https://www.gimp.org/)
* Aseprite: [https://www.aseprite.org/](https://www.aseprite.org/)
* Blog sobre Aseprite: [https://elmundodeubuntu.blogspot.com/2015/11/aseprite-editor-de-sprites.html](https://elmundodeubuntu.blogspot.com/2015/11/aseprite-editor-de-sprites.html)
* Tiled: [https://www.mapeditor.org/](https://www.mapeditor.org/)
