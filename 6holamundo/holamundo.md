# 6. Hola Mundo

Hemos preparado ya nuestro entorno de desarrollo y visto las distintas herramientas que podemos utilizar a la hora de desarrollar nuestro juego "casero"; ahora ya podremos entrar en materia.

En este tema, comenzaremos a hablar sobre como se puede crear un nuevo proyecto; haciendo incapié, en la estructura de este y de como utilizar el proyecto para crear nuestro juego.

Tras comentar como crear un proyecto, nos pondremos con las manos en la masa; de tal forma que crearemos nuestro primer juego; mostrando por pantalla el famoso hola mundo. mostrando el código fuente y lo explicaremos.

Por último, veremos como construir la rom propiamente dicha y ejecutarlo en un emulador, o por el contrario podemos pasarlo a un flashcart, y verlo en una consola real.

## Crear un nuevo proyecto

El primer paso para poder comenzar a escribir nuestro código, es crear un nuevo proyecto para usarlo con SGDK. Para ello, vamos a crear un proyecto con el mínimo código que nos mostrará un "Hola Sega" por pantalla.

Para crear un nuevo proyecto, vamos a utilizar la extensión _Genesis Code_ para Visual Studio code; aunque puede crearse manualmente si se requiere. Para crear un proyecto con esta extensión, usaremos la paleta de comandos usando el atajo de teclado <kbd>ctrl</kbd>+<kbd>⇧ mayus</kbd>+<kbd>p</kbd>. Y seleccionando la opción _Genesis Code: Create Project_.

Al seleccionar esta opción, se nos preguntará por donde se creará el proyecto. Una vez seleccionado, se generarán los ficheros y carpetas necesarios y se abrirá con Visual Studio Code. Podemos visualizar los siguientes ficheros y carpetas:

* _.vscode_ (carpeta): Esta carpeta es especifica de Visual Studio code y contiene configuración para el proyecto. No se debería de modificar esta carpeta directamente.
* _inc_ (carpeta): Esta carpeta contendrá los ficheros cabecera de C, es decir los ficheros .h.
* _res_ (carpeta): Esta carpeta contendrá los recursos del juego; ya sean gráficos (imágenes), sonido (wav), musica (vgm) además, de los ficheros de recursos .res junto a los ficheros .h que son generados por la herramienta _rescomp_.
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
        //For versions prior to SGDK 1.60 use VDP_waitVSync instead.
        SYS_doVBlankProcess();
    }
    return (0);
}
```

Este fragmento de código en C, podemos ver el hola mundo para Sega Mega Drive. En este caso, podemos ver el código más simple para mostrar por pantalla un mensaje para Mega Drive. Vamos a mostrar las funciones más importantes.

En primer lugar, podemos ver el include de la cabecera _genesis.h_; este fichero de cabecera nos provee de acceso a todas las funciones y datos que nos da la librería LibMD que incluye SGDK.

**NOTA**: Dependiendo de la configuración elegida, puede que necesite incluir algunas rutas en la configuración del plugin de C/C++ [^39] de Visual Studio Code para tener acceso a todas las funcionalidades.

[^39]: Puede ver la configuración de los ficheros include para C/C++, en la configuración de VsCode.

Si nos centramos en la función ```main``` vemos que se realiza una llamada a la función ```VDP_drawText```; esta función, llama al chip gráfico VDP y nos va a permitir escribir un texto por pantalla, usando una fuente por defecto (o precargando una fuente personalizada). Vemos que tiene 3 parametros:

* parametro 1: cadena de caracteres con la información a mostrar.
* parametro 2: posición X donde se mostrará el texto. la coordenada X indica la columna donde se mostrará el texto. Esta expresado el Tiles.
* parametro 3: posición X donde se mostrará el texto. la coordenada Y indica la fila donde se mostrará el texto. Esta expresado el Tiles.

Tanto la posición X e Y, estan expresados en Tiles. Un tile es un recuadro de 8x8 pixeles que se pinta por pantalla; el VDP trabaja en esta unidad y por lo tanto debemos de tener en cuenta esta dimensión. En el ejemplo vemos que pintaremos en la posición 10,13 es decir, (80px,104px).

Una vez hemos visto como escribir texto por pantalla, podemos observar que aparece un bucle infinito; esto es importante a la hora de diseñar videojuegos; ya que si no estuviese dicho bucle, la ejecución terminaría, y no se podría interactuar con el juego.

Dentro del bucle, vemos una llamada a la función ```SYS_doVBlankProcess``` esta función, realiza una serie de acciones para gestionar el hardware, como esperar a que se termine de pintar la pantalla; de tal forma que la ejecución del juego se para hasta que se termina de pintar. Este proceso, se realiza 50 veces para sistemas PAL, o 60 veces para sistemas NTSC; de esta forma, se consigue la tasa de refresco, y podemos dibujar nuestro juego.

**NOTA**: Para versiones de SGDK, anteriores a la 1.60, utilizar la función ```VDP_waitVSync```.

## Compilar y ejecutar nuestro proyecto

## Referencias
