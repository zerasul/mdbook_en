# 3. Arquitectura

Para poder Desarrollar para Mega Drive, necesitamos conocer su arquitectura para poder evitar problemas a la hora de crear nuestros juegos; si conocemos bien como funciona, podemos evitar problemas de memoria, cuellos de botella, etc...

A la hora de trabajar con estos sistemas con pocos recursos, cuanto más conozcamos la arquitectura, mejor podremos optimizar nuestro código y nuestro juego será más ligero. No solo necesitaremos conocer la arquitectura del propio procesador; sino que también es bueno conocer los distintos elementos que podemos encontrar en una Mega Drive.

En este capítulo, vamos a estudiar cada uno de los elementos que componen la Mega Drive y la arquitectura de como se conectan cada uno de ellos, además de sus funciones y características de cada uno de ellos.

Además de cada componente se comentarán sus capacidades y funciones tanto en Modo Mega Drive, como en retrocompatibilidad a la hora de ejecutar juegos de Sega Master System.

Para comprender mejor su arquitectura, vamos a mostrar en primer lugar, un esquema con cada uno de los componentes y como se conectan.

<div class="image">
<img id="arq" src="3Arquitectura/img/arqmegadrive.png" alt="Arquitectura Mega Drive" title="Arquitectura Mega Drive"/> </div>
<p>Arquitectura de una Mega Drive</p>

Como podemos ver en la imagen anterior, La Mega Drive, se compone de una serie de elementos conectados por distintos Buses; uno de 16 bits y otro de 8 bits. Veamos los elementos que se compone:

* CPU Motorola 68000: CPU principal de la Mega Drive
* RAM 64kb: Memoria RAM para programa.
* ROM: Memoria ROM externa (cartucho); se comunica por el slot superior.
* Accesory Port: Puerto Auxiliar de la parte inferior (Mega CD).
* VDP: Chip gráfico de la Mega Drive, compuesto por varios elementos:
    * VDP: Chip con todo lo necesario para los gráficos y elementos a mostrar.
    * PSG: Chip de sonido auxiliar para 8 bits.
* VRAM 64Kb: RAM dedicado al VDP para almacenar los elementos gráficos.
* CPU Z80: Co-Procesador Zilog z80. Encargado de ejecutar los juegos de Sega Master System y orquestar el sonido.
* Sound RAM 8Kb: RAM dedicado al sonido utilizado por el procesador Z80 y los chips de sonido.
* YM6212: Chip de sonido FM, dedicado a dar sonido a la Mega Drive.
* Controlador E/S: Controlador de los controladores y distintos dispositivos externos.
* Árbitro Bus: Controlador de los distintos Bus.

## Motorola 68000

Principal procesador de la Mega drive, el Motorola 68000 (MC68000) es un procesador de 16/32 bits de la familia de CISC; se trata del primer modelo de procesador de la familia m68k capaz de direccionar instrucciones de 32 bits. Recibe su nombre por el número de transistores que contiene. El procesador de la Mega Drive, tiene una frecuencia de 7,61Mhz (PAL) o 7,67Mhz (NTSC).

Este procesador tiene una arquitectura basada en 2 bancos (uno para datos y otro para punteros) de 8 registros de 32 bits; además de tener un contador de programa de 32 bits y un registro de estado de 16 bits. Además de tener un bus externo de 24 bits capaz de direccionar hasta 16MB de memoria.

El Motorola 68K tiene distintos registros separados tanto para trabajar con datos, como con punteros. Siendo este último tipo donde se almacena de forma duplicada el puntero de la pila. Uno en modo usuario, y otro en modo supervisor.

Además de tener dos ALU (sin soporte a coma flotante), para poder trabajar con datos y punteros a la vez.

Otro aspecto importante es que este procesador tiene distintos modos de trabajo (normal, parada y excepción); siendo el último modo, importante ya que permite manejar señales internas y externas (interrupciones); de tal manera que nos ayudará a trabajar con las distintas señales que podemos mandarle.

Este procesador fue utilizado por distintas marcas:

* Apple (Los primeros Macintosh [^12]).
* Atari (Los Atari ST [^13], utilizaban este procesador).
* Commodore (Los ordenadores Amiga [^14] 1000, usaban este procesador).
* SNK (usado por la consola Neo Geo [^15]).

[^12]: Macintosh es una marca Registrada de Apple Inc.
[^13]: Atari ST es una marca Registrada de Atari Interactive.
[^14]: Amiga y Commodore son marcas registradas de Commodore International.
[^15]: Neo Geo es una marca registrada de SNK Corporation.

## Memoria Principal (RAM)

La memoria principal de la Mega Drive o la RAM de programa, tiene una capacidad de 64 Kb (8KB); permite almacenar la información de programa y además se utiliza para mandar la información de la ROM a la VRAM (a través del DMA).

La memoria tiene una capacidad de 16 bits de palabra (2x8bits) de tipo PSRAM [^16], la cual tiene una latencia de 190ns (5.263157 MHz de frecuencia) con una latencia de acceso por parte de la CPU de 200-263 ns. Teniendo un ancho de banda la memoria principal para 16 bit de 10,526314 MB/s.

[^16]: PSRAM (Pseudostatic RAM) es un tipo de memoria RAM que permite tener incluido en su circuitería todo lo necesario para refrescar la memoria y direccionarla.

## Memoria ROM (Cartucho)

La memoria ROM o propiamente dicho el "cartucho", es donde se almacenará la información del juego. Normalmente es un chip de tipo EPROM ó EEPROM (aunque los actuales cartuchos pueden ser Flash), donde se almacena el juego tanto el propio código, como todos los gráficos y recursos del juego.

La lectura de este cartucho, se hace por el slot de la parte superior de la Mega Drive; solo hay que insertar los contactos por la ranura que podemos ver en la parte superior. Normalmente, un cartucho standar, tenía un ancho de banda de 10MB/s (aunque había algunos de 15,20-15,34 MB/s); además de tener en cuenta que el acceso del 68k a la rom normalmente tenia una velocidad de 5MB/s.

El cartucho básico que estamos acostumbrados a ver en Mega Drive, tiene una capacidad de 32Mb (4MB), y además puede tener una pequeña RAM (SRAM) a través de una pila de boton CR2302. Existen cartuchos con más funcionalidades, como el conocido _Sonic & Knuckles_ que tenía la ranura superior Lock On. Además de otros cartuchos con algunas funcionalidades extendidas como puede ser el _Virtua Racing [^17]_; que ampliaba la capacidad de la Mega Drive, gracias a un chip con un DSP [^18] personalizado.

Como hemos dicho, por defecto un cartucho de Mega Drive tiene un tamaño máximo de 32Mb, sin embargo, esto era ampliable añadiendo funcionalidad extra al cartucho, como es el caso del _Street Fighter_ el cual ampliaba el cartucho añadiendo distintos chips y usando un mapper, podia cambiar de banco de memoria ROM. Este "Mapper" conocido como Sega Standar Mapper, ha sido reutilizado en algunos juegos homebrew actuales y permiten ampliar el tamaño disponible.

<div class="image">
<img id="arq" src="3Arquitectura/img/cartuchopcb.png" alt="PCB ROM Mega Drive" title="PCB ROM Mega Drive"/> </div>
<p>Cartucho ROM PCB</p>

[^17]: Virtua Racing es un juego desarrollado por Sega AM2.
[^18]: DSP; procesador digital de señales.

## VDP

El VDP, es el chip gráfico que permite a la Mega Drive, poder mostrar todo su potencial. Se trata de un chip integrado Yamaha YM7101; (junto con el chip de sonido PSG, conforman el circuito integrado Sega-yamaha IC6).

El VDP de la mega drive, es una evolución de su predecesor de la Sega master System. Amplia funcionalidades y aumenta de potencia. El chip VDP tiene una frecuencia de reloj de 13,423294Mhz para NTSC y de 13,300856Mhz para Sistemas PAL [^19].

Estaba conectado a través del un bus de 16 bit al Motorola 68K y permitia distintas resoluciones:

* Modo Normal: 320x224,256x224 para NTSC y 320x224, 256x224, 320x240 y 256x240 para PAL.
* Modo Entrelazado: 320x448,256x448,320x480 y 256x480 que era utilizado por distintos juegos como el modo 2 jugadores de sonic 2.

El VDP tenia capacidad de hasta 4 planos:

* 2 planos para Scroll.
* 1 Plano Ventana (Window).
* 1 plano para Sprites.

Los planos de Scroll (A y B) estaban basados en Tiles (imagenes de 8x8 píxeles) que permitian poder formar distintas imagenes a partir de estos pequeños trozos. Normalmente basados en un TileMap, con un tamaño de hasta 1024x256.

El VDP, también tenía soporte para Sprites, pudiendo almacenar hasta 80 sprites, teniendo 20 sprites por línea, con 16 colores por sprite, teniendo un tamaño máximo de 1280Tiles (combinando distintos Sprites), combinando Sprites de 16 tamaños distintos.

El VDP, podía mostrar hasta 512 colores, mostrando por pantalla entre 61-64 colores. Aunque se podía ampliar utilizando tecnicas de sombreado o resaltado (Shadowing / Highlighting) hasta 1536 en total; con 16 colores (4 bit) por píxel. Además de estar almacenados en 4 paletas de 16 colores.

En cuanto a la memoria, el VDP tenia a su disposición 64KB de RAM de vídeo, el cual permitia tener almacenados bastantes tiles (teniendo en cuenta que esta conectado por un bus de 16 bit a la ROM y con capacidad de usar el DMA). La memoria estaba dividida en:

* 2KB a 8KB para el plano A.
* 2Kb a 8KB para el plano B.
* 2KB a 4KB para el plano Window.
* Hasta 40KB para almacenar Sprites.

Además, el VDP tenia una cache de 232bytes para operaciones.

[^19]: Los Sistemas NTSC y PAL son sistemas de color que se usaban en distintos paises a la hora de mostrar por pantallas CRT normalmente.

## Z80

El z80 o zilog z80, es un procesador de proposito general que fue fabricado por Zilog a partir de 1976 fue diseñado para ordenadores de escritorio y para embebidos.

Este procesador tiene una arquitectura parecida al Intel 8080 ya que fue diseñado por un ex-empleado de Intel. Es un procesador de la familia CISC que tiene una longitud variable de instrucciones; las cuales pueden tener una longitud de entre 1 y 4 bytes. Tiene 20 registros de 8 bit y 4 de 16 bit (PC, SP, IX, IY), además de tener una ALU de 8 bits.

Es el procesador utilizado en muchos dispositivos; como:

* ZX Spectrum de Sinclair [^20].
* Neo Geo Pocket [^21] y Neo Geo Pocket Color.
* Nintendo Game Boy [^22]  usando una versión clonica (GB-Z80).
* Sega Master System y Sega SG-100(con un procesador compatible).

El procesador de la Sega mega Drive, tiene una frecuencia de reloj de 3,579545Mhz(NTSC) y 3,546894Mhz (PAL); conectado a un bus de 8 bits.

Tiene acceso a una memoria de 8KB que se utilizará como RAM de sonido ya que el Z80, se puede utilizar para orquestar el sonido o como co-procesador.

Además el Z80, permite retrocompatibilidad con los juegos de Sega Master System de tal forma que no es necesario un hardware adicional (pero si un adaptador para el slot).

[^20]: Zx Spectrum y Sinclair son marcas registadas de Sinclair Research Ltd.
[^21]: Neo Geo Pocket y Neo Geo Pocket Color son marcas registadas de SNK.
[^22]: Nintendo Game Boy es una marca registada de Nintendo Entertainment ltd.

## PSG

## YM6212

## Controlador E/S

## Puerto Auxiliar (MCD)