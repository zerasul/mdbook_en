# 4.Sega genesis Development Kit

Hasta ahora, hemos visto que es la Mega Drive y su arquitectura, conociendo cada parte y las funciones que realiza.

Sin embargo, este libro trata sobre desarrollo de software casero (o HomeBrew) para Sega Mega Drive; por lo que vamos a estudiar las herramientas que necesitaremos para ello.

Para desarrollar software para Mega Drive, debemos conocer como funciona el procesador Motorola 68000; además de las direcciones de memoria para acceder a perifericos, vidéo etc...

Esto era importante en los años 90 cuando se desarrollaba directamente en ensamblador ya que no se disponia herramientas como compiladores muy avanzandos que pudiesen compilar a ensamblador para esta arquitectura de forma eficiente. Por ello, se utilizaba el ensamblador directamente.

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

Sin embargo, esto es muy engorroso aunque puede ser muy optimo el utilizar ensamblador; y el objetivo de este libro es usar herramientas más modernas. Por ello, utilizaremos el lenguaje de programación C.

Además, existe un conjunto de herramientas para poder utilizar este lenguaje C para Sega Mega Drive. Este conjunto de herramientas, se llama Sega Genesis Development Kit o SGDK.

Sega Genesis Development Kit, es un conjunto de herramientas como un compilador, una librería, herramientas de gestión de recursos, etc... que nos va a permitir crear software (videojuegos) para Sega Mega Drive. SGDK, es gratuito y su código es libre; esta liberado bajo la licencia MIT; excepto el compilador GCC [^26] que incorpora que tiene licencia GPL3.

[^26]: GCC (Gnu Compiler Collection) es un conjunto de compiladores de código abierto que se incorpora en muchas de las distribuciones GNU/Linux.

Este capítulo, mostrará tanto la historia, los componentes que se componen y además de ver algunos juegos realizados con SGDK y por supuesto, ya entraremos en materia, instalando el propio SGDK en los Sistemas Operativos más conocidos.

## Historia del SGDK

SGDK, comenzó por el año 2005; y es creado por su principal Autor Stephane Dallongeville; aunque al ser software libre, tiene otros autores que puede consultarse en su repositorio de Github (aunque comenzó en Google Code).

Repositorio SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK)

Durante todos estos años, ha tenido una gran aceptación por la comunidad debido a que facilita mucho el desarrollo de homebrew a los entusiastas de los 16 bits. Además de que hoy en día gracias a este kit, se siguen desarrollando nuevos títulos para esta consola.

La librería que nos provee SGDK, esta escrita en C aunque tiene otras herramientas que estan escritas en otros lenguajes como Java.

Actualmente (2022), se ha publicado la versión 1.70 que incluye soporte para Mega Wifi [^27], además de otras mejoras.

[^27]: Mega Wifi, es un cartucho especial que permite conectar a internet a través de Wifi; además de traer una serie de librerías para gestionar la conectividad con la red.

Si quieres conocer más acerca del proyecto, puedes ver su repositorio de Github o incluso ver el Patreon de Stephane Dallongeville para poder contribuir a dicho proyecto.

[https://www.patreon.com/SGDK](https://www.patreon.com/SGDK).

Una vez hemos conocido la historia del SGDK y de que se trata, vamos a mostrar los compoentes que lo componente este kit de desarrollo.

## Componentes del SGDK

SGDK, se compone de una serie de herramientas que nos van a ayudar a crear nuestros juegos para Sega Mega Drive. En este caso, tanto para realizar la compilación y creación de la ROM, asi como la gestión de los recursos del juego.

Los Componentes son:

* Un compilador GCC que nos va a permitir compilar nuestro código a instrucciones para el procesador 68K. La versión actual del GCC que incluye SGDK es 6.30 (Se puede configurar, para usar un compilador más reciente). Además, incluye un depurador _GDB_ que nos va a permitir depurar nuestros juegos (lo veremos más adelante en el capítulo de depuración) Recordamos que tiene una licencia GPL3.
* Una librería _libmd_ con todas las funciones y herramientas que nos permite desarrollar con el lenguaje C para Sega Mega Drive.
* Un gestor de recursos _rescomp_; que nos va a permitir importar los recursos de nuestro juego (gráficos, sonidos, sprite,etc.)

Veamos cada uno de estos componentes:

### GCC

Este conjunto de compiladores es uno de los más utilizados a la hora de utilizar lenguajes de programación como C o C++. Permite tanto compilar, como posteriormente enlazar y ensamblar el código fuente y generar un binario.

Gcc se incluye con la versión 6.3.0 dentro de SGDK, y utilizando herramientas como make [^28], podemos generar la rom correspondiente.

[^28]: make, es una herramienta para la gestión de dependencias y para construcción de software.

### LibMd

LibMd, es una librería que incorpora SGDK, con una serie de funciones y datos que nos van a permitir crear videojuegos para Sega Mega Drive; incopora todo lo necesario para manejar el hardware ya sea tanto a manejar los controles, vídeo, sonido, etc...

Esta escrita en C y puedes consultar la documentación dentro del propio SGDK.

### Rescomp

Rescomp, es una herramienta que nos va a permitir importar todos los recursos de nuestro juego; ya sean gráficos, sprites, sonido,etc...

Esta herramienta esta esta escrita en C, sin embargo, utiliza otras herramientas ya escritas en otros lenguajes como Java.

Rescomp, se basa el leer una serie de ficheros con extension .res, que tienen definidos una serie de parametros de los distintos datos necesarios para cada recurso; rescomp, al leer este fichero, generará un fichero .h, e importará los recursos a nuestro juego.

Os dejamos un ejemplo de recurso usado por rescomp:

```
SPRITE tiovara_sprite "sprt/tiovara.bmp" 4 4 NONE 5 BOX
```

En el anterior ejemplo, se muestra como importar una hoja de sprites que veremos más adelante con más detalle.

## Juegos Realizados con SGDK

Una parte importante de SGDK, es que se utiliza para juegos ya comerciales que puedes encontrar en algunos crownfunding. En este apartado, vamos a comentar algunos de los más conocidos, y dejaremos algunas direcciones para que podáis aprender más sobre ellos:

### Xeno crisis

Xeno Crisis [^29], es un juego de perspectiva isometrica, que nos permite luchar contra hordas y hordas de aliens mientras sobrevivimos en distintas habitaciones y zonas.

Permite jugar 2 jugadores en la Sega Mega Drive; aunque también existen ya versiones para Steam (PC), Swich e incluso versiones para Xbox y Playstation. También se trabaja en una versión para Neo-Geo y DreamCast.

Puedes consultar las versiones de este juego en el kickstarter del mismo:
[https://www.kickstarter.com/projects/1676714319/xeno-crisis-a-new-game-for-the-sega-genesis-mega-d/](https://www.kickstarter.com/projects/1676714319/xeno-crisis-a-new-game-for-the-sega-genesis-mega-d/)

[^29]: Xeno Crisis es publicado y desarrollado por el estudio Bitmap Bureau. Todos los derechos Reservados.

### Demons of Asteborg

Demons of Astebord [^30] es un juego para Sega Mega Drive, que tiene una estetica de plataformas con movimiento lateral, en el que tiene toques RPG. Este juego esta publicado por Neofid-studios.

En este caso, solo se permite 1 jugador y puede encontrarse tanto la versión de Mega Drive, como en Steam.

Se esta trabajando en una versión para Nintendo Switch. Puede encontrarse más información en su página web:

[https://neofid-studios.com/en/home-3/](https://neofid-studios.com/en/home-3/)

[^30]: Demons of Astebord es un juego publicado y desarrollado por neofid-studios. Todos los derechos reservados.

## Instalación del SGDK

Una vez conocidos tanto la historia del SGDK, sus componentes y visto algunos juegos realizados con el mismo, vamos a pasar a dar nuestros primeros pasos.

En este caso, vamos a ver la instalación del mismo en los distintos Sistemas Operativos más conocidos. Es importante destacar que estas instrucciones pueden cambiar en el tiempo desde que se escribió este libro; por lo que siempre es importante leer las instrucciones del propio repositorio.

### Windows

El primer Sistema Operativo que vamos a ver para instalar SGDK, es Microsoft Windows [^31]; en este caso, veremos las distintas instrucciones necesarias para instalar SGDK.

En primer lugar, necesitaremos descargar una serie de dependencias que se requieren para usar SGDK como por ejemplo el entorno de ejecución Java (JRE [^32]) que nos permitirá utilizar las herramientas como rescomp. Puede instalarse tanto la versión de Oracle, como la versión de _openjdk_ [^33]. Dejamos la URL para poder descargar la versión de Java correspondiente:

[https://www.java.com/es/download/](https://www.java.com/es/download/)

Una vez descargadas e instaladas las dependencias, necesitaremos descargar el propio SGDK; que podéis hacer en el apartado de Releases del Repositorio de SGDK:

[https://github.com/Stephane-D/SGDK/releases](https://github.com/Stephane-D/SGDK/releases)

Una vez descargado y descomprimido SGDK, podemos crear la siguiente variable de entorno (Este paso es opcional):

```cmd
GDK = <directorio donde se encuentra SGDK>
```

**NOTA:** Al descargar SGDK, ya trae una versión compilada de _libmd_; sin embargo, si se requiere compilar la librería con los fuentes descargados, podemos hacerlo con la siguiente instrucción:

```cmd
%GDK%\bin\make -f %GDK%\makelib.gen
```

Recuerda que la variable ```GDK``` es opcional y puede sustituirse por la ruta donde este el SGDK instalado.

Más adelante, veremos como utilizar el SGDK de distintas formas.

[^31]: Microsoft Windows es una marca registrada de Microsoft Corporation.

[^32]: JRE (Java Runtime Environment); entorno de ejecución para poder ejecutar aplicaciones desarrolladas para la máquina virtual Java (JVM).
[^33]: OpenJdk; es una implementación del ecosistema Java de código abierto.

### Linux

SGDK, por defecto no esta compilado para usarse con Linux; sin embargo, existen proyectos como GENDEV que nos permiten utilizar SGDK a partir de dicho conjunto de herramientas.

Puedes encontrar este proyecto en su repositorio de Github:

[https://github.com/kubilus1/gendev](https://github.com/kubilus1/gendev)

Para utilizar este proyecto, necesitaremos instalar una serie de dependencias; las cuales podemos instalar usando el gestor de paquetes de vuestra distribución; para nuestro caso, usaremos una distribución basada en debian [^34] (Ubuntu).

Necesitaras instalar las siguientes dependencias:

* text-info
* java

Primero actualizaremos el arbol de dependencias:

```bash
sudo apt update
```

En el caso de java, usaremos _openjdk_:

```bash
sudo apt install texinfo default-jre
```

[^34]: Debian y Ubuntu son distribuciones Linux de código abierto. Ubuntu esta mantenida por Canonical Ltd.

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

Más adelante, veremos en detalle como utilizar SGDK, utilizando GENDEV.

### Macos

### Docker

### MarsDev
