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

## VDP

## VRAM

## Z80

## PSG

## YM6212

## Controlador E/S

## Puerto Auxiliar (MCD)