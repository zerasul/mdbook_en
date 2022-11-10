# 14. Música y Sonido

Hasta ahora hemos estado trabajando principalmente con la parte visual; como mostrar fondos, sprites, colores ,fondos,etc. Pero un juego no esta completo si no tiene su sonido; tanto los efectos de sonido, como la música que nos haga mejorar la experiencia de juego.

Por ello, es importante conocer como añadir sonido a nuestro juego; desde los distintos efectos como el ataque, voz del personaje o incluso algún efecto más sofisticado, es importante poder añadirlos y disfrutarlos una vez nuestro juego esta en marcha.

No podemos olvidar la música; ya que para muchos la banda sonora de juegos de Mega Drive, ha sidno nuestra infancia y hoy en día solo con escuchar un par de acordes, ya nos transporta a aquella época. De ahí la gran importancia de la música en un videojuego.

En este capítulo, vamos a mostrar como la Mega Drive es capaz de reproducir sonido e incluso música y como podemos añadirla a nuestro juego y tener una mejor experiencia del mismo.

Comezaremos hablando del sistema de sonido que trae la Sega Mega Drive, y como funcionan los distintos elementos que la componen. Además, hablaremos de como se puede crear esta música y por último, veremos algún ejemplo de como añadir música y sonido a nuestros juegos, usando SGDK.

## Sistema de Sonido de la Sega Mega Drive

Comenzaremos hablando del Sistema de Sonido de la Sega Mega Drive; como hemos podido ver en el capítulo de la arquitectura, Sega Mega Drive, dispone de dos chips de sonido:

* Chip Yamaha YM2612; con sonido FM[^57] (6 canales).
* Chip PSG (SN76496); sonido 8 bits con capacidad de emitir 3 ondas de pulso y 1 canal de ruido. Esta dentro del VDP.

Estos dos chips, son orquestados por el procesador Zilog z80; este es quien envia o recibe la información del sonido, ayudandose de la Ram de sonido (8Kb); a través del bus de 8 bits que conecta ambos chips.

[^57]: Sonido FM; se refiere al sonido generado a través de la variación de su frencuencia; de tal forma que se genera una señal variando dicha frecuencia.

### Yamaha 2612

Comenzaremos hablando del Yamaha YM2612; el cual es el chip encargado principalmente de emitir sonido FM o samples, de tal forma que tenemos hasta 6 canales para reproducir música o sonido.

Permite emitir hasta 5 señales FM a la vez, y una de samples aunque hay que tener cuidado a la hora de mezclar estas señales. Es importante, que a la hora de trabajar con este chip, no se creen cuellos de botella a la hora de mezclar los sonidos o incluso que se mezclen erroneamente.


### PSG

Además del chip de sonido Yamaha YM2612, La Sega Mega Drive, tiene un chip de sonido para sonido 8 bits gracias al chip SN76496 de Texas Instruments[^58] ,  permite emitir sonido por varios canales y además, de ser el chip utilizado para emitir sonido en modo Retrocompatibilidad (Master System).

[^58]: Texas Instruments es una marca Registrada. Todos los derechos reservados.

Este chip permite emitir sonido por 4 canales; 3 para generación de ondas (tonos), y otro para ruido (noise). Este chip esta incluido dentro del propip VDP, y permite ser utilizado junto al YM2612 como sistema de sonido para la Sega Mega Drive.

### Z80

Hemos visto los dos chips de sonido que provee la Sega Mega Drive; sin embargo, por ellos mismos no se podrían utilizar; ya que necesitan el procesador Zilog Z80, para poder ser orquestado.

Este procesador de 8 bits, tiene dos funcionalidades; la primera, dar soporte al sistema de sonido junto a 8 Kb de RAM, para orquestar los chips de sonido. Por otro lado, en modo retrocompatibilidad, Es el procesador principal para los juegos de Sega Master System.

Es importante conocer este procesador, ya que a la hora de trabajar con el sonido, hay que programar este a diferencia del resto de componentes, que suelen utilizar más el procesador Motorola 68000; por ello, es complicado el uso de sonido en Sega Mega Drive.

## Driver de sonido

Como hemos estado hablando, el sistema de sonido, se compone de los dos chips (Yamaha y PSG), que son orquestados por el procesador Zilog Z80; por ello, es necesario enviar la información a este procesador, y que reproduzca las distintas instrucciones para que los chips emitan el sonido pertinente.

Esto requiere conocer y programar el procesador Zilog Z80, normalmente esta programación no se hace como estamos acostumbrados en este libro con el lenguaje de programación C. Sino que se utiliza lenguaje ensamblador para el Z80.

```asm
printc:                        ; Routine to print C register as ASCII decimal
 ld a,c
 call dtoa2d                   ; Split A register into D and E

 ld a,d                        ; Print first digit in D
 cp '0'                        ; Don't bother printing leading 0
 jr z,printc2
 rst 16                        ; Spectrum: Print the character in 'A'
```

En el fragmento anterior, vemos un poco de ensamblador para el z80 (en este caso, es para ZX Sepectrum); la creación de un programa para el Z80 para orquestar los chips de sonido, es lo que comunmente se llama Driver de sonido.

Existen varias implementaciones de Drivers para sonido para Sega Mega Drive; como puede ser GEMS [^59], MUCOM88 [^60], 4PCM o XGM. Cada uno ha sido utilizado en varios juegos y utilizado para componenr música ya que traian herramientas para ello, como un tracker [^61] para componer.

[^59]: GEMS (Genesis Editor for Music and Sound effects), es un driver de sonido para Sega Mega Drive desarrollado por Recreational Brainware. 
[^60]: MUCOM88, es un driver de sonido desarrollado por Yuzo Koshiro, considerado uno de los mayores compositores de música para videojuegos (compositor de la Banda sonora de Streets of Rage).
[^61]: Music Tracker, es un secuenciador para componer música de forma electrónica; ya sea con un sintetizador, o con un programa de ordenador.

### XGM

Aunque hemos nombrado varios Drivers, vamos a centrarnos en el Driver _XGM_; este driver es uno de los utilizados por SGDK, y que viene por defecto. Aunque podemos utilizar otros, en este caso, solo vamos a centrarnos en este Driver. Fue desarrollado para usarse integramente con el procesador z80; por lo que podemos utilizar el Motorola 68000 para otros usos. Ha sido desarrollado para usarse con el SGDK ya que ha sido hecho por el propio Stephane Dallongeville (el propio autor de SGDK).

Entre sus características, tiene:

* Solo usa Z80.
* desarrollado solo para minimizar que la CPU tenga que decodificar el sonido.
* Permite enviar sonido FM y PSG a la vez, utilizando los canales tanto para enviar sonido o los distintos samples; pudiendo llegar hasta 13 canales de sonido (5FM + 4PCM + 4PSG).
* Permite reproducir efectos de sonido en formato PCM con 16 niveles de prioridad; esto es útil a la hora de trabajar con distintas fuentes.

Es importante conocer, que se esta trabajando en una segunda versión de este Driver; el XGM2. Este driver incluye mejoras con respecto a la anterior versión ya que tenia bastantes problemas a la hora de compilar y generar los ficheros binarios; ya que consumian mucho espacio en la ROM (20/25% de la ROM podía ser la música). Por ello Stef, esta trabajando en esta nueva versión que esperemos este pronto disponible.

## Crear música y Sonido

Hemos estado hablando de los Drivers que son los encargados de dar las instrucciones al procesador Z80 para orquestar los distintos chips de sonido; pero otro aspecto muy importante, es hablar sobre como podemos crear la música de nuestro juego. Para ello, se suelen utilizar Trackers o secuencisadores, para crear las distintas instrucciones que después el Driver leerá y procederá a ejecutar en los chips de sonido.

Aunque muchos Drivers ya tenian integrados algunos editores, como el _GEMS_ o el _MUCOM88_. Hoy en día se utilizan programas más modernos y sofisticados para poder crear la música en nuestro ordenador de forma mucho más sencilla.

### Deflemask

En este libro, comentaremos el uso de Deflemask; que es uno de los más utilizados. Este programa, nos va a permitir crear nuestra música y exportarlo a los distintos sistemas; entre sus características tiene:

* Emulación en tiempo real de los distintos Chips de sonido (entre ellos el yamaha).
* Soporte para dispositivos MIDI [^62].
* Soporte para generación de ROMS.
* Uso del formato VGM [^63] como salida.

[^62]: MIDI; estándar tecnológico que describe un protocolo, interfaz y conectores para poder utilizar instrumentos musicales para que se comuniquen con el ordenador. 
[^63]: VGM; formato de audio de música para distintos dispositivos; pensado principalmente para videojuegos.

Este programa no es Software libre y tiene un coste de 9,99$; es uno de los más utilizadas para este tema, por lo que no es para nada un mal precio. Además de que hay muchisimos tutoriales por internet acerca de este software para creación musical.

<div class="image">
<img id="arq" src="14sonido/img/deflemask.png" alt="Deflemask" title="Deflemask"/> </div>
<p>Deflemask</p>

## Ejemplo con música y Sonido

Tras ver como se compone el sistema de sonido; los Drivers y como crear el sonido, vamos a crear un ejemplo, en el que podamos reproducir distintos sonidos y música en función de los distintos botones que pulsemos. Este ejemplo, lo puedes encontrar en el repositorio de ejemplos que acompaña a este libro. Este ejemplo corresponde a la carpeta _ej15.musicandsound_; donde podemos encontrar tanto el código como los recursos.

En primer lugar, vamos a mostrar como se puede importar los recursos de música o los efectos de sonido; utilizando la herramienta de _rescomp_ la cual es la encargada de leer los ficheros y pasarlos a binario. Tenemos que diferenciar, que los archivos con música estan en formato VGM, mientras que los ficheros con efectos de sonido, tienen formato WAV.

Comenzaremos mostrando como se puede importar un fichero VGM para utilizarlo con el driver XGM.

```res
XGM name "file" timing options
```

Donde:

* _name_: Nombre del recurso para referenciarlo.
* _file_: Ruta dentro de la carpeta _res_ al fichero que contiene la música.
* _timing_: Indica el tempo a cargar; dependiendo del tipo de sistema puede tener el siguiente valor:
    * -1/AUTO: (NTSC o PAL dependiendo de la información almacenada en el VGM).
    * 0/NTSC: Indica que el sistema será NTSC.
    * 1/PAL: Indica que el sistema será PAL.
* _options_: parámetros adicionales para la herramienta de parseo.

Como has podido ver, se le pueden pasar más parámetros adicionales para la herramienta _xgmtool_; esta herramienta es la que se utiliza para pasar del fichero VGM, a binario. Si necesitas más información sobre xgmtool, puedes consultar la documentación de SGDK.

Si por otro lado queremos importar un fichero con un efecto de sonido, podemos importar un fichero Wav; con dicho sonido. Vamos a ver como podemos importar un fichero Wav usando _rescomp_.

```res
WAV name wav-file driver out-rate far
```

Donde:

* _name_: Nombre del recursos para referenciarlo.
* _wav-file_: Ruta del fichero wav dentro de la carpeta res.
* _driver_: Driver de sonido a utilizar; puede ser:
    * 0/PCM: Driver de 1 solo canal de 8 bits.
    * 1/2/2ADPCM: Driver de 2 canales a 4 bits.
    * 3/4/4PCM: 4 canales a 8 bits.
    * 5/6/XGM: 4 canales con 8 bits.
* _out-rate_: Rate de salida para decodificar la salida. Solo utilizado para Z80_DRIVER_PCM.
* _far_: Parámetro adicional para añadir información al final de la ROM (usado para Bank-switch).

Una vez hemos podido ver como se pueden importar cada uno de los recursos, vamos a mostrar que recursos de sonido vamos a importar en este ejemplo:

```res
XGM music1 "music/infiltration_phase.vgm" AUTO
XGM music2 "music/guaguas2.vgm" AUTO
WAV sound1 "sound/Explosion2.wav" XGM 
WAV sound2 "sound/Jump4.wav" XGM 
WAV sound3 "sound/Teleport4.wav" XGM
```

Donde podemos comprobar que importamos 2 ficheros vgm, y tres efectos de audio. Puedes consultar el resto de recursos importados en la propia carpeta _res_ del ejemplo.

Una vez importados los recursos, ya podemos centrarnos en el código; este juego realizará las siguientes acciones:

* Botón A: Reproduce la música 1.
* Botón B: Reproduce la música 2.
* Botón C: Reproduce el efecto de sonido actual.
* Botón Start: Para de reproducir Sonido.
* Botón Izquierda: Selecciona el anterior efecto de sonido.
* Botón derecha: Selecciona el siguiente efecto de sonido.

Teniendo esto en cuenta, vamos a proceder a mostrar parte del código fuente:

```c
u8 sound;
const u8* sounds[3];
```

Estas dos variables globales, las usaremos para referenciar que sonido hemos recolectado y almacenar la información de los efectos de sonido.

```c
sound=1;
sounds[0]=sound1;
sounds[1]=sound2;
sounds[2]=sound3;
```

Como podemos ver se ha inicializado los tres efectos de sonido y se ha establecido la variable a 1. De tal forma que cargaremos el primer sonido por defecto.

Tras ver las variables globales y como las vamos a inicializar, pasaremos a revisar la función ```inputHandler```; la cual es la encargada de gestionar cada vez que pulsamos un botón en el controlador. Vamos a revisar esta función:

```c
void inputHandler(u16 joy, u16 changed, u16 state){

    if(joy == JOY_1){
...
```

Recordamos que esta función obtendrá los valores de los botones que se han pulsado; de esta forma, podemos comprobar una a una que botones estan pulsados y realizar cada acción; vamos a ver que ocurre en cada botón:

```c
if(changed & state & BUTTON_A){

    if(XGM_isPlaying()){
        XGM_stopPlay();
    }
    XGM_startPlay(music1);         
}
```

Al pulsar el botón A, se va a parar la música anterior y se volverá a reproducir la primera melodia. Como puedes ver, se utilizan varias funciones que son propias del uso del dirver XGM. Veamos estas funciones.

La función ```XGM_isPlaying```, devuelve distinto de cero si el driver XGM, esta reproduciendo una canción.

La función ```XGM_stopPlay```, para la reproducción de la música actual del driver XGM.

La función ```XGM_startPlay```, reproduce un recurso de música utilizando el driver XGM. Recibe por parámetro el recurso que hemos importado usando _rescomp_.

Podemos comprobar que al pulsar el botón B, ocurre lo mismo pero reproduce la segunda canción:

```c
if(changed & state & BUTTON_B){
    if(XGM_isPlaying()){
        XGM_stopPlay();
    }
    XGM_startPlay(music2);
}
```

En el caso de pulsar el botón C, se reproducirá el sonido actual; veamos el fragmento de código:

```c
if(changed & state & BUTTON_C){
    XGM_setPCM(sound,sounds[sound-1],sizeof(sounds[sound-1]));
    XGM_startPlayPCM(sound,14,SOUND_PCM_CH4);
}
```

Podemos observar que se utilizan dos nuevas funciones, para poder reproducir un efecto de sonido. Veamos estas funciones.

La función ```XGM_setPCM``` inicializa el sonido a reproducir utilizando el Driver XGM; recibe los siguientes parámetros:
* _id_: Identificador que tendrá este sonido.
* _sound_: Sonido a inicializar (nombre del recurso importado con rescomp).
* _length_: longitud del sonido a reproducir.

La función ```XGM_startPlayPCM``` reproduce un efecto de sonido previamente inicializado; recibe los siguientes parámetros:

* _id_: Identificador asignado en el anterior paso.
* _prioridad_: define la prioridad con la que se reproducirá el sonido puede tener un valor de entre 0 y 15; siendo 0 la menor y 15 la mayor.
* _channel_: canal a reproducir el sonido; puede seleccionar los distintos canales permitidos por el driver XGM. En este caso, ```SOUND_PCM_CH4``` indica que se utilizará el canal 4 como PCM. Consulta la documentación de SGDK, para saber todos los canales disponibles.

Una vez hemos visto que ocurre al pulsar el botón C, vamos a ver que ocurre cuando se pulsa el botón Start.

```c
if(changed & state & BUTTON_START){
    XGM_stopPlay();
    XGM_stopPlayPCM(SOUND_PCM_CH4);
}
```

En este caso se trata de parar la reproducción tanto de la música, como del efecto de sonido que este reproduciencose. Para ello se utilizan dos funciones; ```XGM_stopPlay``` que para la reproducción de la música actual.

Por otro lado, la función ```XGM_stopPlayPCM```; para la reproducción del efecto de sonido que se este reproduciendo en un canal especifico; recibe los siguientes parámetros:

* _channel_: canal que parará la reproducción del sonido. Tiene los mismos datos que en la anterior función. Consulta la documentación de SGDK, para saber todos los canales disponibles.

Por otro lado, al pulsar los botones izquierda o derecha, se seleccionará el anterior o siguiente efecto de sonido; pero no lo reproducirá.

```c
 if(changed & state & BUTTON_RIGHT){
    sound++;
    if(sound==4) sound=1;
}else if (changed & state & BUTTON_LEFT)
{
    sound--;
    if(sound==0) sound=3;
}
```

Una vez que hemos terminado de revisar los botones y de como funciona cada caso, ya podemos compilar y ejecutar nuestro ejemplo. Dejamos para el lector, el poder revisar como mostramos la pantalla cargando una imágen y un TileSet. Si todo va correctamente, podrás ver y oir este ejemplo en el emulador.

<div class="image">
<img id="arq" src="14sonido/img/ej15.png" alt="Ejemplo 15: Música y Sonido" title="Ejemplo 15: Música y Sonido"/> </div>
<p>Ejemplo 15: Música y Sonido</p>

## Referencias

* Arquitectura Mega Drive: [https://www.copetti.org/writings/consoles/mega-drive-genesis/](https://www.copetti.org/writings/consoles/mega-drive-genesis/)
* Listado de Juegos y Drivers: [http://gdri.smspower.org/wiki/index.php/Mega_Drive/Genesis_Sound_Driver_List](http://gdri.smspower.org/wiki/index.php/Mega_Drive/Genesis_Sound_Driver_List)
* GEMS: [https://segaretro.org/GEMS](https://segaretro.org/GEMS)
* MUCOM88: [https://onitama.tv/mucom88/index_en.html](https://onitama.tv/mucom88/index_en.html)
* XGM: [https://raw.githubusercontent.com/Stephane-D/SGDK/master/bin/xgm.txt](https://raw.githubusercontent.com/Stephane-D/SGDK/master/bin/xgm.txt)
* Deflemask: [https://www.deflemask.com/](https://www.deflemask.com/)
* Sound Effects (Open Game Art): [https://opengameart.org/content/sound-effects-mini-pack15](https://opengameart.org/content/sound-effects-mini-pack15)