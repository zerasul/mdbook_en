# 10. Fisica y matemáticas en Mega Drive

Hay un aspecto importante a la hora de trabjar con ordenadores, que tenemos que tener en cuenta. Sobre todo a la hora de crear videojuegos que tienen distintas interacciones. Y es que un computador no es más que una calculadora que realiza cálculos en números binarios[^51].

Por ello, tenemos que tener en cuenta que en cada arquitectura y procesador, puede tener distintos comportamientos a la hora de realizar cálculos; ya sea desde una simple suma, hasta operaciones más costosas como el acceder a memoria o la propia división o multiplicación.

En este tema, vamos a hablar de como el motorola 68000 trabaja y los distintas operaciones que puede realizar. Además de entrar en detalle en trabajo con punto flotante, e incluso veremos al final como implementar la colisión entre distintos Sprites usando SGDK.

Este tema puede ser algo complicado de entender; pero es necesario para poder crear de la forma más eficiente posible, nuestro videojuego sin tener perdida de frames, o que se congele la pantalla.

[^51]: El Sistema binario, es un sistema de numeración en base 2; por lo que solo se pueden tener dos valores 0 o 1.

## Aritmética en Motorola 68000

Vamos a comenzar hablando sobre el procesador Motorola 68000; ya que este es el procesador principal de la Sega Mega Drive y aunque también posee un procesador Zilog Z80, nos centraremos en el motorola. Recuerda que puedes ver más información sobre la arquitectura y como funciona estos procesadores en la Sega Mega Drive en el capítulo 3.

Vamos a mostrar en este apartado, como se realizan algunas operaciones aritméticas y como se pueden realizar de forma más eficiente.

Comenzamos comentando como trabaja el procesador m68k; se trata de un procesador que tiene registros de 32bits y que puede trabajar con ellos gracias a dos ALU [^52] que tiene. Es importante conocer las limitaciones que nos provee este procesador; si bien puede trabajar perfectamente con cualquier operación matemática, si que no puede por ejemplo trabajar con números decimales, o la eficiencia a la hora de trabajar con las distintas operaciones matemáticas.

Un microprocesador, no tarda lo mismo a la hora de realizar una suma, o de realizar una multiplicación o división; normalmente la duración de estas operaciones, se realizan por ciclos (la duración de un ciclo de un procesador es 1/F; donde F es la frecuencia del reloj). Vamos a mostrar el coste en ciclos que puede llegar a tardar las distintas operaciones aritméticas.

| **Operación** | **Descripción** | **Coste en ciclos** |
|:-------------:|-----------------|---------------------|
|      ADD      | Suma            |                   8 |
|      AND      | And             |                  12 |
|      CMP      | Comparación     |                   6 |
|      DIVS     | División        |                 158 |
|      DIVU     | División Entera |                 140 |
|      EOR      | XOR             |                  12 |
|      MUL      | Multiplicación  |                  70 |
|       OR      | Or              |                  12 |
|      SUB      | Resta           |                  12 |
|      ASR,ASL  | Desplazamiento  |                  8  |

_Tabla3: Operaciones y coste del procesador Motorola 68000_

Podemos observar que tanto la multiplicación; como la división son operaciones muy costosas por lo que realizarlas puede ser poco eficiente (158 y 70 ciclos respectivamente). Por lo tanto, es necesario evitar utilizar estas operaciones.

Una alternativa a multiplicar, es utilizar desplazamientos tanto a la derecha como a la izquierda; como podemos ver en la tabla anterior, un desplazamiento puede tener hasta 8 ciclos de reloj para completarse; por lo es mucho más eficiente a la hora de realizar una multiplicación o división.

Veamos un ejemplo:

```c

int a=3;
int b=2;

a*b;// 6
a<<1; //6

```

Vemos como en el anterior ejemplo, ambas operaciones son equivalentes; puesto que multiplicar por 2, es lo mismo que desplazar 1 a la izquierda. Esto tambien puede aplicarse a la división.

```c

int a=6;

a/2; //3
a>>1; //3
```

Desplazando a la derecha, podemos ver que se puede dividir por 2. Por lo que puede ser más eficiente a la hora de trabajar con estas operaciones aritméticas.

**NOTA**: Es importante saber si el compilador utilizado, puede transformar las operaciones de multiplicación o división en operaciones más eficientes [^53].

Tras ver las operaciones aritméticas y como optimizarlas, vamos a mostrar otro apartado a tener en cuenta a la hora de programar para Sega Mega Drive; se trata del uso de los distintos tipos de datos para poder ir optimizando el uso de memoria; ya que esta es importante a la hora de trabajar con sistemas con pocos recursos (64kb de memoria RAM).

[^52]: (ALU); Unidad Aritmético Lógica; es el componente de un microprocesador encargado de realizar distintas operaciones matemáticas.
[^53]: Las distintas operaciones u optimizaciones que se pueden utilizar, dependerá del compilador y la versión de este. Consulta la documentación de Gcc para más información.

## Números y tipo de Datos en SGDK

A la hora de trabajar con los distintos tipos de datos; necesitamos conocer como se almacenaran en memoria y como se puede utilizar; por ejemplo a la hora de trabajar con números.

Por ello, vamos a mostrar los distintos tipos de datos numéricos que nos provee SGDK; aunque podemos seguir utilizando los clásicos de C (Ya que son deficiniciones a partir de estos); veamos una tabla con los distintos tipos de datos y cuanto ocupa en memoria.

| **Tipo SGDK** |  **Tipo (C)**  | **Descripción**             | **Rango**               |
|---------------|:--------------:|-----------------------------|-------------------------|
|       u8      |  unsigned char | entero sin signo de 8 bits  | 0 a 255                 |
|       s8      |      char      | entero con signo de 8 bits  | -128 a 127              |
|      u16      | unsigned short | entero sin signo de 16 bits | 0 a 65535               |
|      s16      |      short     | entero con signo de 16 bits | -32678 a 32677          |
|      u32      |  unsigned long | entero sin signo de 32 bits | 0 a 4294967295          |
|      s32      |      long      | entero con signo de 32 bits | -2147483648 a 217483647 |

_Tabla 4: Tipo de datos en SGDK y su equivalente en C._

Vemos como hay distintos tipos de datos disponibles para los enteros por ello, tenemos que tener en cuenta siempre el valor que puede contener para evitar desbortamientos y que se realice un comportamiento inesperado.

Habrá podido ver, que no hemos incluido los tipos de datos numéricos con decimales; esto se debe a que el procesador Motorola 68000, no tenia soporte para punto flotante; sin embargo, si que podemos utilizarlo con SGDK.

## Punto Flotante

El procesador Motorola 68000 no tiene soporte para punto flotante por lo tanto, no se pueden realizar cálculos con números decimales; por ello se deben de implementar todos los cálculos con números enteros y realizar transformaciones para trabajar con ellos.

Por ello SGDK, trae una serie de datos preparados para trabajar con punto flotante; estos tipos de datos son el ```FIX16``` y el ```FIX232```; que corresponderían a los tipos ```float``` y ```double``` de C; veamos una tabla con sus datos:

| **Tipo SGDK** | **Tipo (C)** | **Descripción** | **Rango**               |
|---------------|:------------:|-----------------|-------------------------|
|     fix16     |     float    | Decimal simple  | 3.4*E^-38 a 3.4*E^+38   |
|     fix32     |    double    | Decimal doble   | 1.7*E^-308 a 1.7*E^+308 |

_Tabla 5: Tipos de datos decimales en SGDK._

Hay que tener en cuenta, que los tipos de datos ```fix16``` o ```fix32``` no son equivalentes a float o double en código. Por ejemplo:

```c

fix16 a = 1.24;
```

Es una instrucción erronea; ya que se tiene que transformar el valor a dicho tipo; por ello podemos utilizar las distintas funciones que nos provee SGDK. Por ejemplo para declarar un tipo como ```fix16``` o ```fix32```.

```c
fix16 a = FIX16(1.24);
```

En el anterior fragmento; si es una instrucción correcta para declarar en este caso una variable de tipo fix16. Además, podemos ver algunas funciones útiles para usar con los tipos de dato decimal. Veamos una tabla con algunas de ellas.

| **Funciones**         | **Descripción**                                                               |
|-----------------------|-------------------------------------------------------------------------------|
| FIX16(nº)             | Declara un nuevo Fix16 a partir de un número                                  |
| FIX32(nº)             | Declara un nuevo Fix32 a partir de un número                                  |
| intToFix16(nº)        | Convierte un entero a fix16                                                   |
| intToFix32(nº)        | Convierte un entero a fix32                                                   |
| fix16ToInt(nº)        | Convierte un fix16 a entero (truncando)                                       |
| fix32ToInt(nº)        | Convierte un fix32 a entero(truncando)                                        |
| fix16ToRoundedInt(nº) | Convierte un fix16 a entero por redondeo                                      |
| fix32ToRoundedInt(nº) | Convierte un fix32 a entero por redondeo                                      |
| fix16Add(a,b)         | Realiza la suma de dos fix16.                                                 |
| fix32Add(a,b)         | Realiza la suma de dos fix32                                                  |
| fix16Sub(a,b)         | Realiza la resta de dos fix16                                                 |
| fix32Sub(a,b)         | Realiza la resta de dos fix32                                                 |
| fix16Mul(a,b)         | Realiza el producto de dos fix16                                              |
| fix32Mul(a,b)         | Realiza el producto de dos fix32                                              |
| fix16sqrt(a)          | Realiza la raiz cuardara de un fix16                                          |
| fix32sqrt(a)          | Realiza la raiz cuadrada de un fix32                                          |
| sinFix16(v)           | Realiza el seno del angulo en radianes representado en el rango de 0 a 1024   |
| cosFix32(v)           | Realiza el coseno del angulo en radianes representado en el rango de 0 a 1024 |

_Tabla 6: Funciones para utilizar con Fix16 o Fix32_

Si necesita más información de como utilizar Fix16 o Fix32, puede consultar la documentación de SGDK, el fichero que incluye todas las definiciones:

[https://github.com/Stephane-D/SGDK/blob/master/inc/maths.h](https://github.com/Stephane-D/SGDK/blob/master/inc/maths.h)

Una vez ya conocemos los distintos tipos de datos que podemos utilizar y como operar con ellos a través de las distintas funciones, vamos a centrarnos en el objetivo de este capítulo; el poder implementar físicas y colisiones entre los distintos Sprites.

## Física y colisiones

## Ejemplo de colisión de Sprites

## Referencias

* [https://wiki.neogeodev.org/index.php?title=68k_instructions_timings](https://wiki.neogeodev.org/index.php?title=68k_instructions_timings)
* [https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html)
* [https://ccia.ugr.es/~jfv/ed1/c/cdrom/cap2/cap24.htm](https://ccia.ugr.es/~jfv/ed1/c/cdrom/cap2/cap24.htm)
* [https://plutiedev.com/basic-collision](https://plutiedev.com/basic-collision)