# 4.Sega genesis Development Kit

We have seen so far what the Mega Drive is and its architecture, knowing each part and the functions it performs.

However, this book is about homebrew software development for Sega Mega Drive; so we are going to study the tools we will need for it.

To develop software for the Mega Drive, we must know how the Motorola 68000 processor works; as well as the memory addresses to access peripherals, video, etc...

This was important in the 90's when it was developed directly in assembler, since there were no tools such as very advanced compilers that could compile to assembler for this architecture efficiently. Therefore, the assembler was used directly.

Let's see an example of Motorola 68k assembler:

```asm
    ORG    $0400
START:                  ;START

* Put program code here

        movea.w #$600,a0    ;MOVE A
        move.b #$aa,d0      ;MOVE B
bucle   move.b d0,(a0)+     ;MOVE B to D0
        cmpa.w #$700,a0     ;COMPARE 
        bne.s bucle         ;Loop
                         

    SIMHALT             ; HALT

* Put variables and constants here

    END    START        ; END
```

The above fragment corresponds to a program that simply implements a loop and compares a series of data, using processor registers and memory addresses.

However, this is very tedious even though it can be very optimal to use assembler. Remember that the aim of this book is to use more modern tools. Therefore, we will use the C programming language.

Also, there is a set of tools to be able to use this C language for Sega Mega Drive. This set of tools is called Sega Genesis Development Kit or SGDK.

Sega Genesis Development Kit, is a set of tools such as a compiler, a library, resource management tools, etc.. That will allow us to create software (video games) for Sega Mega Drive. SGDK, is free and its open source; it is released under the MIT license; except the GCC [^26] compiler that has a GPL3 license.

[^26]: GCC (Gnu Compiler Collection) is a set of open source compilers that is incorporated in many GNU/Linux distributions.

This chapter will show both the history, the components that are composed and also see some games made with SGDK and of course, we will get into the subject, installing the SGDK itself in the most popular Operating Systems.

## SGDK History

SGDK, started around 2005; and is created by its main author _Stephane Dallongeville_;  although being free software, it has other authors that can be consulted in its Github repository (although it started in Google Code).

SGDK Repository: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK)

During all these years, it has had a great acceptance by the community because it makes homebrew development much easier for 16-bit enthusiasts. In addition, thanks to this kit, new titles are still being developed for this console.

The library provided by SGDK is written in C although it has other tools that are written in other languages such as Java.

Currently (2024), version 2.00 has been released which includes the new sound driver XGM2; also has some improvements at the initialization of floating point types, and some improvements on the Sprite Engine.

[^27]: Mega Wifi, is a special cartridge that allows you to connect to the Internet via Wifi; in addition to bringing a series of libraries to manage connectivity with the network.

If you want to learn more about the project, you can check out its Github repository or even see Stephane Dallongeville's Patreon in order to contribute to the project.

[https://www.patreon.com/SGDK](https://www.patreon.com/SGDK).

Once we have known the history of SGDK and what it is about, let's show the components of this development kit.

## SGDK Components

SGDK, is composed of a series of tools that will help us to create our games for Sega Mega Drive. In this case, both for the compilation and creation of the ROM, as well as the management of the game resources.

The Components are:

* A GCC compiler that will allow us to compile our code to instructions for the 68K processor. The current version of GCC that includes SGDK is 6.30 (It can be configured to use a more recent compiler). In addition, it includes a debugger _GDB_ that will allow us to debug our games (we will see it later in the debugging chapter). We remember that the compiler has a GPL3 license.
* A library called _libmd_ with all the functions and tools that allow us to develop with the C language for Sega Mega Drive.
* Library documentation: You can find in the _doc_ folder, all the information about the library functions.
* A resource manager _rescomp_; that will allow us to import the resources of our game (graphics, sounds, sprite, etc.).

Let's see each component:

### GCC

This set of compilers is one of the most widely used when using programming languages such as C or C++. It allows both compiling and later linking and assembling the source code and generating a binary.

GCC is included with version 6.3.0 inside SGDK, and using tools like make [^28], we can generate the corresponding rom.

[^28]: make is a tool for dependency management and software construction.

### LibMd

LibMd, is a library that incorporates SGDK, with a series of functions and data that will allow us to create video games for Sega Mega Drive; it incorporates everything necessary to handle the hardware either to manage the controls, video, sound, etc..

Is written in C and assembler and you can check the documentation inside the SGDK itself, in the _doc_ folder.

### Rescomp

Rescomp, is a tool that will allow us to import all the resources of our game, graphics, sprites, sound, etc.

This tool is written in Java, however, it uses other tools already written in other languages such as C.

Rescomp, is based on reading a series of files with extension .res, that have defined a series of parameters of the different data necessary for each resource; rescomp, when it reads this file, will generate a file .h, and will import the resources for our game.

Here is an example of a resource used by rescomp:

```res
SPRITE tiovara_sprite "sprt/tiovara.bmp" 4 4 NONE 5 BOX
```

In the previous example, it is shown how to import a sprite sheet that we will see later in more detail.

## Games made with SGDK

An important part of SGDK is that it is used for commercial games that you can find in some crowdfunding. In this section, we are going to comment some of the most known ones, and we will leave some addresses so you can learn more about them:

### Xeno crisis

Xeno Crisis [^29], is an isometric perspective game, which allows us to fight against hordes and hordes of Aliens while surviving in different rooms and areas.

It allows 2 players to play on the Sega Mega Drive; although there are already versions for Steam (PC), Switch and even versions for Xbox, Playstation, Neo-geo and DreamCast. A SNES version is also in progress.

You can check the versions of this game in the Kickstarter of this game:
[https://www.kickstarter.com/projects/1676714319/xeno-crisis-a-new-game-for-the-sega-genesis-mega-d/](https://www.kickstarter.com/projects/1676714319/xeno-crisis-a-new-game-for-the-sega-genesis-mega-d/)

[^29]: Xeno Crisis is published and developed by Bitmap Bureau studio. All rights reserved.

### Demons of Asteborg

Demons of Asteborg [^30] is a game for Sega Mega Drive, which has a side-scrolling platformer aesthetic, with RPG touches. This game is published by Neofid-studios.

In this case, only 1 player is allowed and can be found both in the Mega Drive version, on Steam and Nintendo Switch.

In addition, they have released a new title called _Astrebros_, which is now available for purchase, and are working to port a new game called _Daemon Clawn_.

More details can be found on their web site:

[https://neofid-studios.com/](https://neofid-studios.com/)

[^30]: Demons of Asteborg is a game published and developed by neofid-studios. All rights reserved.

### Metal Dragon

Metal Dragon [^31] is a game for Sega Mega Drive that has an 80s/90s action movie aesthetic; in this game you have to rescue the president's daughter and face endless enemies.

This game is a 1 player game and there is a version for Sega Mega Drive, as well as for MSX. In addition, a Spanish studio _Kai Magazine Software_ is who has developed this game and recently is publishing his game in the magazine _beep_ for Japan. Besides publishing other games like _Life On mars_ or _Life on Earth_. Now it's working on a new Title called _The secret of the 4 Winds_.

[^31]: Metal Dragon has been developed by the Spanish studio Kai Magazine Software. All rights reserved.

### 1985 World Cup

1985 World cup [^32] is a game for Sega Mega Drive that allows us to relive the great soccer titles like the _World Cup Italia 90_. Where players from all over the world will face each other.

This game allows you to play up to 2 players on the same machine, and also has a unique feature; it has integrated the Mega Wi-fi; it allows you to connect to the internet via Wi-fi; and to play online; without the need of a modem; only the cartridge itself.

The same studio is currently working on a port of _Coloco_ for Sega Mega Drive.

[^32]: 1985 World cup was published by Nape Games. All rights reserved.

## SGDK Installation

Once we know the history of SGDK, its components and we have seen some games made with them, we are going to take our first steps.

We will see how to install it on the most popular Operating Systems. It is important to note that these instructions may change over time since this book was written, so it is always important to read the instructions in the repository itself.

### Windows

The first Operating System that we are going to see to install SGDK, is Microsoft Windows [^33]; in this case, we will see the different instructions necessary to install SGDK.

First of all, we will need to download a number of dependencies that are required to use SGDK such as the Java Runtime Environment (JRE [^34]) that will allow us to use tools like _rescomp_. You can install either the Oracle version or the _openjdk_ version [^35]. We leave the URL to download the appropriate Java version:

[https://www.java.com/es/download/](https://www.java.com/es/download/)

Once the dependencies are downloaded and installed, we will need to download the SGDK itself; which you can do in the Releases section of the SGDK Repository:

[https://github.com/Stephane-D/SGDK/releases](https://github.com/Stephane-D/SGDK/releases)

Once SGDK is downloaded and unzipped, we can create the following environment variable (This step is optional):

```cmd
GDK = <SGDK Folder>
```

**NOTE:** When downloading SGDK, a compiled version of _libmd_ is already included; however, if you need to compile the library with the downloaded source code, you can do it with the following instruction:

```cmd
%GDK%\bin\make -f %GDK%\makelib.gen
```

Remember that the ```GDK``` variable is optional and can be replaced by the path where the SGDK is installed.

Later, we will see how to use the SGDK in different ways.

[^33]: Microsoft Windows is a registered trademark of Microsoft Corporation.

[^34]: JRE (Java Runtime Environment); execution environment for running applications developed for the Java Virtual Machine (JVM).
[^35]: OpenJdk is an open source implementation for the Java ecosystem.

### Linux

SGDK, by default, is not compiled for use with Linux; however, there are projects such as GENDEV that allow us to use SGDK from that toolkit.

You can find this project in its Github repository:

[https://github.com/kubilus1/gendev](https://github.com/kubilus1/gendev)

To use this project, we will need to install a series of dependencies; which we can be installed using the package manager of your distribution; for this case, we will use a distribution based on Debian [^36] (Ubuntu).

You will need to install the following dependencies:

* tex-info
* java

First we update the dependency tree:

```bash
sudo apt update
```

In the case of java, we will use _openjdk_:

```bash
sudo apt install texinfo default-jre
```

[^36]: Debian and Ubuntu are open source Linux distributions. Ubuntu is maintained by Canonical Ltd.

Once the dependencies are installed, we will download the _.deb_ (or tar) package from the GENDEV repository. In the case of installing using the .deb package, we will install it with the following instruction:

```bash
sudo dpkg -i <file.deb>
```

If all is OK, we can see that in the address ```/opt/gendev``` all the files will be in the address ```/opt/gendev```.

Finally, we will need to create the ```GENDEV``` environment variable:

```bash
export GENDEV=/opt/gendev/
```

**NOTE:** Remember that if you want to compile the _libmd_ library you can do it with the following instruction:

```bash
make -f $GENDEV/Makefile
```

Later, we will see in detail how to use SGDK, using GENDEV.

**NOTE:** GENDEV doesn't use the last version of SGDK; we recommend using Docker.

### MarsDev

We have been using all the tools that SGDK or GENDEV has; however, sometimes it is very complicated to maintain all the tools in different environments that are very heterogeneous.

Therefore, the MARSDEV project allows a homogeneous way of using SGDK or the different tools available.

You can download MarsDev from its repository:

[https://github.com/andwn/marsdev](https://github.com/andwn/marsdev)

Once downloaded, an environment variable named ```$MARSDEV``` can be used that points to the directory where Marsdev was downloaded.

If you need more information about how to install MarsDev or how to use it we leave a link to its installation page:

[https://github.com/andwn/marsdev/tree/master/doc](https://github.com/andwn/marsdev/tree/master/doc)

### Docker

The use of containers (using Docker or another implementation), is becoming more extended every day; since it allows us to configure a container in such a way that it abstracts us from the host software and the configuration is much simpler.

The use of Docker is valid on the three most popular operating systems (in the case of macOS; although there are other ways to use SGDK, many of them are deprecated).

In order to use SGDK with docker, we will first need to generate an image with SGDK; for this we will use a ```Dockerfile``` which will give us the necessary instructions to generate the container image.

To generate the image, we will download the latest version of SGDK from the SGDK repository (the same step as for Windows). Once this is done, we will execute the next instruction in the folder where SGDK is located:

```bash
docker build -t sgdk .
```

This instruction will generate the SGDK docker image with everything needed to create our Mega Drive ROMs.

Once the image is built, if we need to create a rom, we can do it with the following instruction:

```bash
docker run --rm -v $PWD:/src/sgdk 
```

**NOTE**: For windows systems change $PWD to %CD%.

With the above instruction, the Mega Drive ROM will be compiled and generated.

Also, you can find prebuilt images thanks to _Doragasu_ that includes a SGDK Docker image in his Gitlab Repository; you can find the repository address at References.

## References

* SGKD: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* SpritesMind forum: [http://gendev.spritesmind.net/forum/](http://gendev.spritesmind.net/forum/)
* GCC: [https://gcc.gnu.org/](https://gcc.gnu.org/).
* Make: [https://www.gnu.org/software/make/](https://www.gnu.org/software/make/).
* Bitmap Bureau: [https://bitmapbureau.com/](https://bitmapbureau.com/).
* Neofid-Studios: [https://neofid-studios.com/](https://neofid-studios.com/).
* Kai Magazine Software: [https://kai-magazine-software.fwscart.com/](https://kai-magazine-software.fwscart.com/)
* Nape Games: [https://www.napegames.com/](https://www.napegames.com/)
* Open JDK: [https://openjdk.java.net/](https://openjdk.java.net/).
* MarsDev: [https://github.com/andwn/marsdev](https://github.com/andwn/marsdev).
* Docker: [https://www.docker.com/](https://www.docker.com/).
* Doragasu SGDK Docker Images: [https://gitlab.com/doragasu/docker-sgdk](https://gitlab.com/doragasu/docker-sgdk)
