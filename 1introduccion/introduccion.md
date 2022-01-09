# 1. Introducción

Bienvenido a este libro sobre creación y desarrollo de software Homebrew para Sega Mega Drive (o Sega Genesis) [^1]. Para muchos, este sistema ha sido con el que hemos crecido y nos ha traido grandes recuerdos. Por ello, aquellos que seguimos aprendiendo sobre tecnología como un servidor, podemos aprender a crear software para esta arquitectura que ya tiene más de 30 años.

Aunque alguno puede pensar que soy algo joven (35 años recien cumplidos) para la Mega Drive, supongo que por el ámbito familiar y por haber tenido una de pequeño, siempre me dejo marca pasar horas y horas jugando a Sonic & Knuckles[^2] o al World Of Illusion[^3].

Muchos recordaran los tiempos del spectrum donde usaban revistas donde venian pequeños juegos que debiamos escribir a mano (Normalmente en BASIC o ensamblador), donde cualquier mínimo error hacia que nuestro juego no funcionase. Por suerte, hoy en día se utilizan herramientas más modernas que usar BASIC o ensamblador. Como puede ser utilizar lenguaje C junto a alguna librería como SGDK o editores más modernos que nos ayuden en el desarrollo de nuestro juego.

Por supuesto que existen lenguajes más modernos. Pero queremos recordar que normalmente se utilizaba ensamblador para los desarrollos y que al menos usando C nos abstraeremos del mismo. No quiere decir que no se pueda seguir utilizando ya que a día de hoy, muchos siguen trabajando con ensamblador.

Este libro, pretende ser una guia para poder aprender los conceptos y herramientas para crear un videojuego totalmente funcional para Sega Mega Drive, utilizando herramientas modernas.

[^1]: Sega Mega Drive / Sega Genesis es una marca registrada de Sega Inc.

[^2]: Sonic & Knuckles es un videojuego que pertenece a Sega Inc. Todos los derechos reservados.

[^3]: World of Illusion: es un videojuego desarrollado por Disney Para sega Mega Drive. Todos los derechos reservados.

## ¿Qué es y para que sirve este libro?

Como hemos comentado en la introducción, este libro pretende ser una guia para poder crear un videojuego completamente funcional para el sistema Sega Mega Drive (o Sega Genesis).

Este libro; no pretende ser un libro de introducción a la programación ya que se utilizan conceptos avanzados a la hora de adentrarse en el mundo del Homebrew y se supone que el usuario esta familiarizado con dichos conceptos.

Además, este libro no pretende ser tampoco un libro sobre diseño de videojuegos; ya que no es el objetivo del mismo. Existen mucha bibliografia al respecto y nos centraremos principalmente en diseñar y crear ejemplos para comprender los entresijos de la _"negrita"_ de Sega.

### Estructura del libro

Este libro esta dividido en 16 capitulos donde en cada uno de ellos se aborda un tema desde comentar qué es la Sega Mega Drive, hasta poder crear conceptos avanzados de creación de videojuegos como el scroll o el depurar nuestros juegos.

La primera parte del libro, trata sobre una introducción a la Mega Drive como su historia, arquitectura y las herramientas y librerías que vamos a utilizar; como la libreria SGDK(Sega Genesis Development Kit) y el entorno de desarrollo a utilizar.

En la segunda parte, hablaremos de como comenzar a hacer nuestro juego, mostrando los conceptos básicos; desde el Hola Mundo, hasta terminar con el uso de Sprites sin olvidar el sonido.

Por último, se hablará de conceptos más avanzados como el uso de Scroll, Tilesets e incluso hablar de herarmientas para nuestro desarrollo como la depuración (Debug) e incluso usar la SRAM para guardar información de nuestro juego.

Para poder tener una mejor compresión de cada uno de los capítulos a tratar en este libro, se comentaran distintos ejemplos y pequeños fragmentos de código que estarán disponibles Online dentro del repositorio de código en Github:

[https://github.com/zerasul/mdbook](https://github.com/zerasul/mdbook)

Para cada capítulo, se mostrará un ejemplo con el que trabajar con las distintas herramientas que se comentarán en este libro.

Otra parte importante, es que habrás podido ver que este libro esta bajo una licencia Creative Commons. Por lo que este libro esta disponible para todo el mundo y Puede ser mejorado y modificado. Si detectas alguna errata o posible mejora del mismo, no dudes en enviarme cualquier sugerencia al repositorio de código de este libro.

## Objetivos

Los objetivos de este libro son:

1. Conocer la Sega Mega Drive /Sega genesis y su historia
2. Conocer la arquitectura de la Sega Mega Drive.
3. Conocer las distintas herramientas que se pueden utilizar para crear software casero o Homebrew para Sega Mega Drive.
4. Conocer la libreria SGDK(Sega Genesis Development Kit).
5. Conocer los distintos conceptos sobre creación de videojuegos en 2D aplicados a la Sega Mega Drive.
6. Crear un videojuego completamente funcional para Sega mega Drive.

## Requisitos previos para este libro

Para poder comprender los contenidos de este libro, necesitaras conocer los siguentes lenguajes o herramientas (o al menos haberlos usado).

* Lenguaje de Programación C.
* Bash Script o CMD (windows).
* Git
* Herramientas de dibujo de Pixel Art como asersprite.

Por supuesto, no te preocupes si no entiendes alguna parte del código ya que cada capítulo trae referencias para poder comprender el código fuente o cualquier otra referencia tratada.

Además para poder seguir todos los contenidos de este libro recomendamos utilizar el siguiente software o hardware:

* **Sistema Operativo Windows, Linux o Macos**. Para aquellos que utilicen Linux, los ejemplos y herramientas se han probado en entornos basados en distribuciones Debian (como Ubuntu).
* **Visual Studio Code** como editor. Aunque puede utilizarse cualquier editor que se necesite, en este libro vamos a utilizar este editor como ejemplo. Ademas de instalarle herramientas personalizadas para desarrollo de homebrew.
* **Docker**: aunque esto es opcional, se puede utilizar un contenedor para poder desarrollar para Sega Mega Drive usando SGDK.
* **Emulador Mega Drive Blastem**. Aunque puede utilizarse cualquier otro como Gens (con la version modificada Kmod para Windows) o cualquier otro emulador.
* **Cartucho Flash para Mega Drive**: aunque no es obligatorio, si se dispone de una Mega Drive, se puede utilizar un cartucho flash para poder cargar nuestras roms y probarlas en un hardware real. Uno de los más conocidos es _Everdrive_.
