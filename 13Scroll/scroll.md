# 13. Scroll

Hasta ahora, hemos estado trabajando con fondos e imágenes que ocupaban todo el ancho de la pantalla; pero que ocurre si una imagen es más grande que lo que permite la pantalla; y si nuestro escenario va cambiando conforme nuestro personaje o personajes se mueven, en estos casos se utiliza el llamado Scroll o desplazamiento.

Un Scroll o desplazamiento, no es más que la posibilidad de ir desplazando los elementos de un plano en una dirección; de tal forma que podemos dar la sensación de movimiento.

En este capítulo, vamos a mostrar como utilizar las capacidades de desplazamiento que nos permite Mega Drive, gracias al VDP. Veremos los distintos tipos de Scroll que hay, y además de ver en que direcciones podemos realizarlo.

Además, veremos los distintos ejemplos, con distintos casos de uso con el Scroll o desplazamiento.

## Scroll o Desplazamiento

Como hemos comentado el Scroll o desplazamiento, es la capacidad de desplazar partes de la imagen que estamos mostrando; para el caso de la Sega Mega Drive, se trata de la capacidad de desplazar los tiles de cada plano en distintas direcciones.

El VDP; permite realizar distintos tipos de desplazamiento, de los dos planos (A y B); ya sea dependiendo de la dirección (Horizontal o vertical) o de la porción de pantalla (por línea o por columna); esto permite realizar distintos efectos y dar una mejor sensación de movimiento. Este efecto es comúnmente conocido como Parallax.

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

Como podemos ver en el esquema, la parte visible solo tiene por ejemplo 320px de ancho; y SGDK, reserva hasta 640px de ancho para poder almacenar el resto de imagen; lo que quede de la imagen seguirá almacenada en la ROM y tendrá que ser desplazada a la parte oculta para poder realizar un desplazamiento.

Se permite un plano de 512x256px con la configuración habitual; de tal forma que podemos almacenar más imagen de la visible, y posteriormente desplazarlo tanto horizontalmente, como verticalmente.

### Scroll por Tile

Al igual que el desplazamiento por líneas, se puede realizar por Tiles; dependiendo de si es un desplazamiento horizontal, o vertical podemos realizar distintos movimientos de Tiles.

En el caso de desplazamiento horizontal, se puede realizar por cada Tile; sin embargo, para el movimiento vertical, deben hacerse cada 2 Tiles; por lo que se puede realizar por 20 columnas de 2 Tiles cada una.

Toda la información de desplazamiento tanto vertical como horizontal, se almacena en la VRAM y es accesible por el VDP.

## Ejemplo usando Scroll

Hemos podido ver la teoría de como realizar Scroll por línea, plano o Tiles; por lo que para poder entender mejor como se realizan estos desplazamientos, vamos a ver tres ejemplos:

* Ejemplo de desplazamiento por líneas; vamos a ver deformar un logo para hacer un efecto usando desplazamiento
* Ejemplo de desplazamiento de plano; en este caso, vamos a realizar el famoso efecto paralax para que podamos ver como desplazamos el plano, para mostrar un mapa mayor.
* Ejemplo de desplazamiento por Tiles; en este último ejemplo, vamos a ver como utilizando 1 Tile y un Tilemap, podemos generar un efecto de lluvia, usando desplazamiento por Tiles.

Recuerda; que todos los ejemplos que mencionamos en este libro, los tienes disponible en el repositorio de Github que acompaña a este libro; aquí tienes la dirección:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

### Scroll por lineas

En este primer ejemplo, vamos a centrarnos en realizar desplazamiento por líneas; recordamos que se pueden realizar desplazamiento de las 224 líneas horizontales que tenemos disponibles. Este ejemplo corresponde a la carpeta _ej11.linescroll_; que encontrarás en el repositorio de ejemplos.

Para este ejemplo, usaremos una imagen con un logo recordando a la pantalla de inicio de Sonic por ejemplo; esta es la imagen.

<div class="image">
<img id="arq" src="13Scroll/img/logo.png" alt="Imagen de ejemplo" title="Imagen de ejemplo"/> </div>
<p>Imagen de ejemplo</p>

Lo que vamos a realizar es realizar un desplazamiento de cada línea; las líneas pares irán hacia un lado, y las impares, hacia el otro. Veamos como podemos realizarlo.

En primer lugar, necesitaremos dibujar la imagen en el plano a utilizar:

```c
VDP_drawImageEx(BG_B,&logo,
    TILE_ATTR_FULL(PAL0,FALSE,
     FALSE,FALSE,index)
    ,0,0,TRUE,DMA);
```

Una vez dibujado, vamos a configurar que tipo de Scroll vamos a utilizar tanto horizontalmente, como verticalmente; para ello, utilizaremos la función ```VDP_setScrollingMode```; la cual permite configurar que tipo o modo de Scroll utilizaremos; veamos que parámetros recibe esta función:

* _HScrollMode_: Modo a utilizar para desplazamiento horizontal. Puede tomar los siguientes valores:
    * ```HSCROLL_LINE```: Incida que será un desplazamiento horizontal por líneas.
    * ```HSCROLL_PLANE```: Indica que será un desplazamiento horizontal del plano.
    * ```HSCROLL_TILE```: Indica que será un desplazamiento horizontal por Tile.
* _VScrollMode_: Modo a utilizar para desplazamiento vertical. Puede tomar los siguientes valores:
    * ```VSCROLL_PLANE```: Indica que se realizará un desplazamiento vertical por plano.
    * ```VSCROLL_2TILE```: Indica que se realizará un desplazamiento vertical por cada 2 Tile.

Recuerda que en este caso, vamos a realizar un desplazamiento por línea horizontalmente, por lo que tendremos que configurar el Scroll de la siguiente forma:

```c
VDP_setScrollingMode(
    HSCROLL_LINE,VSCROLL_PLANE);
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

Hemos podido ver el desplazamiento por líneas; pero en muchas ocasiones, necesitamos desplazar el plano ya que puede llegar a ser más grande que lo que mostramos por pantalla; además, de que la imagen a mostrar, puede ser que un escenario sea mucho más grande que lo que se puede almacenar en un plano.

Recordamos que el VDP, permite almacenar un plano de hasta 512x256px; pero en ROM, se puede almacenar información mucho más grande. En este aspecto, vamos a mostrar una imagen mucho mayor, y se irá desplazando a medida que lo necesitemos.

Este ejemplo puedes encontrarlo en el repositorio de ejemplos bajo el nombre de _ej12.planescroll_; en este ejemplo, usaremos un plano fijo, y un segundo plano, que iremos desplazando horizontalmente cuando fuese necesario.

En este ejemplo, no solo desplazaremos el plano; sino que iremos generando los Tiles necesarios conforme fuese necesario de tal forma que vamos a ir descubriendo el escenario poco a poco. Vamos a ver las imágenes que usaremos como planos.

El primer plano, que usaremos como cielo; se trata de una imagen estática que dibujaremos en el plano B.

<div class="image">
<img id="arq" src="13Scroll/img/Sky_pale.png" alt="Imagen de Fondo 1" title="Imagen de Fondo 1"/> </div>
<p>Imagen de Fondo 1 (Open Game Art)</p>

Después, tendremos el fondo que iremos desplazando; que se trata de una imagen de 640x224 píxeles; que almacenaremos en memoria ROM y que iremos mostrando conforme sea necesaria.

<div class="image">
<img id="arq" src="13Scroll/img/map1.png" alt="Imagen de Fondo 2" title="Imagen de Fondo 2"/> </div>
<p>Imagen de Fondo 2 (Open Game Art)</p>

Como vemos en la anterior imagen, el color de fondo rojo, será el color transparente (es el primer color de la paletas de colores). Con estos dos fondos y un Sprite, es con lo que vamos a trabajar.

Una vez que tengamos las imágenes, vamos a revisar el código; que hemos decidido dividir en tres partes; la función principal, la función de manejo de los controles y por último una función para actualizar la pantalla cuando sea necesaria.

Comenzaremos hablando de la función principal; donde inicializaremos todas las variables y dibujaremos los fondos. Veamos un fragmento:

```c
struct{
    Sprite* elliSprt;
    u16 x;
    u16 y;
    u16 offset;
}player;

u16 xord;
u16 countpixel;
u16 col_update;
u16 ind;
```

Vemos que se inicializan una serie de variables globales; vamos a mostrar su utilidad:

* Un Struct llamado player, con información del jugador; como el Sprite a utilizar, x, y y el offset a desplazar.
* xord: Indica si se necesita desplazar o no.
* countpixel: Esta variable nos va a ayudar a que se genere un nuevo Tile cuando sea necesario; recuerda que el movimiento de los Sprites es a nivel de pixel, mientras los fondos a nivel de Tiles.
* col_update: Indica si hay que actualizar una columna o no; será necesario para generar una nueva columna.
* ind: Indice para calcular los Tiles a almacenar en VRAM.

Con estas variables, vamos a realizar el desplazamiento; pero antes lo que realizaremos será dibujar ambos planos, y dibujar los Sprites necesarios.

```c
SPR_init();
    ind = TILE_USER_INDEX;
    VDP_drawImageEx(BG_B,&sky,
        TILE_ATTR_FULL(PAL0,FALSE,
        FALSE,FALSE,ind)
            ,0,0,TRUE,CPU);
    ind+= sky.tileset->numTile;
    VDP_drawImageEx(BG_A,&map1,
        TILE_ATTR_FULL(PAL1,FALSE,
            FALSE,FALSE,ind),
            0,0,TRUE,CPU);
    player.elliSprt=SPR_addSprite(&elli,
        20,135,
        TILE_ATTR(PAL2,FALSE,FALSE,FALSE));
    SPR_setAnim(player.elliSprt,IDLE);
    PAL_setPalette(PAL2,elli.palette->data,CPU);
```

Una vez dibujada la pantalla y los Sprites, pasaremos a configurar el modo de Scroll:

```c
 VDP_setScrollingMode(
    HSCROLL_PLANE,VSCROLL_PLANE);
```

Como vemos en el fragmento anterior, configuraremos tanto el desplazamiento horizontal como el vertical, como desplazamiento de Plano. Después dentro del bucle del juego, llamaremos al resto de funciones y se actualizará la tabla de Sprites.

Vamos a ver como funcionan el resto de funciones; en este caso la función ```void inputHandle()```, que gestiona la entrada de los botones. En este caso, se trata de que cuando el personaje se mueva a la derecha y llegue a cierto punto, se desplace y pueda avanzar por el escenario; sin embargo en este caso solo implementaremos el desplazamiento hacia la izquierda por lo que si el Sprite se mueve en dirección contraria no avanzará.

Veamos un fragmento de la función:

```c
 if(value & BUTTON_RIGHT){
    SPR_setAnim(player.elliSprt, RIGTH);
        if(player.x>220){
        xord=1;
    }else{
        player.x+=2;
        xord=0;
    } 
 }
```

En este fragmento, podemos ver que si se ha pulsado el botón derecha y el personaje esta a más de 220 píxeles a la derecha, se pondrá la variable ```xord``` a 1; indicando que habrá un desplazamiento. Además de que se actualizará la animación del Sprite.

En caso contrario, se pondrá la variable ```xord``` a cero indicando que no hay desplazamiento; además de actualizar posición y animación del Sprite.

Veamos la siguiente función; se trata de la función ```void updatePhisics()```, que actualizará todo lo necesario para realizar el desplazamiento. Veamos un Fragmento:

```c
SPR_setPosition(player.elliSprt
    ,player.x,player.y);
if(xord>0){
    player.offset+=2;
    countpixel++;
    if(countpixel>7) countpixel=0;
}
```

En este caso, vemos que si la variable ```xord``` es mayor que cero, se actualizará el desplazamiento y el contador de pixeles; de tal forma que si el contador es mayor que 7, se necesitará calcular un nuevo Tile. Veamos un último fragmento para ver como generamos dicho Tile al final del plano.

```c
if(player.offset>640) player.offset=0;
    if(countpixel==0){
        col_update=(((player.offset+320)
                >>3)&79);
        VDP_setMapEx(BG_A,map1.tilemap,
        TILE_ATTR_FULL(PAL1,FALSE,FALSE,
            FALSE,ind),col_update,0,
            col_update,0,1,28);
    }
    VDP_setHorizontalScroll(BG_A,-player.offset);
```

Vemos como al inicio, se comprueba que el offset no sea mayor que el tamaño del plano; si ocurre, se vuelve a inicializar el offset a cero para dar sensación de infinito. Una vez hecho esto, comprobaremos que ```countpixel```, sea cero; si es así se calculará la columna a actualizar; veamos esa formula:

```c
col_update=(((player.offset+320)>>3)&79);
```

En este caso se calcula el offset sumando 320 y haciendo un desplazamiento hacia la derecha de 3 posiciones (que será lo mismo que dividir por 8; pero más eficiente ya que la operación de división en el Motorola 68000, puede durar hasta 158 ciclos). Por último, se generará una nueva columna al final del Plano; veamos ese fragmento:

```c
VDP_setMapEx(BG_A,map1.tilemap,
    TILE_ATTR_FULL(PAL1,FALSE,FALSE,
        FALSE,ind),col_update,0,
        col_update,0,1,28);
```

Vemos que se llama a la función ```VDP_setMapEx``` que permite actualizar un fragmento del plano y colocar un nuevo fragmento usando el TileMap de la propia imagen. Veamos los parámetros de esta función:

* _plane_: Indica el plano a actualizar; puede ser ```BG_A```, ```BG_B```.
* _TileMap_: Puntero a la información del TileMap.
* _baseTile_: Tile Base; puede usarse la macro ```TILE_ATTR_FULL```, para generar esta información.
* _x_: posición x en Tiles.
* _y_: posición y en Tiles.
* _xm_: posición x en el TileMap.
* _ym_: Posición y en el TileMap.
* _wm_: Ancho en Tiles del Tilemap a mostrar.
* _hm_: Alto en Tiles del Tilemap a mostrar.

Por último, para este ejemplo, vamos a realizar el desplazamiento propiamente dicho. que usaremos la función ```VDP_setHorizontalScroll```; que realiza un desplazamiento horizontal del plano; recibe los siguientes parámetros:

* _plano_: plano a actualizar; puede ser  ```BG_A```, ```BG_B```.
* _offset_: Desplazamiento a realizar.

Tras ver la última función, ya podemos compilar y ejecutar el ejemplo de tal forma que podemos ver, si pulsamos a la derecha y el personaje llega a cierto punto, como se va desplazando el plano.

<div class="image">
<img id="arq" src="13Scroll/img/ej12.png" alt="Ejemplo 12: Scroll por plano" title="Ejemplo 12: Scroll por plano"/> </div>
<p>Ejemplo 12: Scroll por plano</p>

### Scroll por Tile

Aun queda un modo de Desplazamiento o Scroll que ver; se trata de la capacidad de desplazar a nivel de Tile o conjunto de Tiles el plano; esto puede ser util para crear distintos efectos y poder dar una mayor experiencia al jugador. Vamos a ver por ejemplo, como hacer un efecto de lluvia, usando desplazamiento por Tiles. En este caso, vamos a usar el ejemplo que se encuentra en el repositorio de ejemplos; dentro de la carpeta con nombre _ej13.tilescroll_. En este ejemplo, vamos a crear un efecto lluvia, usando un TileMap y desplazamiento de 2 Tiles Verticalmente.

En primer lugar, vamos a usar un fondo, y un TileMap que generaremos a partir de un pequeño TileSet; por lo que importaremos cada recurso usando _rescomp_ con la información de los recursos a importar:

```res
PALETTE rainplt "rain.png"
TILESET rain "rain.png" NONE NONE
IMAGE city "city3.png" NONE NONE
```

Vemos que importamos una imagen, un tileSet y la correspondiente paleta. El fondo a utilizar recuerda a una ciudad por la noche; mostramos la imagen del fondo.

<div class="image">
<img id="arq" src="13Scroll/img/city3.png" alt="Fondo ejemplo 13" title="Fondo ejemplo 13"/> </div>
<p>Fondo ejemplo 13 (Open Game Art)</p>

Una vez vista esta imagen, vamos a revisar el código fuente; comenzaremos viendo, como dibujar cada fondo; uno como imagen, y el otro usaremos el TileSet _rain_, para generar un TileMap para simular la lluvia. Veamos un fragmento:

```c
 u16 ind = TILE_USER_INDEX;
VDP_loadTileSet(&rain,ind,DMA);
PAL_setPalette(PAL1,rainplt.data,CPU);
u16 tileMap[2048];
int i;
for(i=0;i<2048;i++){
    tileMap[i]=TILE_ATTR_FULL(
        PAL1,FALSE,
        FALSE,FALSE,ind);
}
VDP_setTileMapDataRect(BG_A,tileMap,
0,0,40,32,40,DMA_QUEUE);
```

Como puede observar, creamos un TileMap a partir de los Tiles; que componen el TileSet que hemos cargado; y dibujamos la pantalla, usando un rectángulo de 40x32 Tiles (Todo el espacio disponible a lo Alto). Una vez cargado el TileMap en el fondo A, dibujaremos la imagen en el fondo B; ambos con baja prioridad; por lo que el fondo B estará detrás del fondo A; dando sensación de profundidad.

```c
VDP_drawImageEx(BG_B,&city,
    TILE_ATTR_FULL(PAL0,FALSE,
        FALSE,FALSE,ind),0,0,TRUE,CPU);
```

Tras haber dibujado ambos fondos, ya solo nos queda realizar el desplazamiento; por lo que configuraremos el modo de Scroll.

```c
VDP_setScrollingMode(
    HSCROLL_PLANE,VSCROLL_2TILE);  
```

Hemos configurado el Scroll horizontal, como de tipo plano (en este ejemplo no desplazaremos horizontalmente); y el scroll vertical como ```VSCROLL_2TILE``` que indica que se realiza desplazamiento cada 2 Tiles; ya que en Mega Drive no se puede realizar scroll vertical de 1 solo Tile.

Una vez configurado, pasaremos a cargar un vector con los valores de Desplazamiento:

```c
s16 scrollVector[20];
  
for(i=0;i<20;i++){
    scrollVector[i]=0;
}
```

Este array de 20 posiciones, (1 por columna desplazada), nos permitirá cargar el valor que se va a ir desplazando cada una de las columnas. Una vez cargado, pasaremos a realizar dentro del bucle del juego, el desplazamiento.

```c
while(1)
    {
        for(i=0;i<20;i++){
            scrollVector[i]-=5;
        }
        VDP_setVerticalScrollTile(BG_A,
            0,scrollVector,20,CPU);
        SYS_doVBlankProcess();
    }
```

Veras que se realiza un desplazamiento cada 5 unidades; que será el numero de Tiles que se desplazará por cada tramo; además de que vemos que usamos la función ```VDP_setVerticalScrollTile```; es la que realiza el desplazamiento. Esta función recibe los siguientes parámetros:

* _plane_: Fondo a desplazar los Tiles; puede ser  ```BG_A```, ```BG_B```.
* _firstcol_: Primera columna a desplazar.
* _scroll_: Array con los valores a desplazar.
* nTiles: Numero de Columnas a desplazar.
* _tm_: método de transferencia; permite utilizar la CPU, o los distintos valores de DMA; puede tener los siguientes valores:
    * CPU: se utilizará la CPU.
    * DMA: se utilizará DMA.
    * DMA_QUEUE: Se utilizará la cola de DMA.
    * DMA_QUEUE_COPY: Se utilizará cola de DMA como copia.

Tras revisar las funciones y comprobar que el código es correcto, ya podemos compilar y ejecutar este ejemplo. Podrás ver como la lluvia va desplazándose sobre la ciudad; aunque en este caso estamos desplazando todas las posiciones a la vez, y puede dar la sensación de desplazamiento de plano, podemos cambiar dichos valores y hacer más pruebas para comprobar su uso.

<div class="image">
<img id="arq" src="13Scroll/img/ej13.png" alt="Ejemplo 13" title="Ejemplo 13"/> </div>
<p>Ejemplo 13</p>

### Scroll usando MAP

Aún queda por comentar una forma de realizar scroll; como habrás podido ver, en el ejemplo de desplazamiento por plano, es bastante engorroso tener que calcular el siguiente Tile a mostrar; por ello, se pueden usar unas funciones alternativas, gracias a la estructura ```Map```.

Esta estructura fue añadida dentro de la versión 1.60 de SGDK; por lo que solo se podrá usar este ejemplo en dicha versión o superior; un Map, es una estructura que almacena una gran cantidad de información acerca de una imagen o escenario; por lo que usar este tipo de funciones tenemos que tener cuidado para no realizar cuellos de botella con la CPU o DMA.

Para este ejemplo, vamos a reutilizar el ejemplo 12 para desplazar un plano, pero lo realizaremos será una modificación para utilizar Map, en vez de realizar nosotros el desplazamiento.

Vamos a comenzar, mostrando como vamos a importar los recursos; ya que ya no serán dos imágenes; sino una imagen, un tileset, una paleta y por último un Map.

```res
PALETTE pltmap "map1.png"
TILESET map_tileset "map1.png" NONE ALL
MAP map1 "map1.png" map_tileset NONE 0 
IMAGE sky "Sky_pale.png" NONE 
```

Como podemos observar, cargamos una paleta, un Tileset y un Mapa a partir de la imagen que queremos mostrar. Veamos como se importa un recurso de tipo Map:

```
MAP name "file" tileset-ref compression offset
```

* _name_: nombre del recurso
* _file_: Fichero a cargar; puede ser una imagen, o un fichero TMX de Tiled.
* _tileset-ref_: Referencia al Tileset.
* _compression_: Tipo de compresión:
    * -1/BEST/AUTO: Usa la mejor compresión posible.
    * 0/NONE: Ninguna compresión
    * 1/APLIB: Utiliza compresión con APLIB.
    * 2/FAST/LZ4W: compresión usando lz4.
* _mapbase_: Tileset Base u offset.

**NOTA**: Recuerda que para cargar ficheros TMX, necesitaras SGDK versión 1.80 o superior.

Una vez cargados los recursos con rescomp, ya podemos crear el mapa y realizar Scroll; veamos como se crea el mapa.

```c
Map* map=MAP_create(&map1,BG_A,
    TILE_ATTR_FULL(PAL1,FALSE,
        FALSE,FALSE,ind));
```

La función ```Map_create```; crea un nuevo struct Map; que nos permitirá tener la información de dicho mapa y podremos usar los recursos que tiene; vamos a ver sus parámetros:

* _map_: Puntero a la definición del mapa cargado por rescomp.
* _plane_: Fondo a desplazar los Tiles; puede ser  ```BG_A```, ```BG_B```.
* _TileBase_: Tile Base a usar; se puede usar la macro ```TILE_ATTR_FULL```, para cargar la información del Tile.

**NOTA**: Es muy importante saber, que esta función utiliza el DMA, para poder cargar la información en VRAM; por lo que no es recomendable, cargar varios mapas en un mismo frame.

Esta función, devuelve un puntero a una estrcutura ```Map``` con toda la información del mapa o escenario a mostrar.

Tras ver; como crear un mapa, vamos a pasar a como realizar Scroll; en este caso se utiliza la función ``` MAP_scrollTo```; que realiza el Scroll del mapa y recalcula los Tiles conforme se van necesitando. Ya no es necesario contar los Tiles e ir generando los Tiles fuera de pantalla; ya lo realiza esta función. Veamos los parámetros que recibe:

* _map_: Puntero con la información del mapa creado (que devuelve la función ```Map_create```).
* _x_: Desplazamiento en eje X (En pixeles).
* _y_: Desplazamiento en eje Y (En pixeles).

Esta función, es llamada dentro de ```updatePhisics```; que ya no se realiza con ninguna condición; sino cuando se modifica la variable ```offset```

Ya podemos compilar y ejecutar este ejemplo; el cual veremos que tiene un comportamiento análogo al ejemplo 12. Sin embargo, la lógica es mucho más sencilla. Puedes encontrar más información acerca de la estructura Map y las funciones que lo utilizan en la documentación de SGDK.

<div class="image">
<img id="arq" src="13Scroll/img/ej12.png" alt="Ejemplo 14" title="Ejemplo 14"/> </div>
<p>Ejemplo 14</p>

Tras ver este último ejemplo, ya podemos concluir este capítulo; donde hemos podido ver como funciona el Scroll o desplazamiento, que permite crear distintos efectos y dar una mejor sensación a nuestros juegos.

## Referencias

* SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* Scroll (Sega Retro): [https://segaretro.org/Sega_Mega_Drive/Scrolling](https://segaretro.org/Sega_Mega_Drive/Scrolling).
* VDP Scrolling (Mega Drive Wiki): [https://wiki.megadrive.org/index.php?title=VDP_Scrolling](https://wiki.megadrive.org/index.php?title=VDP_Scrolling).
* Scroll por líneas (Danibus): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/).
* Scroll por planos (Danibus): [https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/](https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/).
* Scroll por Tiles (Danibus): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/).
* TileSet Nature (Open Game Art): [https://opengameart.org/content/nature-tileset](https://opengameart.org/content/nature-tileset).
* Street Backgrounds (Open Game Art): [https://opengameart.org/content/pixel-art-street-backgrounds](https://opengameart.org/content/pixel-art-street-backgrounds).