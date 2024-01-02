# 9. Sprites

We already have our first more colorful example with some backgrounds. But something else is needed, to give life to our first game; since among other things, we don't even have a player. In this case, let's talk about the Sprites.

A Sprite is a bitmap (usually) that represents an object in the game without the need of additional calculations by the CPU; either the player, enemies, objects that we can interact, etc. The Sprites can be static, or have animations that can help us to give life to our game.

Therefore, in this chapter, we are going to talk about Sprites; starting to talk about what they are, and how we can use them in our games in Sega Mega Drive. We will talk about how Sprites are built in Mega Drive, followed by how to import Sprite resources, using _rescomp_, and how they are used by SGDK and the Sprite engine it integrates.

Finally, we will show an example of using Sprites with SGDK.

## Sprites in Mega Drive

Let's comment what a Sprite really is; it is an image that represents an object in the game. This object does not need to be controlled by the CPU itself, so it can be controlled by the graphics chip itself, such as the VDP of the Sega Mega Drive.

Usually, a Sprite is composed of a series of images that represent different frames of an animation; in addition to being able to represent several animations within one image. This is known as a SpriteSheet.

<div class="centered_image">
<img src="9Sprites/img/nadia.png" title="SpriteSheet" alt="SpriteSheet" />
<em>SpriteSheet</em>
</div>

As we can see in the previous image, we can see that it is composed of different frames of different animations; normally each animation corresponds to a row, and each frame to each column.

Although it is possible to have different Sprites to represent different objects, we have to take into account the following limitations when working with Sprites in Sega Mega Drive.

* Sprites are drawn in their own Plane.
* The position on screen of the Sprites are defined in pixels and not in Tiles.
* We can have a total of 80 Sprites on screen.
* You can only have 20 Sprites per horizontal line.
* The size of each hardware Sprite can be between 1 and 4 Tiles. However, SGDK allows to store larger ones by combining them.
* The maximum Sprite size for SGDK is 16x16 (128x128 pixels) Tiles; however, they can be extended by making combinations of Sprites.
* Each Sprite can use a maximum of 16 colors, since it will be associated to one of the four available palettes.
* Each frame should be divisible by 8 (to be able to divide each animation).

It is also important to know that the Sprites will be stored in the VRAM so it is necessary to take into account that normally they have a space of 512x512px in the memory to store the information of the different Sprites.

## Import Sprites Resources

After knowing how the Sega Mega Drive works with the Sprites and especially to see the limitations that the hardware provides us, we are going to see how we can import the Sprite resources for our games. To do this we will use the tool that integrates SGDK, we will use _rescomp_.

As we saw in the previous chapter, with _rescomp_ we can import resources of different types to be able to use them in SGDK. In this section, we are going to see how to import a Sprite and divide the different frames it composes. Remember that each resource can be defined in a file with _.res_ extension (you can define various resources in one resource file).

Let's see an example:

```bash
SPRITE main-sprt "sprt/zeraready.bmp" 2 4 NONE 5 CIRCLE
```

Where:

* _SPRITE_ Resource Type.
* _name_: Name that we will give to the resource to reference it. In this example _main-sprt_.
* _path_: Path of the resource relative to the _res_ directory; it will be enclosed in double quotes. In this example _"sprt/zeraready.bmp"_.
* _width_: Size in Tiles of the width of each frame. It must be less than 32. In this example it indicates 2 Tiles (16 px).
* _height_: Size in Tiles of the height of each frame must be less than 32. In this example it indicates 4 Tiles (32px).
* _compression_: Indicates whether the image can be compressed; it can take the following values:
    * -1/BEST/AUTO: Best Compression.
    * 0/NONE: No compression (Default).
    * 1/APLIB: ApLib Algorithm (good compression, but slower).
    * 2/FAST/LZ4W: LZ4 Algorithm (less compression, but faster).
* _time_: Time between frames usually 1/60; if we put more time, then the animation is more faster. If set to 0, the Sprite will not be animated.
* _collision_: indicates the information of how the box will be for collisions. This option, although set in rescomp, is not yet used by SGDK. It will be a future enhancement. It can have the values CIRCLE, BOX or NONE (default is NONE).
* _opt_: Indicates the optimization to be performed when saving and cropping the image; it can have the following values:
    * 0/BALANCED: Default way, try to optimize in a balanced way.
    * 1/SPRITE: reduces the number of sprites per hardware at the expense of using more Tiles, using a larger Sprite.
    * 2/TILE: Reduces the number of Tiles at the cost of using more Hardware Sprites.
    * 3/NONE:It does not perform any Optimization.
* _iteration_: Indicates the number of iterations for the process of cutting each frame. Default is 500000.

In addition to the above properties, the following characteristics of the input image must be taken into account:

* The image must always be divisible by 8 (to be able to store by Tile).
* The image should be a grid representing each animation per row and each Frame per column.
* An animation cannot contain more than 255 frames.
* It is not possible to have frames larger than 248x248 pixels (32x32 Tiles).
* No more than 16 Hardware Sprites can be used per frame.
* _Rescomp_ detects only rows where there are animations; it ignores empty rows.
* By default, the collider is calculated with 75% of each frame.

When _rescomp_, will process a _SPRITE_ type resource, it performs the cuts of the different animations and optimizes both at frame and hardware level, in order to be able to store in the most optimal way in the VRAM.

When processing the Sprite resource, it will generate (if the _-noheader_ option has not been specified), an .h file with the reference to the resources.

## SGDK's Sprites Engine

When working with animated Sprites, it is always quite awful to make the different Frame changes to make the animations more fluid; so that it can give a better sense of movement when working with the different frames of a Sprite.

Thanks to SGDK, we can use a small Sprite engine; this way we will not need to calculate _"when"_ it is necessary to change the frame of our Sprite. As we have seen in the previous section, we can define the time between animations; this parameter will be used by the Sprite engine to execute the change between the different frames.

SGDK's Sprite engine is based on saving a list of all active Sprites, so that only those in the list are interacted with.

In order to use the Sprite engine, we can use at code level two functions ```SPR_init``` and ```SPR_update```. Let's see each of them.

* ```SPR_init```: Initializes the Sprite engine with default values. Normally, it reserves 420 Tiles in VRAM. In addition, it initializes the hardware to store the Sprites. There is another function called ```SPR_initEx``` that allows to pass by parameter the number of Reserved Tiles.

* ```SPR_update```:Updates and displays the active Sprites. Thanks to this function, every time it is called, it will recalculate the active Sprites and will change the frame of those that need it. It is important that this function is before the call to ```SYS_doVBlankProcess```, so that the frames are updated.

Later on, we will see more functions that we can use, especially when we look at the example in this section.

## Work with Sprites in SGDK

When working with Sprites in SGDK, it is important to know how to work with the different functions that will allow us to modify the characteristics of the Sprites, such as their position, animation, frame or priority.

One of the first features that we have to take into account, is when working with Sprites, their position is calculated in pixels, not in Tiles. Although each frame is drawn and calculated at Tile level. Therefore it is important to always know the position of a sprite both the X and Y coordinate in pixels.

Another aspect to take into account is, that the Sprites are drawn in their own Background; and therefore, they have a priority; in such a way, that it can be established. Let's see again the priority scheme of the different planes.

![Background priority schema](9Sprites/img/esquemaplanos.png "Background priority schema")
_Background priority schema_

We see how the Sprite plane can be drawn with low or high priority, so that we can make the Sprite be behind some plane to give a greater sense of depth.

On the other hand, as we can see, a Sprite is composed of different animations that can indicate different actions that the character can perform (move in different directions, attack, jump); therefore we have to take into account these animations. In a SpriteSheet, each row corresponds to an animation; and each column corresponds to a Frame of each animation. Let's see an example:

<div class="centered_image">
<img src="9Sprites/img/anim.png" title="Animated SpriteSheet" alt="Animated SpriteSheet"/>
<em>Animated SpriteSheet</em>
</div>

As we can see in the previous image, it is composed of 5 animations of 3 Frames each. We observe that for SGDK, the first animation is number 0. So we always have to take this into account to change animation when necessary. This also applies to the Frames; so the first Frame of an animation is number 0.

Finally, as we have seen when importing Sprite resources with _rescomp_, we can define the speed of animation change through a number. This number is manipulable and therefore, we can use it; it is always important to know that more time, minus change; thats means if we add more time the animation change is more faster. That is to say that the value of 1 indicates that the animation will be changed in each frame, therefore, it would be 50/60 times per second.

## Example With Sprites in SGDK

Now that we have seen how to work with Sprites in SGDK, let's see an example. We will take as a base the previous example for the backgrounds and add two Sprites. This example can be found in the example repository that accompanies this book; in the _ej6.sprites_ folder.

This example will consist of working with two sprites and see how we can move them, change animation, priority, etc. These two Sprites, are composed of two SpriteSheets of 72x160 and 96x160 Pixels each one. Let's see these two Sprite Sheets.

![Example SpriteSheets](9Sprites/img/sprites.png "Example SpriteSheets")
_Example SpriteSheets_

As we can see in the images, they are two sheets of Sprites, with different animations and Frames. In this case they are Frames of different sizes. The character on the left, each Frame has 32x32 pixels (4x4 tiles); while the character on the right, has 24x32 pixels (3x4 Tiles); so we have to take this into account when importing both resources. To import these resources, we will use a _.res_ file, to define each one of them.

```
SPRITE shaSprt "sprt/sha.png" 3 4 NONE 6 BOX
SPRITE elliSprt "sprt/elliready.png" 4 4 NONE 5 BOX
```

We see that the first one, which we will call _shaSprt_ and we will obtain the file with the bitmap inside the sprt folder (remember that all the resources must go in the _res_ folder), then we see that we define that each Frame has 3 Tiles of width and 4 of height; to be able to make the cut correctly. Finally, we will not use compression, and the speed of change of Frame will be 6 times per second.

For the second Sprite, that we will call _elliSprt_, we will do the same way; but taking into account that each Frame is 4 tiles wide and 4 tiles high. Once we have defined both Sprites and also the corresponding backgrounds (that we will reuse those of the previous example), we will be able to compile the project and that rescomp, generates the resources and header files _.h_ if necessary.

With these steps we would already have imported the sprites and backgrounds to use in our source code. Let's analyze the source code. In this example we will use both synchronous and asynchronous controls, as well as backgrounds.

We will start by including the resources in our code, followed by the definition of the necessary constants:

```c
#include <genesis.h>

#include "gfx.h"
#include "sprt.h"

#define SHA_UP 0
#define SHA_DOWN 2
#define SHA_LEFT 3
#define SHA_RIGHT 1
#define SHA_STAY 4
```

As we can see in the previous fragment, we import both the ```genesis.h``` library, as well as the header files (_.h_) generated with _rescomp_. On the other hand, we also see a series of constants, which correspond to the indexes of the animations of a Sprite; this is recommended to make the code more readable.

Next, we will define the global variables needed for our game:

```c
Sprite * sha;
Sprite * elli;

u16 sha_x=15;
u16 sha_y=125;

int shaPrio=TRUE;
int elliPrio=FALSE;
```

We will use these variables during the code of the example; such as the pointers to the different Sprites, x and y position of one of them, and the priority status of each one of the Sprites. Later we will see how we will use them.

Next, we will focus on function ```main``` where we can see the initialization of the different resources:

```c
JOY_init();
JOY_setEventHandler(asyncReadInput);
SPR_init();
VDP_setScreenWidth320();
```

Where we can observe how the controls are initialized, establishing the callback function for the asynchronous controls with the function ```JOY_setEventHandler``` (for more information, consult the chapter of controls). Also, initialize the Sprite engine with the ```SPR_init``` function and then set the width to a resolution of 320px.

Then, we start adding elements to the screen, such as backgrounds, as we have seen in the example of the previous chapter:

```c
u16 index = TILE_USERINDEX;
VDP_drawImageEx(BG_B, &bg_b,
     TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE
        ,index),0,0,TRUE,CPU);
index+=bg_b.tileset->numTile;
VDP_drawImageEx(BG_A, &bg_a, 
     TILE_ATTR_FULL(PAL1,FALSE,FALSE,FALSE,
     index),0,0,TRUE,CPU);
index+=bg_a.tileset->numTile;
```

But next, we will see how to add Sprites from a Sprite definition. A Sprite definition is the resource itself that we have imported; but we can define multiple Sprites from a Sprite definition.

Let's see how to add a new Sprite from its definition:

```c
 sha = SPR_addSprite(&shaSprt,sha_x,sha_y,
                TILE_ATTR(PAL2,TRUE,FALSE,FALSE));
```

We see in the previous fragment, that the function ```SPR_addSprite``` is used; this function, allows to create a Sprite from a resource; we are going to see the different parameters of which it is composed:

* _spritedef_: Pointer to the Sprite definition; which corresponds to the resource imported by rescomp.
* _x_: Default X Position in Pixels.
* _y_: Default Y Position in Pixels.
* _attribute_: Indicates the attributes of the Sprite itself. For this, you can use the ```TILE_ATTR``` macro to set these attributes.

The ```TILE_ATTR``` macro allows you to set the attributes of a tilemap; let's look at its parameters:

* _pal_: Color Palette to use(```PAL0```,```PAL1```,```PAL2```,```PAL3```)
* _prio_: Sprite priority ```TRUE``` for high priority or ```FALSE``` for Low priority.
* _FlipV_: Set vertical mirroring ```TRUE``` for mirrored or ```FALSE``` otherwise.
* _FlipH_: Set horizontal mirroring ```TRUE``` for mirrored or ```FALSE``` otherwise.

SGDK's Sprite Engine is in charge of automatically placing the different Sprite Tiles in the VRAM; however, this can lead to VRAM fragmentation due to gaps between different Sprites. To avoid this, the ```SPR_addSpriteSafe``` function can be used; however, we have to be careful, as it can be slower.

Both the ```SPR_addSprite``` and ```SPR_addSpriteSafe``` functions return a pointer to a structure called ```Sprite```; which has a series of properties with everything necessary to store the Sprite; let's see some of the fields of this structure:

* _status_: Internal status with information on how the sprite will be hosted.
* _visibility_: Indicates the current frame information and how it will be displayed in the VDP.
* _spriteDef_: Definition Pointer.
* _onFrameChange_: Specifies the custom function that can be triggered at each Frame change. It can be set with the ```SPR_setFrameChangeCallback``` function.
* _animation_: Pointer to selected animation.
* _frame_: Pointer to the current frame.
* _animInd_: Current animation index.
* _frameInd_: Current Frame index.
* _timer_: Current frame timer (internal use).
* _x_: X position in pixels.
* _y_: Y Position in pixels.
* _depth_: indicates the depth; useful when there are several Sprites.
* _attribute_: Information with the attributes set with the ```TILE_ATTR``` macro.
* _VDPSpriteIndex_: Index to the first Sprite hosted in the VDP.

More information can be found in SGDK's documentation.

Once the two sprites are added, we have to assign the resource palettes to each of the palettes available in Sega Mega Drive. Remember each palette has 16 colors and the first one corresponds to a transparent color. Depending on our version of SGDK, we can use different functions. If we have version 1.80 or higher, we can use the following function ```PAL_setPalette```. It receives the following parameters:

* _pal_: Palette Number (```PAL0```,```PAL1```,```PAL2```,```PAL3```).
* _data_: Data with the palette can be that of the resource itself, or set a custom palette.
* _tm_: Transfer method for storing the palette using ```CPU``` or ```DMA```.

If on the other hand we have a version of SGDK lower than 1.80, we can use the function ```VDP_setPalette``` to set the palette to a Sprite. It receives the following parameters:

* _pal_: Palette Number (```PAL0```,```PAL1```,```PAL2```,```PAL3```).
* _data_: Data with the palette. It can be that of the resource itself, or set a custom one.

As in the example itself, which sets the palette ```PAL3``` with the palette data of the imported resource:

For SGDK 1.80 or later:

```c
PAL_setPalette(PAL3, elliSprt.palette->data,
           DMA);
```

For versions prior to 1.80:

```c
VDP_setPalette(PAL3,elliSprt.palette->data);
```

To finish the initialization, the default animations of the two Sprites are set:

```c
SPR_setAnim(sha,SHA_STAY);
SPR_setAnim(elli,4);
```

Which is performed using the ```SPR_setAnim``` function, which allows a Sprite to define the animation index to use. It receives the following parameters:

* _sprite_: Sprite Pointer.
* _ind_: Animation Index to be used. Remember the indexes of the animations start with 0. As can be seen in the example, it can be interesting to define a series of constants for the animations.

Let'se the rest of the ```main``` function:

```c
while(1)
    {

        readInput();
        SPR_setPosition(sha,sha_x,sha_y);
        SPR_update();
        //For versions prior to SGDK 1.60 use
        // VDP_waitVSync instead.
        SYS_doVBlankProcess();
    }
```

We can see inside the infinite loop, we make a series of calls to functions; like reading the synchronous controls (that we will see later), the position of a Sprite is established, with the function ```SPR_setPosition```; and the Sprite engine is updated calling the function ```SPR_update```. In addition to displaying on screen information such as the priority of each Sprite, and ending the loop with the call to ```SYS_doVBlankProcess```.

The ```SPR_setPosition``` function sets the position of the sprite in pixels; let's see the parameters it receives:

* _sprite_: Sprite Pointer.
* _x_: X position in pixels.
* _y_: Y position in pixels.

Once we have finished looking at the ```main``` function, let's focus on looking at the functions for the synchronous and asynchronous controls. Let's look at the latter first; they are controlled by the ```asyncReadInput``` function, which we set up at the beginning as the controller function. Let's see a fragment of this function:

```c
void asyncReadInput(u16 joy,
          u16 changed,u16 state){

    if(joy == JOY_1){
        if(changed & state &  BUTTON_A){
                 shaPrio=TRUE;
                 elliPrio=FALSE;
                 SPR_setZ(sha,shaPrio);
                 SPR_setZ(sha,elliPrio);
        }
        if(changed & state &  BUTTON_B){
                 shaPrio=FALSE;
                 elliPrio=TRUE;
                 SPR_setZ(sha,shaPrio);
                 SPR_setZ(sha,elliPrio);
        }
    }
}
```

We see how the function, checks if you have pressed controller 1 (```JOY_1```), and if you press button A, the depth of the _sha_ sprite is set against the _elli_ sprite; while if you press button B, the depth of the _elli_ sprite is changed with respect to the _sha_ sprite.

The depth of the Sprite can be set with the ```SPR_setZ``` function, which receives the following parameters:

* _sprite_: Sprite Pointer.
* _Z_: Indicates the depth of the Sprite.

Last but not least, we can see how the synchronous controls are read from the ```readInput``` function; which is the one that will react according to the controls we have used.

Let's see a fragment of this function:

```c
void readInput(){
    int inputValue = JOY_readJoypad(JOY_1);

    if(inputValue & BUTTON_DOWN){
        SPR_setAnim(sha,SHA_DOWN);
        sha_y++;
    }else{
        if(inputValue & BUTTON_UP){
            SPR_setAnim(sha,SHA_UP);
            sha_y--;
...
```

In this fragment, we can see how to read, first of all, the buttons pressed by controller 1 using the function ```JOY_readJoypad``` (remember that you can learn more about the functions to read the input, in the chapter 7); then, we check which button has been pressed; which for this case, we only use those of the addresses.

In each case, the animation is set, and the variable with the position is modified. The first case, only sets 4 directions and you can only go to one at a time.

Once we have seen the code of the example, we can compile it and run it in an emulator. Obtaining the following screen:

![Example 6: Sprites](9Sprites/img/ej6.png "Example 6: Sprites")
_Example 6: Sprites_

With this example, we have already seen how to add Sprites, to show them in our game, and to be able to interact with it from the controls. In addition, of already having a more complete game from the use of backgrounds and Sprites together with the controls.

In the next chapter, we will focus on the physics that we can calculate with the different options provided by SGDK and the use of the Motorola 68000 processor.

## References

* Mega Cat Studios: [https://megacatstudios.com/blogs/retro-development/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17](https://megacatstudios.com/blogs/retro-development/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17).
* SGDK (rescomp): [https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt](https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt).
* Charas Project (Sprites Generator): [http://charas-project.net/index.php](http://charas-project.net/index.php).
