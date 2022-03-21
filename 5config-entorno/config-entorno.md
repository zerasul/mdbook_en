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

Con Visual Studio code, se puede desarrollar facilmente y se pueden ampliar sus funcionalidades de forma muy sencilla, gracias al repositorio de extensiones que incluye (o incluso instalandolas manualmente).

[^35]: Visual Studio Code es una marca registrada de Microsoft Corporation Ltd.
[^36]: intellisense es una marca registrada de Microsoft Corporation ltd.

En este libro, vamos a recomendar algunas de ellas; aunque es solo una recomendación; ya que pueden usarse las que más guste al lector.

* Extensión oficial de C/C++: Nos permitirá programar y activar intellisense para los lenguajes de programación C/C++.
* Amiga Assembly: Aunque este libro no se centra en el uso de ensamblador, si que puede ser interesante poder ver el código de ensablador que haya escrito con sintaxis resaltada. En este caso, se trata de poder ver con la sintaxis ya coloreada, el ensamblador para Motorola 68000.
* Genesis Code: Este libro se centra en el uso de SGDK; y aunque podemos utilizar directamente SGDK a través de tareas y/o una terminal en el propio editor, suele ser bastante complicado configurar el entorno. Por ello, Genesis Code te simplifica el uso de SGDK a través de este editor. A continuación, nos centraremos en esta extensión.

#### Genesis Code

Genesis Code es una extensión para Visual Studio Code, 

## Emulador

## Software de Manipulación Gráfica

## Referencias