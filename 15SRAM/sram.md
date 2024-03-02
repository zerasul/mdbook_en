# 15. SRAM and Interruptions

We are now approaching the final part of this book. We have been reviewing both the visual part, as well as the sound. Besides studying all the architecture of the Sega Mega Drive; we are going to review an important section; to save the progress of our game, as well as to handle the different interruptions that we can use when drawing the screen.

First of all, we have to know how we are going to store the data and keep in mind that not all types of cartridges have the feature to store information. On the other hand, we will see the use of interrupt functions to be able to update the resources of our game using these interrupts.

Finally, we are going to see an example that will use these interruptions to make these modifications and see how to optimize our game.

## Save our Game Process

Many of us have suffered, not being able to save the progress of our Mega Drive games; only some games had this ability to save the progress in the cartridge. This is because these cartridges, had a SRAM memory [^64] along with a button battery (which we have to be careful not to run out of battery after so many years); there were also some special types such as _Sonic 3_ that had a special type of memory without the need of battery (using flash memory).

Therefore, if we need to store information about the progress of our game, we can use this SRAM memory, we will need a cartridge that has both ROM and static memory.

![SRAM Cartridge](15SRAM/img/sram.png "SRAM Cartridge")
_SRAM Cartridge (DragonDrive)_

[^64]: SRAM: Static RAM. It is a static random access memory; it allows high speed but is usually small in size.

Although there is also the possibility of creating a password generator; so we can show this code to the player to be able to continue the progress later.

### SRAM

As we have already mentioned, we can store information in the static memory in such a way that this information is not lost when the console is turned off. To do this, we will need a way to send information to the cartridge to store this information in the SRAM memory.

Thanks to SGDK, we can store this information so that we can also retrieve it. Let's put a use case related to how we can store or retrieve such information. Let's assume the following ```struct``` in C:

```c
struct{
    u8 lives;
    u8 scene;
    u32 score;
    u32 checksum
}player;
```

Where we see that we have stored the lives that the player has, the scene through which it goes, the score and finally a checksum to be able to verify that the stored information is correct. This information, we can store it in the SRAM, using a series of functions.

First of all, we will need to enable the memory in write mode using the ```SRAM_enable``` function, which enables the SRAM memory access in write mode. In case we want to access only in read mode, we can use the function ```SRAM_enableRO```; which enables the SRAM memory in read-only mode.

Once enabled, we can write to or read from the memory. It is important to know that the SRAM is divided into 8-bit words; so when storing information we have to take this into account.

Let's see what functions we will need to store the above ```struct```; we see that we will need to store 2 variables of 8 bits and two of 32 bits. So we will need 10 bytes to store all the information.

We can use the ```SRAM_writeByte```,```SRAM_writeWord``` or ```SRAM_writeLong``` functions to store information in SRAM memory. Let's take a look at each of them:

The ```SRAM_writeByte``` function stores 1 byte in the SRAM according to the Offset that indicates the offset in the space inside the SRAM (remember that each word is 8 bits). It receives the following parameters:

* _offset_: The offset where the bytes will be stored in SRAM.
* _value_: Value To Store (1 byte).

The ```SRAM_writeWord``` function stores 1 word (2 bytes) in the SRAM. It receives the following parameters:

* _offset_: The offset where the bytes will be stored in SRAM.
* _value_: Value To Store (2 bytes).

Finally, the ```SRAM_writeLong``` function writes a long integer (32 bits) to the SRAM. It receives the following parameters:

* _offset_: The offset where the bytes will be stored in SRAM.
* _value_: Value To Store (4 bytes).

Considering the above functions, we can create the following function to save progress.

```c
void savePlayerProgress(){

    SRAM_writeByte(0,player.lives);
    SRAM_writeByte(1,player.scene);
    SRAM_writeLong(2,player.score);
    u32 checksum= player.lives+
        player.scene+player.score;
    player.checksum=checksum;
    SRAM_writeLong(6,player.checksum);
}
```

As we can see, we will perform a checksum (in a simple way); adding up the stored values and storing them in the memory; so that later, when reading, we can check that it has been done correctly.

Let's see what the reverse operation would be like. Read from SRAM memory. In this case, we are going to use the following functions ```SRAM_readByte```, ```SRAM_readWord``` or ```SRAM_readLong```. Let's look at each of these functions:

The ```SRAM_readByte``` function reads a byte from the SRAM memory. It receives the following parameter:

* _offset_: The offset where the bytes are stored in SRAM.

This function returns a 1-byte integer with the information that has been read.

The ```SRAM_readWord``` function reads a word (2 bytes) from the SRAM memory. It receives the following parameter:

* _offset_: The offset where the bytes are stored in SRAM.

This function returns a 2-byte integer with the information read.

The ```SRAM_readLong``` function reads a long integer (4 bytes) from SRAM memory. It receives the following parameter:

* _offset_: The offset where the bytes are stored in SRAM.

This function returns a 4-byte integer with the information read.

After seeing the functions that read from the SRAM memory, we can create a function to read this information:

```c
void readGameProgress(){
    player.lives = SRAM_readByte(0);
    player.scene = SRAM_readByte(1);
    player.score = SRAM_readByte(2);
    player.checksum= SRAM_readByte(6);
}
```

Obviously, it would still be necessary to verify that the checksum read is correct with the one calculated from the struct data.

## Interruptions

We have talked about how to use the SRAM; but now we would like to talk about another important aspect when working with Sega Mega Drive.

In the previous chapters examples, you can see that we have been doing each action, and then we have waited for the screen to finish repainting; due to the use of the ```SYS_doVBlankProcess()``` function, which manages the screen and hardware repainting until the screen has been completely repainted.

We have to take into account that this console is designed to be used in CRT  _(Cathodic Ray Tube)_ televisions, that they are painted by each line and from top to bottom; so in each frame, it is necessary to wait until both the VDP and the television finish painting.

During this painting time, the CPU can be very idle; so it can be interesting to use this time to perform operations and optimize the CPU time; because if it takes too long to perform all operations before waiting for painting, a drop in frames per second can occur (50 for PAL and 60 for NTSC); so it is better to optimize the CPU usage.

To do this, we can use interrupts, which will allow us to execute code during these periods when the screen is being painted. These interruptions are launched by the VDP when finishing painting both a set of lines and the screen itself. Let's see a diagram.

![Mega Drive Screen Interruptions](15SRAM/img/hblank.jpg "Mega Drive Screen Interruptions")
_Sega Mega Drive Screen Interruptions_

As we can see in the schematic, for each time a line is painted, an _HBlank_ interrupt is thrown, when it is repositioned to paint the next one. In this time, it can be used to update part of our code such as updating the palettes (Some games like Sonic uses this technique).

On the other hand, we can observe that when the screen is finished painting, another interruption the _VBlank_ is launched, which we can also use to update parts of our game such as the backgrounds and/or palette; in this way we can create animations on the backgrounds themselves.

You should always know that both _HBlank_ and _VBLank_ have a short period of time to execute code so we cannot use very complex operations. Therefore, we have to be very careful when using these interrupts.

Let's see how each of these interrupts can be used.

### HBlank

The HBlank interrupt occurs every time you paint a line, although in many cases it is not necessary to use an interrupt function for each line; therefore, Mega Drive has an interrupt register ($0A), which will act as a counter and will be decremented until it reaches zero.

When this register reaches zero, the associated interrupt function will be called. We can control this at the SGDK level.

It is very important to keep in mind that the time that passes from the time the interruption is triggered until the next line is painted is very short, so these functions cannot be too heavy.

Let's see what functions SGDK has to work with this type of interrupt.

The function ```VDP_setHIntCounter```, allows you to set the value of the interrupt counter to be executed every X lines, note that the counter goes up to the value 0, so a value of 5 will be from 5 to 0 (5+1); it receives the following parameter:

* _value_: Value to be set indicating how many lines will be painted until the interrupt is triggered; if set to 0, it will be on each line (scanLine).

On the other hand, the function ```VDP_setHInterrupt```, enables or disables the _Hblank_ interrupt so that the interrupt function will not be triggered. It receives the following parameter:

* _value_: Enables (non-zero value) or disables (zero value) the HBLank Interruption.

Finally, to set the function to be used for the HBlank interrupt, the ```SYS_setHIntCallback``` function, which receives the following parameter, will be used:

* _CB_: Pointer to callback function will be a function that will not have parameters and does not return anything; although it is necessary that it has as prefix ```HINTERRUPT_CALLBACK```. It is important to know that this function cannot perform very heavy operations; although it can change the color palette (CRAM), Scroll or some other effect.

### VBlank

After seeing the horizontal interruption, we can see the vertical interruption; which occurs when the entire screen is finished being painted; this interruption takes much longer to complete. Therefore, it can be used to make more changes than the horizontal interruptions.

We are going to see how we can use this interrupt, and the functions that SGDK provides us to work with this type of interrupt. It is important to know that for this type of interrupt it is very useful to perform all the operations that are related to the VDP like updating the backgrounds or the Sprites themselves.

It is very important to take this into account since making these changes in the main thread is much more expensive, so we have to avoid making these changes in the main thread.

We will start with the function ```SYS_setVBlankCallback``` which sets the function that establishes the function to be executed at the _VBlank_ interrupt. This function uses the time when ```SYS_doVBlankProcess``` is called and takes advantage of the time while the screen is being painted. It receives the following parameters:

* _CB_: pointer to the interrupt function. This function does not receive any parameters or return any data.

There is also the function ```SYS_setVIntCallback``` which also sets the interrupt function working in the same way as the previous one. But in this case, since the interrupt itself is launched and the screen is just painted. It receives the following parameters:

* _CB_: pointer to the interrupt function. This function does not receive any parameters or return any data.

## Interruption Example

We have already been able to see the different functions for working with interrupts; so we can move on to an example of use with these functions. You can find the example of this chapter, in the repository of examples; that you can find in the following address:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

The folder where you will find this example is _ej16.interrupts_; in this folder you will find a simple example, in which we can control a character. In this case, we are going to change the way of interacting with the game.

First, we will work with a series of variables where we will store the state of the player; for this we will use the following ```struct```:

```c
struct{
    Sprite* sprite;
    u16 x;
    u16 y;
    u8 anim;
}player;
```

In this case, we will store the Sprite to use, x and y position, as well as the current animation (we will use a series of constants to set it). We will define the following two functions:

```c
void vblank_int_function();
void handleInput();
```

The first function ```vblank_int_function``` is the one we will use as a function for the _vBlank_ interrupt in such a way that we will use it to update the screen (backgrounds, Sprites,etc).

On the other hand, the ```handleInput``` function will be used to manage the controls (synchronously).

Let's look at the beginning of the main function:

```c
SYS_disableInts();
u16 ind = TILE_USER_INDEX;
VDP_drawImageEx(BG_A,&back1,
    TILE_ATTR_FULL(PAL0,FALSE,
    FALSE,FALSE,ind),0,0,
    TRUE,CPU);
ind+=back1.tileset->numTile;
player.x=30;
player.y=20;
player.anim=IDLE;
PAL_setPalette(PAL1,
    player_sprt.palette->data,CPU);
player.sprite = SPR_addSprite(&player_sprt,
    player.x,player.y,
    TILE_ATTR(PAL1,FALSE,FALSE,FALSE));
SYS_enableInts();
```

We see that at the beginning of the initialization, we disable the interrupts with the function ```SYS_disableInts``` and ```SYS_enableInts``` which activate the interrupts. It is always important to disable interrupts when loading data (adding sprites, backgrounds, etc).

Once the background and the sprite have been added, we can activate the _VBlank_ interrupt function; which we will do with the function ```SYS_setVBlankCallback```; setting the pointer to the function.

If we review the ```vblank_int_function```, we can see that it is performed in this function:

```c
void vblank_int_function(){

    SPR_setPosition(player.sprite,player.x,player.y);
    SPR_setAnim(player.sprite,player.anim);
    SPR_update();
}
```

In this function, we see that the position of the Sprite, its animation and the Sprites are updated. This is done in the time that the screen is finished being painted.

Now we can move on to review the ```handleInput``` function that will manage the controls. Let's see a fragment:

```c
u16 value = JOY_readJoypad(JOY_1);

if(value & BUTTON_RIGHT){
    player.anim= RIGHT;
    player.x++;
}else{
...
```

We can see the value read from controller 1 (```JOY_1```) is checked, and the struct status is updated. In such a way, it will be updated when the _VBlank_ interrupt is performed. In this way, the game is much more efficient since any operation with the VDP can be performed in the interrupt function; while the main thread serves to update the state to be painted.

Now we can compile and execute the example, where we can see how the character can move; in such a way that it is more efficient than in other examples. We have already been able to see the content of this chapter; where we have seen two important aspects at the time of working creating games; the use of the SRAM in case we want to store the progress of the game, and on the other hand the use of interrupts.

![Example 16: Interruptions](15SRAM/img/ej16.png "Example 16: Interruptions")
_Example 16: Interruptions_

## References

* Sega/Mega Drive Interrupts: [https://segaretro.org/Sega_Mega_Drive/Interrupts](https://segaretro.org/Sega_Mega_Drive/Interrupts).
* SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* Danibus (github): [https://github.com/danibusvlc/aventuras-en-megadrive](https://github.com/danibusvlc/aventuras-en-megadrive).
* DragonDrive (PCM Flash): [https://dragonbox.de/](https://dragonbox.de/)
