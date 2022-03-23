# 5. Configurar Entorno de Desarrollo

Ya hemos podido ver, el marco de trabajo o librerías, que vamos a utilizar para desarrollar nuestros videojuegos para Sega Mega Drive. Sin embargo, para poder trabajar de forma más eficiente, necesitaremos instalar y configurar una serie de herramientas que nos ayudaran a acelerar el proceso de creación de nuestro juego.

En este capítulo, vamos a ver las herramientas que se pueden utilizar a la hora de crear no sólo el código de nuestro juego; sino también, todos los recursos necesarios para el mismo; como pueden ser las imágenes, sonidos, etc.

Las herramientas que comentamos en este capítulo, son opcionales ya que cada desarrollador tendrá sus herramientas, pero damos la recomendación de algunas de ellas a la hora de trabajar para crear nuestro juego casero.

Comenzaremos hablando del entorno de desarrollo, y posteriormente nos centraremos en otras herramientas como los emuladores, o incluso herramientas que podemos utilizar para manejar los gráficos.

El objetivo de este capítulo, es configurar un entorno de desarrollo de forma sencilla; por lo que no entraremos en detalle de como utilizar cada herramienta; si que darémos enlaces a manuales y recursos para cada una de las herramientas utilizadas, al final de este capítulo.

## Editor de Texto

A la hora de trabajar con código fuente, necesitaremos tener un editor de texto que nos ayude a la hora de estar con muchos ficheros fuente y que sea rápido y ligero para poder acelerar el máximo el tiempo que tardamos en códificar nuestro juego.

Aunque cada desarrollador utilizará distintas herramientas, en este libro vamos a recomendar el editor de texto _Visual Studio Code_; el cual utilizaremos en los ejemplos y capturas que podrás ver en este libro.

### Visual Studio Code

Visual Studio Code[^35] (no confundir con Visual Studio), es un editor de texto enriquecido que nos va a permitir desarrollar nuestro juego de forma sencilla.

Este editor tiene distintas características como:

* Resaltado de sintaxis.
* Autocompletado inteligente (usando intellisense[^36]).
* Depuración integrada (requiere configuración avanzada ver capítulo 16).
* Integración con sistemas de control de versiones (GIT).
* Ampliable y modularizable gracias a las distintas extensiones que se pueden instalar.

Visual Studio Code, tiene partes del código fuente con licencia Mit; y otras tiene licencia privativa de Microsoft. Puedes ver parte del código fuente de Visual Studio Code en su repositorio:

[https://github.com/Microsoft/vscode](https://github.com/Microsoft/vscode)

<div class="image">
<img id="arq" src="5config-entorno/img/vscode.png" alt="Visual Studio Code" title="Visual Studio Code"/> </div>
<p>Visual Studio Code</p>

Para aquellos que no esten familiarizados con este editor de texto, os dejamos un enlace al manual de VsCode:

[https://code.visualstudio.com/docs](https://code.visualstudio.com/docs)

Con Visual Studio code, se puede desarrollar fácilmente y se pueden ampliar sus funcionalidades de forma muy sencilla, gracias al repositorio de extensiones que incluye (o incluso instalandolas manualmente).

[^35]: Visual Studio Code es una marca registrada de Microsoft Corporation Ltd.
[^36]: intellisense es una marca registrada de Microsoft Corporation ltd.

En este libro, vamos a recomendar algunas de ellas; aunque es solo una recomendación; ya que pueden usarse las que más guste al lector.

* _Extensión oficial de C/C++_: Nos permitirá programar y activar intellisense para los lenguajes de programación C/C++.
* _Amiga Assembly_: Aunque este libro no se centra en el uso de ensamblador, si que puede ser interesante poder ver el código de ensablador que haya escrito con sintaxis resaltada. En este caso, se trata de poder ver con la sintaxis ya coloreada, el ensamblador para Motorola 68000.
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
* Compilar con opciones de depuracion.
* Importar un fichero en formato TMX o Json para generar un fichero cabecera C. Este comando, utiliza el formato de la herramienta _TILED_ para importar mapas.

Además, Genesis Code incluye otras funcionalidades como resaltado de sintaxis para los ficheros de recursos de SGDK _.res_, autocompletado para los recursos o Visor de imágenes personalizado.

Si necesitas más información; acerca de Genesis Code, puedes consultar la documentación de la misma en:

[https://zerasul.github.io/genesis-code-docs](https://zerasul.github.io/genesis-code-docs)

**Instalación**

Para instalar Genesis Code en Visual Studio Code, puede hacerse a través del repositorio de extensiones. Para ello, puslaremos en el 5º icóno de la izquierda y buscaremos la extensión.

<div class="image">
<img id="arq" src="5config-entorno/img/genscode.png" alt="Genesis Code" title="Instalar Genesis Code"/> </div>
<p>Exntesión Genesis Code</p>

Una vez localizada, pulsaremos el botón _install_ (o instalar), y la extensión quedará instalada.

Ademas, puede instalarse manualmente, descargando la última versión del repositorio del proyecto:

[https://github.com/zerasul/genesis-code/releases](https://github.com/zerasul/genesis-code/releases)

Una vez descargado el fichero con extensión _.vsix_, abriremos la consola de comandos de Visual Studio Code <kbd>ctrl</kbd>+<kbd>Mayus</kbd>+<kbd>,</kbd> y buscaremos la opción _Extension: Install from vsix..._; seleccionaremos el fichero vsix y esperaremos que acabe la instalación.

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
* GDK: sobrescribe la variable de entorno GDK apuntando a la instalación de SGDK (solo Windows).
* GENDEV: sobrescribe la variable de entorno GENDEV apuntando a la instalación de Gendev (solo Linux).
* Gens path: Indica la ruta del ejecutable donde se encuentre el emulador que se va a utilizar.
* MARSDEV: sobrescribe la variable de entorno MARSDEV apuntando a la instalación de MarsDev.
* Toolchain Type: Indica el tipo de herramienta que utilizará para usar SGDK; puede tener los siguientes valores:
    * sgdk/gendev: Utiliza SGDK o Gendev (windows o Linux).
    * marsdev: Utiliza MARSDEV como entorno para llamar a SGDK.
    * Docker: Utiliza un contenedor Docker para crear la ROM.

## Emulador

### Gens KMod

### Blastem

## Software de Manipulación Gráfica

### GIMP

### AserSrprite

### TILED

## Referencias