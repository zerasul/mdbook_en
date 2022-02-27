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

Gcc se incluye con la versión 6.3.0 dentro de SGDK, y utilizando herramientas como make[^28], podemos generar la rom correspondiente.

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

En el anterior ejemplo, se muestra como importar una hoja de sprites que veremos más adelante como se realiza.

## Juegos Realizados con SGDK

## Instalación del SGDK

### Windows

### Linux

### Macos

### Docker
