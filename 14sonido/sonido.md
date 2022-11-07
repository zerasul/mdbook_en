# 14. Música y Sonido

Hasta ahora hemos estado trabajando principalmente con la parte visual; como mostrar fondos, sprites, colores ,fondos,etc. Pero un juego no esta completo si no tiene su sonido; tanto los efectos de sonido, como la música que nos haga mejorar la experiencia de juego.

Por ello, es importante conocer como añadir sonido a nuestro juego; desde los distintos efectos como el ataque, voz del personaje o incluso algún efecto más sofisticado, es importante poder añadirlos y disfrutarlos una vez nuestro juego esta en marcha.

No podemos olvidar la música; ya que para muchos la banda sonora de juegos de Mega Drive, ha sidno nuestra infancia y hoy en día solo con escuchar un par de acordes, ya nos transporta a aquella época. De ahí la gran importancia de la música en un videojuego.

En este capítulo, vamos a mostrar como la Mega Drive es capaz de reproducir sonido e incluso música y como podemos añadirla a nuestro juego y tener una mejor experiencia del mismo.

Comezaremos hablando del sistema de sonido que trae la Sega Mega Drive, y como funcionan los distintos elementos que la componen. Además, hablaremos de como se puede crear esta música y por último, veremos algún ejemplo de como añadir música y sonido a nuestros juegos, usando SGDK.

## Sistema de Sonido de la Sega Mega Drive

Comenzaremos hablando del Sistema de Sonido de la Sega Mega Drive; como hemos podido ver en el capítulo de la arquitectura, Sega Mega Drive, dispone de dos chips de sonido:

* Chip Yamaha YM2612; con sonido FM (6 canales).
* Chip PSG (SN76496); sonido 8 bits con capacidad de emitir 3 ondas de pulso y 1 canal de ruido. Esta dentro del VDP.

Estos dos chips, son orquestados por el procesador Zilog z80; este es quien envia o recibe la información del sonido, ayudandose de la Ram de sonido (8Kb); a través del bus de 8 bits que conecta ambos chips.

### Yamaha 2612

Comenzaremos hablando del Yamaha 2612; el cual es el chip encargado principalmente de emitir sonido FM o samples, de tal forma que tenemos hasta 6 canales para reproducir música o sonido.

Permite emitir hasta 5 señales FM a la vez, y una de samples aunque hay que tener cuidado a la hora de mezclar estas señales. Es importante, que a la hora de trabajar con este chip, no se creen cuellos de botella a la hora de mezclar los sonidos o incluso que se mezclen erroneamente.



### PSG

### Z80

## Driver de sonido

### XGM



## Crear música y Sonido

### Deflemask

## Ejemplo con música y Sonido