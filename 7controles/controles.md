# 7. Controles

En el último capítulo, ya pudimos ver nuestro primer ejemplo y ver como comenzar a desarrollar el código de nuestro juego.

En este capítulo, ya comenzamos a hablar sobre conceptos sobre desarrollo de videojuegos y vamos a ver los distintos modulos o partes con las que tenemos que tratar a la hora de crear nuestro juego. Una de las partes más importantes a la hora de crear un videojuego; se trata de los controles para interactuar con el juego.

Es una de las partes más importantes el poder usar controles ya que de otra forma, no se podría controlar al personaje o hacer cualquier accion en el juego. Ya sea a través de un controlador, o cualquier otro dispositivo que permita enviar información a la consola y esta sea capaz de actuar en consecuencia dentro de nuestro juego.

En este capítulo, vamos a mostrar como utilizar estos controles; a través de distintos ejemplos para distintos dipositivos como pueden ser los controladores dpara Sega Mega Drive de 3 o 6 botones, o incluso el ratón _Sega Mouse_.

## Dispositivos de entrada

Para Sega Mega Drive, se crearon numerosos dipositivos de entrada; desde controladores  de 3 o 6 botones, el famoso _Sega Mouse_, pistolas de luz como la famosa _The Justifier_ que permitia jugar a juegos de punteria con una pistola y sin olvidar, el Sega Activator que permitia poder jugar a juegos de Mega Drive con un control de movimiento.

Obviamente es importante recordar que la Sega Mega Drive, tenía 2 puertos de entrada tipo Atari o DE-9. En el cual se conectaban los dispositivos. Aunque era ampliable gracias a otros dispositivos como el _Super Multi Play_; que permitia conectar hasta 4 controladores por puerto; o algunos juegos como el _Micro Machines 2_ [^41] que permitia conectar 2 controladores más con unos puertos en el propio cartucho.

Para comprender mejor el conector DE-9 y como se compone para un controlador de 3 botones:

<div class="image">
<img id="arq" src="7controles/img/de-9.png" alt="de-9" title="de-9"/> </div>
<p>Pintout Conector DE-9</p>

Donde:

1. Arriba
2. Abajo
3. Izquierda
4. Derecha
5. Vcc
6. C/Start
7. GND
8. Select (dependiendo de si esta a 1 o 0 se realizará una funcion u otra en los pines 6 o 9).
9. A/B

[^41]: Micro Machines 2: Turbo Tournament fue un juego publicado por codemasters y que permitía jugar hasta 4 jugadores simultaneos.

Si necesita conocer más sobre los distintos controladores y como se componen, hemos dejado información adicional en las referencias de este capítulo.

En este apartado, vamos a ver algunos de ellos para comentar sus características, y que versiones se pueden encontrar.

### Controlador de 3 Botones

El controlador más conocido de Sega Mega Drive, disponia de una cruceta de direcciones, y además de 3 botones llamados A, B y C; además de un botón START.

Algunos otros controladores de terceros, añadian algunas funcionalidades extra como el autodisparo u otras opciones.

Existieron distintos diseños dependiendo de la versión de Mega Drive (Japón/Europa o américa); además de muchos otros mandos de terceros que tenian muchos otros diseños.

<div class="image">
<img id="arq" src="7controles/img/controller3Button.jpg" alt="Controlador 3 botones" title="Controlador 3 botones"/> </div>
<p>Controlador 3 botones</p>

### Controlador de 6 botones

Otra versión del controlador para Sega Mega Drive, es el controlador de 6 botones; que añadía tres botones adicionales. Esta versión era utilizada por algunos juegos como _Comix Zone_ [^42] o incluso _Streets of Rage 3_ [^43].

Además, como había algunos juegos que no eran compatibles con el modo 6 botones, se añadió un botón adicional, que permitia usar el mando en modo "3 botones". Este botón llamado _MODE_, si se pulsaba al iniciar el juego, se cambiaba el modo del mismo.

[^42]: Comix Zone es un videojuego desarrollado por Sega y publicado en el año 1995.
[^43]: Streets of Rage 3, es la tercera entrega de la saga de Streets of rage, publicado en el año 1994.

### Sega Mouse

## Referencias

* [https://segaretro.org/Super_Multi-play](https://segaretro.org/Super_Multi-play)
* [https://segaretro.org/The_Justifier](https://segaretro.org/The_Justifier)
* [https://segaretro.org/Micro_Machines_2:_Turbo_Tournament](https://segaretro.org/Micro_Machines_2:_Turbo_Tournament).
