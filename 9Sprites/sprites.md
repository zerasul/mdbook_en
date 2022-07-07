# 9. Sprites

Ya tenemos nuestro primer ejemplo más colorido con algunos fondos. Pero hace falta algo más, para dar vida a nuestro primer juego; ya que entre otras cosas, no tenemos ni un jugador. En este caso, vamos a hablar de los Sprites.

Un Sprite, es un mapa de bits (normalmente) que representa un objeto en el juego y sin necesidad de calculos adicionales por parte de la CPU; ya sea el jugador, enemigos, objetos que podemos interactuar,etc. Los Sprites pueden ser estáticos, o tener animaciones que nos pueden ayudar a dar vida a nuestro juego.

Por ello, en este capítulo, vamos a hablar sobre los Sprites; comenzando a hablar sobre que son, y como podemos utilizarlos en nuestros juegos en Sega Mega Drive. Hablaremos de como se constituyen los Sprites en Mega Drive, seguido de como importar los recursos de Sprites, usando recomp, y de como se utilizan por SGDK y el motor de Sprites que integra.

Por último, vamos a mostrar un ejemplo de utilización de Sprites con SGDK.

## Sprites en Mega Drive

Vamos a comentar que es un Sprite realmente; se trata de una imagen que representa un objeto en el juego. Este objeto, no es necesario que sea controlado por la propia CPU; de tal forma que puede ser controlado por el propio chip gráfico; como puede ser el VDP de la Sega Mega Drive.

Normalmente, un Sprite esta compuesto por una serie de imágenes que representan distintos frames de una animación; además de poder representar varias animaciones dentro de una imagen. Esto se conoce como Hoja de Sprite o _spritesheet_.

<div class="image">
<img id="arq" src="9sprites/img/nadia.png" alt="Hoja de Sprites" title="Hoja de Sprites"/> </div>
<p>Hoja de Sprites</p>

Como podemos ver en la anterior imagen, vemos que se compone de distintos frames de distintas animaciones; normalmente cada animación corresponde a una fila, y cada frame a cada columna.

Aunque se pueden tener distintos Sprites para representar distintos objetos, tenemos que tener en cuenta las siguientes limitaciones a la hora de trabajar con Sprites en Sega Mega Drive.

* Los Sprites se dibujan en su propio Plano.
* La posición en pantalla de los Sprites se definen en píxeles y no en Tiles.
* Podemos tener un total de 80 Sprites en pantalla.
* Solo se pueden tener 20 Sprites por línea horizontal.
* El tamaño de cada Sprite por hardware puede ser de entre 1 y 4 Tiles. Sin embargo, SGDK permite almacenar mayores combinandolos.
* El tamaño máximo de Sprite para SGDK es de 16x16 (128x128 píxeles) Tiles; sin embargo, se pueden ampliar realizando combinaciones de Sprites.
* Cada Sprite puede usar como máximo 16 colores ya que estará asociado a una de las cuatro paletas disponibles.
* Cada frame debería ser divisible por 8 (para poder dividir cada animación).

También es importante saber que los Sprites se almacenaran en la VRAM por lo que tenemos que tener en cuenta que normalmente tienen un espacio de 512x512px en dicha memoria para almacenar la información de los distintos Sprites.

## Importar Recursos de Sprites

Tras conocer como La Sega Mega Drive trabaja con Sprites y sobre todo ver la limitaciones que nos provee el hardware, vamos a ver como podemos importar los recursos de Sprites para nuestros juegos. Para ello, gracias a la herramienta que integra SGDK, usaremos _recomp_.

Como vimos en el anterior capítulo, con rescomp podemos importar recursos de distintos tipos para poder usarlos en SGDK. En este apartado, vamos a ver como importar un Sprite y dividir los distintos frames que compone. Recordamos que se deben definir cada recurso en un fichero con extensión _.res_.

Veamos un ejemplo:

```
SPRITE main-sprt "sprt/zeraready.bmp" 2 4 NONE 5 CIRCLE
```

Donde:

* _SPRITE_ Indica el tipo de Recurso.
* _name_: nombre que le daremos al recurso para referenciarlo. En este ejemplo _main-sprt_.
* _path_: Ruta del recurso relativa al directorio _res_; estará entre comillas dobles. En este ejemplo _"sprt/zeraready.bmp"_.
* _width_: Tamaño en Tiles del ancho de cada frame. Debe ser menor que 32. En este ejemplo indica 2 Tiles (16 px).
* _height_: Tamaño en Tiles del alto de cada frame Debe ser menor que 32. En este ejemplo indica 4 Tiles (32px).
* _compression_: Indica si la imágen puede estar comprimida; puede tomar los siguientes valores:
    * -1/BEST/AUTO: Usa la mejor compresión.
    * 0/NONE: No usa ninguna compresión (por defecto).
    * 1/APLIB: algoritmo aplib (buena compresión, pero más lento).
    * 2/FAST/LZ4W: Algoritmo LZ4 (menor compresión, pero más rápido).
* _time_: Tiempo entre frames normalmente 1/60; a más tiempo, más rápida será la animación. Si se establece a 0, no se animará el Sprite.
* _collision_: indica la información de como será la caja para las colisiones. Esta opción aunque esta puesta en rescomp, aún no es utilizada por SGDK. Será una futura mejora. Puede tener los valores CIRCLE, Box o NONE (por defecto es NONE).
* _opt_: Indica la optimización a realizar a la hora de almacenar y cortar la imágen; puede tener los siguientes valores:
    * 0/BALANCED: Manera por defecto trata de optimizar de manera equilibrada. Valor por defecto.
    * 1/SPRITE: reduce el número de sprites por hardware a expensas de usar más Tiles, usando un Sprite mayor.
    * 2/TILE: Reduce el número de Tiles a coste de usar más Sprites Hardware.
    * 3/NONE: No realiza ninguna Optimización.
* _iteration_: Indica el nº de iteraciones para el proceso de cortar cada frame. Por defecto 500000.

Además de las anteriores propiedades, hay que tener en cuenta las siguientes características de la imagen de entrada:

* La imagen debe ser siempre divisible por 8 (para poder almacenar por Tile).
* La imagen debe ser una cuadricula que representa cada animación por fila y cada Frame por columna.
* Una animación, no puede contener más de 255 frames.
* No se pueden tener frames de más de 248x248 píxeles (32x32 Tiles).
* No se pueden usar más de 16 Hardware Sprites por frame.
* Rescomp detecta solo las filas donde hay animaciones; ignora las filas vacias.
* Por defecto la colisión (collider) se calcula con el 75% de cada frame.

Cuando rescomp, va a procesar un recurso tipo _SPRITE_, el mismo realiza los cortes de las distintas animaciones y optimiza tanto a nivel de frame, como a nivel de hardware, para poder almacenar de la manera más óptima en la VRAM.

Al procesar el recurso Sprite, generará (si no se ha especificado la opción _-noheader_), un fichero .h con la referencia a los recursos.

## Motor de Sprites de SGDK

A la hora de trabajar con Sprites animados, es siempre bastante engorroso realizar los distintos cambios de Frame para hacer las animaciones más fluidas; de tal forma que pueda dar una mejor sensación de movimiento a la hora de trabajar con los distintos frames de un Sprite.

Gracias a SGDK, podemos utilizar un pequeño motor de Sprites que integra; de esta forma no necesitaremos estar calculando "cuando" es necesario cambiar de frame nuestro Sprite. Como hemos podido ver en el anterior apartado, podemos definir el tiempo entre animaciones; este parámetro será usado por el motor de Sprites para realizar el cambio entre los distintos frames.

El motor de Sprites de SGDK, se basa en guardar una lista con todos los Sprites activos de tal forma que solo se interactua con aquellos que estan en dicha lista.

Para poder usar el motor de Sprites, podemos usar a nivel de código dos funciones ```SPR_init``` y ```SPR_update```. Veamos cada una de ellas.

* ```SPR_init```: Inicializa el motor de Sprites con los valores por defecto. Normalmente reserva 420 Tiles en VRAM. Además inicializa el hardware para almacenar los Sprites. Existe otra función llamada ```SPR_initEx``` que permite pasar por parámetro el número de Tiles Reservados.

* ```SPR_update```: Actualiza y muestra los Sprites activos. Gracias a esta función, cada vez que se llama recalculara los Sprites activos y cambiará de frame aquellos que lo necesiten. Es importante que esta función este antes de la llamada a ```SYS_doVBlankProcess```, para que se actualicen los frames.

Más adelante, veremos más funciones que podremos utilizar, sobre todo al ver el ejemplo de esta sección.

## Trabajar con Sprites en SGDK

A la hora de trabajar con Sprites en SGDK, es importante saber como trabajar con las distintas funciones que nos van a permitir modificar las características de los sprites, como puede ser su posición, animación, frame o prioridad.

Una de las primeras características que tenemos que tener en cuenta, es que a la hora de poder trabajar con Sprites, es que se calcula su posición en píxeles no en Tiles. Aunque si se dibujan y se calcula cada frame a nivel de Tile. Por ello es importante siempre conocer la posición de un sprite tanto la coordenada X e Y en píxeles.

Por otro lado, tenemos que tener en cuenta que los Sprites se dibujan en su propio plano; y por lo tanto tienen una prioridad; de tal forma, que se puede establacer. Veamos de nuevo el esquema de prioridades de los distintos planos.

<div class="image">
<img id="arq" src="9sprites/img/esquemaplanos.png" alt="Esquema de Prioridad de los Fondos" title="Esquema de Prioridad de los Fondos"/> </div>
<p>Esquema de Prioridad de los Fondos</p>

Vemos como el plano de Sprites, puede ser dibujado con baja o alta prioridad; de tal forma, que podemos hacer que el sprite este detras de algún plano, para poder dar una mayor sensación de profundidad.

Por otro lado, como podemos ver, un Sprite se compone de distintas animaciones que pueden indicar distintas acciones que puede realizar el personaje (moverse en las distintas direcciones, atacar, saltar); por ello tenemos que tener en cuenta dichas animaciones. En una hoja de Sprites, cada fila corresponde a una animación; y cada columna, corresponde a un Frame de cada animación. Veamos un ejemplo:

<div class="image">
<img id="arq" src="9sprites/img/anim.png" alt="Hoja de Sprites con animaciones" title="Hoja de Sprites con animaciones"/> </div>
<p>Hoja de Sprites con animaciones</p>

Como vemos en la anterior imagen, se compone de 5 animaciones de 3 frames cada uno. Observamos que para SGDK, la primera animación es la número 0. Por lo que siempre tenemos que tener en cuenta esto para cambiar de animación cuando sea necesario. Esto también se aplica a los Frames; por lo que el primer frame de una animación, es el número 0.

Por último, como hemos podido ver a la hora de importar los recursos de sprites con rescomp, se puede definir la velocidad de cambio de animación a través de un número. Este número es manipulable, y por lo tanto podemos utilizarlo; siempre es importante saber que a mayor tiempo, es más lento el cambio. es decir que el valor de 1, indica que se cambiará de animación en cada frame por lo tanto serían 50/60 veces por segundo.

## Ejemplo con Sprites en SGDK

## Referencias

* [https://megacatstudios.com/blogs/retro-development/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17](https://megacatstudios.com/blogs/retro-development/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17).
* [https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt](https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt).
* [http://charas-project.net/index.php](http://charas-project.net/index.php)
