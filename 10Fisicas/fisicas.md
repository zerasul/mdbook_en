# 10. Fisica y matemáticas en Mega Drive

Hay un aspecto importante a la hora de trabjar con ordenadores, que tenemos que tener en cuenta. Sobre todo a la hora de crear videojuegos que tienen distintas interacciones. Y es que un computador no es más que una calculadora que realiza cálculos en números binarios[^51].

Por ello, tenemos que tener en cuenta que en cada arquitectura y procesador, puede tener distintos comportamientos a la hora de realizar cálculos; ya sea desde una simple suma, hasta operaciones más costosas como el acceder a memoria o la propia división o multiplicación.

En este tema, vamos a hablar de como el motorola 68000 trabaja y los distintas operaciones que puede realizar. Además de entrar en detalle en trabajo con punto flotante, e incluso veremos al final como implementar la colisión entre distintos Sprites usando SGDK.

Este tema puede ser algo complicado de entender; pero es necesario para poder crear de la forma más eficiente posible, nuestro videojuego sin tener perdida de frames, o que se congele la pantalla.

[^51]: El Sistema binario, es un sistema de numeración en base 2; por lo que solo se pueden tener dos valores 0 o 1.

## Aritmética en Motorola 68000

Vamos a comenzar hablando sobre el procesador Motorola 68000; ya que este es el procesador principal de la Sega Mega Drive y aunque también posee un procesador Zilog Z80, nos centraremos en el motorola. Recuerda que puedes ver más información sobre la arquitectura y como funciona estos procesadores en la Sega Mega Drive en el capítulo 3.

Vamos a mostrar en este apartado, como se realizan algunas operaciones aritméticas y como se pueden realizar de forma más eficiente.

## Números y tipo de Datos en SGDK

## Punto Flotante

## Física y colisiones

## Ejemplo de colisión de Sprites.

## Referencias

* [https://wiki.neogeodev.org/index.php?title=68k_instructions_timings](https://wiki.neogeodev.org/index.php?title=68k_instructions_timings)