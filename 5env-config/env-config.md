# 5. Environment Configuration

We have already seen the libraries and tools that we are going to use to develop our video games for Sega Mega Drive. However, in order to work more efficiently, we will need to install and configure a series of additional tools that will help us to speed up the process of creating our game.

In this chapter, we are going to see the tools that can be used when we create not only the code for our game, as well as all the necessary resources for it; such as images, sounds, etc.

The tools that we discuss in this chapter are optional as each developer will have his own tools, but we recommend some of them when creating our home-made game.

We will start talking about the development environment configuration, and then we will focus on other tools such as emulators, or even tools that can be used to handle graphics.

The objective of this chapter is to configure a development environment in a simple way, so we will not focus in detail on how to use each tool, but we will provide links to manuals and resources for each of the tools used, at the end of this chapter.

## Text Editor

When working with source code, we will need to have a text editor that helps us to work with many source files; that can help us to speed up the time it takes to code our game as much as possible.

Although every developer will use different tools, in this book we are going to recommend the text editor _Visual Studio Code_; which we will use in the examples and screenshots that you will see in this book.

### Visual Studio Code

Visual Studio Code[^37] (not to be confused with Visual Studio), is a rich text editor that will allow us to develop our game in a simple way.

This editor has several features such as:

* Syntax highlighting.
* Intelligent auto-completion (using intellisense[^38]).
* Integrated debugging (requires advanced configuration see chapter 16).
* Integration with version control systems (GIT).
* Expandable and modular thanks to the various extensions which can be installed.

Visual Studio Code, has parts of the source code with Mit license; and others have a proprietary license from Microsoft. You can see part of the Visual Studio Code source code in its repository:

[https://github.com/Microsoft/vscode](https://github.com/Microsoft/vscode)

![Visual Studio Code](5env-config/img/vscode.png "Visual Studio Code")
_Visual Studio Code_

For those who are not familiar with this text editor, here is a link to the VsCode manual:

[https://code.visualstudio.com/docs](https://code.visualstudio.com/docs)

With Visual Studio code, you can easily develop and extend its functionalities in a very simple way, thanks to the included extensions repository (or even installing them manually).

[^37]: Visual Studio Code is a registered trademark of Microsoft Corporation Ltd.
[^38]: intellisense is a registered trademark of Microsoft Corporation ltd.

In this book, we are going to recommend some of them; although it is only a recommendation; since the ones that the reader likes the most can be used.

* _Official C/C++ extension_: It will allow us to program and activate intellisense for C/C++ programming languages.
* _Amiga Assembly_: Although this book does not focus on the use of assembler, it can be interesting to see the assembler code that you have written with highlighted syntax. In this case, it is about being able to see with the syntax already colored, the assembler for Motorola 68000.
* _Genesis Code_: This book focuses on the use of SGDK; and although we can use SGDK directly through tasks and/or a terminal in the editor itself, it is often quite complicated to configure the environment. Therefore, Genesis Code simplifies the use of SGDK through this editor. In this section, we will focus on this extension.

#### Genesis Code

Genesis Code is an extension for Visual Studio Code, which will allow us to use SGDK and its tools, in a simple way. Genesis Code is open source and has a MIT license. You can find its source code at the following link:

[https://github.com/zerasul/genesis-code](https://github.com/zerasul/genesis-code)

Genesis Code, allows, through a series of commands, to perform different tasks with SGDK; these commands are:

* Compile Our Game and Build the ROM.
* Clean the construction files.
* Run our game in an emulator.
* Compile and run our game in an emulator.
* Create a new Project.
* Compile with Debug Options
* Import a file in TMX or Json format to generate a C header file. This command uses the _TILED_ tool format to import maps.

Also, Genesis Code includes other features such as syntax highlighting for SGDK _.res_ resource files, auto-completion for resources or custom image viewer. In addition, you should know that the author of this extension is the same as this book.

If you need more information about Genesis Code, you can consult the Genesis Code documentation:

[https://zerasul.github.io/genesis-code-docs](https://zerasul.github.io/genesis-code-docs)

**Installation**

To install Genesis Code in Visual Studio Code, you can install it through the extensions repository. To do this, click on the 5th icon on the left and search for the extension.

![Genesis Code](5env-config/img/genscode.png "Genesis Code")
_Genesis Code Extension_

Once located, click the _install_ button, and the extension will be installed.

It can also be installed manually by downloading the latest version from the project repository:

[https://github.com/zerasul/genesis-code/releases](https://github.com/zerasul/genesis-code/releases)

Once the file with extension _.vsix_ is downloaded, open the Visual Studio Code command console <kbd>ctrl</kbd>+<kbd>Shift</kbd>+<kbd>p</kbd> and look for the option _Extension: Install from vsix..._; select the vsix file and wait for the installation to finish.

**Configuration**

Genesis Code supports the following ways of using SGDK:

* SGDK.
* GENDEV.
* MARSDEV.
* Docker.

Depending on the SGDK installation, we have to configure Genesis Code in one way or another.

To access the Genesis Code configuration, we will access using Visual Studio Code options (File->preferences->settings menu or <kbd>ctrl</kbd>+<kbd>,</kbd>), and look for the Genesis Code options; a screenshot of the options is shown below.

![Genesis Code Configuration](5env-config/img/settings.png "Genesis Code Configuration")
_Genesis Code Configuration_

The options available are:

* custom-makefile: Allows to use a custom Makefile to generate the rom. If not specified, it will use the one from the SGDK itself.
* Docker Tag: Specifies the name of the Docker image using SGDK. If not specified, the name _sgdk_ will be used.
* Doragasu Image: Checks that the Docker image used is based on those created by _Doragasu_.
* GDK: Overwrites the _GDK_ environment variable targeting the SGDK installation (Windows only).
* GENDEV: Overwrites the GENDEV environment variable targeting the Gendev installation (Linux only).
* Gens path:Specifies the path to the executable where the emulator to be used is located.
* MARSDEV: Overwrites the MARSDEV environment variable targeting the MarsDev installation.
* Toolchain Type: Indicates the specific toolchain you will use for SGDK; it can have the following values:
    * sgdk/gendev: Use SGDK or Gendev (windows or Linux).
    * marsdev: Use MARSDEV as the environment to call SGDK.
    * Docker: Use a Docker container to create the ROM.

## Emulator

When developing our game, it is important to be able to test its progress and although we can use a real hardware using a FlashCart cartridge like _Everdrive_[^39], it is not practical to transfer the ROM every time to the SD card. Therefore, emulators can be used to be able to run the generated rom and see the results.

Also, some of these emulators have tools that can help us to debug our games; such as debugging both 68K and z80, VDP graphics viewer, Sprite viewer, etc.

We are going to see a pair of emulators; it is important to know that the reader can use the one that best fits his needs when working on his homebrew project.

Also you need to know that even if we use an emulator, we can never emulate the 100% accuracy of the real hardware; so even if we can emulate the game, it is interesting to be able to test it on hardware; moreover, if possible on different Mega Drive models.

[^39]: Everdrive: is a FlashCart cartridge with the ability to load roms using an SD or MicroSD card.

### Gens KMod

Gens, is a free and open source emulator with GPL-2.0 license, that allows you to emulate Sega Mega drive, Mega CD, 32X and even Master System. This emulator has many versions starting with the version for Windows operating system, but many ports have been made for different other Operating Systems.

It has different features such as status saving, support for internet connection, audio enhancement, etc. There are different versions such as the so-called _gens Plus_ that adds more improvements such as different effects or Shaders.

For Microsoft Windows, there is a modified version, called _Gens KMod_, which adds different tools for development; such as:

* Motorola 68000 and Z8 Debuggers.
* Memory Debug.
* Plane Explorer.
* Sprite Explorer.
* Tiles and Palettes Explorer (VDP).
* Sound Explorer for YM2612 y PSG.

![Gens Kmod](5env-config/img/gens.png "Gens KMod")
_Gens Kmod_

It can be downloaded from the following address:

[https://segaretro.org/Gens_KMod](https://segaretro.org/Gens_KMod)

In order to use it for our development, if you have the Genesis Code extension, you can configure it to use for developing; to do so, you can do it in two ways:

The first is to use the _Genesis Code: set Gens Emulator Command Path_ command that provides the extension and add the path to the _gens.exe_ file in order to execute the command.

The other way is from the Genesis Code configuration we can add the path where the emulator executable is located.

### Blastem

Another well-known emulator, is _Blastem_; this emulator, allows to emulate with enough precision, the hardware of the Mega Drive; besides having a series of tools like the viewer of the palettes and colors of the VDP. Blastem is free software under the GNU GPL v3 license.

This emulator has the following features:

* Saving and Loading of states.
* Integrated Debugger and can be used with remote debugging (GDB).
* Gamepad Support (Joystick).
* Mega/Sega Mouse emulation.
* Saturn Keyboard Support.
* Sonic & Knuckles Lock-on Support and some mappers like Sega Standard Mapper.
* Homebrew Custom Mappers Support.
* SRAM and EEPROM Support.
* Filters and Shaders Support..

![Blastem](5env-config/img/blastem.png "Blastem")
_Blastem_

Blastem also includes some tools for development. Such as the VDP palette viewer or a debugger included in the emulator itself; both internal, as well as being able to connect to an external debugger.

Blastem can be downloaded for the most used operating systems (Windows, MacOs, Linux...); using the following address, or in the package repositories of some Linux distributions.

[https://www.retrodev.com/blastem/](https://www.retrodev.com/blastem/)

As with Gens, Blastem can be used with the _Genesis Code_ extension, so the same steps described above can be followed to set it up.

## Graphic Manipulation Software

When working on a video game, it is important to work on the source code of the game, as well as the resources to be used (graphics, sound, maps, etc.); therefore, we are going to review some tools that we can use to create all these resources.

### GIMP

GIMP (Gnu Image Manipulation Program), is a bitmap image editing program; this program is open source and has a GPLv3 license.

The first version of this program was released in 1995 at the Berkley's University; and since then it has become part of the GNU project [^40]. GIMP is going to help us to modify the images to be able to use them in our projects.

[^40]: GNU Project: [https://www.gnu.org/home.es.html](https://www.gnu.org/home.es.html)

It allows you to modify digitized images through its many built-in tools such as cropping, scaling, modifying image properties (reordering the palette). GIMP, is compatible with many image formats (BMP, PNG, JPG, TIFF, PSD); so it can be a good tool to convert into the formats we need.

In addition to the built-in tools, more tools can be added thanks to the extensions or plugins of this program.

![GIMP](5env-config/img/GIMP2.png "GIMP")
_GIMP_

You can download GIMP from its official website:

[https://www.gimp.org/](https://www.gimp.org/)

### Aseprite

At the time of creating our graphics, with programs like GIMP, they are not very usable; for that reason other programs are used to be able to create the Sprites or the necessary patterns for our game.

To do this, we use programs like Aseprite which is a program that will allow us to create, in a simple way, our sprites and their animations.

Also, it will also allow us to manage the color palette for our graphics. So we will be able to see every moment, the colors that we are using to create our graphics.

Aseprite allows us to export our animations easily in different formats, or to create a pattern that we can use later in our game.

Aseprite is not open source, and costs $19.99, which can be purchased from their website.

[https://www.aseprite.org/](https://www.aseprite.org/)

We can see some of his features:

* Animation previewer.
* Palette management.
* Pattern Creation.
* SpriteSheet Creation.
* Custom Brushes Creation.
* Line Smoothing when drawing.

![Aseprite](5env-config/img/asersprite.png "Aseprite")
_Aseprite_

### TILED

Finally, when creating our games, we will often need tools to create our levels from libraries of graphic elements (also called TileSets); therefore, we can recommend the use of the Tiled tool.

This open source tool will allow us to create our own maps, from different graphic elements and later, we can export them to our games.

TILED has a GPL license, however, it uses different components that have different licenses; for more information, consult the license in the TILED repository.

[https://github.com/mapeditor/tiled/blob/master/COPYING](https://github.com/mapeditor/tiled/blob/master/COPYING)

TILED, allows us to generate multilayer maps, to be able to draw our levels independently each layer; in this way, we can add many more elements in a more comfortable way.

In addition, TILED allows to add objects to add information to each level and manage it within our source code.

![TILED](5env-config/img/TILED.png "TILED")
_TILED_

If you use the _Genesis Code_ extension, you can export the data for each map to an .h file for use in our games. We will see more about the use of TileSets in chapter 12.

TILED can be downloaded from its official website:

[https://www.mapeditor.org/](https://www.mapeditor.org/)

## References

* Visual Studio Code: [https://code.visualstudio.com/](https://code.visualstudio.com/)
* Genesis Code Extension: [https://marketplace.visualstudio.com/items?itemName=zerasul.genesis-code](https://marketplace.visualstudio.com/items?itemName=zerasul.genesis-code)
* Genesis Code Documentation: [https://zerasul.github.io/genesis-code-docs](https://zerasul.github.io/genesis-code-docs)
* Gens Emulator: [http://www.gens.me/](http://www.gens.me/)
* Gens KMod: [https://segaretro.org/Gens_KMod](https://segaretro.org/Gens_KMod)
* Blastem: [https://www.retrodev.com/blastem/](https://www.retrodev.com/blastem/)
* Gimp: [https://www.gimp.org/](https://www.gimp.org/)
* Aseprite: [https://www.aseprite.org/](https://www.aseprite.org/)
* Article about Aseprite (Spanish): [https://elmundodeubuntu.blogspot.com/2015/11/aseprite-editor-de-sprites.html](https://elmundodeubuntu.blogspot.com/2015/11/aseprite-editor-de-sprites.html)
* Tiled: [https://www.mapeditor.org/](https://www.mapeditor.org/)
