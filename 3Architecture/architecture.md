# 3. Architecture

To be able to develop for Mega Drive, we need to know its architecture in order to avoid problems when creating our games; if we know how it works, we can avoid memory problems, bottlenecks...

When working with these systems with few resources, its important to know the architecture, and we can optimize our code and our game will be lighter. Not only do we need to know the architecture of the processor itself, but it is also good to know the different elements that can be found in a Mega Drive.

In this chapter, we are going to study each of the elements that make up the Mega Drive and the architecture of how each of them are connected, as well as their functions and characteristics.

In addition to each component will be discussed its capabilities and functions both in Mega Drive Mode and in backward compatibility when running Sega Master System games.

To better understand its architecture, we will first show a diagram with each of the components and how they are connected.

![Mega Drive Architecture](3Architecture/img/arqmegadrive.png "Mega Drive Architecture")
_Mega Drive Architecture_

As we can see in the previous image, the Mega Drive is composed of a series of elements connected by different Buses; one of 16 bits and another one of 8 bits. Let's see the elements that are composed:

* CPU Motorola 68000: Mega Drive Main CPU.
* RAM 64kb: Main Program RAM.
* ROM: External ROM Memory (cartridge); it uses slot at the top to communicate.
* Accessory Port: Bottom Auxiliary Port (Mega CD).
* VDP: Mega Drive graphics chip, consisting of several elements:
    * VDP: Chip with everything needed for the graphics and elements to be displayed.
    * PSG: 8 Bits Auxiliar sound Chip.
* VRAM 64Kb: RAM dedicated to the VDP for storing graphic elements.
* CPU Z80: Zilog z80 Co-Processor. In charge of running Sega Master System games and orchestrating the sound.
* Sound RAM 8Kb: RAM dedicated to sound used by the Z80 processor and sound chips.
* YM2612: FM sound chip, dedicated to give sound to the Mega Drive.
* I/O Controller: Controller of controllers and various external devices.
* Bus Arbiter: Controller of the different Buses.

## Motorola 68000

The main processor of the Mega drive, the Motorola 68000 (MC68000) is a 16/32-bit processor of the CISC family; it is the first processor model of the m68k family capable of addressing 32-bit instructions. It gets its name from the number of transistors it contains. The Mega Drive processor has a frequency of 7.61Mhz (PAL) or 7.67Mhz (NTSC).

This processor has an architecture based on 2 banks (one for data and one for pointers) of 8 32-bit registers; it also has a 32-bit program counter and a 16-bit status register. It also has a 24-bit external bus capable of addressing up to 16MB of memory.

The Motorola 68K has separate registers for working with both data and pointers. Being the latter type where the stack pointer is stored in duplicate. One in user mode, and another in supervisor mode.

In addition to having two ALUs (without floating point support), in order to be able to work with data and pointers at the same time.

Another important aspect is that this processor has different working modes (normal, stop and exception); being the last mode important because it allows to handle internal and external signals (interrupts); so it will help us to work with the different signals that we can send to it.

Este procesador fue utilizado por distintas marcas:

* Apple (Firsts Macintosh [^12]).
* Atari (Atari ST [^13], used this processor).
* Commodore (Amiga [^14] 1000 computers used this processor.).
* SNK (used by the Neo Geo console [^15]).

[^12]: Macintosh is a registered trademark of Apple Inc.
[^13]: Atari ST is a registered trademark of Atari Interactive.
[^14]: Amiga and Commodore are registered trademarks of Commodore International.
[^15]: Neo Geo is a registered trademark of SNK Corporation.

## Main Memory (RAM)

The Mega Drive's main memory, or program RAM, has a capacity of 64 Kb (8KB); it stores the program information and is also used to send the ROM information to the VRAM (through the DMA).

The memory has a 16-bit word capacity (2x8bits) of PSRAM type [^16], which has a latency of 190ns (5.263157 MHz frequency) with an access latency by the CPU of 200-263 ns. The main memory bandwidth for 16 bit is 10.526314 MB/s.

[^16]: PSRAM (Pseudostatic RAM) is a type of RAM memory that allows to have included in its circuitry everything necessary to refresh the memory and address it.

## ROM (Cartridge)

The ROM memory, or properly speaking the "cartridge", is where the game information is stored. Normally, it is a chip of EPROM or EEPROM type (although the current cartridges can be Flash), where the game is stored both the code itself, as well as all the graphics and resources of the game.

The reading of this cartridge is done through the slot on the top of the Mega Drive; just insert the contacts through the slot that we can see at the top. Normally, a standard cartridge, had a bandwidth of 10MB/s (although there were some of 15.20-15.34 MB/s); in addition to take into account that the access of the 68k to the rom normally had a speed of 5MB/s.

The basic cartridge that we are used to seeing in Mega Drive, has a capacity of 32Mb (4MB), and can also have a small RAM (SRAM) through a CR2302 button battery. There are cartridges with more functionalities, like the well-known _Sonic & Knuckles_ which had the top Lock On slot. Besides other cartridges with some extended functionalities like the _Virtua Racing [^17]_; that extended the capacity of the Mega Drive, thanks to a chip with a customized DSP [^18].

As we have said, by default a Mega Drive cartridge has a maximum size of 32Mb, however, this was expandable by adding extra functionality to the cartridge, as is the case of _Street Fighter_ which expanded the cartridge by adding different chips and using a mapper, could change the ROM memory bank. This "Mapper" known as _Sega Standard Mapper_, has been reused in some current homebrew games and allow to expand the available size.

![PCB ROM Mega Drive](3Architecture/img/cartuchopcb.png "PCB ROM Mega Drive")
_ROM PCB Cartridge_

[^17]: Virtua Racing is a game developed by Sega AM2.
[^18]: DSP; digital signal processor.

## VDP

The VDP is the graphics chip that allows the Mega Drive to show its full potential. It is a Yamaha YM7101 integrated chip; (together with the PSG sound chip, they make up the Sega-yamaha IC6 integrated circuit).

The VDP for the mega drive is an evolution of its predecessor from the Sega master System. It expands functionality and increases its power. The VDP chip has a clock frequency of 13.423294Mhz for NTSC and 13.300856Mhz for PAL systems [^19].

It was connected through a 16 bit bus to the Motorola 68K and allowed different resolutions:

* Normal Mode: 320x224,256x224 for NTSC y 320x224, 256x224, 320x240 y 256x240 for PAL.
* Interlaced Mode: 320x448,256x448,320x480 y 256x480 which was used by different games such as the 2 player mode of sonic 2.

The VDP had a capacity of up to 4 planes or backgrounds:

* 2 backgrounds with Scroll.
* 1 Window background .
* 1 Sprite background .

The Scroll planes (A and B) were based on Tiles (8x8 pixel images) that allowed to form different images from these small pieces. Usually based on a TileMap, with a size up to 1024x256.

The VDP, also had support for Sprites, being able to store up to 80 sprites, having 20 sprites per line, with 16 colors per sprite, having a maximum size of 1280 Tiles (combining different Sprites), combining Sprites of 16 different sizes.

The VDP could display up to 512 colors, showing 61-64 colors per screen. Although it could be expanded using shading or highlighting techniques (Shadowing / Highlighting) up to 1536 in total; with 16 colors (4 bit) per pixel. In addition to being stored in 4 palettes of 16 colors.

As for memory, the VDP had at its disposal 64KB of video RAM, which allowed to store a lot of tiles (taking into account that it is connected by a 16 bit bus to the ROM and with the ability to use the DMA). The memory was divided into:

* 2KB a 8KB for Background A.
* 2Kb a 8KB for Background B.
* 2KB a 4KB for Window Background.
* Up to 40KB to store Sprites.

In addition, the VDP had a 232-byte cache for operations.

Thanks to DMA [^20], information could be sent from ROM to VRAM (and RAM), without going through the CPU.

[^19]: The NTSC and PAL systems are color systems that were used in different countries when displaying on CRT screens normally.
[^20]: DMA (Direct Memory Access), allows information to pass through the bus without the need to interact with the CPU; however the CPU, RAM and DMA bus were shared so there could be bottlenecks.

## Z80

The z80, or zilog z80, is a general purpose processor that was manufactured by Zilog starting in 1976 and was designed for desktop and embedded computers.

This processor has a similar architecture to the Intel 8080, since it was designed by a former Intel employee. It is a processor of the CISC family that has a variable length of instructions; which can have a length between 1 and 4 bytes. It has 20 8-bit and 4 16-bit registers (PC, SP, IX, IY), in addition to having an 8-bit ALU.

It is the processor used in many devices; such as:

* ZX Spectrum from Sinclair [^21].
* Neo Geo Pocket [^22] and Neo Geo Pocket Color.
* Nintendo Game Boy [^23] using a clone version (GB-Z80).
* Sega Master System and Sega SG-100(using a compatible processor).

The Sega mega Drive processor has a clock frequency of 3.579545Mhz (NTSC) and 3.546894Mhz (PAL); connected to an 8-bit bus.

It has access to an 8KB memory to be used as sound RAM, as the Z80 can be used to orchestrate sound or as a co-processor.

In addition, the Z80 allows backward compatibility with Sega Master System games so that no additional hardware (using an adapter for the slot) is required.

[^21]: Zx Spectrum and Sinclair are trademarks of Sinclair Research Ltd.
[^22]: Neo Geo Pocket and Neo Geo Pocket Color are trademarks of SNK.
[^23]: Nintendo Game Boy is a registered trademark of Nintendo Entertainment ltd.

## PSG

Inside the VDP chip, we can find both the chip dedicated to graphics, and an 8-bit sound chip dedicated both to give sound to the Mega Drive (for 8-bit sound), and to be used as a sound chip in Master System games.

Today, this chip is still being used in home electronics projects such as the Durango project.

The PSG sound chip is a custom chip by SEGA called PSG (SN76496) that is connected to the clock of the Z80 itself, it is the same chip that had the Master System.

This chip allows us to create 4 audio channels:

* 3 channels for generating square sound curves[^24].
* 1 sound channel to generate noise.

This chip could be used by both the 68k and the z80 in such a way that extra sound could be generated.

However, let's not forget that one of the strong points of the Mega Drive is the FM stereo sound. Which was generated with the other sound chip. The Yamaha YM2612.

[^24]: A signal that passes between two values, without passing through intermediate values, is known as a square wave. It is often used in electronics and alternating current.

## YM2612

Main sound chip of the Mega Drive, this chip allowed the Mega Drive to generate FM sound thanks to the Yamaha YM2612 chip, which was connected to the 68k clock.

It allowed to generate 6 FM audio channels, which gave an output signal of 53.267Khz (NTSC) and 52.781Khz (PAL).

It also allowed to generate with another configuration 5 FM audio channels, and 1 channel for PCM[^25].

This chip could be used through the z80 which was the one that orchestrated the sound together with the PSG chip; these chips together with the z80, were connected to an 8-bit bus; which connected to the sound RAM with 8Kb of size.

In the Mega Drive model 1, the sound output by the television, was Mono sound; but it had a jack connector, which generated stereo sound (in addition to a volume control on the console itself).

The models 2 and 3 of the mega drive, had stereo sound through the TV output, but no longer had the Jack connector. In addition, some models had a clone version of the YM2612.

[^25]: PCM sound (Pulse Code Modulation). It is a modulation procedure used to transform an analog signal (sound) into a sequence of bits.

## I/O Controller

An important part of having a video game console is being able to use peripherals and controllers. The Sega Mega Drive had two built-in Atari-type ports (DE9 type); these ports allowed to connect both 3 and 6-button controllers, as well as other peripherals.

In the early Mega Drive models on the back, a serial port was allowed to be connected. This was used by the Mega Modem to connect the Sega Mega Drive to the Internet via the telephone line.

By default, only 2 controllers were allowed to be connected to the Mega Drive through the various ports available on the Mega Drive. However, there were special cartridges (J-CART), which had two additional ports on the cartridge itself; allowing up to 4 players.

All this was done by the Input-Output controller. This controller was connecting to both the 16-bit bus and the 8-bit bus to be able to access both Mega Drive mode and Master System backwards compatible mode.

## Auxiliar Port (MCD)

One of the important parts of the Mega Drive, was its ability to expand; thanks among others to its Mega CD accessory.

This accessory allowed to increase computing, graphics and even sound capabilities by having access to a CD-ROM reader.

The connector for the Mega CD, was located at the bottom right and connected through a few pins. This connector was connected to the 16-bit bus to be accessed through the Motorola 68000.

## References

* Sega Retro; Technical Specifications: [https://segaretro.org/Sega_Mega_Drive/Technical_specifications](https://segaretro.org/Sega_Mega_Drive/Technical_specifications).
* Mega Drive Wikipedia: [https://es.wikipedia.org/wiki/Mega_Drive](https://es.wikipedia.org/wiki/Mega_Drive).
* Durango Project: [https://durangoretro.com](https://durangoretro.com)
