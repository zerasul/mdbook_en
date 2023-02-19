# 7. Controles

En el último capítulo, ya pudimos ver nuestro primer ejemplo y ver como comenzar a desarrollar el código de nuestro juego.

En este capítulo, ya comenzamos a hablar sobre conceptos sobre desarrollo de videojuegos y vamos a ver los distintos módulos o partes con las que tenemos que tratar a la hora de crear nuestro juego. Una de las partes más importantes a la hora de crear un videojuego; se trata de los controles para interactuar con el juego.

Es una de las partes más importantes el poder usar controles ya que de otra forma, no se podría controlar al personaje o hacer cualquier acción en el juego. Ya sea a través de un controlador, o cualquier otro dispositivo que permita enviar información a la consola y esta sea capaz de actuar en consecuencia dentro de nuestro juego.

En este capítulo, vamos a mostrar como utilizar estos controles; a través de distintos ejemplos para distintos dispositivos como pueden ser los controladores para Sega Mega Drive de 3 o 6 botones, o incluso el ratón _Sega Mouse_.

## Dispositivos de entrada

Para Sega Mega Drive, se crearon numerosos dispositivos de entrada; desde controladores  de 3 o 6 botones, el famoso _Sega Mouse_, pistolas de luz como la famosa _The Justifier_ que permitía jugar a juegos de puntería con una pistola y sin olvidar, el Sega Activator se define como un control de movimiento para Sega Mega Drive.

Obviamente es importante recordar que la Sega Mega Drive, tenía 2 puertos de entrada tipo Atari o DE-9. En el cual se conectaban los dispositivos. Aunque era ampliable gracias a otros dispositivos como el _Super Multi Play_; que permitía conectar hasta 4 controladores por puerto; o algunos juegos como el _Micro Machines 2_ [^44] que incluía 2 puertos adicionales en el propio cartucho.

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

[^44]: Micro Machines 2: Turbo Tournament fue un juego publicado por codemasters y que permitía jugar hasta 4 jugadores simultáneos.

Si necesita conocer más sobre los distintos controladores y como se componen, hemos dejado información adicional en las referencias de este capítulo.

En este apartado, vamos a ver algunos de ellos para comentar sus características, y que versiones se pueden encontrar.

### Controlador de 3 Botones

El controlador más conocido de Sega Mega Drive, disponía de una cruceta de direcciones, y además de 3 botones llamados A, B y C, y  de un último botón START.

Algunos otros controladores de terceros, añadían algunas funcionalidades extra como el autodisparo u otras opciones.

Existieron distintos diseños dependiendo de la versión de Mega Drive (Japón/Europa o América); además de muchos otros mandos de terceros que tenían muchos otros diseños.

<div class="image">
<img id="arq" src="7controles/img/controller3Button.jpg" alt="Controlador 3 botones" title="Controlador 3 botones"/> </div>
<p>Controlador 3 botones</p>

### Controlador de 6 botones

Otra versión del controlador para Sega Mega Drive, es el controlador de 6 botones; que añadía tres botones adicionales (X,Y y Z). Esta versión era utilizada por algunos juegos como _Comix Zone_ [^45] o incluso _Streets of Rage 3_ [^46].

Además, como había algunos juegos que no eran compatibles con el modo 6 botones, se añadió un botón adicional, que permitía usar el mando en modo "3 botones". Este botón llamado _MODE_, si se pulsaba al iniciar el juego, se cambiaba el modo del mismo [^47].

<div class="image">
<img id="arq" src="7controles/img/md6buttons.jpg" alt="Controlador 6 botones" title="Controlador 6 botones"/> </div>
<p>Controlador 6 botones de la marca retro-bit.</p>

[^45]: Comix Zone es un videojuego desarrollado por Sega y publicado en el año 1995.
[^46]: Streets of Rage 3, es la tercera entrega de la saga de Streets of rage, publicado en el año 1994.
[^47]: El mando de la imagen no es oficial, pero si tiene licencia para Sega Mega Drive. En las referencias puede encontrar un enlace de compra.

### Sega Mouse

Otro de los periféricos que podemos encontrar para Sega Mega Drive, es el famoso _Sega Mouse_; se trataba de un ratón con 2 botones con distintas versiones. Permitía jugar a algunos juegos que eran compatibles. Como el famoso _lemmings 2_ [^48], o el famoso _Cannon Fodder_ [^49].

El ratón de 2 botones, permitía usar los botones A y B; sin embargo, para usar el botón C, la propia Bola del ratón era clickable; lo cual permitía mayor compatibilidad. Sin embargo, el Sega Mouse, no llegó a Sega America por lo que solo se pudo ver en Japón y Europa. Pero si tuvo su propia versión llamada _Mega Mouse_ que tenía 3 botones y un botón start; eliminando la posibilidad de hacer click con la propia Bola del ratón.

<div class="image">
<img id="arq" src="7controles/img/SegaMouse_MD_EU.jpg" alt="Sega Mouse" title="Sega Mouse"/> </div>
<p>Sega Mouse (Sega Retro.org)</p>

[^48]: Lemmings; era un juego de estrategia, donde se controlaban unos simpáticos personajes llamados lemmings, que cada uno tenia una función y se tenía que resolver un puzzle. La versión de Mega Drive fue publicada por Sega y lanzada en el año 1992.
[^49]: Cannon Fodder es un juego de estrategia que fue publicado para Sega Mega Drive en el año 1992.

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

**NOTA**: Las funciones anteriormente mencionadas, solo actualizarán la información, si se llama a la función ```JOY_Init()``` o ```JOY_Reset()``` para inicializar el sistema de controles de SGDK; no es necesario llamarlas manualmente ya que estas funciones se llaman automáticamente al cargar el SGDK.

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
        printChar(UP_TEXT,POSX_UP,POSY_UP);
    else
        printChar(EMPTY_TEXT,POSX_UP,POSY_UP);
```

Donde vemos que si se pulsa el botón Arriba, se mostrará un texto o sino, se mostrará un texto vacío.

<div class="image">
<img id="arq" src="7controles/img/ej2.png" alt="Ejemplo 2: Controles Síncronos" title="Ejemplo 2: Controles Síncronos"/> </div>
<p>Ejemplo 2: Controles Síncronos</p>

### Asíncronos

Hasta ahora hemos podido ver como poder leer los distintos controles usando la forma síncrona; es decir, que en cada frame se lee las teclas pulsadas en los distintos controles y se comprueban todos los controles se estén pulsando o no.

Esto puede hacer a la larga que sea más engorroso y que puede hacer que se ralentice nuestro juego; por ello, gracias a que el procesador Motorola 68000 tiene interrupciones, podemos usar una función que maneje los eventos cuando pulsemos una tecla.

Una interrupción, es una señal recibida por el procesador, el cual para la tarea actual, y ejecuta una función llamada subrutina de interrupción; además de realizar una serie de acciones y una vez terminada, el procesador continua con la tarea anterior. Con una interrupción, se pueden manejar de forma óptima los eventos recibidos desde el hardware.

SGDK, nos permite crear una función para manejar los eventos de los controles de forma asíncrona; de tal forma que solo actuará si se ha pulsado una tecla:

```JOY_setEventHandler```; esta función permite definir una función que se ejecutará cuando se pulse una tecla.

Recibe los siguientes parámetros:

* ```function*(u16 joy, u16 changed, u16 state)```: puntero a función que debe de recibir los siguientes 3 parámetros:
    * ```u16 joy```: Controlador pulsado puede tener el valor:
        * ```JOY_1```: Controlador 1.
        * ```JOY_2```: Controlador 2.
        * ...
        * ```JOY_8```: Controlador 8.
    * ```u16 changed```: Indica el botón pulsado. Por ejemplo: ```BUTTON_START```.
    * ```u16 state```: Indica el estado; es decir si ha sido pulsado o soltado. ```state=0``` indica que ha sido soltado.

Una vez hemos visto como se utiliza la función para manejar los eventos de los controladores, podemos ver en el repositorio de ejemplos el ejemplo _ej3.controls2_; el cual tiene el comportamiento parecido al anterior ejemplo; sin embargo, podemos ver que se ha definido la función para manejar los distintos eventos.

```c
    JOY_init();

    JOY_setEventHandler(inputHandler);
```

Podemos ver en el fragmento anterior, que se llama a la función ```JOY_Init``` que inicializa todo el motor asociado con los controladores (esta función se ejecuta al iniciar todo el sistema de SGDK automáticamente). Vemos que se ha establecido la función ```inputHandler```; la cual gestionará que ocurre cuando se pulsa un botón de uno de los controladores.

Si echamos un vistazo a la función, podemos ver lo siguiente:

```c
    void inputHandler(u16 joy,u16 changed,
            u16 state){


        if (changed & state & BUTTON_START)
		{
			printChar(START_TEXT, POSX_START,
              POSY_RIGHT);
		}
    ...
```
Vemos que la función ```inputHandler```, recibe los tres parámetros comentados:

* _joy_: controlador pulsado.
* _changed_: botón pulsado.
* _state_: estado del botón (pulsado o soltado).

Observamos como se compara la variable changed, con state y un botón; de esta forma se comprueba que sólo se realizará la acción, cuando se pulse el botón correspondiente y no cuando se suelta.

<div class="image">
<img id="arq" src="7controles/img/ej3.png" alt="Ejemplo 2: Controles Síncronos" title="Ejemplo 3: Controles Asíncronos"/> </div>
<p>Ejemplo 3: Controles Asíncronos</p>

### Programación con Sega Mouse

Hasta ahora, hemos estado trabajando con los controladores; ya sean de 3 o de 6 botones; sin embargo, puede ser interesante, ofrecer soporte para usar ratón en nuestros juegos. En esta sección, vamos a ver cómo poder leer el ratón _Sega Mouse_, usando SGDK.

En primer lugar, no todos tenemos acceso a un Sega Mouse; por lo que es necesario utilizar un emulador, que permita usar el ratón de nuestro ordenador dentro del propio emulador. En este caso recomendamos el emulador _Kega Fusion_ o fusion. Este emulador, permite usando la tecla <kbd>F12</kbd>, capturar el ratón de nuestro ordenador.

Hemos creado un nuevo ejemplo; en el repositorio de ejemplos para este libro; recuerda que puedes encontrarlo en:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

El ejemplo que vamos a tratar aquí, es _ej4.mouse_ El cual nos va a mostrar por pantalla las coordenadas X e Y del ratón. No se mostrará por pantalla el cursor; esto lo veremos más adelante cuando usemos Sprites.

En primer lugar, se va a habilitar el soporte para usar el ratón; usando la función ```JOY_setSupport``` la cual nos va a permitir habilitar el soporte para distintos dispositivos; veamos como funciona esta función:

```JOY_setSupport```: habilita soporte para un dispositivo; recibe los siguientes parámetros:
* ```port```: Puerto donde estará conectado; tiene los siguientes valores:
    * ```PORT_1```: Puerto 1 de la consola.
    * ```PORT_2```: Puerto 2 de la consola.
* ```support```: Dispositivo para dar soporte; tiene los siguientes valores:
    * ```JOY_SUPPORT_OFF```: Deshabilitado.
    * ```JOY_SUPPORT_3BTN```: Controlador de 3 botones.
    * ```JOY_SUPPORT_6BTN```: Controlador de 6 botones.
    * ```JOY_SUPPORT_TRACKBALL```: Sega Sports Pad (SMS trackball).
    * ```JOY_SUPPORT_MOUSE```: Sega Mouse.
    * ```JOY_SUPPORT_TEAMPLAYER```: Sega TeamPlayer.
    * ```JOY_SUPPORT_EA4WAYPLAY```: EA 4-Way Play.
    * ```JOY_SUPPORT_MENACER```: Sega Menacer.
    * ```JOY_SUPPORT_JUSTIFIER_BLUE```: Konami Justifier (Sólo pistola Azul).
    * ```JOY_SUPPORT_JUSTIFIER_BOTH```: Konami Justifier (Todas las pistolas).
    * ```JOY_SUPPORT_ANALOGJOY```: Sega analog joypad (Todavía no soportado).
    * ```JOY_SUPPORT_KEYBOARD```: Sega keyboard (Todavía no soportado).

También podemos ver la función ```sprintf``` la cual nos va a permitir mostrar por pantalla los valores de las distintas variables. Esta función funciona exactamente igual que su homónima de la librería standard de C.

Podemos observar que hay una función llamada ```read_mouse``` la cual será la encargada de leer las coordenadas del ratón.

veamos esta función:

```c
void read_mouse(){
    u16 readX;
    u16 readY;

    if(status.portType == PORT_TYPE_MOUSE ){
        readX=JOY_readJoypadX(JOY_1);
        readY=JOY_readJoypadY(JOY_1);
    }
...
```

Vemos en el fragmento anterior, que se comprueba el tipo de controlador; el cual hemos leído con la función ```JOY_getPortType``` y comprobamos que es un ratón lo que hay conectado al puerto 1. Una vez comprobado, tenemos dos funciones; ```JOY_readJoypadX``` y ```JOY_readJoypadY```la cual nos va a permitir leer tanto la coordenada X o coordenada Y del dispositivo conectado al controlador 1.

Una vez hemos visto el código, podemos ejecutar el ejemplo y ver como cambian el valor X e Y.

<div class="image">
<img id="arq" src="7controles/img/ej4.png" alt="Ejemplo 4: Programación Sega Mouse" title="Ejemplo 4: Programación Sega Mouse"/> </div>
<p>Ejemplo 4: Programación Sega Mouse</p>

## Referencias

* Control pad: [https://segaretro.org/Control_Pad_(Mega_Drive)](https://segaretro.org/Control_Pad_(Mega_Drive))
* Control Pad 6 botones: [https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive)](https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive))
* Super Multi Play: [https://segaretro.org/Super_Multi-play](https://segaretro.org/Super_Multi-play)
* The Justifier: [https://segaretro.org/The_Justifier](https://segaretro.org/The_Justifier)
* Compra controlador 6 botones: [https://amzn.to/3lBRnfv](https://amzn.to/3lBRnfv)
* MicroMachines 2 Turbo Tournament: [https://segaretro.org/Micro_Machines_2:_Turbo_Tournament](https://segaretro.org/Micro_Machines_2:_Turbo_Tournament)
* Sega Mouse: [https://segaretro.org/Sega_Mouse](https://segaretro.org/Sega_Mouse)
* Lemmings: [https://segaretro.org/Lemmings](https://segaretro.org/Lemmings)
* Cannon Fodder: [https://segaretro.org/Cannon_Fodder](https://segaretro.org/Cannon_Fodder)
* C++ Sprintf: [https://www.cplusplus.com/reference/cstdio/sprintf/](https://www.cplusplus.com/reference/cstdio/sprintf/)
* Kega Fusion: [https://segaretro.org/Kega_Fusion](https://segaretro.org/Kega_Fusion)
