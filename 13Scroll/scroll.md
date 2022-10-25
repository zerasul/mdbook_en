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

Comenzaremos por hablar del desplazamiento por líneas; en este caso se trata de poder desplazar hasta 224 líneas por pantalla de forma horizontal. De tal forma que podemos desplazar distintas porciones de pantalla de forma independiente. Esto lo realiza el propio chip VDP, gracias a la tabla de desplazamiento que almacena en VRAM.

Cada una de las 224 líneas, almacena un fragmento del plano que podemos desplazar a derecha o a izquierda de tal forma que podemos cambiar la dirección de este si fuese necesario.

Aunque hemos hablado de desplazamiento horizontal, también podemos realizar desplazamiento vertical; pero en este caso se trata en columnas de 16 px (2 tiles); que podemos desplazar arriba y abajo.

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

## Ejemplo usando Scroll

### Scroll por lineas

### Scroll por plano

### Scroll usando MAP

### Scroll por Tile

## Referencias

* Scroll (Sega Retro): [https://segaretro.org/Sega_Mega_Drive/Scrolling](https://segaretro.org/Sega_Mega_Drive/Scrolling)
* VDP Scrolling (Mega Drive Wiki): [https://wiki.megadrive.org/index.php?title=VDP_Scrolling](https://wiki.megadrive.org/index.php?title=VDP_Scrolling)
* Scroll por líneas (Danibus): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/)
* Scroll por planos (Danibus): [https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/](https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/)
* Scroll por Tiles (Danibus): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/)