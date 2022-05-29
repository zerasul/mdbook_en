# 7. Controles

En el último capítulo, ya pudimos ver nuestro primer ejemplo y ver como comenzar a desarrollar el código de nuestro juego.

En este capítulo, ya comenzamos a hablar sobre conceptos sobre desarrollo de videojuegos y vamos a ver los distintos módulos o partes con las que tenemos que tratar a la hora de crear nuestro juego. Una de las partes más importantes a la hora de crear un videojuego; se trata de los controles para interactuar con el juego.

Es una de las partes más importantes el poder usar controles ya que de otra forma, no se podría controlar al personaje o hacer cualquier acción en el juego. Ya sea a través de un controlador, o cualquier otro dispositivo que permita enviar información a la consola y esta sea capaz de actuar en consecuencia dentro de nuestro juego.

En este capítulo, vamos a mostrar como utilizar estos controles; a través de distintos ejemplos para distintos dispositivos como pueden ser los controladores para Sega Mega Drive de 3 o 6 botones, o incluso el ratón _Sega Mouse_.

## Dispositivos de entrada

Para Sega Mega Drive, se crearon numerosos dispositivos de entrada; desde controladores  de 3 o 6 botones, el famoso _Sega Mouse_, pistolas de luz como la famosa _The Justifier_ que permitía jugar a juegos de puntería con una pistola y sin olvidar, el Sega Activator se define como un control de movimiento para Sega Mega Drive.

Obviamente es importante recordar que la Sega Mega Drive, tenía 2 puertos de entrada tipo Atari o DE-9. En el cual se conectaban los dispositivos. Aunque era ampliable gracias a otros dispositivos como el _Super Multi Play_; que permitía conectar hasta 4 controladores por puerto; o algunos juegos como el _Micro Machines 2_ [^42] que incluía 2 puertos adicionales en el propio cartucho.

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

[^42]: Micro Machines 2: Turbo Tournament fue un juego publicado por codemasters y que permitía jugar hasta 4 jugadores simultáneos.

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

Otra versión del controlador para Sega Mega Drive, es el controlador de 6 botones; que añadía tres botones adicionales (X,Y y Z). Esta versión era utilizada por algunos juegos como _Comix Zone_ [^43] o incluso _Streets of Rage 3_ [^44].

Además, como había algunos juegos que no eran compatibles con el modo 6 botones, se añadió un botón adicional, que permitía usar el mando en modo "3 botones". Este botón llamado _MODE_, si se pulsaba al iniciar el juego, se cambiaba el modo del mismo [^45].

<div class="image">
<img id="arq" src="7controles/img/md6buttons.jpg" alt="Controlador 6 botones" title="Controlador 6 botones"/> </div>
<p>Controlador 6 botones de la marca retro-bit.</p>

[^43]: Comix Zone es un videojuego desarrollado por Sega y publicado en el año 1995.
[^44]: Streets of Rage 3, es la tercera entrega de la saga de Streets of rage, publicado en el año 1994.
[^45]: El mando de la imagen no es oficial, pero si tiene licencia para Sega Mega Drive. En las referencias puede encontrar un enlace de compra.

### Sega Mouse

Otro de los periféricos que podemos encontrar para Sega Mega Drive, es el famoso _Sega Mouse_; se trataba de un ratón con 2 botones con distintas versiones. Permitía jugar a algunos juegos que eran compatibles. Como el famoso _lemmings 2_ [^46], o el famoso _Cannon Fodder_ [^47].

El ratón de 2 botones, permitía usar los botones A y B; sin embargo, para usar el botón C, la propia Bola del ratón era clickable; lo cual permitía mayor compatibilidad. Sin embargo, el Sega Mouse, no llegó a Sega America por lo que solo se pudo ver en Japón y Europa. Pero si tuvo su propia versión llamada _Mega Mouse_ que tenía 3 botones y un botón start; eliminando la posibilidad de hacer click con la propia Bola del ratón.

<div class="image">
<img id="arq" src="7controles/img/SegaMouse_MD_EU.jpg" alt="Sega Mouse" title="Sega Mouse"/> </div>
<p>Sega Mouse (Sega Retro.org)</p>

[^46]: Lemmings; era un juego de estrategia, donde se controlaban unos simpáticos personajes llamados lemmings, que cada uno tenia una función y se tenía que resolver un puzzle. La versión de Mega Drive fue publicada por Sega y lanzada en el año 1992.
[^47]: Cannon Fodder es un juego de estrategia que fue publicado para Sega Mega Drive en el año 1992.

## Programación de los controles

Tras ver en detalle algunos de los dispositivos de entrada con los que podemos trabajar, vamos a mostrar como programar nuestro juego para poder utilizarlos. SGDK, provee de distintos métodos para poder interactuar con los controles; ya sea mando o incluso el ratón. Por ello, vamos a mostrar tres ejemplos de distintos métodos con los que se pueden encontrar para desarrollar nuestro juego.

En primer lugar, veremos como saber de que tipo de controlador se esta utilizando (3 o 6 botones o mouse). Además, Vamos a mostrar 2 formas de poder leer la entrada de nuestros controladores, el primero de forma síncrona, y el segundo de forma asíncrona; el primero lee en todo momento si se ha pulsado un botón y pregunta cuales de ellos han sido. El segundo método, utiliza las interrupciones del procesador, para poder definir una rutina de interrupción para cada pulsación.

Por último, mostraremos un ejemplo de como utilizar el ratón para Sega Mega Drive (puede usarse un emulador para utilizar el ratón de nuestro ordenador).

### Tipo de Controlador

Si nuestro juego es compatible con distintos dispositivos; como puede ser un controlador de 3 o de 6 botones, ratón o incluso pistola, podemos usar la función ```JOY_getPortType```, para poder saber que tipo de dispositivo de entrada esta conectado a un puerto.

La función ```JOY_getPortType```, tiene los siguientes parámetros:

* ```u16 port``` Indica el puerto por el cual esta conectado; puede tener los siguientes valores:
    * ```PORT_1```: indica el primer puerto de la consola.
    * ```PORT_2```: indica el segundo puerto de la consola.

Esta función devuelve un valor entero ```u8``` la cual nos puede indicar el tipo de dispositivo, usando el operador &. Por ejemplo:

```c
u8 value = JOY_getPortType(PORT_1);

if(value & PORT_TYPE_PAD) // comprueba que es un controlador.
```

Los valores que podemos encontrar son:

* ```PORT_TYPE_MENACER```: Sega Menacer (Pistola de Luz).
* ```PORT_TYPE_JUSTIFIER```: Konami Justifier (Pistola de Luz).
* ```PORT_TYPE_MOUSE```: Sega MegaMouse.
* ```PORT_TYPE_TEAMPLAYER```: Sega TeamPlayer.
* ```PORT_TYPE_PAD```: Sega joypad.
* ```PORT_TYPE_UNKNOWN```: unidentified or no peripheral.
* ```PORT_TYPE_EA4WAYPLAY```: EA 4-Way Play.

Además, se puede detectar el tipo de controlador para cada mando detectado; si se utiliza un multitap, (como Sega Player o EA4WayPlay), se necesita saber que tipo de dispositivo hay conectado; por ello se utiliza la función ```JOY_getJoypadType```; que recibe por parámetro:

* ```u16 joy```: indicando el número de controlador a revisar; puede tener los siguientes valores:
    * ```JOY_1```: Para indicar el primer controlador.
    * ```JOY_2```: Para indicar el segundo controlador.
    * ...
    * ```JOY_8```: Para indicar el controlador número 8.

Esta función devuelve un valor entero que nos va a permitir comparar con distintos valores para saber de que tipo de controlador se trata; puede tener los siguientes valores:

* ```JOY_TYPE_PAD3```: 3 buttons joypad.
* ```JOY_TYPE_PAD6```: 6 buttons joypad.
* ```JOY_TYPE_MOUSE```: Sega Mouse.
* ```JOY_TYPE_TRACKBALL```: Sega trackball.
* ```JOY_TYPE_MENACER```: Sega Menacer gun.
* ```JOY_TYPE_JUSTIFIER```: Sega Justifier gun.
* ```JOY_TYPE_UNKNOWN```: Desconocido o no conectado.

**NOTA**: Las funciones anteriormente mencionadas, solo actualizarán la información, si se llama a la función ```JOY_Init()``` o ```JOPY_Reset()``` para inicializar el sistema de controles de SGDK; no es necesario llamarlas manualmente ya que estas funciones se llaman automáticamente al cargar el SGDK.

### Síncronos

La primera manera de poder usar los controles, es de forma síncrona; esto quiere decir, que en cada frame de nuestro juego, se va a leer el estado de los botones pulsados para cada uno de los controladores que tengamos conectados.

Para comprender mejor como leer el estado de los controles de esta manera, puede ver el ejemplo llamado _ej2.controls1_ que encontrará en el repositorio de ejemplos que acompañan a este libro. Este ejemplo, nos mostrará por pantalla los botones que tengamos pulsados; en este caso se basa en un controlador de 3 botones por que solo se podrán visualizar las direcciones, y los botones A,B,C y Start.

En este ejemplo, podrá ver que se ha creado un fichero llamado ```constants.h``` y que incluye una serie de constantes como las posiciones X e Y de los distintos mensajes a mostrar, en tiles. Este fichero se encuentra en el directorio _inc_; del proyecto.

Si observamos el código, podemos ver que se utilizan la función ```JOY_readJoypad```, la cual permite leer el estado actual de un controlador; esta función recibe los siguientes parámetros:

* ```u16 joy```: Indica el número de controlador; puede tener los siguientes valores:
    * ```JOY_1```: Para indicar el primer controlador.
    * ```JOY_2```: Para indicar el segundo controlador.
    * ...
    * ```JOY_8```: Para indicar el controlador número 8.

Esta función, devuelve un número entero ```u16```; el cual contiene el estado actual del controlador; puede usarse el operador & para saber que botones se están utilizando; como podemos ver en el ejemplo:

```c
  if (value & BUTTON_UP)
```

El anterior fragmento, comprueba que se esta pulsando la dirección hacia arriba; podemos comprobar los siguientes botones:

* ```BUTTON_UP```: Dirección Arriba.
* ```BUTTON_DOWN```: Dirección Abajo.
* ```BUTTON_LEFT```: Dirección Izquierda.
* ```BUTTON_RIGHT```: Dirección Derecha.
* ```BUTTON_A```: Botón A.
* ```BUTTON_B```: Botón B.
* ```BUTTON_C```: Botón C.
* ```BUTTON_START```: Botón Start.
* ```BUTTON_X```: Botón X (6 botones).
* ```BUTTON_y```: Botón Y (6 botones).
* ```BUTTON_Z```: Botón Z (6 botones).
* ```BUTTON_MODE```: Botón MODE (6 botones).

Además, existen unos alias si se usa un ratón:

* ```BUTTON_LMB``` = Alias para el botón A para Ratón.
* ```BUTTON_MMB``` = Alias para el botón B para Ratón.
* ```BUTTON_RMC``` = Alias para el botón C para Ratón.

En el ejemplo, se puede ver como se dibujará un texto o se borrará, en función de los botones pulsados; aquí puede verse un fragmento del ejemplo:

```c
  int value = JOY_readJoypad(JOY_1);

    
    if (value & BUTTON_UP)
        printChar(UP_TEXT, POSX_UP, POSY_UP);
    else
        printChar(EMPTY_TEXT, POSX_UP, POSY_UP);
```

Donde vemos que si se pulsa el botón Arriba, se mostrará un texto o sino, se mostrará un texto vacío.

<div class="image">
<img id="arq" src="7controles/img/ej2.png" alt="Ejemplo 2: Controles Síncronos" title="Ejemplo 2: Controles Síncronos"/> </div>
<p>Ejemplo 2: Controles Síncronos</p>

### Asíncronos

### Programación con Sega Mouse

## Referencias

* [https://segaretro.org/Control_Pad_(Mega_Drive)](https://segaretro.org/Control_Pad_(Mega_Drive))
* [https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive)](https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive))
* [https://segaretro.org/Super_Multi-play](https://segaretro.org/Super_Multi-play)
* [https://segaretro.org/The_Justifier](https://segaretro.org/The_Justifier)
* [https://amzn.to/3lBRnfv](https://amzn.to/3lBRnfv)
* [https://segaretro.org/Micro_Machines_2:_Turbo_Tournament](https://segaretro.org/Micro_Machines_2:_Turbo_Tournament)
* [https://segaretro.org/Sega_Mouse](https://segaretro.org/Sega_Mouse)
* [https://segaretro.org/Lemmings](https://segaretro.org/Lemmings)
* [https://segaretro.org/Cannon_Fodder](https://segaretro.org/Cannon_Fodder)
