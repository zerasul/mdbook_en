# 9. Sprites

Ya tenemos nuestro primer ejemplo más colorido con algunos fondos. Pero hace falta algo más, para dar vida a nuestro primer juego; ya que entre otras cosas, no tenemos ni un jugador. En este caso, vamos a hablar de los Sprites.

Un Sprite, es un mapa de bits (normalmente) que representa un objeto en el juego y sin necesidad de cálculos adicionales por parte de la CPU; ya sea el jugador, enemigos, objetos que podemos interactuar, etc. Los Sprites pueden ser estáticos, o tener animaciones que nos pueden ayudar a dar vida a nuestro juego.

Por ello, en este capítulo, vamos a hablar sobre los Sprites; comenzando a hablar sobre que son, y como podemos utilizarlos en nuestros juegos en Sega Mega Drive. Hablaremos de como se constituyen los Sprites en Mega Drive, seguido de como importar los recursos de Sprites, usando _rescomp_, y de como se utilizan por SGDK y el motor de Sprites que integra.

Por último, vamos a mostrar un ejemplo de utilización de Sprites con SGDK.

## Sprites en Mega Drive

Vamos a comentar que es un Sprite realmente; se trata de una imagen que representa un objeto en el juego. Este objeto no es necesario que sea controlado por la propia CPU; de tal forma que puede ser controlado por el propio chip gráfico; como puede ser el VDP de la Sega Mega Drive.

Normalmente, un Sprite está compuesto por una serie de imágenes que representan distintos frames de una animación; además de poder representar varias animaciones dentro de una imagen. Esto se conoce como Hoja de Sprite o _spritesheet_.

![Hoja de Sprites](9Sprites/img/nadia.png "Hoja de Sprites")
_Hoja de Sprites_

Como podemos ver en la anterior imagen, vemos que se compone de distintos frames de distintas animaciones; normalmente cada animación corresponde a una fila, y cada frame a cada columna.

Aunque se pueden tener distintos Sprites para representar distintos objetos, tenemos que tener en cuenta las siguientes limitaciones a la hora de trabajar con Sprites en Sega Mega Drive.

* Los Sprites se dibujan en su propio Plano.
* La posición en pantalla de los Sprites se definen en píxeles y no en Tiles.
* Podemos tener un total de 80 Sprites en pantalla.
* Solo se pueden tener 20 Sprites por línea horizontal.
* El tamaño de cada Sprite por hardware puede ser de entre 1 y 4 Tiles. Sin embargo, SGDK permite almacenar mayores combinándolos.
* El tamaño máximo de Sprite para SGDK es de 16x16 (128x128 píxeles) Tiles; sin embargo, se pueden ampliar realizando combinaciones de Sprites.
* Cada Sprite puede usar como máximo 16 colores, ya que estará asociado a una de las cuatro paletas disponibles.
* Cada frame debería ser divisible por 8 (para poder dividir cada animación).

También es importante saber que los Sprites se almacenaran en la VRAM por lo que tenemos que tener en cuenta que normalmente tienen un espacio de 512x512px en dicha memoria para almacenar la información de los distintos Sprites.

## Importar Recursos de Sprites

Tras conocer como La Sega Mega Drive trabaja con Sprites y sobre todo ver las limitaciones que nos provee el hardware, vamos a ver como podemos importar los recursos de Sprites para nuestros juegos. Para ello usaremos la herramienta que integra SGDK, usaremos _rescomp_.

Como vimos en el anterior capítulo, con _rescomp_ podemos importar recursos de distintos tipos para poder utilizarlos en SGDK. En este apartado, vamos a ver como importar un Sprite y dividir los distintos frames que compone. Recordamos que se deben definir cada recurso en un fichero con extensión _.res_.

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
* _compression_: Indica si la imagen puede estar comprimida; puede tomar los siguientes valores:
    * -1/BEST/AUTO: Usa la mejor compresión.
    * 0/NONE: No usa ninguna compresión (por defecto).
    * 1/APLIB: algoritmo aplib (buena compresión, pero más lento).
    * 2/FAST/LZ4W: Algoritmo LZ4 (menor compresión, pero más rápido).
* _time_: Tiempo entre frames normalmente 1/60; a más tiempo, más rápida será la animación. Si se establece a 0, no se animará el Sprite.
* _collision_: indica la información de como será la caja para las colisiones. Esta opción, aunque esta puesta en rescomp aún no es utilizada por SGDK. Será una futura mejora. Puede tener los valores CIRCLE, Box o NONE (por defecto es NONE).
* _opt_: Indica la optimización a realizar a la hora de almacenar y cortar la imagen; puede tener los siguientes valores:
    * 0/BALANCED: Manera por defecto, trata de optimizar de manera equilibrada. Valor por defecto.
    * 1/SPRITE: reduce el número de sprites por hardware a expensas de usar más Tiles, usando un Sprite mayor.
    * 2/TILE: Reduce el número de Tiles a coste de usar más Sprites Hardware.
    * 3/NONE: No realiza ninguna Optimización.
* _iteration_: Indica el nº de iteraciones para el proceso de cortar cada frame. Por defecto 500000.

Además de las anteriores propiedades, hay que tener en cuenta las siguientes características de la imagen de entrada:

* La imagen debe ser siempre divisible por 8 (para poder almacenar por Tile).
* La imagen debe ser una cuadrícula que representa cada animación por fila y cada Frame por columna.
* Una animación, no puede contener más de 255 frames.
* No se pueden tener frames de más de 248x248 píxeles (32x32 Tiles).
* No se pueden usar más de 16 Hardware Sprites por frame.
* _Rescomp_ detecta solo las filas donde hay animaciones; ignora las filas vacías.
* Por defecto, la colisión (collider) se calcula con el 75% de cada frame.

Cuando _rescomp_, va a procesar un recurso tipo _SPRITE_, el mismo realiza los cortes de las distintas animaciones y optimiza tanto a nivel de frame, como a nivel de hardware, para poder almacenar de la manera más óptima en la VRAM.

Al procesar el recurso Sprite, generará (si no se ha especificado la opción _-noheader_), un fichero .h con la referencia a los recursos.

## Motor de Sprites de SGDK

A la hora de trabajar con Sprites animados, es siempre bastante engorroso realizar los distintos cambios de Frame para hacer las animaciones más fluidas; de tal forma que pueda dar una mejor sensación de movimiento a la hora de trabajar con los distintos frames de un Sprite.

Gracias a SGDK, podemos utilizar un pequeño motor de Sprites que integra; de esta forma no necesitaremos estar calculando _"cuando"_ es necesario cambiar de frame nuestro Sprite. Como hemos podido ver en el anterior apartado, podemos definir el tiempo entre animaciones; este parámetro será usado por el motor de Sprites para ejecutar el cambio entre los distintos frames.

El motor de Sprites de SGDK, se basa en guardar una lista con todos los Sprites activos, de tal forma que solo se interactúa con aquellos que están en dicha lista.

Para poder usar el motor de Sprites, podemos usar a nivel de código dos funciones ```SPR_init``` y ```SPR_update```. Veamos cada una de ellas.

* ```SPR_init```: Inicializa el motor de Sprites con los valores por defecto. Normalmente, reserva 420 Tiles en VRAM. Además, inicializa el hardware para almacenar los Sprites. Existe otra función llamada ```SPR_initEx``` que permite pasar por parámetro el número de Tiles Reservados.

* ```SPR_update```: Actualiza y muestra los Sprites activos. Gracias a esta función, cada vez que se llama recalculará los Sprites activos y cambiará de frame aquellos que lo necesiten. Es importante que esta función este antes de la llamada a ```SYS_doVBlankProcess```, para que se actualicen los frames.

Más adelante, veremos más funciones que podremos utilizar, sobre todo al ver el ejemplo de esta sección.

## Trabajar con Sprites en SGDK

A la hora de trabajar con Sprites en SGDK, es importante saber como trabajar con las distintas funciones que nos van a permitir modificar las características de los Sprites, como puede ser su posición, animación, frame o prioridad.

Una de las primeras características que tenemos que tener en cuenta, es que a la hora de poder trabajar con Sprites, es que se calcula su posición en píxeles, no en Tiles. Aunque si se dibujan y se calcula cada frame a nivel de Tile. Por ello es importante siempre conocer la posición de un sprite tanto la coordenada X e Y en píxeles.

Otro aspecto a tener en cuenta es, que los Sprites se dibujan en su propio plano; y por lo tanto, tienen una prioridad; de tal forma, que se puede establecer. Veamos de nuevo el esquema de prioridades de los distintos planos.

![Esquema de Prioridad de los Planos](9Sprites/img/esquemaplanos.png "Esquema de Prioridad de los Planos")
_Esquema de Prioridad de los Planos_

Vemos como el plano de Sprites, puede ser dibujado con baja o alta prioridad; de tal forma, que podemos hacer que el Sprite este detrás de algún plano, para poder dar una mayor sensación de profundidad.

Por otro lado, como podemos ver, un Sprite se compone de distintas animaciones que pueden indicar distintas acciones que puede realizar el personaje (moverse en las distintas direcciones, atacar, saltar); por ello tenemos que tener en cuenta dichas animaciones. En una hoja de Sprites, cada fila corresponde a una animación; y cada columna, corresponde a un Frame de cada animación. Veamos un ejemplo:

![Hoja de Sprites con animaciones](9Sprites/img/anim.png "Hoja de Sprites con animaciones")
_Hoja de Sprites con animaciones_

Como vemos en la anterior imagen, se compone de 5 animaciones de 3 Frames cada uno. Observamos que para SGDK, la primera animación es la número 0. Por lo que siempre tenemos que tener en cuenta esto para cambiar de animación cuando sea necesario. Esto también se aplica a los Frames; por lo que el primer Frame de una animación, es el número 0.

Por último, como hemos podido ver a la hora de importar los recursos de Sprites con _rescomp_, se puede definir la velocidad de cambio de animación a través de un número. Este número es manipulable y por lo tanto, podemos utilizarlo; siempre es importante saber que a mayor tiempo, es más lento el cambio. Es decir, que el valor de 1 indica que se cambiará de animación en cada frame por lo tanto, serían 50/60 veces por segundo.

## Ejemplo con Sprites en SGDK

Una vez hemos visto como trabajar con Sprites en SGDK, vamos a ver un ejemplo. El cual tomaremos como base el anterior ejemplo para los fondos y añadiremos dos Sprites. Este ejemplo puede encontrarse en el repositorio de ejemplos que acompaña a este libro; en la carpeta _ej6.sprites_.

Este ejemplo consistirá, en trabajar con dos sprites y ver como podemos moverlos, cambiar animación, prioridad, etc. Estos dos Sprites, se componen de dos hojas de Sprites de 72x160 y 96x160 Píxeles cada una. Veamos estas dos Hojas de Sprite.

![Hojas de Sprites de ejemplo](9Sprites/img/sprites.png "Hojas de Sprites de ejemplo")
_Hojas de Sprites de ejemplo_

Como podemos ver en las imágenes, se tratan de dos hojas de Sprites, con distintas animaciones y Frames. En este caso se tratan de Frames de distintos tamaños. El personaje de la izquierda, cada Frame tiene 32x32 píxeles (4x4 tiles); mientras que el personaje de la derecha, tiene 24x32 píxeles (3x4 Tiles); por lo que tenemos que tener en cuenta esto a la hora de importar ambos recursos. Para importar estos recursos, usaremos un fichero _.res_, para definir cada uno de ellos.

```
SPRITE shaSprt "sprt/sha.png" 3 4 NONE 6 BOX
SPRITE elliSprt "sprt/elliready.png" 4 4 NONE 5 BOX
```

Vemos que el primero, el cual llamaremos _shaSprt_ y obtendremos el fichero con el mapa de bits dentro de la carpeta sprt (recordamos que todos los recursos deben ir en la carpeta _res_), después vemos que definimos que cada Frame tiene 3 Tiles de anchura y 4 de altura; para poder realizar el corte correctamente. Por último, no usaremos compresión, y la velocidad de cambio de Frame será 6 veces por segundo.

Para el segundo Sprite, que llamaremos _elliSprt_, haremos de igual forma; pero teniendo en cuenta, que cada Frame es de 4 tiles de anchura y 4 tiles de altura. Una vez que hemos definido ambos Sprites y también los correspondientes fondos (que reutilizaremos los del ejemplo anterior), podremos compilar el proyecto y que rescomp, nos genere los recursos y ficheros cabecera _.h_ si fuese necesario.

Con estos pasos ya tendríamos importados los sprites y los fondos para utilizar en nuestro código fuente. Vamos a analizar el código fuente. En este ejemplo ya utilizaremos, tanto por un lado controles tanto síncronos como asíncronos, además de utilizar fondos.

Comenzaremos por incluir los recursos en nuestro código, seguido de la definición de las constantes necesarias:

```c
#include <genesis.h>

#include "gfx.h"
#include "sprt.h"

#define SHA_UP 0
#define SHA_DOWN 2
#define SHA_LEFT 3
#define SHA_RIGHT 1
#define SHA_STAY 4
```

Como podemos ver en el anterior fragmento, importamos tanto la librería ```genesis.h```, además de los ficheros cabecera (_.h_) generados con _rescomp_. Por otro lado, también vemos una serie de constantes, que corresponden a los índices de las animaciones de un Sprite; esto es recomendable para hacer el código más legible.

Seguidamente, definiremos las variables globales necesarias para nuestro juego:

```c
Sprite * sha;
Sprite * elli;

u16 sha_x=15;
u16 sha_y=125;

int shaPrio=TRUE;
int elliPrio=FALSE;
```

Las cuales utilizaremos durante el código del ejemplo; como pueden ser los punteros a los distintos Sprites, posición x e y de uno de ellos, y el estado de la prioridad de cada uno de los Sprites. Más adelante veremos como vamos a utilizarlos.

A continuación, nos centraremos en la función ```main``` donde podemos ver la inicialización de los distintos recursos:

```c
JOY_init();
JOY_setEventHandler(asyncReadInput);
SPR_init();
VDP_setScreenWidth320();
```

Donde podemos observar como se inicializan los controles, estableciendo la función callback para los controles asíncronos con la función ```JOY_setEventHandler``` (para más información, consulta el capítulo de controles). Además, de inicializar el motor de Sprites con la función ```SPR_init``` y posteriormente establecemos el ancho a una resolución de 320px.

Después, ya comenzamos a añadir elementos a la pantalla, como pueden ser los fondos; de igual forma que hemos visto en el ejemplo del capítulo anterior:

```c
u16 index = TILE_USERINDEX;
VDP_drawImageEx(BG_B, &bg_b,
     TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE
        ,index),0,0,TRUE,CPU);
index+=bg_b.tileset->numTile;
VDP_drawImageEx(BG_A, &bg_a, 
     TILE_ATTR_FULL(PAL1,FALSE,FALSE,FALSE,
        index),0,0,TRUE,CPU);
index+=bg_a.tileset->numTile;
```

Pero a continuación, podremos ver como añadir Sprites a partir de una definición de Sprite. Una definición de Sprite, es el propio recurso que hemos importado; pero podemos definir múltiples Sprites a partir de una definición de Sprite.
Veamos como se añade un nuevo Sprite a partir de su definición:

```c
 sha = SPR_addSprite(&shaSprt,sha_x,sha_y,
                TILE_ATTR(PAL2,TRUE,FALSE,FALSE));
```

Vemos en el fragmento anterior, que se utiliza la función ```SPR_addSprite```; esta función, permite crear un Sprite a partir de un recurso; vamos a ver los distintos parámetros de la que se compone:

* _spritedef_: Puntero a la definición de Sprite; que corresponde con el recurso importado por rescomp.
* _x_: posición X por defecto en píxeles.
* _y_: posición Y por defecto en píxeles.
* attrbute: Indica los atributos del propio Sprite. Para ello, se puede utilizar la macro ```TILE_ATTR```, para establecer dichos atributos.

La macro ```TILE_ATTR``` permite establecer los atributos de un tilemap; veamos sus parámetros:

* _pal_: Paleta a utilizar (```PAL0```,```PAL1```,```PAL2```,```PAL3```)
* _prio_: Indica la prioridad ```TRUE``` para alta o ```FALSE``` para baja.
* _FlipV_: Indica si hay volteo vertical ```TRUE``` para voltear o ```FALSE``` para desactivarlo.
* _FlipH_: Indica si hay volteo horizontal ```TRUE``` para voltear o ```FALSE``` para desactivarlo.

El motor de Sprites de SGDK, es el encargado de alojar automáticamente los distintos Tiles de los Sprites en la VRAM; sin embargo, esto puede dar lugar a fragmentar la VRAM; debido a huecos que haya entre distintos Sprites. Para evitarlo, se puede usar la función ```SPR_addSpriteSafe```; sin embargo, tenemos que tener cuidado, ya que puede ser más lenta.

Tanto la función ```SPR_addSprite``` como ```SPR_addSpriteSafe```, devuelven un puntero a una estructura llamada ```Sprite```; la cual tiene una serie de propiedades con todo lo necesario para almacenar el Sprite; vamos a ver algunos de los campos de esta estructura:

* _status_: Estado interno con información de como se alojará el sprite.
* _visibility_: Indica la información del frame actual y como se mostrará en el VDP.
* _spriteDef_: Puntero a la definición.
* _onFrameChange_: Indica la función personalizada que puede lanzarse en cada cambio de Frame. Puede establecerse con la función ```SPR_setFrameChangeCallback```.
* _animation_: Puntero a la animación seleccionada.
* _frame_: Puntero al Frame actual.
* _animInd_: Índice a la animación actual.
* _frameInd_: Índice al Frame actual.
* _timer_: timer del Frame actual (uso interno).
* _x_: posición x en píxeles.
* _y_: posición y en píxeles.
* _depth_: indica la profundidad; útil cuando hay varios Sprites.
* _attribut_ Información con los atributos establecidos con la macro ```TILE_ATTR```.
* _VDPSpriteIndex_: Índice al primer Sprite alojado en la VDP.

Puede encontrar más información en la propia documentación de SGDK.

Una vez añadidos los dos sprites, tenemos que asignar las paletas de los recursos, a cada una de las paletas disponibles en Sega Mega Drive. Recordemos que cada paleta tiene 16 colores y que el primero, corresponde a un color transparente. Dependiendo de nuestra versión de SGDK, podemos usar distintas funciones. Si se tiene la versión 1.80 o superior, podemos usar la siguiente función ```PAL_setPalette```. La cual recibe los siguientes parámetros:

* _pal_: Número de paleta a utilizar (```PAL0```,```PAL1```,```PAL2```,```PAL3```).
* _data_: Datos con la paleta puede ser la del propio recurso, o establecer una personalizada.
* _tm_: Método de transferencia para almacenar la paleta usando ```CPU``` o ```DMA```.

Si por el contrario tenemos una versión de SGDK inferior a 1.80, podemos usar la función ```VDP_setPalette```; para establecer la paleta a un Sprite. La cual recibe los siguientes parámetros:

* _pal_: Paleta a utilizar (```PAL0```,```PAL1```,```PAL2```,```PAL3```).
* _data_: Datos con la paleta. Puede ser la del propio recurso, o establecer una personalizada.

Como en el propio ejemplo, que establece la paleta ```PAL3``` con los datos de la paleta del recurso importado:


Para SGDK 1.80 o superior:

```c
PAL_setPalette(PAL3, elliSprt.palette->data,
           DMA);
```

Para versiones inferiores a 1.80:

```c
VDP_setPalette(PAL3,elliSprt.palette->data);
```

Para acabar la inicialización, se establecen las animaciones por defecto de los dos Sprites:

```c
SPR_setAnim(sha,SHA_STAY);
SPR_setAnim(elli,4);
```

La cual se realiza usando la función ```SPR_setAnim```, la cual permite a un Sprite definir el índice de la animación a utilizar. Recibe los siguientes parámetros:

* _sprite_: Puntero al Sprite a utilizar.
* _ind_: Índice de la animación a utilizar. Recordemos que los índices de las animaciones comienzan por 0. Como puede verse en el ejemplo, puede ser interesante definirse una serie de constantes para las animaciones.

Veamos el resto de la función ```main```:

```c
while(1)
    {

        readInput();
        SPR_setPosition(sha,sha_x,sha_y);
        SPR_update();
        //For versions prior to SGDK 1.60 use
        // VDP_waitVSync instead.
        SYS_doVBlankProcess();
    }
```

Vemos que dentro del bucle infinito, realizamos una serie de llamas a funciones; como puede ser el leer los controles síncronos (que veremos más adelante), se establece la posición de un Sprite, con la función ```SPR_setPosition```; y se actualiza el motor de Sprites llamando a la función ```SPR_update```. Además de mostrar por pantalla información como la prioridad de cada Sprite, y acabando el bucle con la llamada a ```SYS_doVBlankProcess```.

La función ```SPR_setPosition``` establece la posición del sprite en píxeles; veamos los parámetros que recibe:

* _sprite_: Puntero al Sprite a cambiar.
* _x_: Posición X en píxeles.
* _y_: Posición Y en píxeles.

Una vez que hemos terminado de ver la función ```main```, vamos a centrarnos en ver las funciones para los controles síncronos y asíncronos. Veamos estos últimos primero; que son controlados por la función ```asyncReadInput```, que hemos establecido al inicio como función controladora. Veamos fragmento de esta función:

```c
void asyncReadInput(u16 joy,
          u16 changed,u16 state){

    if(joy == JOY_1){
        if(changed & state &  BUTTON_A){
                 shaPrio=TRUE;
                 elliPrio=FALSE;
                 SPR_setZ(sha,shaPrio);
                 SPR_setZ(sha,elliPrio);
        }
        if(changed & state &  BUTTON_B){
                 shaPrio=FALSE;
                 elliPrio=TRUE;
                 SPR_setZ(sha,shaPrio);
                 SPR_setZ(sha,elliPrio);
        }
    }
}
```

Vemos como la función, comprueba si ha pulsado el controlador 1 (```JOY_1```), y si pulsa el botón A, se establece la profundidad del sprite _sha_ frente al sprite _elli_; mientras que si se pulsa el botón B, se cambia la profundidad del sprite _elli_ respecto al sprite _sha_.

La profundidad del Sprite, se puede establecer con la función ```SPR_setZ```, que recibe los siguientes parámetros:

* _sprite_: Puntero al sprite a modificar.
* _Z_: Indica la profundidad del Sprite.

Por último, y no menos importante, podemos ver como se leen los controles síncronos a partir de la función ```readInput```; la cual es quien reaccionará en función de los controles que hemos utilizado.

Veamos un fragmento de esta función:

```c
void readInput(){
    int inputValue = JOY_readJoypad(JOY_1);

    if(inputValue & BUTTON_DOWN){
        SPR_setAnim(sha,SHA_DOWN);
        sha_y++;
    }else{
        if(inputValue & BUTTON_UP){
            SPR_setAnim(sha,SHA_UP);
            sha_y--;
...
```

En este fragmento, podemos ver como se lee, en primer lugar los botones pulsados por el controlador 1 usando la función ```JOY_readJoypad``` (recuerda que puedes saber más sobre de las funciones para leer la entrada, en el capítulo de controles); a continuación, se comprueba que botón se ha pulsado; los cuales para este caso, solo utilizamos los de las direcciones.

En cada caso, se establece la animación, y se modifica la variable con la posición. El primer caso caso, solo establece 4 direcciones y solo se puede ir a una a la vez. En próximos ejemplos estableceremos para usar 8 direcciones.

Una vez hemos visto el código del ejemplo, podemos compilarlo y ejecutarlo en un emulador. Obteniendo la siguiente pantalla:

![Ejemplo 6: Sprites](9Sprites/img/ej6.png "Ejemplo 6: Sprites")
_Ejemplo 6: Sprites_

Con este ejemplo, hemos visto ya como añadir Sprites, mostrarlos en nuestro juego, y poder interactuar con él a partir de los controles. Además, de ya tener un juego más completo a partir del uso de fondos y Sprites junto con los controles.

En el siguiente capítulo, nos centraremos en la física que podemos calcular con las distintas opciones que nos provee SGDK.

## Referencias

* Mega Cat Studios: [https://megacatstudios.com/blogs/retro-development/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17](https://megacatstudios.com/blogs/retro-development/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17).
* SGDK (rescomp): [https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt](https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt).
* Charas Project (Generador Sprites): [http://charas-project.net/index.php](http://charas-project.net/index.php).
