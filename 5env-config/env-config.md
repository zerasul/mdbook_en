# 5. Environment Configuration

We have already seen the framework or libraries that we are going to use to develop our video games for Sega Mega Drive. However, in order to work more efficiently, we will need to install and configure a series of tools that will help us to speed up the process of creating our game.

In this chapter, we are going to see the tools that can be used when we create not only the code for our game, as well as all the necessary resources for it; such as images, sounds, etc.

The tools that we discuss in this chapter are optional as each developer will have his own tools, but we recommend some of them when creating our home-made game.

We will start talking about the development environment configuration, and then we will focus on other tools such as emulators, or even tools that can be used to handle graphics.

The objective of this chapter is to configure a development environment in a simple way, so we will not focus in detail on how to use each tool, but we will provide links to manuals and resources for each of the tools used, at the end of this chapter.

## Text Editor

When working with source code, we will need to have a text editor that helps us to work with many source files; that can help us to speed up the time it takes to code our game as much as possible.

Although every developer will use different tools, in this book we are going to recommend the text editor _Visual Studio Code_; which we will use in the examples and screenshots that you will see in this book.

### Visual Studio Code

Visual Studio Code[^37] (not to be confused with Visual Studio), is a rich text editor that will allow us to develop our game in a simple way.

This editor has several features such as:

* Syntax highlighting.
* Intelligent auto-completion (using intellisense[^38]).
* Integrated debugging (requires advanced configuration see chapter 16).
* Integration with version control systems (GIT).
* Expandable and modular thanks to the various extensions which can be installed.

Visual Studio Code, has parts of the source code with Mit license; and others have a proprietary license from Microsoft. You can see part of the Visual Studio Code source code in its repository:

[https://github.com/Microsoft/vscode](https://github.com/Microsoft/vscode)

![Visual Studio Code](5config-entorno/img/vscode.png "Visual Studio Code")
_Visual Studio Code_

For those who are not familiar with this text editor, here is a link to the VsCode manual:

[https://code.visualstudio.com/docs](https://code.visualstudio.com/docs)

With Visual Studio code, you can easily develop and extend its functionalities in a very simple way, thanks to the included extensions repository (or even installing them manually).

[^37]: Visual Studio Code is a registered trademark of Microsoft Corporation Ltd.
[^38]: intellisense is a registered trademark of Microsoft Corporation ltd.

In this book, we are going to recommend some of them; although it is only a recommendation; since the ones that the reader likes the most can be used.

* _Official C/C++ extension_: It will allow us to program and activate intellisense for C/C++ programming languages.
* _Amiga Assembly_: Although this book does not focus on the use of assembler, it can be interesting to see the assembler code that you have written with highlighted syntax. In this case, it is about being able to see with the syntax already colored, the assembler for Motorola 68000.
* _Genesis Code_: This book focuses on the use of SGDK; and although we can use SGDK directly through tasks and/or a terminal in the editor itself, it is often quite complicated to configure the environment. Therefore, Genesis Code simplifies the use of SGDK through this editor. In this section, we will focus on this extension.

#### Genesis Code

Genesis Code is an extension for Visual Studio Code, which will allow us to use SGDK and its tools, in a simple way. Genesis Code is open source and has a MIT license. You can find its source code at the following link:

[https://github.com/zerasul/genesis-code](https://github.com/zerasul/genesis-code)

Genesis Code, allows, through a series of commands, to perform different tasks with SGDK; these commands are

* Compile Our Game and Build the ROM.
* Clean the construction files.
* Run our game in an emulator.
* Compile and run our game in an emulator.
* Create a new Project.
* Compile with Debug Options
* Import a file in TMX or Json format to generate a C header file. This command uses the _TILED_ tool format to import maps.

Also, Genesis Code includes other features such as syntax highlighting for SGDK _.res_ resource files, auto-completion for resources or custom image viewer.

If you need more information about Genesis Code, you can consult the Genesis Code documentation:

[https://zerasul.github.io/genesis-code-docs](https://zerasul.github.io/genesis-code-docs)

**Installation**

To install Genesis Code in Visual Studio Code, you can install it through the extensions repository. To do this, click on the 5th icon on the left and search for the extension.

![Genesis Code](5config-entorno/img/genscode.png "Genesis Code")
_Genesis Code Extension_

Once located, click the _install_ button, and the extension will be installed.

It can also be installed manually by downloading the latest version from the project repository:

[https://github.com/zerasul/genesis-code/releases](https://github.com/zerasul/genesis-code/releases)

Once the file with extension _.vsix_ is downloaded, open the Visual Studio Code command console <kbd>ctrl</kbd>+<kbd>Shift</kbd>+<kbd>p</kbd> and look for the option _Extension: Install from vsix..._; select the vsix file and wait for the installation to finish.

**Configuration**

Genesis Code supports the following ways of using SGDK:

* SGDK.
* GENDEV.
* MARSDEV.
* Docker.

Depending on the SGDK installation, we have to configure Genesis Code in one way or another.

To access the Genesis Code configuration, we will access using Visual Studio Code options (File->preferences->settings menú or <kbd>ctrl</kbd>+<kbd>,</kbd>), and look for the Genesis Code options; a screenshot of the options is shown below.

![Genesis Code Configuration](5config-entorno/img/settings.png "Genesis Code Configuration")
_Genesis Code Configuration_

The options available are:

* custom-makefile: Allows to use a custom Makefile to generate the rom. If not specified, it will use the one from the SGDK itself.
* Docker Tag: Specifies the name of the Docker image using SGDK. If not specified, the name _sgdk_ will be used.
* Doragasu Image: Checks that the Docker image used is based on those created by _Doragasu_.
* GDK: Overwrites the _GDK_ environment variable targeting the SGDK installation (Windows only).
* GENDEV: Overwrites the GENDEV environment variable targeting the Gendev installation (Linux only).
* Gens path:Specifies the path to the executable where the emulator to be used is located.
* MARSDEV: Overwrites the MARSDEV environment variable targeting the MarsDev installation.
* Toolchain Type: Indicates the specific toolchain you will use for SGDK; it can have the following values
    * sgdk/gendev: Use SGDK or Gendev (windows or Linux).
    * marsdev: Use MARSDEV as the environment to call SGDK.
    * Docker: Use a Docker container to create the ROM.

## Emulator

When developing our game, it is important to be able to test its progress and although we can use a real hardware using a FlashCart cartridge like _Everdrive_[^39], it is not practical to transfer the ROM every time to the SD card. Therefore, emulators are used to be able to run the created rom and see the results.

In addition, some of these emulators have tools that can help us to debug our games; such as debugging both 68K and z80, VDP graphics viewer, Sprite viewer, etc.

We are going to see a couple of examples of emulators; it is important to emphasize that the reader can use the one that best fits his needs when working on his homebrew project.

Es importante saber, que aunque usemos un emulador, nunca se podrá emular el hardware 100%; por lo que aunque podamos emular el juego, si es interesante poder probarlo en un hardware; es más, a ser posibles en distintos modelos de Mega Drive.

[^39]: Everdrive: es un Cartucho FlashCart con capacidad de poder cargar roms usando una tarjeta SD o MicroSD.

### Gens KMod

Gens, es un emulador de código abierto y gratuito con licencia GPL-2.0, que permite emular Sega Mega drive, Mega CD, 32X e incluso Master System. Este emulador ha tenido muchas versiones comenzando en una versión para el sistema operativo Windows, pero se han hecho muchos ports para distintos otros Sistemas Operativos.

Tiene distintas funcionalidades como puede ser el guardado de estados, soporte para conexión por internet, mejora de audio,etc. Existen distintas versiones como el llamado _gens Plus_ que añade más mejoras como distintos efectos o Shaders.

Para Microsoft Windows, existe una versión modificada, llamada Gens KMod, que añade distintas herramientas para desarrollo; como puede ser:

* Depurador tanto para el Motorola 68000 como Z80.
* Depuración de la memoria
* Visor de Planos
* Visor de Sprites
* Visor de Tiles y paletas (VDP)
* Visor para Sonido YM2612 y PSG

![Gens Kmod](5config-entorno/img/gens.png "Gens KMod")
_Gens Kmod_

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

![Blastem](5config-entorno/img/blastem.png "Blastem")
_Blastem_

Blastem, además, incluye algunas herramientas para desarrollo. Como puede ser el visor de las paletas del VDP o un depurador incluido en el propio emulador; tanto interno, como poder conectar uno externo.

Blastem, se puede descargar para los sistemas operativos más utilizados (Windows, MacOs, Linux...); tanto desde la siguiente dirección, como usando los repositorios de paquetería de algunas distribuciones.

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

![GIMP](5config-entorno/img/GIMP2.png "GIMP")
_GIMP_

Puede descargarse GIMP, desde su página web Oficial:

[https://www.gimp.org/](https://www.gimp.org/)

### Aseprite

A la hora de crear nuestro gráficos, con programas como GIMP, no son muy usable; por eso se utilizan otros programas para poder crear los Sprites o los patrones necesarios para nuestro juego.

Para ello, se utilizan programas como Aseprite el cual es un programa que nos va a permitir crear nuestros sprites y sus animaciones, de forma sencilla.

Además, también nos va a permitir manejar la paleta de colores para nuestros gráficos. Por lo que podremos ver en todo momento los colores que estamos utilizando para crear nuestros gráficos.

Aseprite permite exportar nuestras animaciones de forma sencilla en distintos formatos, o crear un patron que podamos utilizar posteriormente en nuestro juego.

Aseprite no es código abierto, y tiene un coste de 19.99$; el cual se puede adquirir desde su página web.

[https://www.aseprite.org/](https://www.aseprite.org/)

Entre sus muchas características, podemos ver:

* Pre-visualizador de animaciones.
* Gestión de las paletas.
* Creación de Patrones.
* Crear Hojas de Sprites.
* Creación de pinceles personalizados.
* Suavizado de lineas al dibujar.

![Aseprite](5config-entorno/img/asersprite.png "Aseprite")
_Aseprite_

### TILED

Por último, a la hora de crear nuestros juegos, muchas veces necesitaremos herramientas para poder crear nuestros niveles a partir de bibliotecas de elementos gráficos (también llamados TileSets); por ello, podemos recomendar la utilización de la herramienta Tiled.

Esta herramienta de código Abierto, nos va a permitir crear nuestros propios mapas, a partir de distintos elementos gráficos y posteriormente, podremos exportarlo a nuestros juegos.

TILED, tiene una licencia GPL, sin embargo, utiliza distintos componentes que tienen diferentes licencias; para más información, consultar la licencia en el repositorio de TILED.

[https://github.com/mapeditor/tiled/blob/master/COPYING](https://github.com/mapeditor/tiled/blob/master/COPYING)

TILED, nos permite generar mapas multicapa, para poder dibujar nuestros niveles de forma independiente cada capa; de esta forma, podemos añadir muchos más elementos de una forma más cómoda.

Además. TILED permite añadir objetos para poder añadir información a cada nivel y poder gestionarlo dentro de nuestro código fuente.

![TILED](5config-entorno/img/TILED.png "TILED")
_TILED_

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
