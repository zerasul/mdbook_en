# 16. Debug

Hemos llegado al último capítulo de este libro y de nuestro viaje por los entresijos de la programación para Sega Mega Drive. Desde que comenzamos a hablar sobre que es la Mega Drive, su historia, arquitectura, configurar nuestro entorno, hasta ver todas las herramientas disponibles para crear nuestros juegos.

Solo queda por hablar de un tema que es bastante importante para todo aquel que se enfrente a la programación; y es a la hora de depurar y poder ver la trazabilidad de nuestro código. Cosa importante, para poder detectar posibles errores de ejecución o comúnmente llamados "bugs".

Existen muchas herramientas útiles a la hora de encontrar dichos errores. Como puede ser el poder visualizar la memoria de nuestro dispositivo, y poder ver el valor de nuestras variables, instrucción que estamos ejecutando, etc.

Este tipo de herramientas como depuradores, herramientas de trazabilidad (log) e incluso ver una imagen de la memoria, están disponibles en muchos de los emuladores que hemos mencionado en este libro; como puede ser Gens KMod, Blastem o Kega Fusion, además de que el propio SGDK, nos provee algunas de estas herramientas.

En este capítulo, vamos a ver que herramientas podemos usar para depurar nuestros juegos y poder detectar los fallos o errores.

## Depuración y trazabilidad

Como hemos estado hablando en este capítulo, es importante conocer y utilizar herramientas para poder detectar los errores de nuestro juego y ver que esta haciendo correctamente lo que debe; en muchas ocasiones este tipo de errores no se detectan a simple vista y necesitamos herramientas para ver que esta ocurriendo.

Por ello, necesitamos poder tener una trazabilidad, y la posibilidad de utilizar un depurador para nuestro juego. SGDK, nos provee de herramientas para poder realizar esta trazabilidad.

### KLog

El uso de ficheros de Traza (o logs); es común a la hora de trabajar con sistemas. Por ello, algunos emuladores son capaces de escribir una traza con mensajes que el propio programador utiliza; en muchas ocasiones se podrían poner por pantalla. Pero, es mucho mejor poder tener un fichero de trazas con estos mensajes.

Algunos emuladores como Gens KMod o Blastem, tienen un apartado para ver estas trazas y mostrarlo por dicha consola o fichero. Veamos como se podrían ver los mensajes en el emulador Gens con la modificación KMod.

<div class="image">
<img id="arq" src="16Debug/img/messages.png" alt="Pantalla Mensajes Gens KMod" title="Pantalla Mensajes Gens KMod"/> </div>
<p>Pantalla Mensajes Gens KMod</p>

Para acceder a este apartado, puedes encontrarlo en el menú _CPU->Debug->Messages_; y aquí podremos ver los mensajes que enviemos con unas función especial que contiene SGDK.

La función para enviar información a esta traza es ```kprintf```; la cual escribe un mensaje en dicha traza en vez de escribirlo por pantalla. Esta función es análoga al uso de ```printf``` en c estándar; es decir que recibe 1 o varios parámetros:

* _fmt_: cadena de caracteres que puede contener una serie de formateadores que empiezan por `%`; que nos permitirán escribir variables de distintos tipos y formatos. Para saber como utilizar estos formatos específicos, puedes revisar la documentación estándar de C (dejamos información en las referencias). Es importante saber, que esta función tiene un buffer interno de 255 bytes; por lo que tenemos que tener esto en cuenta a la hora de poner un mensaje muy largo.
* ...: el resto de parámetros, será cada una de las variables que sustituirá a cada uno de los formateadores incluidos en el anterior parámetro.

La función ```kprintf```, devuelve el número de bytes escritos (hasta 255) en la traza.

## Uso de Depurador

Hemos hablado de como utilizar la consola que trae algunos emuladores para escribir una serie de trazas. Pero en muchas ocasiones nos ocurre que necesitamos utilizar herramientas como depuradores para poder ver que esta pasando en un momento dado en nuestro programa.

Por ello, vamos a mostrar en primer lugar, como se podría hacer esta depuración para nuestros juegos; primero de forma más teórica, y después entraremos en más detalle dependiendo de nuestro emulador o herramientas a utilizar.

Si has trabajado con la programación anteriormente, habrás tenido que depurar muchos programas; normalmente en la propia máquina y compilar el código para la misma arquitectura que estas trabajando (normalmente x86_64 o ARM); sin embargo, en este caso no vamos a trabajar con estas arquitecturas; sino con la del Motorola 68000. Por ello necesitamos una forma de depurar este código utilizando un emulador por ejemplo. (Existen formas de depurar con hardware real; pero con mucho más costosas). Veamos un esquema para entender que es lo que queremos hacer.

<div class="image">
<img id="arq" src="16Debug/img/depuracionremota.jpg" alt="Esquema Depuración Remota" title="Esquema Depuración Remota"/> </div>
<p>Esquema Depuración Remota</p>

Como podemos ver en el esquema, se disponen de distintos elementos; algunos en la máquina local, que sería el computador en el que estamos trabajando, y otros en una máquina remota que sería en este caso la propia Mega Drive o un emulador.

Si nos centramos en la máquina local, podemos ver que tenemos el editor, que puede ser cualquier editor de código o entorno de desarrollo integrado, con capacidad de conectarse a un depurador; en la imagen puedes ver que se trata de _Visual Studio Code_.

Por otro lado, necesitaremos utilizar un programa que nos permita conectarnos a una máquina remota (o local) para poder obtener la información necesaria para depurar; como la memoria, instrucción actual, ejecución paso a paso,etc. Para ello, utilizaremos el depurador GDB [^65]; el cual nos va a permitir conectarnos a un emulador (Normalmente utilizando un puerto de red), para poder depurar nuestro juego. SGDK, incluye GDB para poder depurar nuestros juegos.

[^65]: GDB: Gnu Project Debugger, nos va a permitir ver que ocurre dentro de un programa; además de permitir detener la ejecución y poder visualizar las variables o cambiar los valores de estas.

Por último, la máquina remota que puede ser un emulador, a la que GDB se conectará y proveerá toda la información que necesita el depurador. El emulador, tiene que ser capaz de recibir y enviar esta información al depurador para poder tener un correcto funcionamiento; para una mejor comprensión de como se podría realizar esto o que herramientas disponemos, vamos a ver en detalle para algunos emuladores ya mencionados.

### Gens KMod

Como hemos podido ver en otros capítulos, Gens es un emulador de código abierto que nos provee una serie de herramientas adicionales para ayudarnos al desarrollo. Por ejemplo, podemos ver el estado de los registros del procesador y como se encuentra:

<div class="image">
<img id="arq" src="16Debug/img/m68debug.png" alt="Depuración Motorola 68K" title="Depuración Motorola 68K"/> </div>
<p>Depuración Motorola 68K</p>

Esto puede ser util para ver el estado del procesador; pero no es lo que estamos buscando; ya que necesitaremos la modificación KMod, para poder definir las opciones de depuración remota. En el menú _options->Debug_, podemos establecer los puertos y opciones relacionadas con la depuración remota.

<div class="image">
<img id="arq" src="16Debug/img/debugoptgens.png" alt="Opciones de depuración Gens Kmod" title="Opciones de depuración Gens Kmod"/> </div>
<p>Opciones de depuración Gens Kmod</p>

Estas opciones, abrirán un puerto (por defecto el 6868); para poder depurar el procesador M68k. Este puerto será utilizando por GDB para conectarse.

Puedes encontrar más herramientas para depuración o poder visualizar la memoria del VDP,etc. Para más información, consulta la ayuda de Gens KMod.

### Blastem

Otro emulador que hemos mencionado por este libro, es el uso de Blastem. También dispone de opciones de depuración, incluyendo una depuración remota. Sin embargo, no funciona correctamente o esta aún en desarrollo. Por lo que el uso de depuración remota, solo esta soportado por las últimas versiones de Blastem (Recomendamos utilizar la versión Nightly; puedes encontrar más información en las referencias).

En este caso, podremos utilizar un depurador interno, arrancando Blastem con la opción -d; el cual nos permitirá ejecutar paso a paso. Sin embargo, esta opción nos mostrará las instrucciones en ensamblador y tendremos que ser nosotros quienes las traduzcamos para ver que sta ocurriendo.

Si queremos utilizar una depuración remota, necesitaremos ejecutar el siguiente comando dentro de GDB:

```bash
target remote:1234| blastem.exe rom.bin -D
```

Esto dirá a GDB, que se debe de conectar al puerto 1234 (se puede cambiar) y que inicie Blastem emulando nuestra ROM, además de activar la emulación remota. Con esto, podremos depurar nuestro juego a través de GDB.

### Genesis Code

Sin embargo, aunque hemos podido iniciar la emulación, todavía nos queda algo; el poder conectar GDB con nuestro entorno de desarrollo para poder ver las instrucciones de nuestro código C y poder visualizar también paso a paso dichas instrucciones.

Para ello, vamos a ver un ejemplo usando Visual Studio Code, con la extensión _Genesis Code_; que hemos podido ver en este libro, que es una ayuda para el desarrollo usando SGDK. Esta extensión, cuando crea un proyecto, genera una configuración en el directorio _.vscode_; esta configuración, nos ayuda a poder gestionar los ficheros .h, y además a generar la configuración para iniciar la depuración; si echamos un vistazo al fichero _launch.json_, podemos ver.

```json
...
"name": "Debug with gdb remote",
"request": "launch",
"type": "cppdbg",
"program": "%CD%\\out\\rom.out",
"miDebuggerServerAddress": "localhost:6868",
"sourceFileMap": {
  "d:\\apps\\sgdk\\src\\": "${env:GDK}\\src\\",
},
"args": [],
"stopAtEntry": true,
"cwd": "${workspaceFolder}",
"environment": [],
"externalConsole": false,
"MIMode": "gdb",
"launchCompleteCommand": "exec-continue",
"miDebuggerPath": "${env:GDK}\\gdb.exe",
"setupCommands": [
    {
        "text": 
        "set directories '${workspaceFolder}
            ;$cwd;$cdir'"
    }
],
...
```

Podemos ver algunas propiedades en este fichero:

* _name_: Nombre de la configuración que podremos ver en VSCODE.
* _program_: Indica el nombre del binario que usará gdb para iniciar la depuración; se trata del fichero _rom.out_ que se genera al compilar en modo depuración.
* _miDebuggerServerAddress_: Indica la dirección y puerto donde se conectará gdb para hacer la depuración remota. Debe coincidir con el puerto del emulador.
* _sourceFileMap_: Esta propiedad es importante ya que GDB tiene establecidas unas rutas con las que se compilo y se configuró (Concretamente las del proyecto SGDK); por lo tanto se debe de mapear a nuestra carpeta de fuentes de SGDK.
* _cwd_: Indica el directorio de trabajo.
* _MIMode_: Indica el modo de depurador en este caso se trata de gdb.
* _miDebuggerPath_: Ruta donde se encuentra GDB; en este caso se usa el integrado en SGDK. Puede definirse otro.
* _setupCommands_: Indica los comandos y configuraciones que se pasará a GDB. Entre ellas se establece el directorio de los fuentes.

Tras visualizar esta configuración, podemos generar la rom con opciones de depuración, usando el comando de _Genesis Code: Compile For Debugging_; para generar la rom añadiendo la tabla de símbolos y todo lo necesario para depurar.

Por último, ya podemos ejecutar la depuración en el propio editor de Visual Studio Code; si todo va correctamente, podremos ver algo como la siguiente pantalla.

<div class="image">
<img id="arq" src="16Debug/img/vscodedebug.png" alt="Depuración con VsCode" title="Depuración con VsCode"/> </div>
<p>Depuración con VsCode</p>

## Ejemplo de depuración usando KLog

Tras ver las herramientas y como poder depurar, vamos a mostrar el ejemplo de esta sección y de como poder utilizar las trazas correctamente; para ello, vamos a crear un ejemplo muy sencillo que nos mandará una traza cuando pulsemos un botón (A, B o C). Recuerda que este ejemplo, lo puedes encontrar en el repositorio de ejemplos que acompaña a este libro; correspondiente a la carpeta _ej17.klog_.

En primer lugar definimos la función que gestionará los controles. para este ejemplo de forma asíncrona; que será la función ```handleAsyncInput```. En esta función, vamos a revisar cuando se pulsa el botón A, B o C; guardando cada botón en una variable. Veamos un fragmento:

```c
char button='\0';
...
if(state & changed & BUTTON_A){
            button='A';
}else{
...
```

Vemos que  para cada botón, la variable ```button```, almacena un carácter con el botón correspondiente; y más adelante veremos que usamos la función ```kprintf```, para mostrar la traza correspondiente; veamos un fragmento.

```c
#ifdef DEBUG
kprintf("Button Pushed: %c \n",button);
#endif
```

Como habrás podido ver, la instrucción se encuentra entre dos instrucciones de preprocesador; estas instrucciones, harán que este código solo este disponible, si la constante ```DEBUG``` está definida. Esto es una buena práctica; ya que si nuestro juego va a ser publicado, no necesitamos dichas trazas; solo serán útiles mientras se esta desarrollando.

Si ya compilamos y ejecutamos este ejemplo, al pulsar una tecla, podemos ver en la consola de Blastem (o en el apartado correspondiente de Gens KMod), nuestro mensaje.

<div class="image">
<img id="arq" src="16Debug/img/blastemconsole.png" alt="Consola Depuración Blastem" title="Consola Depuración Blastem"/> </div>
<p>Ejemplo 17: Consola Depuración Blastem</p>

Tras ver nuestro último ejemplo, ya damos por finalizado nuestro viaje por la consola de 16 bits; y esperemos que al lector le haya gustado. Además de que esperemos que esto te anime a crear tus propios juegos y publicar más software casero o "homeBrew". Por supuesto no me olvido de darte las gracias personalmente por tu lectura.

## Referencias

* Printf (Documentación C): [https://cplusplus.com/reference/cstdio/printf/](https://cplusplus.com/reference/cstdio/printf/).
* Gens KMod: [https://segaretro.org/Gens_KMod](https://segaretro.org/Gens_KMod).
* Blastem: [https://www.retrodev.com/blastem/nightlies/](https://www.retrodev.com/blastem/nightlies/).
* GNU GDB: [https://www.sourceware.org/gdb/](https://www.sourceware.org/gdb/).
* Artículo sobre Depuración: [https://zerasul.me/blog/debug](https://zerasul.me/blog/debug).
* Visual Studio Code C Debug: [https://code.visualstudio.com/docs/cpp/cpp-debug](https://code.visualstudio.com/docs/cpp/cpp-debug).
