# 13. Scroll

Hasta ahora, hemos estado trabajando con fondos e imágenes que ocupaban todo el ancho de la pantalla; pero que ocurre si una imágen es más grande que lo que permite la pantalla; y si nuestro escenario va cambiando conforme nuestro personaje o personajes se mueven, en estos casos se utiliza el llamado Scroll o desplazamiento.

Un Scroll o desplazamiento, no es más que la posibilidad de ir desplazando los elementos de un plano en una dirección; de tal forma que podemos dar la sensación de movimiento.

En este capítulo, vamos a mostrar como utilizar las capacidades de desplazamiento que nos permite Mega Drive, gracias al VDP. Veremos los distintos tipos de Scroll que hay, y además de ver en que direcciones podemos realizarlo.

Además, veremos los distintos ejemplos, con distintos casos de uso con el Scroll o desplazamiento.

## Scroll o Desplazamiento

Como hemos comentado el Scroll o desplazamiento, es la capacidad de desplazar partes de la imágen que estamos mostrando; para el caso de la Sega Mega Drive, se trata de la capacidad de desplazar los tiles de cada plano en distintas direcciones.

El VDP; permite realizar distintos tipos de desplazamiento, de los dos planos (A y B); ya sea dependiendo de la dirección (Horizontal o vertical) o de la porción de pantalla (por línea o por columna); esto permite realizar distintos efectos y dar una mejor sensación de movimiento. Este efecto es comunmente conocido como Parallax.

Podemos diferenciar tanto el Scroll por dirección, que podremos encontrar de dos tipos:

* Horizontal: cuando el desplazamiento se hace de derecha a izquierda o viceversa.
* Vertical: cuando el desplazamiento se hace de arriba a abajo o viceversa.

Además, dependiendo de la porción de pantalla desplazada, podemos encontrar dos tipos:

* Línea: El VDP permite desplazar horizontalmente hasta 224 líneas; aunque verticalmente, tiene capacidad de desplazar algunas porciones.
* Plano: El VDP permite desplazar tanto horizontalmente, como verticalmente, un plano completo.
* Tile: Se puede realizar desplazamiento de los distintos Tiles de una línea.

En este apartado, vamos a centrarnos en estos tipos de Scroll y veremos como puede realizarse en cada una de las direcciones propuestas.

### Scroll por Líneas

Comenzaremos por hablar del desplazamiento por líneas; en este caso se trata de poder desplazar hasta 224 líneas por pantalla de forma horizontal; una por píxel. De tal forma que podemos desplazar distintas porciones de pantalla de forma independiente. Esto lo realiza el propio chip VDP, gracias a la tabla de desplazamiento que almacena en VRAM.

Cada una de las 224 líneas, almacena un fragmento del plano que podemos desplazar a derecha o a izquierda de tal forma que podemos cambiar la dirección de este si fuese necesario. No es posible realizar desplazamiento por cada columna; aunque se puede realizar por cada 2 Tiles.

Recordamos que esto puede realizarse en cada uno de los dos planos disponibles.

### Scroll por Plano

Por otro lado, también puede desplazarse un plano completo; debido por ejemplo a que un plano, puede desplazarse de arriba a abajo y de derecha a izquierda; de tal forma que podemos tener imágenes o mapas más grandes que lo permitido por pantalla (320x240 o 320x224).

Esto es debido a que el VDP, permite almacenar planos de mayor capacidad que la pantalla; para poder realizar este desplazamiento. Para comprender mejor esto, veamos un esquema.

<div class="image">
<img id="arq" src="13Scroll/img/esquemascroll.png" alt="Esquema desplazamiento" title="Esquema desplazamiento"/> </div>
<p>Esquema desplazamiento</p>

Como podemos ver en el esquema, la parte visible solo tiene por ejemplo 320px de ancho; y SGDK, reserva hasta 640px de ancho para poder almacenar el resto de imágen; lo que quede de la imagen seguira almacenada en la ROM y tendrá que ser desplazada a la parte oculta para poder realizar un desplazamiento.

Se permite un plano de 512x256px con la configuración habitual; de tal forma que podemos almacenar más imágen de la visible, y posteriormente desplazarlo tanto horizontalmente, como verticalmente.

### Scroll por Tile

Al igual que el desplazamiento por líneas, se puede realizar por Tiles; dependiendo de si es un desplazamiento horizontal, o vertical podemos realizar distintos movimientos de Tiles.

En el caso de desplazamiento horizontal, se puede realizar por cada Tile; sin embargo, para el movimiento vertical, deben hacerse cada 2 Tiles; por lo que se puede realizar por 20 columnas de 2 Tiles cada una.

Toda la información de desplazamiento tanto vertical como horizontal, se almacena en la VRAM y es accesible por el VDP.

## Ejemplo usando Scroll

Hemos podido ver la teoria de como realizar Scroll por línea, plano o Tiles; por lo que para poder entender mejor como se realizan estos desplazamientos, vamos a ver tres ejemplos:

* Ejemplo de desplazamiento por líneas; vamos a ver deformar un logo para hacer un efecto usando desplazamiento
* Ejemplo de desplazamiento de plano; en este caso, vamos a realizar el famoso efecto paralax para que podamos ver como desplazamos el plano, para mostrar un mapa mayor.
* Ejemplo de desplazamiento por Tiles; en este último ejemplo, vamos a ver como utilizando 1 Tile y un Tilemap, podemos generar un efecto de lluvia, usando desplazamiento por Tiles.

Recuerda; que todos los ejemplos que mencionamos en este libro, los tienes disponible en el repositorio de Github que acompaña a este libro; aquí tienes la dirección:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

### Scroll por lineas

En este primer ejemplo, vamos a centrarnos en realizar desplazamiento por líneas; recordamos que se pueden realizar desplazamiento de las 224 líneas horizontales que tenemos disponibles.

Para este ejemplo, usaremos una imagen con un logo recordando a la pantalla de inicio de Sonic por ejemplo; esta es la imagen.

<div class="image">
<img id="arq" src="13Scroll/img/logo.png" alt="Imagen de ejemplo" title="Imagen de ejemplo"/> </div>
<p>Imagen de ejemplo</p>

Lo que vamos a realizar es realizar un desplazamiento de cada línea; las líneas pares iran hacia un lado, y las impares, hacia el otro. Veamos como podemos realizarlo.

En primer lugar, necesitaremos dibujar la imágen en el plano a utilizar:

```c
VDP_drawImageEx(BG_B,&logo,
    TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE,index)
    ,0,0,TRUE,DMA);
```

Una vez dibujado, vamos a configurar que tipo de Scroll vamos a utilizar tanto horizontalmente, como vericalmente; para ello, utilizaremos la función ```VDP_setScrollingMode```; la cual permite configurar que tipo o modo de Scroll utilizaremos; veamos que parámetros recibe esta función:

* _HScrollMode_: Modo a utilizar para desplazamiento horizontal. Puede tomar los siguientes valores:
    * ```HSCROLL_LINE```: Incida que será un desplazamiento horizontal por líneas.
    * ```HSCROLL_PLANE```: Indica que será un desplazamiento horizontal del plano.
    * ```HSCROLL_TILE```: Indica que será un desplazamiento horizontal por Tile.
* _VScrollMode_: Modo a utilizar para desplazamiento vertical. Puede tomar los siguientes valores:
    * ```VSCROLL_PLANE```: Indica que se realizará un desplazamiento vertical por plano.
    * ```VSCROLL_2TILE```: Indica que se realizará un desplazamiento vertical por cada 2 Tile.

Recuerda que en este caso, vamos a realizar un desplazamiento por línea horizontalmente, por lo que tendremos que configurar el Scroll de la siguiente forma:

```c
VDP_setScrollingMode(HSCROLL_LINE,VSCROLL_PLANE);
```

Una vez configurado, vamos a cargar los desplazamientos que tendrá cada línea de esta forma que necesitaremos una variable por línea; por lo que crearemos un array para almacenar todos los desplazamientos.

```c
s16 lines[224];
```

Este array lo inicializamos a cero; para que tengan todas las posiciones valor; y posteriormente es cuando le damos valores; para las líneas pares se incrementa el desplazamiento, y para las impares se decrementa. Esto nos permitirá, dar una sensación de movimiento y crear una deformación del logo.

```c
for(i=84;i<121;i+=2){
    lines[i]+=2;
}

for(i=85;i<120;i+=2){
    lines[i]-=2;
}
```

Por último, solo nos queda realizar el desplazamiento de las líneas:

```c
VDP_setHorizontalScrollLine(BG_B,0,lines
    ,224,DMA_QUEUE);
```

Esta función llamada ```VDP_setHorizontalScrollLine``` permite realizar desplazamiento de línea de un fragmento del plano. Recibe los siguientes parámetros:

* _plane_: Plano a utilizar; puede ser ```BG_A``` o ```BG_B```.
* _firstLine_: Primera línea a cambiar.
* _lines_: información de desplazamiento para cada línea a desplazar.
* _nLines_: Número de líneas a desplazar.
* _tm_: método de transferencia; permite utilizar la CPU, o los distintos valores de DMA; puede tener los siguientes valores:
    * CPU: se utilizará la CPU.
    * DMA: se utilizará DMA.
    * DMA_QUEUE: Se utilizará la cola de DMA.
    * DMA_QUEUE_COPY: Se utilizará cola de DMA como copia.

Habrás podido ver, que estamos mandando información de cada una de las líneas; se desplacen o no; esto no es lo más eficiente; ya que podemos crear un array sólo con la información de las líneas a desplazar. De tal forma que será más eficiente y menos consumo de recursos realizará el hardware.

Una vez hemos podido explicar el código y como funciona este ejemplo, ya podemos compilar y ejecutar, para poder ver en un emulador como queda tal efecto.

<div class="image">
<img id="arq" src="13Scroll/img/ej11.png" alt="Ejemplo 11: Scroll de línea" title="Ejemplo 11: Scroll de línea"/> </div>
<p>Ejemplo 11: Scroll de línea</p>

### Scroll por plano

### Scroll por Tile

### Scroll usando MAP

## Referencias

* Scroll (Sega Retro): [https://segaretro.org/Sega_Mega_Drive/Scrolling](https://segaretro.org/Sega_Mega_Drive/Scrolling)
* VDP Scrolling (Mega Drive Wiki): [https://wiki.megadrive.org/index.php?title=VDP_Scrolling](https://wiki.megadrive.org/index.php?title=VDP_Scrolling)
* Scroll por líneas (Danibus): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/)
* Scroll por planos (Danibus): [https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/](https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/)
* Scroll por Tiles (Danibus): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/)
* TileSet Nature (Open Game Art): [https://opengameart.org/content/nature-tileset](https://opengameart.org/content/nature-tileset)
* Street Backgrounds (Open Game Art): [https://opengameart.org/content/pixel-art-street-backgrounds](https://opengameart.org/content/pixel-art-street-backgrounds)