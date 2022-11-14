# 15. SRAM e interrupciones

Ya estamos acercándonos a la recta final de este libro. Hemos estado revisando tanto la parte visual, como el sonido. Además de estudiar de estudiar toda la arquitectura de la Sega Mega Drive; vamos a estudiar un apartado importante; tanto para guardar los progresos de nuestro juego, tanto para manejar las distintas interrupciones que podemos utilizar a la hora de dibujar la pantalla.

En primer lugar, tenemos que saber como vamos a almacenar los datos y tener en cuenta que no todos los tipos de cartucho a utilizar. Por otro lado, veremos el uso de funciones de interrupción para poder actualizar los recursos de nuestro juego usando dichas interrupciones.

Por último, vamos a ver un ejemplo que utilizará estas interrupciones para poder realizar dichas modificaciones y ver como optimizar nuestro juego.

## Guardar el progreso de nuestros juegos

Muchos hemos sufrido, el no poder guardar el progreso de nuestros juegos en Mega Drive; solo algunos juegos disponían de esta capacidad de poder guardar dicho progreso en el cartucho. Esto es debido a que estos cartuchos, tenían una memoria SRAM [^64] junto con una pila de botón (que tenemos que tener cuidado que no se agote tras tantos años); también había algunos tipos especiales como Sonic 3 que tenia un tipo de memoria especial sin necesidad de Pila.

Por ello, si necesitamos almacenar información del progreso de nuestro juego, podemos utilizar esta memoria SRAM, necesitaremos un cartucho que tenga tanto la ROM, como dicha memoria estática.

<div class="image">
<img id="arq" src="15SRAM/img/sram.png" alt="Cartucho con SRAM" title="Cartucho con SRAM"/> </div>
<p>Cartucho con SRAM (DragonDrive)</p>

[^64]: SRAM: Memoria RAM estática. Es una memoria estática de acceso aleatorio; que permite una gran velocidad pero normalmente de poco tamaño.

Aunque también existe la posibilidad de crear un generador de contraseñas; de tal forma que podamos mostrar dicho código al jugador para poder posteriormente continuar el progreso.

### SRAM

Como hemos podido comentar, podemos almacenar información en la memoria estática de tal forma que no se pierda dicha información al apagar la consola. Para ello, necesitaremos una forma de enviar información al cartucho para almacenar dicha información en la memoria SRAM.

Gracias a SGDK, podemos almacenar esta información de manera que podamos también recuperarla. Vamos a poner un caso de uso relacionado con como podemos almacenar o recuperar dicha información. Supongamos el siguiente ```struct``` en C:

```c
struct{
    u8 lives;
    u8 scene;
    u32 score;
    u32 checksum
}player;
```

Donde vemos que tenemos almacenada las vidas que tiene el jugador, escena por la que va, la puntuación y por último un checksum para poder comprobar que la información almacenada es correcta. Esta información, la podemos almacenar en la SRAM, usando una serie de funciones.

En primer lugar, necesitaremos activar al memoria en modo escritura usando la función ```SRAM_enable```; que activa el acceso a la memoria SRAM en modo escritura. En caso de querer acceder solo en modo lectura, podemos usar la función ```SRAM_enableRO```; que activa la memoria SRAM en modo solo lectura.

Una vez activada, podemos escribir o leer sobre la memoria. Es importante conocer que la SRAM esta dividida en palabras de 8 bits; por lo que a la hora de almacenar la información tenemos que tener esto en cuenta.

Veamos que funciones necesitaremos para almacenar el anterior ```struct```; vemos que necesitaremos almacenar 2 variables de 8 bits y dos de 32 bits. Por lo que necesitaremos 10 bytes para almacenar toda la información.

Podemos usar las funciones ```SRAM_writeByte```,```SRAM_writeWord``` o ```SRAM_writeLong``` para almacena información en la memoria SRAM. Veamos cada una de ellas:

La función ```SRAM_writeByte``` almacena 1 byte en la SRAM en función del Offset que indica el offset en el espacio dentro de la SRAM (recuerda que cada palabra son 8 bits). Recibe los siguientes parámetros:

* _offset_: Indica el offset con el que se almacenará.
* _value_: Indica el valor a almacenar (un byte).

La función ```SRAM_writeWord``` almacena 1 palabra (de 2 bytes) en la SRAM. Recibe los siguientes parámetros:

* _offset_: Indica el offset con el que se almacenará.
* _value_: Indica el valor a almacenar (dos bytes).

Por último, la función SRAM_writeLong escribe un entero largo (32 bits) en la SRAM. Recibe los siguientes parámetros:

* _offset_: Indica el offset con el que se almacenará.
* _value_: Indica el valor a almacenar (4 bytes).

Teniendo en cuenta las anteriores funciones, podemos crear la siguiente función para guardar el progreso.

```c
void savePlayerProgress(){

    SRAM_writeByte(0,player.lives);
    SRAM_writeByte(1,player.scene);
    SRAM_writeByte(2,player.score);
    u32 checksum= player.lives+player.scene+player.score;
    player.checksum=checksum;
    SRAM_writeByte(6,player.checksum);
}
```

Como podemos ver, hacemos un checksum (de forma sencilla); sumando los valores almacenados y almacenándolos en la memoria; de tal forma, que después en la lectura podamos comprobar que se ha realizado correctamente.

Vamos a ver como sería la operación inversa. Leer desde la memoria SRAM.En este caso, vamos a utilizar las siguientes funciones ```SRAM_readByte```, ```SRAM_readWord``` o ```SRAM_readLong```. Veamos cada una de estas funciones:

La función ```SRAM_readByte``` lee un byte desde la memoria SRAM. Recibe el siguiente parámetro:

* _offset_: Indica el offset con el que se almacenará.

Esta función devuelve un entero de 1 byte con la información leída.

La función ```SRAM_readWord``` lee una palabra (2 bytes) desde la memoria SRAM. Recibe el siguiente parámetro:

* _offset_: Indica el offset con el que se almacenará.

Esta función devuelve un entero de 2 bytes con la información leída.

La función ```SRAM_readLong``` lee un entero largo (4 bytes) desde la memoria SRAM. Recibe el siguiente parámetro:

* _offset_: Indica el offset con el que se almacenará.

Esta función devuelve un entero de 4 bytes con la información leída.

Tras ver las funciones que leen desde la memoria SRAM, podemos crear una función para leer dicha información:

```c
void readGameProgress(){
    player.lives = SRAM_readByte(0);
    player.scene = SRAM_readByte(1);
    player.score = SRAM_readByte(2);
    player.checksum= SRAM_readByte(6);
}
```

Obviamente, quedaría por comprobar que el checksum leído es correcto con el calculado de los datos del struct.

## Interrupciones

### HBlank

### VBlank

## Ejemplo con Interrupciones

## Referencias
