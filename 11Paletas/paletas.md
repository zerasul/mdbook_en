# 11. Paletas de Colores

No podemos hablar de la Sega Mega Drive y su desarrollo, si no hablamos de los colores y como se manejan por este sistema. Hasta ahora hemos estado hablando de las paletas y como las podemos manejar a la hora de tratar con los planos o los distintos sprites en los distintos ejemplos que hemos estado mostrando.

En este capítulo, vamos a mostrar los distintos colores que puede manejar la Mega Drive, y como almacenarlos en las distintas paletas que podemos  manejar a nivel de hardware. Además, vamos a mostrar como realizar distintos efectos como transparencias o destacar algun color con respecto al fondo, gracias a los colores _HighLigth_ y _ShadowLigth_.

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
u16 vdpRedColor = RGB8_8_8_TO_VDPCOLOR(255,0,0)

```

La macro ```RGB8_8_8_TO_VDPCOLOR```, permite transformar un color RGB definido por 3 parametros (rojo, verde, azul) a el color equivalente para VDP. Cada uno de los parámetros tiene un valor de 0 a 255. Esto puede ser interesante para modificar colores del entorno o hacer algún efecto con el mismo.


También existen equivalentes en otros formatos:

* ```RGB24_TO_VDPCOLOR```: Transforma un color en formato RGB 24 bits a VDP.
* ```RGB3_3_3_TO_VDPCOLOR```: Transforma un color en formato RGB (r,g,b) a VDP. Donde cada componente tiene valor de 0 a 7.

Obviamente es importante saber que a la hora de trabajar con los colores y paletas usando SGDK, normalmente se importa la información de la paleta junto con la información de los gráficos. Por ello, es importante que para ahorrar colores y no tener que estar cambiando la paleta, se reutilice la paleta para distintos gráficos.

Si durante el juego tenemos que cambiar la paleta y cargar distintos gráficos, esto puede ocasionar cuellos de botella ya que la información debe pasar de la ROM a la VRAM ya sea a través de CPU o usando DMA. Usando cualquiera de estas alternativas, podemos generar dicho cuello de botella ya que comparten el bus.

## HighLigth & ShadowLigth

## Prioridades y colores

## Ejemplo con Efectos de transparencia y destacados

## Referencias

* Paleta de Colores Mega Drive: [https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB](https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB)