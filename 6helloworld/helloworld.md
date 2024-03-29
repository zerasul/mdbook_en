# 6. Hello World

We have already prepared our development environment and seen the different tools that we can use when developing our "home-made" game; now we can get down to business.

In this chapter, we will start talking about how to create a new project; focusing on its structure and how to use the project to create our game.

After commenting on how to create a project, we will start coding, and see the way that we will create our first game; showing on screen the famous hello world. showing the source code and we will explain it.

Finally, we will see how to build the rom itself and run it on an emulator, or on the contrary we can pass it to a FlashCart, and see it on a real console.

## Create a new Project

The first step to be able to begin to write our code, its to create a new project to use it with SGDK. To do that, we are going to create a project with the minimum code that will show us a "Hello Sega" on the screen.

To create a new project, we will use the _Genesis Code_ extension for Visual Studio code; although it can be created manually if required. To create a project with this extension, we will use the command palette using the keyboard shortcut <kbd>ctrl</kbd>+<kbd>⇧ shift</kbd>+<kbd>p</kbd>; and selecting the option _Genesis Code: Create Project_.

**NOTE**: Remember that you can still manually create the project without using Genesis Code.

When selecting this option, we will be asked where the project will be created. Once selected, the necessary files and folders will be generated and opened with Visual Studio Code. We can see the following files and folders:

* _.vscode_ (folder): This folder is specific to Visual Studio code and contains settings for the project. You should not modify this folder directly, unless necessary.
* _inc_ (folder): This folder will contain the C header files, i.e. the .h files.
* _res_ (folder): This folder will contain the game resources; either graphics (images), sound (wav), music (vgm) as well as the .res resource files together with the .h files that are generated by the _rescomp_ tool.
* _src_ (folder): This folder will contain the source code files .c. All the source code of our game will be stored here.
* _.gitignore_: This file is used by the Git repository that is generated when the project is created. It contains the files that will not be handled by the version control system.
* _README.md_: A small Markdown file with a project readme.

Although modifications of the project structure can be found for SGDK; this will depend on the Makefile used; in this case we focus on the default file used by SGDK.

## Hello World

Once the structure of the project is known, we can now focus on the source code itself; for this, when creating the project, we can observe in the _src_ folder a file called _main.c_; in this file is the source code of our game.

We remind you that you can find all the projects of this book in the following Github repository; in this case, you can find the code that we will describe in this chapter in the _ej1.helloworld_ folder. Below is the address of the repository:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

Let's see the hello world source code fragment:

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

This fragment of code written in C, we can see the hello world for Sega Mega Drive. In this case, we can see the simplest code to display on screen a message for Mega Drive. Let's see the most important functions.

First, we can see the header file _genesis.h_; this file provides access to all the functions and data provided by the LibMD library included in SGDK.

**NOTE**: Depending on the chosen configuration, you may need to include some paths in the Visual Studio Code C/C++ plugin [^41] configuration to have access to all functionalities.

[^41]: You can see the configuration of the include files for C/C++, in the VsCode configuration.

If we focus on the ```main``` function we see that a call is made to the function ```VDP_drawText(const char * text,u16 x, u16 y)```; this function calls the VDP graphics chip and will allow us to write a text on the screen, using a default font (or pre-loading a custom font). We can see that it has 3 parameters:

* _str_: character string with the information to be displayed.
* _x_: X position where the text will be displayed. The X coordinate indicates the column where the text will be displayed. It is expressed in Tiles.
* _y_: Y position where the text will be displayed. The Y coordinate indicates the row where the text will be displayed. It is expressed in Tiles.

Both X and Y positions are expressed in Tiles. A Tile is a square of 8x8 pixels that is painted on the screen; the VDP works in this unit and therefore we must take into account this dimension. In the example we see that we will draw in the position 10,13 that is to say, (80px,104px).

Once we have seen how to write text on the screen, we can observe that an infinite loop appears; this is important when designing videogames; because if this loop were not present, the execution would end, and it would not be possible to interact with the game.

Inside the loop, we see a call to the function ```SYS_doVBlankProcess```. This function performs a series of actions to manage the hardware, like waiting for the screen to finish painting; in such a way that the execution of the game stops until the painting is finished. This process is performed 50 times for PAL systems, or 60 times for NTSC systems; in this way, the refresh rate is achieved, and we can draw our game.

**NOTE**: For versions prior to SGDK 1.60, use the function ```VDP_waitVSync```.

## Compile and Run the Project

After finishing writing our code, we can take the next step; generate the ROM [^42], and run it in an emulator.

In this step, all the necessary files will be generated, and at the end we will have a file called _rom.bin_ with our ROM ready to be executed in an emulator, or in a real hardware.

To compile our game, it is necessary to have correctly configured SGDK; either using the environment variables, or with the configuration of _Genesis Code_. In addition to having correctly configured the path where our emulator is located.

The command _Genesis Code: compile & Run Project_, will be used to generate the ROM and then run an emulator with the generated ROM. There are other commands to Compile (_Genesis Code: Compile Project_) or compile for debugging (_Genesis Code: Compile For Debugging_). In this example, we will use the _Compile & Run Project_ option.

### Manual Compiling

If by any chance you need to compile manually, you can do it using the commands to call SGDK. We leave here the different calls to generate the Rom using SGDK, Gendev or Docker.

#### SGDK (Windows)

```bash
%GDK%/bin/make -f %GDK%/makefile.gen
```

#### Gendev (linux)

```bash
make -f $GENDEV/sgdk/mkfiles/makefile.gen
```

#### Docker

```bash
docker run --rm -v $PWD:/src sgdk
```

If everything has gone correctly, we can see how the ROM will be generated in the _out_ folder with the name _rom.bin_ and later, our emulator opens showing it.

**NOTE**: For those using Windows, you may get an error if you are using an integrated console by default to _PowerShell_ (in Visual Studio Code); this can be fixed by setting the default vscode terminal to use _cmd_. To do this we will use the command palette and select the _View: Toggle Integrated Terminal_ option; subsequently selecting it to use cmd.

![Hello](6helloworld/img/hello.png "Hello")
_Hello World on Sega Mega Drive_

[^42]: ROM (Read Only Memory): is a read-only memory that is usually located inside the cartridge in an EPROM (or Flash in the most modern versions).

## ROM Header

When the ROM of our game is generated, a series of data about the game must be added in the ROM Header. Some of them are generated automatically and others can be customized. SGDK, generates this header but we can add data about the game; as for example the title of the game, version or even with which devices it is compatible.

We see that it is interesting to talk about this section and see the different options that we can find when generating the ROM header as it is necessary especially to be able to test it properly on real hardware, once we have our ROM finished.

As we have already mentioned, SGDK generates the minimum content for the ROM header. This content can be found inside the _src/boot_ folder of our project. In this folder, we can find a file called _"rom_head.c"_, with the definition of a C struct. with the definition of a C struct and its initialization.

Let's see the definition of the header struct:

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

We can see that there are different sections for different uses; let's show some of them:

**Console**

A 16-byte character string; where the System type of the ROM is indicated; for Mega Drive it can have the value ```SEGA MEGA DRIVE``` or ```SEGA GENESIS```.

**Copyright**

Indicates the Copyright showing who publishes the ROM and in which year. For example ```(C)SGDK 2019```.

**Title_local**

Show game title.

**Title_int**

Show international Game Title; can be the same as the previous value.

**Serial**

Show the game serial number; can be useful for identifying ROM or compilation Version.

It usually has the format  ```XX YYYYYYYY-ZZ``` where ```XX``` defines ROM Type (GM for game), ```YYYYYYYY``` indicates the Serial Number and ```ZZ``` for the revision number.

**Checksum**

The _checksum_ is a 16-bit sum of the ROM contents; this sum can indicate whether the ROM has been modified or not; so some games check it as a way to find out that it is an original ROM; some emulators also check it. This checksum is generated by SGDK.

**IOSupport**

This is one of the most important aspects; in this section, you define which input or output devices it is compatible with; whether it is a 3 or 6 button gamepad, mouse, CD-ROM, Activator, etc....

It is important to define it in order to have better compatibility with all available hardware. Let's see a table with the available options:

| Key   | Description               |
|-------|---------------------------|
| J     | 3 Buttons Gamepad         |
| 6     | 6 Buttons Gamepad         |
| 0     | Master System Gamepad     |
| A     | Analog Joystick           |
| 4     | Multitap                  |
| G     | Lightgun                  |
| L     | Activator                 |
| M     | Mouse                     |
| B     | Trackball                 |
| T     | Tablet                    |
| V     | Paddle                    |
| K     | keyboard                  |
| R     | RS-232                    |
| P     | Printer                   |
| C     | CD-ROM (Sega CD)          |
| F     | Floppy drive              |
| D     | Download?                 |
_Table 1: Compatible devices values._

Different options can be used at the same time, i.e. if we define the value ```J6M```, it means that the ROM is compatible with 3 and 6 button controllers, and with the mouse.

**Rom_start y Rom_end**

Indicates where the ROM begins and ends; these values are calculated by SGDK when the ROM is generated.

**Sram_start y Sram_end**

If our ROM uses SRAM to store data, the start and end addresses must be defined. ```sram_type``` must also be defined to indicate the type of SRAM to be used.

**Modem_support**

Check if this ROM has Modem support and what services are available.

**Region**

Indicates the regions in which the ROM is supported (Japan, Europe or America); with the following values [^43] :

| Key   | Description   |
|-------|---------------|
| "J"   | Japan         |
| "U"   | America       |
| "E"   | Europe        |
_Table 2: ROM Region Values_

It may be compatible in various regions; therefore it may have the value ``JUE`` indicating that it is compatible with Japan, Europe and America.

[^43]: These values correspond to the traditional form; there is a later form that was adopted by SEGA; for more information, check the references in this chapter.

**NOTE**: Always keep in mind that even if the ROM is compatible with other regions, the PAL or NTSC color system must also be defined.

More information about the ROM header can be found in the references.

## References

* Ohsat Games: [https://www.ohsat.com/](https://www.ohsat.com/)
* SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK)
* Docker: [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)
* Danibus (Aventuras en mega Drive)(spanish): [https://danibus.wordpress.com/](https://danibus.wordpress.com/)
* Plutiedev (Rom Header Info): [https://plutiedev.com/rom-header#devices](https://plutiedev.com/rom-header#devices)
