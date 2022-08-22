# 11. Paletas de Colores

No podemos hablar de la Sega Mega Drive y su desarrollo, si no hablamos de los colores y como se manejan por este sistema. Hasta ahora hemos estado hablando de las paletas y como las podemos manejar a la hora de tratar con los planos o los distintos sprites en los distintos ejemplos que hemos estado mostrando.

En este capítulo, vamos a mostrar los distintos colores que puede manejar la Mega Drive, y como almacenarlos en las distintas paletas que podemos  manejar a nivel de hardware. Además, vamos a mostrar como realizar distintos efectos como transparencias o destacar algun color con respecto al fondo, gracias a los colores _HighLight_ y _Shadow_.

Por último, veremos un ejemplo donde manejaremos los distintos efectos, y además, veremos algunas funciones avanzadas relacionadas con el pintado de pantalla que nos va a ayudar a añadir mayores efectos.

## Color en Sega Mega Drive

Hasta ahora hemos comentado, que Sega Mega Drive, puede mostrar hasta 64 colores en pantalla (en realidad 61 sin contar colores transparentes). Esto es debido a que Sega Mega Drive, trabaja siempre con paletas de colores de 16 colores y que solo se disponen de 4 paletas.

Sin embargo, no hemos podido ver cuantos colores en total, puede mostrar Sega Mega Drive. Sega Mega Drive, almacena los colores en una paleta de colores de 9bits RGB. Esto quiere decir, que puede mostrar 512 colores que es capaz de manejar Sega Mega Drive. Pero recordamos que solo podremos ver 64 colores por pantalla debido a las 4 paletas de 16 colores.

<div class="image">
<img id="arq" src="11Paletas/img/RGB_9bits_palette.png" alt="Paleta de Colores" title="Paleta de Colores"/> </div>
<p>Paleta de Colores (Wikipedia)</p>

Como podemos ver en la anterior imagen, se muestran los distintos colores que es capaz de mostrar la Sega Mega Drive. y es importante tener esto en cuenta, ya que a la hora de trabajar los distintos gráficos, debemos saber a que color correspondería en Sega Mega Drive si estamos trabajando con RGB desde nuestro equipo de desarrollo.

En el caso de que el color con el que estamos trabajando no corresponda a un color para la Sega Mega Drive, SGDK, transformará este color al más aproximado.

Además, SGDK trae funciones y macros, para trabajar con distintos colores. Por ejemplo:

```c
u16 vdpRedColor = 
    RGB8_8_8_TO_VDPCOLOR(255,0,0)

```

La macro ```RGB8_8_8_TO_VDPCOLOR```, permite transformar un color RGB definido por 3 parametros (rojo, verde, azul) a el color equivalente para VDP. Cada uno de los parámetros tiene un valor de 0 a 255. Esto puede ser interesante para modificar colores del entorno o hacer algún efecto con el mismo.


También existen equivalentes en otros formatos:

* ```RGB24_TO_VDPCOLOR```: Transforma un color en formato RGB 24 bits a VDP.
* ```RGB3_3_3_TO_VDPCOLOR```: Transforma un color en formato RGB (r,g,b) a VDP. Donde cada componente tiene valor de 0 a 7.

Obviamente es importante saber que a la hora de trabajar con los colores y paletas usando SGDK, normalmente se importa la información de la paleta junto con la información de los gráficos. Por ello, es importante que para ahorrar colores y no tener que estar cambiando la paleta, se reutilice la paleta para distintos gráficos.

Si durante el juego tenemos que cambiar la paleta y cargar distintos gráficos, esto puede ocasionar cuellos de botella ya que la información debe pasar de la ROM a la VRAM ya sea a través de CPU o usando DMA. Usando cualquiera de estas alternativas, podemos generar dicho cuello de botella ya que comparten el bus.

## HighLight & Shadow

Hemos podido ver como trabajar con los distintos colores que nos provee la Sega Mega Drive. Usando las distintas paletas que tenemos disponibles, podemos trabajar con hasta 64 colores en pantalla. Sin embargo, este número es ampliable gracias entre otros al uso de HighLight y Shadow.

El uso de estos modos, permite ampliar el número de colores, modificando el brillo de la paleta; de dos modos:

* _HighLight_: Aumenta el brillo al doble, mostrando colores más llamativos.
* _Shadow_: Disminuye el brillo a la mitad, mostrando colores más oscuros.

De esta forma, puede aumentar el número de colores y mostrar distintos efectos como puede ser el destacar un personaje u oscurecer una zona.

<div class="image">
<img id="arq" src="11Paletas/img/paletas.png" alt="Modos HighLight y Shadow" title="Modos HighLight y Shadow"/> </div>
<p>Modos HighLight y Shadow</p>

**NOTA:**  Para aquellos que tengan la versión impresa o que lean este capítulo en escala de grises, podrán ver este y otros ejemplos en el repositorio de código fuente que acompaña este libro, a todo color.

Podemos ver en la imagen anterior, como la misma paleta de colores, puede estar en modo HighLight o modo shadow ampliando el número de colores a poder mostrar con solo una paleta. Sin embargo, estos colores no son siempre ampliables por tres (es decir, que de 16 colores pasa a 48). Sino que depende de varios casos, se mostrarán más o menos colores.

En este apartado, vamos a mostrar como trabajan estos modos en la Sega mega Drive. Ya que dependiendo de lo que se va a mostrar y dela prioridad del mismo, se tiene un comportamiento u otro. Vamos a ver como se comporta estos modos en planos y Sprites.

Para activar el modo HighLight/Shadow, puede usarse la función ```VDP_setHilightShadow``` la cual se indica si se activa o no. Recibe por parametro con valor 1 o 0. Por ejemplo:

```c
VDP_setHilightShadow(1);
```

Vamos a ver como se comporta esta función al activarla en Planos o Sprites.

### Planos

A la hora de trabajar con planos, no se puede acceder al modo HighLight; ya que esta preparado para Sprites. Sin embargo, si podemos acceder a los colores de los otros dos modos. Teniendo en cuenta las siguientes características:

* Si los Tiles tienen prioridad, se mostrará con los colores Normales.
* Si los Tiles no tienen prioridad, se mostrará el modo shadow.
* Si un Tile con prioridad se solapa con otro sin prioridad, se mostrarán con el color normal.


### Sprites

Cuando se trabaja con Sprites, tenemos que tener en cuenta las siguientes características:

* Si la paleta utilizada es una de las 3 primeras, (```PAL0```, ```PAL1```, ```PAL2```), se comportará igual que los planos (con prioridad color normal, sin prioridad Shadow).
* Si la paleta utilizada es la cuarta (```PAL3```), tenemos que tener en cuenta los siguientes casos:
    * Si el fondo del Sprite tiene color Normal:
        * Los colores 14 y 15 de la paleta se mostrarán en modo _HighLight_.
        * El resto de colores se mostrarán normal.
    * Si el fondo del Sprite tiene color Shadow:
        * El color 14 de la paleta se mostrará en modo Normal.
        * El color 15 de la paleta no se mostrará. Esto nos puede ayudar a simular transparencias.

Además, para los Sprites en modo Shadow, mostrará solo los píxeles del fondo más oscurezidos. Esto nos puede ayudar a simular sombras. Veremos más adelante en los ejemplos como realizar estos efectos.

Es importante saber que a la hora de trabajar con estos modos, puede cambiar el comportamiento dependiendo del emulador a utilizar. Por lo que puede ser interesante probarlo en hardware real, además de probarlo en algún emulador como _Blastem_ o _Kega Fusion_.

## Manejo de Paletas y colores en CRAM

Otro aspecto a tener en cuenta, es a la hora de trabajar con los distintos colores y como podemos manejar los distintos colores almacenados en la CRAM (Color RAM).

En este apartado, vamos a mostrar algunas funciones útiles que posteriormente algunas usaremos en un ejemplo.

Es importante saber que el contenido de las 4 paletas se almacena en la CRAM y que puede se accedida por un índice, desde el 0 al 63. Para acceder, podemos hacerlo a través de la función ```PAL_getColor```. La cual recibe el siguiente parámetro:

* _index_: índice de 0 a 63 para acceder al color de la CRAM.

Esta función devuelve el valor RGB del color que hay en dicha posición de la CRAM.

También se puede establecer el color que hay en una posición en concreto. En este caso se usará la función ```PAL_setColor``` la cual recibe los siguientes parámetros:

* _index_: Índice de la CRAM (0 a 63), para poder establecer el color a sustituir.
* _value_: Valor RGB del color a utilizar. En este caso, se pueden utilizar las funciones ```RGB8_8_8_TO_VDPCOLOR``` o similar, para establecer el valor del color.

Un aspecto a tener en cuenta, es que estas funciones modifican el valor de la CRAM que se encuentra junto al VDP; por lo tanto, el valor del color debe escribirse y si se utiliza tanto la CPU, como el DMA tenemos que tener en cuenta que puede haber un cuello de botella.

Puedes encontrar más información acerca de las funciones para modificar los colores de la CRAM tanto por CPU como por DMA, dentro de la propia documentación del SGDK.

## Ejemplo con Efectos de Shadow y Paletas

En este capítulo hemos estado trabajando con las paletas de colores y los efectos que podemos hacer en ellas. Por ello, el ejemplo que vamos a estudiar, usaremos las distintas paletas de colores y su correspondientes efectos Shadow.

En este ejemplo, vamos a utilizar las caráteristicas de la prioridad, para poder simular un efecto de luces; simulando en este caso, la luz de unas farolas, y ver como afecta a los distintos Sprites,con las distintas características que pueda tener.

El ejemplo que vamos a estudiar, llamado _ej8.colors_, lo puedes encontrar en el repositorio de ejemplos que acompaña a este libro. Recordamos que dicho repositorio; lo puedes encontrar en la siguiente dirección:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

En este caso, vamos a mostrar un fondo que hemos generado nosotros usando distintos recursos que hemos encontrado por Internet; puedes ver dichos recursos y dar crédito a los autores en las referencias de este capítulo. Veamos el fondo que vamos a mostrar:

<div class="image">
<img id="arq" src="11Paletas/img/fondo1.png" alt="Fondo Ejemplo" title="Fondo Ejemplo"/> </div>
<p>Fondo Ejemplo</p>

Como podemos ver en la imágen, vemos un paisaje nocturo donde podemos observar 3 farolas. La Idea del ejemplo, es mostrar que debajo de cada farola haya un haz de luz pero fuera de estas se note un color más oscuro. Este efecto lo podemos realizar usando un mapa de prioridad.

Esto se puede realizar, usando otra imágen, con las zonas que queremos iluminar; de esta forma, al poner ambas imágenes se mostrarán las zonas que esten pintadas en la segunda imagen, más claras que las que no; utilizando el efecto Shadow.

Veamos la imágen del mapa de prioridades:

<div class="image">
<img id="arq" src="11Paletas/img/fondo2.png" alt="Mapa Prioridad" title="Mapa Prioridad"/> </div>
<p>Mapa Prioridad</p>

Como vemos en esta imagen, las zonas moradas, serán las que se mostrarán más claras que las que estan de color negro, que coinciden con la posición de las farolas del primer fondo. Este efecto es debido a que a nivel de plano, los tiles con prioridad se mostrarán de forma normal, mientras que los Tiles que esten pintados sin prioridad, tendrán el efecto shadow; de ahí que tenga el efecto de iluminación. Veamos como se realiza este efecto a nivel de código para establecer la prioridad solo de las zonas que estan marcadas.

Cada fondo se carga usando un fichero _.res_ con la definición de ambas imágenes:

```res
IMAGE bg_color1 "gfx/fondocolor1.png" NONE
IMAGE bg_prio "gfx/fondocolor2.png" NONE
```

En el código fuente, puedes encontrar la función ```drawPriorityMap```, la cual nos va a dibujar en el plano A el mapa de prioridades, a partir de la segunda imágen. Este recibe la imagen que contiene las prioridades por parámetro; veamos un fargmento con la función:

```c
    u16 tilemap_buff[MAXTILES];
    u16* priority_map_pointer = &tilemap_buff[0];

    for(int j=0; j<MAXTILES;j++) tilemap_buff[j]=0;

    u16 *shadow_tilemap = bg_map->tilemap->tilemap;
    u16 numTiles = MAXTILES;
    while(numTiles--){
        if(*shadow_tilemap){
            *priority_map_pointer |= TILE_ATTR_PRIORITY_MASK;
        }
        priority_map_pointer++;
        shadow_tilemap++;
    }
    VDP_setTileMapDataRectEx(BG_A,&tilemap_buff[0],0,
    0,0,MAP_WITH,MAP_HEIGHT,MAP_WITH,CPU);
```

En primer lugar, podemos observar como se inicializa a vacío un buffer que utilizaremos para dibujar la imagen; posteriormente, vamos a ir recorriendo cada Tile del mapa de prioridad, y comparándola con una máscara especial.

La máscara ```TILE_ATTR_PRIORITY_MASK```; permite almacenar en cada Tile, solo la información de prioridad; de tal forma que no se mostrará nada por pantalla; esto es importante para poder mostrar el fondo de atrás con los distintos efectos.

Una vez se ha rellenado el mapa de prioridades, se pinta en el plano A, usando la función ```VDP_setTileMapDataRectEx```; la cual nos va a permitir dibujar un rectángulo como mapa de Tiles por pantalla.

Una vez hemos dibujado este mapa, podemos dibujar el otro fondo de la forma que ya conocemos; pero sin prioridad:

```c
VDP_drawImageEx(BG_B, &bg_color1,
    TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE,index), 0,0,TRUE,CPU);
```

Vemos como esta imágen la dibujamos en el plano B sin prioridad y usamos la paleta 0.

Además en este caso, vamos a mostrar un Sprite que dibujaremos sin prioridad, y que podemos mover a la izquierda o a la derecha. El cual lo dibujamos sin prioridad, y usaremos la Paleta 1.

```c
 zera = SPR_addSprite(&zera_spr,
        zera_x,
        zera_y,
        TILE_ATTR(PAL1,FALSE,FALSE,FALSE));
```

Por último y más importante, tenemos que activar el modo Shadow HighLight; usando la función ```VDP_setHilightShadow```, estableciendo el valor a 1.

```c
    VDP_setHilightShadow(1);
```

Si todo ha ido bien, podemos ver una imágen parecida a esta:

<div class="image">
<img id="arq" src="11Paletas/img/ej8.png" alt="Ejemplo 8: Colores y Shadow" title="Ejemplo 8: Colores y Shadow"/> </div>
<p>Ejemplo 8: Colores y Shadow</p>

Como vemos en la imágen, en cada farola se muestra una parte iluminada; esto es debido a que dichas zonas se estan pintando Tiles con Prioridad; de tal forma que se muestran de forma normal; el resto de Tiles que no tienen prioridad, se muestran en modo Shadow. De tal forma, que podemos ver como dicho modo con los planos se comporta como hemos comentado en este capítulo.

También vemos que a nivel de Sprite, si vamos moviendo a nuestro personaje, es afectado tambien por el modo Shadow; de esta forma podemos dar la sensación de una iluminación que es afectada por nuestro personaje. Obviamente, podemos trabajar tambien con el modo HighLight, usando la Paleta 3, y jugando con los colores 14 y 15. Pero eso lo podemos ver en ejemplos más adelante.

Con este ejemplo, ya hemos podido ver como funcionan las paletas de colores y los modos Shadow y HighLight.

## Referencias

* Paleta de Colores Mega Drive: [https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB](https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB)
* Danibus (Aventuras en Mega Drive): [https://danibus.wordpress.com/2019/09/13/14-aventuras-en-megadrive-highlight-and-shadow/](https://danibus.wordpress.com/2019/09/13/14-aventuras-en-megadrive-highlight-and-shadow/)
* Open Game Art (Night Background): [https://opengameart.org/content/background-night](https://opengameart.org/content/background-night)
* Open Game Art (Nature TileSet): [https://opengameart.org/content/nature-tileset](https://opengameart.org/content/nature-tileset)
