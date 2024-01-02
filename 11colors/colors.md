# 11. Color Palettes

We can't talk about the Sega Mega Drive's Development, if we don't talk about colors and how they are handled by this system. So far we have been talking about the palettes and how we can handle them when dealing with backgrounds or the different sprites in the examples that we have been showing.

In this chapter, we are going to show the different colors that the Mega Drive can handle, and how to store them in the different palettes available at hardware level. Also, we are going to show how to perform different effects such as transparencies or highlight some color with respect to the background, thanks to the _HighLight_ and _Shadow_ colors.

Finally, we will see an example where we will handle the different effects and in addition, we will see some advanced functions related to screen painting that will help us to add more effects.

## Sega Mega Drive Color

So far we have mentioned that Sega Mega Drive can display up to 64 colors on the screen (actually 61 without counting transparent colors). This is due to the fact that Sega Mega Drive always works with 16 color palettes and that only 4 palettes are available.

However, we have not been able to see how many colors in total the Sega Mega Drive can display. Sega Mega Drive stores colors in a 9-bit RGB color palette. This means that it can display 512 colors that Sega Mega Drive is capable of handling. But remember that we can only see 64 colors per screen due to the 4 palettes of 16 colors.

![Mega Drive Palette Color](11colors/img/RGB_9bits_palette.png "Mega Drive Palette Color")
_Mega Drive Palette Color (Wikipedia)_

As we can see in the previous image, the different colors of the Sega Mega Drive is capable of displaying are shown, and it is important to take this into account since when working with the different graphics, we must know which color would correspond to the Sega Mega Drive if we are working with RGB from our development team.

In case the color we are working with does not correspond to a color for the Sega Mega Drive, SGDK will transform this color to the closest color.

Also, SGDK comes with functions and macros to work with different colors. For example:

```c
u16 vdpRedColor = 
    RGB8_8_8_TO_VDPCOLOR(255,0,0)

```

The macro ```RGB8_8_8_8_TO_VDPCOLOR```, allows to transform an RGB color defined by 3 parameters (red, green, blue) to the equivalent color for VDP. Each of the parameters has a value from 0 to 255. This can be interesting to modify colors of the environment or to make some effect with it.

There are also equivalents in other formats:

* ```RGB24_TO_VDPCOLOR```: Transforms a color in RGB 24-bit format to VDP.
* ```RGB3_3_3_TO_VDPCOLOR```: Transforms a color in RGB format (r,g,b) to VDP. Where each component has value from 0 to 7.

Obviously it is important to know that when working with colors and palettes using SGDK, the palette information is usually imported together with the graphics information. Therefore, it is important that in order to save colors and not having to change the palette, the palette is reused for different graphics.

If during the game we have to change the palette and load different graphics, this can cause bottlenecks since the information must pass from the ROM to the VRAM (or CRAM) either through CPU or using DMA. Using any of these alternatives, we can generate such a bottleneck since they share the bus.

## HighLight & Shadow

We have been able to see how to work with the different colors provided by the Sega Mega Drive. Using the different palettes we have available, we can work with up to 64 colors on screen. However, this number is expandable thanks to the use of HighLight and Shadow, among others.

The use of these modes allows the number of colors to be expanded by modifying the brightness of the palette in two ways:

* _HighLight_: Increases brightness to twice the brightness, showing more striking colors.
* _Shadow_: Decreases brightness by half, showing darker colors.

In this way, you can increase the number of colors and show different effects such as highlighting a character or darkening an area.

![HighLight and Shadow modes](11colors/img/paletas.png "HighLight and Shadow modes") _HighLight and Shadow modes_

**NOTE:**  For those who have the grayscale version of this book, you can see this and other examples in the source code repository that accompanies this book, in full color.

We can see in the previous image, how the same color palette can be in HighLight mode or shadow mode, increasing the number of colors to be displayed with only one palette. However, these colors are not always expandable by three (i.e. from 16 colors to 48). It depends on various cases, more or less colors will be displayed.

In this section, we are going to show how these modes work in the Sega mega Drive. Since depending on what is going to be shown and the priority of the same one, it has a behavior or another. We are going to see how these modes behave in planes and Sprites.

To activate the HighLight/Shadow mode, you can use the function ```VDP_setHilightShadow``` which indicates whether it is activated or not. It receives a parameter with value 1 or 0. For example:

```c
VDP_setHilightShadow(1);
```

Let's see how this function behaves when activated in Backgrounds or Sprites.

### Backgrounds

When working with planes, the HighLight mode is not accessible; since it is prepared for Sprites. However, we can access the colors of the other two modes. Taking into account the following characteristics:

* If the Tiles have priority, it will be displayed with Normal colors.
* If the Tiles do not have priority, the shadow mode will be displayed.
* If a Tile with priority overlaps with a Tile without priority, they will be displayed with the normal color.

### Sprites

When working with Sprites, we have to take into account the following characteristics:

* If the palette used is one of the first 3, (```PAL0```, ```PAL1```, ```PAL2```), it will behave the same as the planes (with priority normal color, without priority shadow color).
* If the palette used is the fourth palette (```PAL3```), we have to take into account the following cases:
    * If the Sprite background has Normal color:
        * Colors 14 and 15 of the palette will be displayed in _HighLight_ mode.
        * All other colors will be displayed as normal.
    * If the Sprite background has Shadow color:
        * Color 14 in the palette will be displayed in Normal mode.
        * Color 15 of the palette will not be displayed. This can help us to simulate transparencies.

Also, for Sprites in Shadow mode, it will show only the darkest background pixels. This can help us to simulate shadows. We will see later in the examples how to perform these effects.

It is important to know that when working with these modes, the behavior may change depending on the emulator to be used. So it may be interesting to test it on real hardware, in addition to testing it in an emulator such as _Blastem_ or _Kega Fusion_.

## Palette and color management in CRAM

Another aspect to take into account is when working with the different colors and how we can handle the different colors stored in the CRAM (Color RAM).

In this section, we will show some useful functions that we will later use in an example.

It is important to know that the content of the 4 palettes is stored in the CRAM and can be accessed by an index, from 0 to 63. To access, we can do it through the function ```PAL_getColor```. It receives the following parameter:

* _index_: index from 0 to 63 to access the CRAM color.

This function returns the RGB value of the color at that position in the CRAM.

You can also set the color at a specific position. In this case we will use the ```PAL_setColor``` function which receives the following parameters:

* _index_: CRAM index (0 to 63), in order to set the color to be replaced.
* _value_: RGB value of the color to be used. In this case, you can use the ```RGB8_8_8_8_TO_VDPCOLOR``` or similar functions to set the color value.

One aspect to take into account, is that these functions modify the value of the CRAM that is next to the VDP; therefore, the color value must be written and if both the CPU and the DMA are being used we have to take into account that there may be a bottleneck.

You can find more information about the functions to modify the CRAM colors by both CPU and DMA in the SGDK documentation.

## Example with Shadow Effects

In this chapter we have been working with color palettes and the effects we can do on them. Therefore, in the example we are going to study, we will use the different color palettes and their respective Shadow effects.

In this example, we are going to use the characteristics of the priority, to be able to simulate an effect of lights; simulating in this case, the light of some street lamps, and to see how it affects to the different Sprites, with the different properties that they can have.

The example we are going to study, called _ej8.colors_, can be found in the repository of examples that accompanies this book. We remind you that this repository can be found at the following address:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

In this case, we are going to show a background that we have generated using different resources that we have found on the Internet; you can see these resources and give credit to the authors in the references of this chapter. Let's take a look at the background we are going to show:

<div class="centered_image">
<img src="11colors/img/fondo1.png" title="Example Background" alt="Example Background"/>
<em>Example Background</em>
</div>

As we can see in the image, we see a night scene where we can observe 3 street lamps. The idea of the example is to show that under each streetlight there is a beam of light but outside of them a darker color is noticed. This effect can be done using a priority map.

This can be done by using another image with the areas that we want to illuminate; in this way, by placing both images, the areas that are painted in the second image will be shown lighter than those that are not; using the Shadow effect.

Let's look at the image of the priority map:

<div class="centered_image">
<img src="11colors/img/fondo2.png" title="Priority Map" alt="Priority Map"/>
<em>Priority Map</em>
</div>

As we can see in this image, the marked areas will be the ones that will appear lighter than the black ones, which coincide with the position of the street lamps in the foreground. This effect is due to the fact that at the plane level, the tiles with priority will be displayed normally, while the Tiles that are painted without priority, will have the shadow effect; hence it has the effect of illumination. Let's see how this effect is done at the code level to set the priority only for the areas that are marked.

The backgrounds are loaded using a _.res_ file with the definition of both images:

```res
IMAGE bg_color1 "gfx/fondocolor1.png" NONE
IMAGE bg_prio "gfx/fondocolor2.png" NONE
```

In the source code, you can find the function ```drawPriorityMap```, which will draw in the background A the priority map, starting from the second image. It receives the image containing the priorities by parameter; let's see a fragment with the function:

```c
    u16 tilemap_buff[MAXTILES];
    u16* priority_map_pointer=
        &tilemap_buff[0];

    for(int j=0;j<MAXTILES;j++)
        tilemap_buff[j]=0;

    u16 *shadow_tilemap = bg_map->
          tilemap->tilemap;
    u16 numTiles = MAXTILES;
    while(numTiles--){
        if(*shadow_tilemap){
            *priority_map_pointer |= 
                TILE_ATTR_PRIORITY_MASK;
        }
        priority_map_pointer++;
        shadow_tilemap++;
    }
    VDP_setTileMapDataRectEx(BG_A,
    &tilemap_buff[0],0,0,0,
    MAP_WITH,MAP_HEIGHT,MAP_WITH,CPU);
```

First of all, we can observe how a buffer is initialized to empty, which we will use to draw the image; subsequently, we will go through each Tile of the priority map, and compare it with a special mask.

The ```TILE_ATTR_PRIORITY_MASK```; mask allows to store in each Tile, only the priority information, so that nothing will be displayed on the screen; this is important to be able to display the background with the different effects.

Once the priority map has been filled in, it is painted in plane A, using the function ```VDP_setTileMapDataRectExRectEx```; which will allow us to draw a rectangle as a Tiles map per screen.

After having drawn this map, we can draw the other background in the way we already know; but without priority:

```c
VDP_drawImageEx(BG_B, &bg_color1,
    TILE_ATTR_FULL(PAL0,FALSE,FALSE,
    FALSE,index),0,0,TRUE,CPU);
```

We see how this image is drawn in plane B without priority and we use palette 0 (```PAL0```).

Also in this case, we are going to show a Sprite that we will draw without priority, and that we can move to the left or to the right. Which we draw without priority, and we will use Palette 1.

```c
 zera = SPR_addSprite(&zera_spr,
        zera_x,
        zera_y,
        TILE_ATTR(PAL1,FALSE,FALSE,FALSE));
```

Finally and most important, we have to activate the Shadow HighLight mode; using the ```VDP_setHilightShadow``` function, setting the value to 1.

```c
    VDP_setHilightShadow(1);
```

If everything went fine, we can see an image similar to this one:

![Example 8: Colors and Shadow](11colors/img/ej8.png "Example 8: Colors and Shadow")
_Example 8: Colors and Shadow_

As we can see in the image, in each streetlight a part is shown illuminated; this is because these areas are painting Tiles with Priority; so they are shown in a normal way; the rest of Tiles that do not have priority are shown in Shadow mode. With this, we confirm that the behavior with the planes, is as we have mentioned previously.

We also see that at the Sprite level, if we move our character, it is also affected by the Shadow mode; in this way we can give the sensation of a lighting that is affected by our character. Obviously, we can also work with HighLight mode, using Palette 3, and playing with colors 14 and 15.

With this example, we have already seen how the color palettes and the Shadow and HighLight modes work.

## References

* Mega Drive Color Palette: [https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB](https://en.wikipedia.org/wiki/List_of_monochrome_and_RGB_color_formats#9-bit_RGB)
* Danibus (Aventuras en Mega Drive)(Spanish): [https://danibus.wordpress.com/2019/09/13/14-aventuras-en-megadrive-highlight-and-shadow/](https://danibus.wordpress.com/2019/09/13/14-aventuras-en-megadrive-highlight-and-shadow/)
* Open Game Art (Night Background): [https://opengameart.org/content/background-night](https://opengameart.org/content/background-night)
* Open Game Art (Nature TileSet): [https://opengameart.org/content/nature-tileset](https://opengameart.org/content/nature-tileset)
