# 12. TileSets

Uno de los aspectos importantes a la hora de diseñar un videojuego es el uso de TileSets para generar distintos niveles. Esto es importante ya que a partir de una colección de gráficos, podemos generar distintos niveles usando los llamados TileMaps.

Hasta ahora hemos estado trabajando con imágenes estáticas que se mostraban como uno o varios fondos. En este capítulo, trabajaremos la forma de poder crear mapas a partir de un TileSet. Además de poder utilizar distintas herramientas disponibles como puede ser Tiled o usar la última versión de SGDK (1.80).

Al final de este capítulo, mostraremos como se puede generar distintos niveles tanto de forma manual, como usando la herramienta _rescomp_ que integra SGDK (Recuerda que necesitas la versión 1.80).

## Tilesets y TileMaps

En primer lugar, vamos a definir correctamente que son los llamados TileSets y TileMaps; esto también nos ayudará a comprender como se almacenan y como se pintan los fondos en Mega Drive usando SGDK.

Un TileSet o conjunto de patrones, es un conjunto de gráficos que componen todos los elementos que puede contener un escenario o el propio videojuego. Se suelen almacenar como un mapa de bits con todos los elementos.

<div class="image">
<img id="arq" src="12TileSets/img/tileset.png" alt="Ejemplo de TileSet (Open Game Art)" title="Ejemplo de TileSet (Open Game Art)"/> </div>
<p>Ejemplo de TileSet (Open Game Art)</p>

Como podemos ver en la imagen anterior, se pueden observar los distintos elementos gráficos. Este Tileset nos va a permitir generar escenarios con los distintos elementos que lo componen.

Una vez hemos visto lo que es un TileSet, definiremos el llamado TileMap. Un TileMap, es un conjunto de referencias a elementos de un TileSet para definir un escenario o cualquier otro elemento necesario para mostrarlo en pantalla. Normalmente se utilizan índices para indicar el elemento del TileSet a mostrar. Veamos un ejemplo de un TileMap a partir del Tileset anterior.

<div class="image">
<img id="arq" src="12TileSets/img/mapabosque.png" alt="Ejemplo TileMap" title="Ejemplo TileMap"/> </div>
<p>Ejemplo TileMap</p>

Observamos que a partir del anterior Tileset, se ha compuesto una nueva imágen para poder generar un escenario; en este caso una escena dentro de un bosque. Aunque se podría utilizar como una imágen estática, en este capítulo, vamos a dibujarla a partir de la información del TileSet y la información del TileMap.

Es importante conocer, que a la hora de trabajar con una imagen estática en SGDK, esta se compone siempre de un TileSet, y de un TileMap por lo que se estan utilizando ambos conceptos.

Aunque se pueden utilizar distintas herramientas para trabajar con TileSets y generar nuestros escenarios, en este libro vamos a mostrar un poco como utilizar una herramienta llamada _Tiled_.

## Tiled

Tiled es una herramienta de código abierto, que nos va a permitir trabajar a partir de Tilesets (o conjuntos de patrones); aunque ya hemos hablado de ella anteriormente, aquí vamos a ver más en detalle como utilizarla para generar a partir de Tilesets, nuestros TileMaps para importarlos a Sega Mega Drive.

<div class="image">
<img id="arq" src="12TileSets/img/Tiled.png" alt="Tiled" title="Tiled"/> </div>
<p>Tiled</p>

Como podemos ver en la anterior imagen, Tiled permite crear mapas a partir de un conjunto de patrones. Estos conjuntos de patrones e información del mapa, se pueden importar a nuestro juego de Mega Drive usando distintas herramientas.

Vamos a centrarnos en como crear un mapa usando Tiled; concretamente a partir del ejemplo de TileSet anterior, podamos generar un nuevo mapa. Para ello, se importa un nuevo _conjunto de patrones_, a Tiled y se guarda con el formato _.tsx_; un fichero tsx, almacena la informacion de un conjunto de patrones. Que se le puede indicar el tamaño de cada Tile (Un Tile recuerda que es un fragmento de la imagen); en este caso, usaremos el tamaño de 8x8 px.

A la hora de generar un mapa, podemos hacerlo con distintas capas. Cada capa puede contener distintos elementos que tengamos en los distintos conjuntos de patrones. De tal forma que podamos enriquezer nuestro mapa con más elementos.

<div class="image">
<img id="arq" src="12TileSets/img/capas.png" alt="Capas" title="Capas"/> </div>
<p>Capas</p>

Como podemos ver en la imagen anterior, vemos las dos capas separadas que al juntarlas y configurar el color transparente, se conforman la imagen anterior; de tal forma que la información de ambas capas se puede guardar en un TileMap que es generado por el mismo TileSet.

Ambas capas se pueden almacenar en el mismo fichero _TMX_; los ficheros Tmx, almacenan la información de los mapas asociados a un fichero _tsx_ que almacena la información de los TileSet.

Para más información acerca de los ficheros TMX o TSX, puede consultar la documentación de _Tiled_.

Pero para nuestro caso; como podemos importar esta información, a nuestro juego de Mega Drive, existen varias formas; pero utilizaremos la más actual; que se trata de generar la información, usando _rescomp_ dentro de las herramientas que incluye SGDK.

Sin embargo, para este apartado necesitarás SGDK 1.80 o superior; por lo que en caso de no tener esta versión, mostraremos una forma alternativa.

Otro aspecto a tener en cuenta, es que Tiled tambien permite exportar la información a un fichero JSon; el cual puede ser util para importar los recursos a nuestro juego usando otras herramientas.

### Generar TileMap con Rescomp

Comenzaremos en ver como se puede cargar la información tanto del TileSet, como del TileMap, usando la herramienta de gestión de recursos de SGDK, _rescomp_.

Para ello, podemos cargar la información de los dos recursos, usando un fichero _.res_; donde definiremos la información de cada recurso; veamos un ejemplo:

```
PALETTE palbosque   "tilesetbosque.png"
TILESET mapabosque  "tilesetbosque.png" NONE NONE
TILEMAP map1  "mapabosque.tmx" "Capa de patrones 1" NONE NONE
TILEMAP map1b  "mapabosque.tmx" "Capa de patrones 2" NONE NONE
```

Podemos ver que en ese ejemplo, cargamos una paleta, un Tileset y dos Tilemap; uno por cada capa definida en el fichero tmx.

**NOTA:** Puede obviarse el uso de cargar la paleta; ya que a partir de la versión 1.80 de SGDK, se permite cargar la paleta estableciendo al inicio del fichero los colores a utilizar. Para más información, por favor consultar la documentación de SGDK.

Veamos como se define un TileSet:

```TILESET name "file" compression optimization``` ; donde:

* name: nombre del recurso
* file: nombre del fichero con el Tileset; puede ser una imagen en formato bmp,png,tiff o un fichero tsx de TILED.
* compression: Compresión a utilizar; puede tener los siguientes valores:
    * -1/BEST/AUTO: automática; utiliza la mejor compresión disponible.
    * 0/NONE: ninguna compresión.
    * 1/APLIB: compresión usando _ApLib_.
    * 2/FAST/LZ4W: compresión usando la implementación personalizada de _lz4_.
* optimization: indica la optimización a realizar:
    * 0/NONE: No realiza ninguna optimización.
    * 1/ALL: Ignora los tiles duplicados y espejados.
    * 2/DUPLICATE: Ignora los tiles duplicados.

Una vez visto como se importan los Tilesets, pasaremos a ver como se importan los TileMaps; tanto usando imágenes, como utilizando un ficheto TMX.

En primer lugar, veremos como se importa un tilemap a partir de una imagen:

```TILEMAP name "file" tilset_id  [compression [map_opt [map_base]]]``` ; donde:

* name: nombre del recurso.
* file: nombre del fichero de la imagen a cargar.
* tileset_id: identificador que tendra este tilemap.
* Compresión a utilizar; puede tener los siguientes valores:
    * -1/BEST/AUTO: automática; utiliza la mejor compresión disponible.
    * 0/NONE: ninguna compresión.
    * 1/APLIB: compresión usando _ApLib_.
    * 2/FAST/LZ4W: compresión usando la implementación personalizada de _lz4_.
* map_opt: indica la optimización a realizar:
    * 0/NONE: No realiza ninguna optimización.
    * 1/ALL: Ignora los tiles duplicados y espejados.
    * 2/DUPLICATE: Ignora los tiles duplicados.
* map_base: indica la base del tilemap; es util para definir la prioridad, paleta y tileBase.

En el caso de utilizar un fichero TMX, podemos importar el recurso de la siguiente forma:

```TILEMAP name  "file.tmx" "layer" NONE NONE map_base```; donde:

* name: nombre del recurso.
* file: nombre del fichero TMX del mapa.
* layer: nombre de la capa a cargar; esto es importante si se tiene un fichero tmx con varias capas.
* Compresión a utilizar; puede tener los siguientes valores:
    * -1/BEST/AUTO: automática; utiliza la mejor compresión disponible.
    * 0/NONE: ninguna compresión.
    * 1/APLIB: compresión usando _ApLib_.
    * 2/FAST/LZ4W: compresión usando la implementación personalizada de _lz4_.
* map_opt: indica la optimización a realizar:
    * 0/NONE: No realiza ninguna optimización.
    * 1/ALL: Ignora los tiles duplicados y espejados.
    * 2/DUPLICATE: Ignora los tiles duplicados.
* map_base: indica la base del tilemap; es util para definir la prioridad, paleta y tileBase.

**NOTA:** Si se quieren cargar los Tiles con baja prioridad, se puede establecer el nombre de la capa con el sufijo "low" o sufijo "high".
**NOTA2:** También puede realizarse la carga de la información de la prioridad nombrando la capa con el sufijo "priority".


### Generar TileMap a mano

Una vez visto como importar los recursos usando ficheros TMX o TSX; vamos a ver como podemos importar la información de un TMX, a mano. 

Si estas utilizando la extensión para Visual Studio Code; _Genesis Code_, puedes generar un fichero .h, con la información del tilemap, usando el comando _Genesis Code: Import TMX File_; además si desde Tiled, has exportado el fichero como formato Json, también es compatible.

Para ello, simplemente en nuestro juego, utilizar dicho comando, y seleccionar el fichero _.tmx_ automáticamente se generará un fichero .h.

Para más información de como importar ficheros Tmx, usando Genesis Code, consulta la documentación de dicha extensión.

También podemos obtener la información a mano; para ello, podemos abrir el fichero TMX con un editor de texto y obtener la información (Sólo si la información esta como CSV [^55] y sin comprimir).

[^55]: CSV (Comma Seppàrated Values); formato de fichero que almacena cada dato separado por ",".

<div class="image">
<img id="arq" src="12TileSets/img/tmx.png" alt="Fichero TMX" title="Fichero TMX"/> </div>
<p>Fichero TMX</p>

Podemos ver en la anterior imagen, que la información se encuentra en la etiqueta _data_ y que debe estar codificada como _csv_; copiaremos la lista completa de índices, y crearemos un fichero .h en la carpeta _inc_; allí guardaremos la información de la siguiente forma:

```c

u16 map[1120]=481,482,483,484,485,482.....;
```
Es importante saber el nº de Tiles que debe ser igual que el de nuestro mapa.

Obviamente este proceso se podría automatizar utilizando distintos scripts o herramientas. Pero en este caso es importante conocer como importar esta información.


## Ejemplos con TileSets

Una vez hemos visto como se importan los TileSets y TileMaps a nuestro juego, vamos a ver como utilizarlos y mostrarlos por pantalla; de tal forma que sea más fácil mostrar los distintos escenarios de nuestro juego.

En este caso, vamos a mostrar dos ejemplos; para poder importar y utilizar los recursos usando un fichero TMX; o directamente con la información almacenada en un fichero .h.

### Fichero TMX

Comenzaremos con el ejemplo utilizando un fichero TMX; recuerda que esta versión, solo funcionará si usas la versión de SGDK 1.80 o superior. Este ejemplo llamado _ej9.tilesets1_ se encuentra en el repositorio de ejemplos que acompaña a este libro.

En este ejemplo, vamos a cargar un Tilset, y luego los correspondientes TileMaps; que hemos importado usando rescomp; con la siguiente configuración:

```res
PALETTE palbosque   "tilesetbosque.png"
TILESET mapabosque  "tilesetbosque.png" NONE NONE
TILEMAP map1  "mapabosque.tmx" "Capa de patrones 1" NONE NONE
TILEMAP map1b  "mapabosque.tmx" "Capa de patrones 2" NONE NONE
```

Podemos ver que tenemos una paleta, que almacenará la información de los colores, un Tileset, con la información del tileset a cargar, que vemos que no tiene compresión ni optimización. Además que cargamos 2 TileMaps; los cuales corresponden al mismo fichero TMX, pero a distintas capas de tal forma que cargaremos distintas capas en este fichero.

Veamos el código fuente de este ejemplo:

```c
#include <genesis.h>

#include "tileset.h"

int main()
{
    //Versions prior to SGDK 1.80 use TILE_USERINDEX
    u16 ind = TILE_USER_INDEX;
    VDP_loadTileSet(&mapabosque, ind, DMA);
    PAL_setPalette(PAL0,palbosque.data,DMA);
    VDP_setTileMapEx(BG_B,&map1,
    TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE,ind),
    0,0,0,0,map1.w,map1.h,DMA);
    VDP_setTileMapEx(BG_A,&map1b,
    TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE,ind),
    0,0,0,0,map1b.w,map1b.h,DMA);
    while(1)
    {
        //For versions prior to SGDK 1.60 use VDP_waitVSync instead.
        SYS_doVBlankProcess();
    }
    return (0);
}
```

Podemos ver en el ejemplo, que se utilizan distintas funciones para cargar tanto el TileSet, como los TileMap; vamos a ver esas funciones:

La primera función que observamos es ```VDP_loadTileSet``` la cual carga la información de un TileSet en VRAM; de tal forma que este disponible. para cargar los TileMaps; veamos los parámetros de la función:
* _tileset*_: Puntero donde se encuentra el recurso del Tileset a cargar.
* _tileIndex_: Indice del tile a utilizar como base. Puede usarse como índice ```TILE_USER_INDEX``` para que use la primera posición disponible.
* _tm_: método de transferencia; permite utilizar la CPU, o los distintos valores de DMA; puede tener los siguientes valores:
    * CPU: se utilizará la CPU.
    * DMA: se utilizará DMA.
    * DMA_QUEUE: Se utilizará la cola de DMA.
    * DMA_QUEUE_COPY: Se utilizará cola de DMA como copia.

**NOTA**: El recurso Tileset si esta comprimido, será descomprimido en memoria.

En nuestro ejemplo se utiliza DMA para transferir la información; recuerda no sobrecargar el DMA ya que comparte bus con la CPU y podría haber cuellos de botella.

Por otro lado, vamos a ver como se carga la información de los Tilemap, usando la función ```VDP_setTileMapEx```; esta función permite cargar la información del tilemap, además de recibir la información de la paleta y prioridad; veamos los parámetros de esta función:

* _Plano_: Indica el plano a utilizar; puede ser ```BG_A```o ```BG_B```.
* _tilemap*_: Puntero al recurso donde se almacena este TileMap.
* _mapbase_: Indica cual sera el Tile Base para cargar la información de la prioridad, paleta,etc. Se puede utilizar la macro ```TILE_ATTR_FULL```.
* _sx_: posición X en Tiles dentro del plano.
* _sy_: Posición Y en Tiles dentro del plano.
* _x_: posición x del mapa en Tiles.
* _y_: posición y del mapa en Tiles.
* _w_: ancho en Tiles.
* _h_: alto en Tiles.
* _tm_: método de transferencia; permite utilizar la CPU, o los distintos valores de DMA; puede tener los siguientes valores:
    * CPU: se utilizará la CPU.
    * DMA: se utilizará DMA.
    * DMA_QUEUE: Se utilizará la cola de DMA.
    * DMA_QUEUE_COPY: Se utilizará cola de DMA como copia. 

Existen variantes de esta función que cargan la información de la paleta o prioridad, de la información obtenida por rescomp, como ```VDP_setTileMap```. Puedes ver como utilizar esta función, en la documentación de SGDK.

Una vez tenemos este ejemplo listo, ya podemos compilar y ejecutar para ver como se carga el fondo:

<div class="image">
<img id="arq" src="12TileSets/img/ej910.png" alt="Ejemplo 9: Uso de TileSets usando fichero TMX" title="Ejemplo 9: Uso de TileSets usando fichero TMX"/> </div>
<p>Ejemplo 9: Uso de TileSets usando fichero TMX</p>

### Ejemplo a mano

Si por el contrario no se puede utilizar un fichero TMX, podemos cargar a mano la información; creando a mano el fichero .h (o utilizando la extensión _Genesis Code_); de tal forma que podamos cargar dicha información en nuestro juego y mostrarlo por pantalla. Este ejemplo llamado _ej10.tileset2_, puedes encontrarlo en el repositorio de ejemplos que acompaña a este libro.

En primer lugar, vamos a mostrar como importaremos en este ejemplo la información; primero el Tileset y la información de la paleta, seran importados usando _rescomp_:

```res
PALETTE palbosque "tilesetbosque.png"
TILESET tilesetBosque "tilesetbosque.png" 0
```

Es importante que a la hora de cargar el Tileset el parametro de optimización no este activado para no tener problemas a la hora de cargar los índices del tilemap. Una vez importados estos recursos con rescomp, ya podemos crear un fichero .h, con la información obtenida del fichero TMX.

```c
u16 map1[1120]={481,482,483,484,...};
```

Una vez importada la información, ya podemos pasar a nuestro ejemplo:

Veamos un fragmento:

```c
    u16 ind = TILE_USER_INDEX;
    VDP_loadTileSet(&tilesetBosque,
        TILE_USER_INDEX,CPU);
    PAL_setPalette(PAL0,palbosque.data,CPU);
    int i,j;
    for (i = 0; i < 40; i++)
        {
        for (j = 0; j < 28; j++)
         {
             VDP_setTileMapXY(BG_A,
              TILE_ATTR_FULL(PAL0, FALSE,
                 FALSE, FALSE,
                (ind-1) + map1b[(i) + 40 * j])
                ,i,j);
         }
        }
```

Podemos ver como al principio cargamos la información del tileset de igual forma que el ejemplo anterior; pero esta vez en vez de cargar el TileMap, pintamos a mano  indicando en cada posición el Tile a pintar. Obviamente, esta no es la forma más eficiente de pintar pero es util a modo de demostración.

La función ```VDP_setTileMapXY``` que permite pintar Tile en una posición a partir de un Tileset cargado en memoria. En este caso podemos ver que tiene los siguientes parámetros:

* _Plano_: plano donde se dibujara; puede ser ```BG_A```o ```BG_B```.
* _tileBase_: Tile a dibujar; puede usarse la macro ```TILE_ATTR_FULL```.
* _x_: posición X en Tiles.
* _y_: posición Y en Tiles.

Vemos que para calcular el Tile a mostrar, usamos una formula que se trata de ir buscando en el array que hemos creado en el fichero .h, la coordenada correspondiente, en Tiles. De tal forma que se dibujará cada Tile en su posición. Pueden usarse otras funciones para dibujar Tiles, como ```VDP_setTileMapDataRect```; que permite dibujar un área como rectángulo; para más información, puedes consultar la documentación de SGDK.

Una vez que hemos terminado de revisar el código, ya podemos compilar y ejecutar este ejemplo:

<div class="image">
<img id="arq" src="12TileSets/img/ej10.png" alt="Ejemplo 10: Uso de TileSets a mano" title="Ejemplo 10: Uso de TileSets a mano"/> </div>
<p>Ejemplo 10: Uso de TileSets a mano</p>

Como podemos ver, el resultado es casi el mismo (puede cambiar por la forma de cargar la paleta); y ya hemos podido ver como utilizar TileSets y TileMaps en Sega MegaDrive, utilizando herramientas externas como pueden ser _Tiled_, y como la última versión de SGDK 1.80, permite cargar ficheros con formato TMX hechos con Tiled.


## Referencias

* Tileset Ejemplo: [https://opengameart.org/content/forest-tileset-new-and-old](https://opengameart.org/content/forest-tileset-new-and-old).
* Tiled: [https://www.mapeditor.org/](https://www.mapeditor.org/).
* Documentación Genesis Code: [https://zerasul.github.io/genesis-code-docs/](https://zerasul.github.io/genesis-code-docs/)