# 6. Hola Mundo

Hemos preparado ya nuestro entorno de desarrollo y visto las distintas herramientas que podemos utilizar a la hora de desarrollar nuestro juego "casero"; ahora ya podremos entrar en materia.

En este tema, comenzaremos a hablar sobre como se puede crear un nuevo proyecto; haciendo hincapié, en la estructura de este y de como utilizar el proyecto para crear nuestro juego.

Tras comentar como crear un proyecto, nos pondremos con las manos en la masa; de tal forma que crearemos nuestro primer juego; mostrando por pantalla el famoso hola mundo. mostrando el código fuente y lo explicaremos.

Por último, veremos como construir la rom propiamente dicha y ejecutarlo en un emulador, o por el contrario podemos pasarlo a un flashcart, y verlo en una consola real.

## Crear un nuevo proyecto

El primer paso para poder comenzar a escribir nuestro código, es crear un nuevo proyecto para usarlo con SGDK. Para ello, vamos a crear un proyecto con el mínimo código que nos mostrará un "Hola Sega" por pantalla.

Para crear un nuevo proyecto, vamos a utilizar la extensión _Genesis Code_ para Visual Studio code; aunque puede crearse manualmente si se requiere. Para crear un proyecto con esta extensión, usaremos la paleta de comandos usando el atajo de teclado <kbd>ctrl</kbd>+<kbd>⇧ mayus</kbd>+<kbd>p</kbd>. Y seleccionando la opción _Genesis Code: Create Project_.

Al seleccionar esta opción, se nos preguntará por donde se creará el proyecto. Una vez seleccionado, se generarán los ficheros y carpetas necesarios y se abrirá con Visual Studio Code. Podemos visualizar los siguientes ficheros y carpetas:

* _.vscode_ (carpeta): Esta carpeta es especifica de Visual Studio code y contiene configuración para el proyecto. No se debería de modificar esta carpeta directamente.
* _inc_ (carpeta): Esta carpeta contendrá los ficheros cabecera de C, es decir los ficheros .h.
* _res_ (carpeta): Esta carpeta contendrá los recursos del juego; ya sean gráficos (imágenes), sonido (wav), música (vgm) además, de los ficheros de recursos .res junto a los ficheros .h que son generados por la herramienta _rescomp_.
* _src_ (carpeta): Esta carpeta contendrá los ficheros de código fuente .c. Aquí se almacenará todo el código fuente de nuestro juego.
* _.gitignore_: Este fichero es usado por el repositorio Git que se genera al crear el proyecto. Contiene los ficheros que no serán manejados por el sistema de control de versiones.
* _README.md_: Un pequeño fichero Markdown con un readme del proyecto.

Aunque pueden encontrarse modificaciones de la estructura de los proyectos para SGDK; esto dependerá en gran medida del fichero Makefile que se utilice; en este caso nos centramos en el fichero que se utiliza por defecto con SGDK.

## Hola Mundo

Una vez conocida la estructura del proyecto, ya podemos centrarnos en el propio código fuente; para ello, al crear el proyecto, podemos observar en la carpeta _src_, un fichero llamado _main.c_; en este fichero se encuentra el código fuente de nuestro juego.

Recordamos que puede encontrar todos los proyectos de este libro en el siguiente repositorio de Github; en este caso, podéis encontrar el código que describiremos en este capítulo en la carpeta _ej1.helloworld_. Seguidamente mostramos la dirección del repositorio:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

Veamos el fragmento de código:

```c
#include <genesis.h>

int main()
{
    VDP_drawText("Hello Sega!!", 10,13);
    while(1)
    {
        //For versions prior to SGDK 1.60
        // use VDP_waitVSync instead.
        SYS_doVBlankProcess();
    }
    return (0);
}
```

Este fragmento de código en C, podemos ver el hola mundo para Sega Mega Drive. En este caso, podemos ver el código más simple para mostrar por pantalla un mensaje para Mega Drive. Vamos a mostrar las funciones más importantes.

En primer lugar, podemos ver el include de la cabecera _genesis.h_; este fichero de cabecera nos provee de acceso a todas las funciones y datos que nos da la librería LibMD que incluye SGDK.

**NOTA**: Dependiendo de la configuración elegida, puede que necesite incluir algunas rutas en la configuración del plugin de C/C++ [^41] de Visual Studio Code para tener acceso a todas las funcionalidades.

[^41]: Puede ver la configuración de los ficheros include para C/C++, en la configuración de VsCode.

Si nos centramos en la función ```main``` vemos que se realiza una llamada a la función ```VDP_drawText(const char * text,u16 x, u16 y)```; esta función, llama al chip gráfico VDP y nos va a permitir escribir un texto por pantalla, usando una fuente por defecto (o pre-cargando una fuente personalizada). Vemos que tiene 3 parámetros:

* str: cadena de caracteres con la información a mostrar.
* x: posición X donde se mostrará el texto. la coordenada X indica la columna donde se mostrará el texto. Esta expresado en Tiles.
* y: posición Y donde se mostrará el texto. la coordenada Y indica la fila donde se mostrará el texto. Esta expresado en Tiles.

Tanto la posición X e Y, están expresados en Tiles. Un tile es un recuadro de 8x8 pixeles que se pinta por pantalla; el VDP trabaja en esta unidad y por lo tanto debemos de tener en cuenta esta dimensión. En el ejemplo vemos que pintaremos en la posición 10,13 es decir, (80px,104px).

Una vez hemos visto como escribir texto por pantalla, podemos observar que aparece un bucle infinito; esto es importante a la hora de diseñar videojuegos; ya que si no estuviese dicho bucle, la ejecución terminaría, y no se podría interactuar con el juego.

Dentro del bucle, vemos una llamada a la función ```SYS_doVBlankProcess``` esta función, realiza una serie de acciones para gestionar el hardware, como esperar a que se termine de pintar la pantalla; de tal forma que la ejecución del juego se para hasta que se termina de pintar. Este proceso, se realiza 50 veces para sistemas PAL, o 60 veces para sistemas NTSC; de esta forma, se consigue la tasa de refresco, y podemos dibujar nuestro juego.

**NOTA**: Para versiones de SGDK, anteriores a la 1.60, utilizar la función ```VDP_waitVSync```.

## Compilar y ejecutar nuestro proyecto

Tras finalizar de escribir nuestro código, podemos dar el siguiente paso; generar la ROM [^42], y ejecutarla en un emulador.

En este paso, se generarán todos los ficheros necesarios, y al final tendremos un fichero llamado _rom.bin_ con nuestra ROM preparada para ser ejecutada en un emulador, o en un hardware Real.

Para compilar nuestro juego, es necesario tener configurado correctamente SGDK; ya sea usando las variables de entorno, o con la configuración de _Genesis Code_. Además de tener configurada correctamente la ruta donde se encuentra nuestro emulador.

Se utilizará el comando _Genesis Code: compile & Run Project_, para generar la ROM y posteriormente ejecutar un emulador con la Rom Generada. Existen otros comandos para Compilar (_Genesis Code: Compile Project_) o compilar para depuración (_Genesis Code: Compile For Debugging_). En este ejemplo, usaremos la opción de _Compile & Run Project_.

### Compilar a mano

Si por un casual necesitara compilar manualmente, puede hacerlo usando los comandos para llamar a SGDK. Dejamos aquí las distintas llamadas para generar la Rom usando SGDK, Gendev o Docker.

#### SGDK (Windows)

```bash
%GDK%/bin/make -f %GDK%/makefile.gen
```

#### Gendev (linux)

```bash
make -f $GENDEV/sgdk/mkfiles/makefile.gen
```

### Docker

```bash
docker run --rm -v $PWD:/src sgdk
```

Si todo ha ido correctamente, podemos ver como se generará la ROM en la carpeta _out_ con el nombre de _rom.bin_ y posteriormente, se abre nuestro emulador mostrándolo.

**NOTA**: Para aquellos que usen Windows, puede darle un error si por defecto usan _PowerShell_; esto puede solucionarse estableciendo por defecto la terminal de vscode para que use _cmd_. Para ello usaremos la paleta de comandos y seleccionaremos la opción _View: Toggle Integrated Terminal_; seleccionando posteriormente, para que utilice cmd.

<div class="image">
<img id="arq" src="6holamundo/img/hello.png" alt="Hello" title="Hello"/> </div>
<p>Hello Sega en Mega Drive</p>

[^42]: ROM (Read Only Memory): se trata de una memoria de solo lectura que normalmente se encuentra dentro del cartucho en una EPROM (o Flash en las versiones más modernas).

## Cabecera de una ROM

A la hora de crear la ROM de nuestro juego, se deben de añadir una serie de datos sobre el juego. Algunos se generan automáticamente y otros se pueden personalizar. SGDK, genera esta cabecera pero podemos añadir datos sobre el juego; como por ejemplo el título del juego, versión o incluso con qué dispositivos es compatible.

Vemos que es interesante hablar sobre este apartado y ver las distintas opciones que podemos encontrar a la hora de generar la cabecera de la ROM ya que es necesario sobre todo para poder probarlo correctamente en un hardware real, una vez queramos tener nuestra ROM finalizada.

Como hemos comentado, SGDK, genera el contenido mínimo para la cabecera de la ROM. Este contenido puede encontrarse dentro de la carpeta _src/boot_ de nuestro proyecto. En esta carpeta, podemos encontrar un fichero llamado "rom_head.c" , con la definición de un struct de C y posteriormente la inicialización de este.

Vamos a mostrar la definición de este struct:

```C
const struct
{
    char console[16];             
    char copyright[16];             
    char title_local[48];           
    char title_int[48];             
    char serial[14];                
    u16 checksum;                   
    char IOSupport[16];             
    u32 rom_start;                  
    u32 rom_end;                    
    u32 ram_start;                  
    u32 ram_end;                    
    char sram_sig[2];               
    u16 sram_type;                  
    u32 sram_start;                 
    u32 sram_end;                   
    char modem_support[12];         
    char notes[40];                 
    char region[16];                
}
```

Vemos que hay distintos apartados para distintos usos; vamos a mostrar algunos de ellos:

**console**

Una cadena de caracteres de 16 bytes; donde se indica el tipo de Sistema de la ROM; para Mega Drive puede tener el valor ```SEGA MEGA DRIVE``` o ```SEGA GENESIS```.

**copyright**

Indica el Copyright indicando quien publica la ROM y en que año. Por ejemplo ```(C)SGDK 2019```.

**title_local**

Indica el título del juego.

**title_int**

Indica el título del juego internacionalmente. Puede repetir el anterior.

**serial**

Indica el nº de serie del juego; puede ser interesante para identificar la tirada de la ROM o la compilación de la misma.

Suele tener el formato ```XX YYYYYYYY-ZZ``` donde ```XX``` define el tipo de ROM (GM para juego), ```YYYYYYYY``` para indicar el nº de serie y ```ZZ``` para indicar la revisión.

**checksum**

El _checksum_ es una suma de 16 bits con el contenido de la ROM; esta suma puede indicar si la ROM ha sido modificada o no; de tal forma que algunos juegos la comprueban como forma de averiguar que es una ROM original; algunos emuladores también la comprueban.

**IOSupport**

Este es uno de los aspectos más importantes; en este apartado, se define con qué dispositivos de entrada o salida es compatible; ya sea mando de 3 o 6 botones, ratón, CD-ROM, Activator,etc...

Es importante definirlo para tener una mayor compatibilidad con todo el hardware disponible. Veamos una tabla con las opciones disponibles:

| Clave | Descripción               |
|-------|---------------------------|
| J     | Mando de 3 Botones        |
| 6     | Mando de 6 Botones        |
| 0     | Mando Master System       |
| A     | Joystick Analógico        |
| 4     | Multitap                  |
| G     | Pistola de Luz (Lightgun) |
| L     | Activator                 |
| M     | Mouse                     |
| B     | Trackball                 |
| T     | Tablet                    |
| V     | Paddle                    |
| K     | Teclado                   |
| R     | RS-232                    |
| P     | Impresora                 |
| C     | CD-ROM (Sega CD)          |
| F     | Floppy drive              |
| D     | Download?                 |
_Tabla 1: Valores para dispositivos compatibles._

Se pueden usar distintas opciones a la vez; es decir si definimos el valor ```J6M``` quiere decir que la ROM es compatible con mando de 3 y 6 botones y además el ratón.

**rom_start y rom_end**

Indica donde comienza y donde termina la ROM; estos valores son calculados por SGDK cuando se genera la ROM.

**sram_start y sram_end**

Si nuestra ROM utiliza SRAM para almacenar datos, se deben definir las direcciones de inicio y de fin. también se debe definir ```sram_type```para indicar el tipo de SRAM a utilizar.

**modem_support**

Indica si esta ROM tiene soporte para Modem y que servicios dispone.

**region**

Indica las regiones en la que es compatible la ROM (Japón, Europa o America); con los siguientes valores [^43] :

| Clave | Descripción   |
|-------|---------------|
| "J"   | Japan         |
| "U"   | Americas      |
| "E"   | Europe        |
_Tabla 2: Valores de las regiones de la ROM_

Puede ser compatible en varias regiones; por lo que puede tener el valor ```JUE``` indicando que es compatible con Japón, Europa y America.

[^43]: Estos valores corresponden a la forma tradicional; existe una forma posterior que fue adoptada por SEGA; para más información, comprueba las referencias de este capítulo.

**NOTA**: Tener siempre en cuenta que aunque la ROM sea compatible con otras regiones, se debe también definir el Sistema de color PAL o NTSC.

En las referencias, dejamos más información acerca de la cabecera de la ROM.

## Referencias

* Ohsat Games: [https://www.ohsat.com/](https://www.ohsat.com/)
* SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK)
* Docker: [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)
* Danibus (aventuras en mega Drive): [https://danibus.wordpress.com/](https://danibus.wordpress.com/)
* Plutiedev: [https://plutiedev.com/rom-header#devices](https://plutiedev.com/rom-header#devices)
