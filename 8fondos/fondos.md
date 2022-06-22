# 8. Fondos

Hemos podido ya empezar a ver nuestros primeros juegos; pero nos falta el poder ver más colorido y poder jugar con las distintas cracterísticas que nos ofrece la Sega Mega Drive.

Uno de los apartados más significativos a la hora de trabajar con juegos, son los fondos. Estos fondos son imagenes que podemos superponer, para poder dar una sensación de profundidad. Sega Mega Drive, permite trabajar con varios fondos (o planos), de tal forma que podemos dar esa sensación de profundidad.

En este capítulo, nos centraremos en el uso de fondos o planos, a través de SGDk y el uso de herramientas para poder gestionar estos fondos; como por ejemplo la herramienta _rescomp_.

Comenzaremos por hablar de como gestiona las imágenes o los gráficos la Sega Mega Drive, e iremos explicando los distintos conceptos relacionados con los fondos.

## Imágenes en Sega Mega Drive

En primer lugar, antes de entrar en más conceptos, vamos a estudiar como se gestionan las imágenes o gráficos en la Sega Mega Drive; a través del VDP.

Veamos las cracterísticas de los gráficos para Sega Mega Drive:

* Todo gráfico o imagen, se dibuja dividido por Tiles [^48], de un tamaño de 8x8 píxeles.
* Solo se pueden almacenar 4096 Tiles (64Kb de VRAM).
* Las imágenes, estan almacenadas en formáto indexado [^49] no como RGB [^50].
* Solo se pueden almacenar 4 paletas de 16 colores cada una.
* Normalmente, sólo se pueden mostrar 61 colores en pantalla.
* En cada paleta, el primer color, se considera transparente.

[^48]: Un Tile es un fragmento de una imágen que se muestra como si fuese un mosaico; por lo que una imágen esta compuesta por una serie de Tiles.
[^49]: Una imágen en formato indexado, almacena una paleta con los distintos colores que contiene; después cada píxel, solo tiene información del color que representa en dicha paleta.
[^50]: RGB (Red Green Blue) es un formato que se define en cada píxel almacenar el color rojo, verde y azul de tal forma que se pueda ver cada color combinando estos tres.

Es importante conocer estas características, a la hora de trabajar con imágenes en Mega Drive; para no perder calidad o algún color, si la paleta no esta bien referenciada.

Además, hemos podido ver que solo se pueden mostrar 61 colores en pantalla. Esto es debido a los colores transparentes de cada una de las paletas; excepto la primera paleta (paleta 0), que se considera el color de fondo.

Toda esta información, de las paletas y los distintos Tiles que se vana mostrar, se almacenan en la VRAM y son accesibles por el VDP; de tal forma que en algunas ocasiones gracias al uso del DMA, la CPU no necesita trabajar con ello; sino que el propio VDP realiza todo el trabajo de forma más eficiente.

Si se necesita conocer, los distintos colores y paletas que hay almacenadas; podemos usar algunas herramientas que nos traen emuladores como _Blastem_; pulsando la tecla <kbd>c</kbd>, podremos ver el contenido de las paletas del VDP.

<div class="image">
<img id="arq" src="8fondos/img/blastem.png" alt="Visor VDP Blastem" title="Visor VDP Blastem"/> </div>
<p>Visor VDP Blastem</p>

Más adelante, veremos como importar imágenes y gráficos para nuestro juego usando la herramienta _rescomp_ de SGDK.

## Fondos

Como hemos comentado, una parte importante es el uso de fondos o planos como también se les conoce; Sega Mega Drive permite trabajar con 2 fondos a la vez, de tal forma, que siempre se pintan estos dos fondos a la vez.

Un fondo, no es más que un conjunto de Tiles que estan almacenados en la memoria de vídeo; normalmente en cada fondo se establece en cada Tile, un índice que apunta a un Tile de la memoria de vídeo; esto se conoce como Mapa y el conjunto de Tiles almacenados en la memoria, se conoce como TileSet. Más adelante, hablaremos sobre los Tilesets y como se pueden utilizar.

En este apartado, solo hablaremos sobre los fondos y como podemos utilizarlos para nuestros juegos, de forma estática.

Es importante saber, que un fondo se dibuja de arriba a abajo y de izquierda a derecha. De tal forma, que es más fácil de trabajar con ellos. Además, no podemos olvidar que los fondos trabajan a nivel de Tile no a nivel de píxel.

Por último, aunque la Sega Mega Drive tiene una resolución de pantalla de 320x224 (320x240 NTSC) que corresponden a 40x28 tiles en PAL, si que se pueden almacenar más Tiles por fondo de tal forma que podemos almacenar hasta 64x32 Tiles; de tal forma que podriamos utilizar este sobrante para realizar scroll. Esto lo veremos en el capítulo de Scroll.

### Fondo A, B y Window

Como hemos comentado, Sega Mega Drive tiene disponibles 2 fondo para trabajar con ellos (a parte del encargado de los Sprites).

* **Fondo A**; permite dibujar un plano completo.
* **Fondo B**; permite dibujar un plano completo.
* **Window**; es un plano especial, que permite escribir dentro del Plano A, el plano Window, tiene un scroll diferente del A y por lo tanto suele usarse para mostrar por ejemplo, la interfaz de usuario.

<div class="image">
<img id="arq" src="8fondos/img/planeExplorer.png" alt="Visor de Planos de Gens Kmod" title="Visor de planos de Gens KMod"/> </div>
<p>Visor de planos de Gens Kmod</p>

En la anterior imágen, podemos ver el visor de fondos de _Gens KMod_, donde podremos visualizar cada fondo para ver como se dibuja.

Además, los fondos A,B y el plano de Sprites (que verémos en el siguiente capítulo), tienen distinta prioridad; de tal forma que podemos dar esta prioridad a cada fondo dando la sensación de profundidad.

<div class="image">
<img id="arq" src="8fondos/img/esquemaplanos.png" alt="Esquema de Prioridad de los Fondos" title="Esquema de Prioridad de los Fondos"/> </div>
<p>Esquema de Prioridad de los Fondos</p>

## Rescomp

## Ejemplo con fondos

## Referencias