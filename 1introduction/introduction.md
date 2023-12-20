# 1. Introduction

Welcome to this book about creating and developing Homebrew software for Sega Mega Drive (or Sega Genesis) [^1]. For many, this system has been the one we have grown up with and has brought us great memories. Therefore, those of us who are still learning about technology like me, can learn how to create software for this architecture that is already more than 30 years old.

Although some may think I'm a little young (36 years old) for the Mega Drive, I guess because of the family environment and having had one when I was a kid, I always let myself spend hours and hours playing _Sonic & Knuckles_[^2] or _World Of Illusion_[^3].

Many will remember the times of the Spectrum where they used magazines with small games that we had to write by hand (usually in BASIC or assembler), where any slightest error would make our game not work. Fortunately, nowadays more modern tools are used than BASIC or assembler. As it can be to use C language together with some library like SGDK or more modern editors that help us in the development of  our game.

Of course there are more modern languages. But we want to remember that assembler was normally used for the developments and that at least using C we will abstract from it. This does not mean that it can no longer be used, since today, many people still work with assembler.

This book is intended as a guide to learn the concepts and tools to create a fully functional video game for Sega Mega Drive, using modern tools.

**NOTE:** This book and its contents are not affiliated with SEGA Inc. or any of its subsidiaries.

[^1]: Sega Mega Drive / Sega Genesis is a registered trademark of Sega Inc.

[^2]: Sonic & Knuckles is a video game owned by Sega Inc. All rights reserved.

[^3]: World of Illusion is a video game developed by Disney for Sega Mega Drive. All rights reserved.

## What is this book and what is it for?

As mentioned in the introduction, this book is intended to be a guide to create a fully functional video game for the Sega Mega Drive (or Sega Genesis) system.

This book is not intended to be an introductory book to programming since advanced concepts are used when entering the world of Homebrew and it is assumed that the user is familiar with these concepts.

In addition, this book is not intended to be a book about video game design; it is not the goal of this book. There is a lot of literature on the subject and we will mainly focus on designing and creating examples to understand the ins and outs of Sega's 16-bit console.

### Book's structure

This book is divided in 16 chapters where in each one of them a topic is approached from commenting what is the Sega Mega Drive, to being able to create advanced concepts of creation of videogames like the scroll or the debugging of our games.

The first part of the book is an introduction to the Mega Drive as its history, architecture and the tools and libraries that we will use, such as the SGDK library (Sega Genesis Development Kit) and the development environment to use.

In the second part, we will talk about how to start making our game, showing the basic concepts; from Hello World, to finish with the use of Sprites.

Finally, we will talk about more advanced concepts such as the use of Scroll, Tilesets, sound and even talk about tools for our development such as debugging (Debug) in addition to being able to use the SRAM to save information of our game.

In order to have a better understanding of each of the chapters to be covered in this book, different examples and small code fragments will be commented and made available online in the code repository in Github:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

For each chapter, one or more examples will be shown with which to work with the different tools that will be discussed in this book.

Another important part is that you will have seen that this book is under a Creative Commons license. So this book is available for everybody and can be improved and modified. If you detect any typo or possible improvement of this book, do not hesitate to send me any suggestion to the code repository of this book.

## Objectives

The objectives of this book are:

1. Learn about the Sega Mega Drive / Sega genesis and its history.
2. Learn about the architecture of the Sega Mega Drive.
3. To know the different tools that can be used to create homebrew software for Sega Mega Drive.
4. Know the SGDK (Sega Genesis Development Kit) library.
5. To know the different concepts of 2D videogame creation applied to the Sega Mega Drive.
6. Create a fully functional video game for Sega mega Drive.

## Prerequisites for this book

In order to understand the contents of this book, you will need to know the following languages or tools (or at least have used them).

* C programming language.
* Bash Scripting or CMD prompt (Windows).
* Git
* Pixel Art drawing tools such as Aseprite.

Of course, don't worry if you don't understand any part of the code, as each chapter has references to help you understand the source code or any other reference discussed.

In addition, in order to be able to follow all the contents of this book we recommend using the following software or hardware:

* **Windows, Linux or MacOs Operating System**. For those using Linux, the examples and tools have been tested in environments based on Debian distributions (such as Ubuntu).
* **Visual Studio Code** as an editor. Although you can use any editor you need, in this book we are going to use this editor as an example. In addition to installing custom tools for homebrew development.
* **Docker**: although this is optional, a container can be used to be able to develop for Sega Mega Drive using SGDK.
* **Mega Drive Blastem Emulator**. Although you can use any other such as Gens (with the modified Kmod version for Windows) or any other emulator.
* **Flash cartridge for Mega Drive**: Although it is not mandatory, if you have a Mega Drive, you can use a flash cartridge to load your roms and test them on real hardware. One of the best known is _Everdrive_.

## References

* Wikipedia: Sega Mega Drive: [https://es.wikipedia.org/wiki/Mega_Drive](https://es.wikipedia.org/wiki/Mega_Drive).
* SGDK: Github Repository: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* Sega Retro: [https://segaretro.org/](https://segaretro.org/).
