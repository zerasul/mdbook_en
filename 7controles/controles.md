# 7. Controles

En el último capítulo, ya pudimos ver nuestro primer ejemplo y ver como comenzar a desarrollar el código de nuestro juego.

En este capítulo, ya comenzamos a hablar sobre conceptos sobre desarrollo de videojuegos y vamos a ver los distintos módulos o partes con las que tenemos que tratar a la hora de crear nuestro juego. Una de las partes más importantes a la hora de crear un videojuego; se trata de los controles para interactuar con el juego.

Es una de las partes más importantes el poder usar controles ya que de otra forma, no se podría controlar al personaje o hacer cualquier acción en el juego. Ya sea a través de un controlador, o cualquier otro dispositivo que permita enviar información a la consola y esta sea capaz de actuar en consecuencia dentro de nuestro juego.

En este capítulo, vamos a mostrar como utilizar estos controles; a través de distintos ejemplos para distintos dispositivos como pueden ser los controladores para Sega Mega Drive de 3 o 6 botones, o incluso el ratón _Sega Mouse_.

## Dispositivos de entrada

Para Sega Mega Drive, se crearon numerosos dispositivos de entrada; desde controladores  de 3 o 6 botones, el famoso _Sega Mouse_, pistolas de luz como la famosa _The Justifier_ que permitía jugar a juegos de puntería con una pistola y sin olvidar, el Sega Activator se define como un control de movimiento para Sega Mega Drive.

Obviamente es importante recordar que la Sega Mega Drive, tenía 2 puertos de entrada tipo Atari o DE-9. En el cual se conectaban los dispositivos. Aunque era ampliable gracias a otros dispositivos como el _Super Multi Play_; que permitía conectar hasta 4 controladores por puerto; o algunos juegos como el _Micro Machines 2_ [^41] que incluía 2 puertos adicionales en el propio cartucho.

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
8. Select (dependiendo de si esta a 1 o 0 se realizará una función u otra en los pines 6 o 9).
9. A/B

[^41]: Micro Machines 2: Turbo Tournament fue un juego publicado por codemasters y que permitía jugar hasta 4 jugadores simultáneos.

Si necesita conocer más sobre los distintos controladores y como se componen, hemos dejado información adicional en las referencias de este capítulo.

En este apartado, vamos a ver algunos de ellos para comentar sus características, y que versiones se pueden encontrar.

### Controlador de 3 Botones

El controlador más conocido de Sega Mega Drive, disponía de una cruceta de direcciones, y además de 3 botones llamados A, B y C; además de un botón START.

Algunos otros controladores de terceros, añadían algunas funcionalidades extra como el autodisparo u otras opciones.

Existieron distintos diseños dependiendo de la versión de Mega Drive (Japón/Europa o América); además de muchos otros mandos de terceros que tenían muchos otros diseños.

<div class="image">
<img id="arq" src="7controles/img/controller3Button.jpg" alt="Controlador 3 botones" title="Controlador 3 botones"/> </div>
<p>Controlador 3 botones</p>

### Controlador de 6 botones

Otra versión del controlador para Sega Mega Drive, es el controlador de 6 botones; que añadía tres botones adicionales (X,Y y Z). Esta versión era utilizada por algunos juegos como _Comix Zone_ [^42] o incluso _Streets of Rage 3_ [^43].

Además, como había algunos juegos que no eran compatibles con el modo 6 botones, se añadió un botón adicional, que permitía usar el mando en modo "3 botones". Este botón llamado _MODE_, si se pulsaba al iniciar el juego, se cambiaba el modo del mismo [^44].

<div class="image">
<img id="arq" src="7controles/img/md6buttons.jpg" alt="Controlador 6 botones" title="Controlador 6 botones"/> </div>
<p>Controlador 6 botones de la marca retro-bit.</p>

[^42]: Comix Zone es un videojuego desarrollado por Sega y publicado en el año 1995.
[^43]: Streets of Rage 3, es la tercera entrega de la saga de Streets of rage, publicado en el año 1994.
[^44]: El mando de la imagen no es oficial, pero si tiene licencia para Sega Mega Drive. En las referencias puede encontrar un enlace de compra.

### Sega Mouse

Otro de los periféricos que podemos encontrar para Sega Mega Drive, es el famoso _Sega Mouse_; se trataba de un ratón con 2 botones con distintas versiones. Permitía jugar a algunos juegos que eran compatibles. Como el famoso _lemmings 2_ [^45], o el famoso _Cannon Fodder_ [^46].

El ratón de 2 botones, permitía usar los botones A y B; sin embargo, para usar el botón C, la propia Bola del ratón era clickable; lo cual permitía mayor compatibilidad. Sin embargo, el Sega Mouse, no llegó a Sega America por lo que solo se pudo ver en Japón y Europa. Pero si tuvo su propia versión llamada _Mega Mouse_ que tenía 3 botones y un botón start; eliminando la posibilidad de hacer click con la propia Bola del ratón.

<div class="image">
<img id="arq" src="7controles/img/SegaMouse_MD_EU.jpg" alt="Sega Mouse" title="Sega Mouse"/> </div>
<p>Sega Mouse (Sega Retro.org)</p>

[^45]: Lemmings; era un juego de estrategia, donde se controlaban unos simpáticos personajes llamados lemmings, que cada uno tenia una función y se tenía que resolver un puzzle. La versión de Mega Drive fue publicada por Sega y lanzada en el año 1992.
[^46]: Cannon Fodder es un juego de estrategia que fue publicado para Sega Mega Drive en el año 1992.

## Programación de los controles

### Síncronos

### asíncronos

### Programación con Sega Mouse

## Referencias

* [https://segaretro.org/Control_Pad_(Mega_Drive)](https://segaretro.org/Control_Pad_(Mega_Drive))
* [https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive)](https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive))
* [https://segaretro.org/Super_Multi-play](https://segaretro.org/Super_Multi-play)
* [https://segaretro.org/The_Justifier](https://segaretro.org/The_Justifier)
* [https://amzn.to/3lBRnfv](https://amzn.to/3lBRnfv)
* [https://segaretro.org/Micro_Machines_2:_Turbo_Tournament](https://segaretro.org/Micro_Machines_2:_Turbo_Tournament).
* [https://segaretro.org/Sega_Mouse](https://segaretro.org/Sega_Mouse)
* [https://segaretro.org/Lemmings](https://segaretro.org/Lemmings)
* [https://segaretro.org/Cannon_Fodder](https://segaretro.org/Cannon_Fodder)
