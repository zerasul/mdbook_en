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



## Ejemplo con Efectos de transparencia y destacados

## Referencias

* Paleta de Colores Mega Drive: [https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB](https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB)
* Danibus (Aventuras en Mega Drive): [https://danibus.wordpress.com/2019/09/13/14-aventuras-en-megadrive-highlight-and-shadow/](https://danibus.wordpress.com/2019/09/13/14-aventuras-en-megadrive-highlight-and-shadow/)