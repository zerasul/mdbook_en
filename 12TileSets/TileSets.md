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



## Ejemplos con TileSets


## Referencias

* Tileset Ejemplo: [https://opengameart.org/content/forest-tileset-new-and-old](https://opengameart.org/content/forest-tileset-new-and-old).
* Tiled: [https://www.mapeditor.org/](https://www.mapeditor.org/).