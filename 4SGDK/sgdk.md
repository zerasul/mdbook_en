# 4.Sega genesis Development Kit

Hasta ahora, hemos visto que es la Mega Drive y su arquitectura, conociendo cada parte y las funciones que realiza.

Sin embargo, este libro trata sobre desarrollo de software casero (u HomeBrew) para Sega Mega Drive; por lo que vamos a estudiar las herramientas que necesitaremos para ello.

Para desarrollar software para Mega Drive, debemos conocer como funciona el procesador Motorola 68000; además de las direcciones de memoria para acceder a periféricos, vídeo, etc...

Esto era importante en los años 90 cuando se desarrollaba directamente en ensamblador, ya que no se disponía herramientas como compiladores muy avanzados que pudiesen compilar a ensamblador para esta arquitectura de forma eficiente. Por ello, se utilizaba el ensamblador directamente.

Veamos un ejemplo de ensamblador para Motorola 68k:

```asm
    ORG    $0400
START:                  ; first instruction of program

* Put program code here

        movea.w #$600,a0    ;En A0 la dirección inicial
        move.b #$aa,d0      ;En D0 el dato (AA)
bucle   move.b d0,(a0)+     ;Guarda dato e incrementa A0 puntero
        cmpa.w #$700,a0     ;Compara A0 con el final
        bne.s bucle         ;Si no llegó al final salta a bucle
                         

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
```

En el anterior fragmento corresponde a un programa que simplemente implementa un bucle y compara una serie de datos, usando registros del procesador y direcciones de la memoria.

Sin embargo, esto es muy engorroso aunque puede ser muy óptimo el utilizar ensamblador; y el objetivo de este libro es utilizar herramientas más modernas. Por ello, usaremos el lenguaje de programación C.

Además, existe un conjunto de herramientas para poder usar este lenguaje C para Sega Mega Drive. Este conjunto de herramientas, se llama Sega Genesis Development Kit o SGDK.

Sega Genesis Development Kit, es un conjunto de herramientas como un compilador, una librería, herramientas de gestión de recursos, etc. Que nos va a permitir crear software (videojuegos) para Sega Mega Drive. SGDK, es gratuito y su código es libre; está liberado bajo la licencia MIT; excepto el compilador GCC [^26] que incorpora que tiene licencia GPL3.

[^26]: GCC (Gnu Compiler Collection) es un conjunto de compiladores de código abierto que se incorpora en muchas de las distribuciones GNU/Linux.

Este capítulo mostrará tanto la historia, los componentes que se componen y además de ver algunos juegos realizados con SGDK y por supuesto, ya entraremos en materia, instalando el propio SGDK en los Sistemas Operativos más conocidos.

## Historia del SGDK

SGDK, comenzó por el año 2005; y es creado por su principal Autor Stephane Dallongeville; aunque al ser software libre, tiene otros autores que puede consultarse en su repositorio de Github (aunque comenzó en Google Code).

Repositorio SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK)

Durante todos estos años, ha tenido una gran aceptación por la comunidad debido a que facilita mucho el desarrollo de homebrew a los entusiastas de los 16 bits. Además de que hoy en día gracias a este kit, se siguen desarrollando nuevos títulos para esta consola.

La librería que nos provee SGDK, está escrita en C aunque tiene otras herramientas que están escritas en otros lenguajes como Java.

Actualmente (2023), se ha publicado la versión 1.80 que incluye soporte para Mega Wifi [^27], además de otras mejoras como el poder importar ficheros _TMX_ para incluir TileSets y TileMaps generados a partir de la herramienta _Tiled_; veremos esta herramienta en un capítulo más adelante.

[^27]: Mega Wifi, es un cartucho especial que permite conectar a internet a través de Wifi; además de traer una serie de librerías para gestionar la conectividad con la red.

Si quieres conocer más acerca del proyecto, puedes ver su repositorio de Github o incluso ver el Patreon de Stephane Dallongeville para poder contribuir a dicho proyecto.

[https://www.patreon.com/SGDK](https://www.patreon.com/SGDK).

Una vez hemos conocido la historia del SGDK y de que se trata, vamos a mostrar los componentes de este kit de desarrollo.

## Componentes del SGDK

SGDK, se compone de una serie de herramientas que nos van a ayudar a crear nuestros juegos para Sega Mega Drive. En este caso, tanto para realizar la compilación y creación de la ROM, así como la gestión de los recursos del juego.

Los Componentes son:

* Un compilador GCC que nos va a permitir compilar nuestro código a instrucciones para el procesador 68K. La versión actual del GCC que incluye SGDK es 6.30 (Se puede configurar, para usar un compilador más reciente). Además, incluye un depurador _GDB_ que nos va a permitir depurar nuestros juegos (lo veremos más adelante en el capítulo de depuración) Recordamos que tiene una licencia GPL3.
* Una librería _libmd_ con todas las funciones y herramientas que nos permite desarrollar con el lenguaje C para Sega Mega Drive.
* Documentación de la librería: Puede encontrar en la carpeta _doc_, toda la información de las funciones de la librería.
* Un gestor de recursos _rescomp_; que nos va a permitir importar los recursos de nuestro juego (gráficos, sonidos, sprite, etc.).

Veamos cada uno de estos componentes:

### GCC

Este conjunto de compiladores es uno de los más utilizados a la hora de utilizar lenguajes de programación como C o C++. Permite tanto compilar, como posteriormente enlazar y ensamblar el código fuente y generar un binario.

GCC se incluye con la versión 6.3.0 dentro de SGDK, y usando herramientas como make [^28], podemos generar la rom correspondiente.

[^28]: make, es una herramienta para la gestión de dependencias y para construcción de software.

### LibMd

LibMd, es una librería que incorpora SGDK, con una serie de funciones y datos que nos van a permitir crear videojuegos para Sega Mega Drive; incorpora todo lo necesario para manejar el hardware ya sea tanto a manejar los controles, vídeo, sonido, etc.

Está escrita en C y puedes consultar la documentación dentro del propio SGDK, en la carpeta _doc_.

### Rescomp

Rescomp, es una herramienta que nos va a permitir importar todos los recursos de nuestro juego; ya sean gráficos, sprites, sonido,etc.

Esta herramienta está escrita en Java, sin embargo, utiliza otras herramientas ya escritas en otros lenguajes como C.

Rescomp, se basa el leer una serie de ficheros con extensión .res, que tienen definidos una serie de parámetros de los distintos datos necesarios para cada recurso; rescomp, al leer este fichero, generará un fichero .h, e importará los recursos a nuestro juego.

Os dejamos un ejemplo de recurso usado por rescomp:

```res
SPRITE tiovara_sprite "sprt/tiovara.bmp" 4 4 NONE 5 BOX
```

En el anterior ejemplo, se muestra como importar una hoja de sprites que veremos más adelante con más detalle.

## Juegos Realizados con SGDK

Una parte importante de SGDK, es que se utiliza para juegos ya comerciales que puedes encontrar en algunos crowdfunding. En este apartado, vamos a comentar algunos de los más conocidos, y dejaremos algunas direcciones para que podáis aprender más sobre ellos:

### Xeno crisis

Xeno Crisis [^29], es un juego de perspectiva isométrica, que nos permite luchar contra hordas y hordas de Aliens mientras sobrevivimos en distintas habitaciones y zonas.

Permite jugar 2 jugadores en la Sega Mega Drive; aunque también existen ya versiones para Steam (PC), Switch e incluso versiones para Xbox y Playstation. También se trabaja en una versión para Neo-Geo y DreamCast.

Puedes consultar las versiones de este juego en el kickstarter del mismo:
[https://www.kickstarter.com/projects/1676714319/xeno-crisis-a-new-game-for-the-sega-genesis-mega-d/](https://www.kickstarter.com/projects/1676714319/xeno-crisis-a-new-game-for-the-sega-genesis-mega-d/)

[^29]: Xeno Crisis es publicado y desarrollado por el estudio Bitmap Bureau. Todos los derechos Reservados.

### Demons of Asteborg

Demons of Astebord [^30] es un juego para Sega Mega Drive, que tiene una estética de plataformas con movimiento lateral, en el que tiene toques RPG. Este juego esta publicado por Neofid-studios.

En este caso, solo se permite 1 jugador y puede encontrarse tanto la versión de Mega Drive, como en Steam.

Se está trabajando en una versión para Nintendo Switch. Puede encontrarse más información en su página web:

[https://neofid-studios.com/en/home-3/](https://neofid-studios.com/en/home-3/)

[^30]: Demons of Astebord es un juego publicado y desarrollado por neofid-studios. Todos los derechos reservados.

### Metal Dragon

Metal Dragon [^31] es un juego para Sega Mega Drive que tiene una estética de película de acción de los años 80/90; en este juego tienes que rescatar a la hija del presidente y enfrentarte a un sinfin de enemigos.

Este juego es de 1 jugador y hay versión para Sega Mega Drive, como para MSX. Además de ser un estudio Español el que ha desarrollado este juego y recientemente esta publicando su juego en la revista _beep_ para Japón. Además de publicar otros juegos como _Life On mars_ o _Life on Earth_.

[^31]: Metal Dragon ha sido desarrollado por el estudio español Kai Magazine Software. Todos los derechos reservados.

### 1985 World Cup

1985 World cup  [^32] es un juego para Sega Mega Drive que nos permite revivir los grandes títulos de futbol como el  _World Cup Italia 90_. Donde se enfrentarán frente a frente jugadores de todo el mundo.

Este juego permite jugar hasta 2 jugadores en la misma máquina, y además tiene una característica única; tiene integrado el llamado Mega Wi-fi; por que se permite conectar a internet via Wi-fi; y poder jugar en línea; sin necesidad de Modem; solo el propio cartucho.

[^32]: 1985 World cup ha sido publicado por Nape Games. Todos los derechos reservados.

## Instalación del SGDK

Una vez conocidos tanto la historia del SGDK, sus componentes y visto algunos juegos realizados con el mismo, vamos a pasar a dar nuestros primeros pasos.

En este caso, veremos la instalación del mismo en los distintos Sistemas Operativos más conocidos. Es importante destacar que estas instrucciones pueden cambiar en el tiempo desde que se escribió este libro; por lo que siempre es importante leer las instrucciones del propio repositorio.

### Windows

El primer Sistema Operativo que vamos a ver para instalar SGDK, es Microsoft Windows [^33]; en este caso, veremos las distintas instrucciones necesarias para instalar SGDK.

En primer lugar, necesitaremos descargar una serie de dependencias que se requieren para usar SGDK como por ejemplo el entorno de ejecución Java (JRE [^34]) que nos permitirá utilizar las herramientas como rescomp. Puede instalarse tanto la versión de Oracle, como la versión de _openjdk_ [^35]. Dejamos la URL para poder descargar la versión de Java correspondiente:

[https://www.java.com/es/download/](https://www.java.com/es/download/)

Una vez descargadas e instaladas las dependencias, necesitaremos descargar el propio SGDK; que podéis hacer en el apartado de Releases del Repositorio de SGDK:

[https://github.com/Stephane-D/SGDK/releases](https://github.com/Stephane-D/SGDK/releases)

Una vez descargado y descomprimido SGDK, podemos crear la siguiente variable de entorno (Este paso es opcional):

```cmd
GDK = <directorio donde se encuentra SGDK>
```

**NOTA:** Al descargar SGDK, ya trae una versión compilada de _libmd_; sin embargo, si se requiere compilar la librería con el código fuente descargado, podemos hacerlo con la siguiente instrucción:

```cmd
%GDK%\bin\make -f %GDK%\makelib.gen
```

Recuerda que la variable ```GDK``` es opcional y puede sustituirse por la ruta donde esté el SGDK instalado.

Más adelante, veremos como utilizar el SGDK de distintas formas.

[^33]: Microsoft Windows es una marca registrada de Microsoft Corporation.

[^34]: JRE (Java Runtime Environment); entorno de ejecución para poder ejecutar aplicaciones desarrolladas para la máquina virtual Java (JVM).
[^35]: OpenJdk; es una implementación del ecosistema Java de código abierto.

### Linux

SGDK, por defecto, no está compilado para usarse con Linux; sin embargo, existen proyectos como GENDEV que nos permiten utilizar SGDK a partir de dicho conjunto de herramientas.

Puedes encontrar este proyecto en su repositorio de Github:

[https://github.com/kubilus1/gendev](https://github.com/kubilus1/gendev)

Para utilizar este proyecto, necesitaremos instalar una serie de dependencias; las cuales podemos instalar usando el gestor de paquetes de vuestra distribución; para nuestro caso, usaremos una distribución basada en Debian [^36] (Ubuntu).

Necesitarás instalar las siguientes dependencias:

* text-info
* java

Primero actualizaremos el árbol de dependencias:

```bash
sudo apt update
```

En el caso de java, usaremos _openjdk_:

```bash
sudo apt install texinfo default-jre
```

[^36]: Debian y Ubuntu son distribuciones Linux de código abierto. Ubuntu está mantenida por Canonical Ltd.

Una vez instaladas las dependencias, descargaremos el paquete _.deb_ (o el tar); del repositorio de GENDEV. En el caso de instalar usando el paquete .deb, lo instalaremos con la siguiente instrucción:

```bash
sudo dpkg -i <fichero.deb>
```

Si todo va bien, podemos ver que en la dirección ```/opt/gendev``` estarán todos los ficheros.

Por último, necesitaremos crear la variable de entorno ```GENDEV```.

```bash
export GENDEV=/opt/gendev/
```

**NOTA:** Recuerda que si quieres compilar la librería _libmd_ puedes hacerlo con la siguiente instrucción:

```bash
make -f $GEDEV/Makefile
```

Más adelante, veremos en detalle como utilizar SGDK, usando GENDEV.

### MarsDev

Hasta ahora, hemos estado utilizando todas las herramientas que tiene SGDK o GENDEV; sin embargo, a veces es muy complicado mantener todas las herramientas en distintos entornos que son muy heterogéneos.

Por ello, el proyecto MARSDEV, permite tener de forma homogénea la forma de usar SGDK o las distintas herramientas disponibles.

Podéis descargar MarsDev de su repositorio:

[https://github.com/andwn/marsdev](https://github.com/andwn/marsdev)

Una vez descargado, puede usarse una variable de entorno llamada ```$MARSDEV``` que apunta al directorio donde se descargó Marsdev.

Si se requiere más información acerca de cómo instalar MarsDev o de como utilizarlo dejamos enlace a su página de instalación:

[https://github.com/andwn/marsdev/tree/master/doc](https://github.com/andwn/marsdev/tree/master/doc)

### Docker

El uso de contenedores (usando Docker u otra implementación), cada día está más extendido; ya que nos permite configurar un contenedor de tal forma que nos abstrae por parte del software del host y la configuración es mucho más sencilla.

La utilización de Docker, es válida en los tres sistemas Operativos más conocidos (en el caso de macOs; aunque hay otras maneras de utilizar SGDK, muchas están deprecadas).

Si necesita conocer más sobre Docker, recomendamos el libro _Aprender Docker. Un enfoque Práctico_ escrito por _José Juan Sánchez_ (En las referencias de este capítulo puede encontrar un enlace al libro).

Para poder utilizar SGDK con docker, primero necesitaremos generar una imagen con SGDK; por ello utilizaremos un fichero ```Dockerfile``` que nos indicará las instrucciones necesarias para generar la imagen del contenedor.

Para generar la imagen, descargaremos la última versión de SGDK del repositorio del mismo (el mismo paso que para Windows). Una vez hecho esto, ejecutaremos la siguiente instrucción en la carpeta donde se encuentre SGDK:

```bash
docker build -t sgk .
```

Esta instrucción generará la imagen de SGDK con todo lo necesario para crear nuestras ROM Para Mega Drive.

Una vez construida la imagen, si necesitamos crear una rom, podemos hacerlo con la siguiente instrucción:

```bash
docker run --rm -v $PWD:/src/sgdk 
```

**NOTA**: Para sistemas windows cambiar $PWD por %CD%.

Con la instrucción anterior, se compilará y generará la ROM de Mega Drive.

## Referencias

* SGKD: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* SpritesMind Foro: [http://gendev.spritesmind.net/forum/](http://gendev.spritesmind.net/forum/)
* GCC: [https://gcc.gnu.org/](https://gcc.gnu.org/).
* Make: [https://www.gnu.org/software/make/](https://www.gnu.org/software/make/).
* Bitmap Bureau: [https://bitmapbureau.com/](https://bitmapbureau.com/).
* Neofid-Studios: [https://neofid-studios.com/](https://neofid-studios.com/).
* Kai Magazine Software: [https://kai-magazine-software.fwscart.com/](https://kai-magazine-software.fwscart.com/)
* Nape Games: [https://www.napegames.com/](https://www.napegames.com/)
* Open JDK: [https://openjdk.java.net/](https://openjdk.java.net/).
* MarsDev: [https://github.com/andwn/marsdev](https://github.com/andwn/marsdev).
* Docker: [https://www.docker.com/](https://www.docker.com/).
* Aprender Docker. Un enfoque Práctico (Amazon): [https://amzn.to/35M9sCR](https://amzn.to/35M9sCR).
