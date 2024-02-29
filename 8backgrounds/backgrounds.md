# 8. Backgrounds

We have already been able to start to see our first games; but we are missing the ability to see more color and to play with the different features offered by the Sega Mega Drive.

One of the most significant sections when working with games, are the backgrounds. These backgrounds are images that we can superimpose, in order to give a sense of depth. Sega Mega Drive, allows to work with several backgrounds (or planes), in such a way that we can give them movement or a greater interaction.

In this chapter, we will focus on the use of backgrounds or plans, through SGDK and the use of tools to manage these backgrounds, such as the _rescomp_ tool.

We will start by talking about how the Sega Mega Drive handles images or graphics, and we will explain the different concepts related to backgrounds.

## Images in Sega Mega Drive

First of all, before going into more advanced concepts, we are going to study how the images or graphics are managed in the Sega Mega Drive; through the VDP.

Let's see the features of the graphics for Sega Mega Drive:

* Any graphic or image is drawn divided by Tiles[^50], of a size of 8x8 pixels.
* Only 4096 Tiles can be stored (64Kb of VRAM).
* The images are stored in indexed format [^51] not as RGB [^52].
* Only 4 palettes of 16 colors each can be stored in CRAM.
* Usually, only 61 colors can be displayed on the screen (61 colors and 3 transparent).
* In each palette, the first color is considered transparent. Except the First palette that the first color is used as background.

[^50]:A Tile is a fragment of an image that is displayed as a mosaic; thus an image is composed of a series of Tiles.
[^51]: An image in indexed format stores a palette with the different colors it contains; each pixel then only has information about the color it represents in that palette.
[^52]: RGB (Red Green Blue) is a format that is defined in each pixel to store the color red, green and blue in such a way that each color can be seen by combining these three.

It is important to know these features when working with images in Mega Drive, in order not to lose quality or any color if the palette is not well referenced.

In addition, we could see that only 61 colors can be displayed on the screen. This is due to the transparent colors of each of the palettes; except for the first palette (_palette 0_), which is considered the background color.

All this information, from the palettes and the different Tiles to be displayed, are stored in the VRAM (and CRAM) and are accessible by the VDP; so that in some occasions thanks to the use of the DMA, the CPU does not need to work with it; but the VDP itself performs all the work more efficiently.

If you need to know the different colors and palettes that are stored; we can use some tools that bring us emulators such as _Blastem_; pressing the <kbd>c</kbd> key, we can see the contents of the palettes of the VDP.

![Blastem VDP Viewer](8backgrounds/img/blastem.png "Blastem VDP Viewer")
_Blastem VDP Viewer_

Later, we will see how to import images and graphics for our game using SGDK's _rescomp_ tool.

## Backgrounds

As we have already mentioned, an important part is the use of backgrounds or planes as they are also known; Sega Mega Drive allows working with 2 backgrounds at the same time, so that these two backgrounds are always painted at the same time.

A background is nothing more than a set of Tiles that are stored in the video memory; normally in each background an index that points to a Tile in the video memory is established in each Tile; this is known as Map and the set of Tiles stored in the memory is known as TileSet. Later, we will talk about Tilesets and how they can be used.

In this section, we will only talk about backgrounds and how we can use them for our games in a static way.

It is important to know that a background is drawn from top to bottom and from left to right. So, it is easier to work with them. In addition, we cannot forget that backgrounds work at the tile level, not at the pixel level.

Finally, although the Sega Mega Drive has a screen resolution of 320x240 (320x224 NTSC) which corresponds to 40x30 tiles in PAL, you can store more Tiles per background so that we can store up to 64x32 Tiles; so that we could use this extra Tiles for scrolling; that we will see in more detail in a next chapter.

### Background A, B and Window

As we have mentioned, Sega Mega Drive has 2 backgrounds available to work with (apart from the one in charge of the Sprites).

* **Background A**; allows you to draw a complete background.
* **Background B**; allows you to draw a complete background.
* **Window**; is a special plane, which allows writing inside Background A, the Window Background, has a different scroll than Background A and is therefore often used to display e.g. the user interface.

![Gens Kmod Plane Viewer](8backgrounds/img/planeExplorer.png "Gens Kmod Plane Viewer")
_Gens Kmod Plane Viewer_

In the previous image, we can see the _Gens KMod_ background viewer, where we can visualize each background to see how it is drawn.

In addition, the backgrounds A, B and the Sprite plane (which we will see in the next chapter), have different priority; in such a way that we can give this priority to each background giving the sensation of depth.

![Background Priority Schema](8backgrounds/img/esquemaplanos.png "Background Priority Schema")
_Background Priority Schema_

As we can see in the previous image, backgrounds A, B and Sprite can have a low or high priority. In such a way, that we can play indistinctly with them, to be able to show them in different places and be able to show that sensation of depth.

## Rescomp

In order to import the different resources for our game, it is necessary to use a tool that is included in the SGDK itself. This tool is called _rescomp_ "Resource Compiler"; which will allow to import the resources generating all the necessary to be able to use it through the SGDK itself.

This tool generates everything needed to import the different types of resources of our game (graphics, sprites, music, sound, binary...). It is based on the use of files that describe each resource; these files with extension _.res_, include all the description of the resources to import.

Rescomp, reads these files and will generate one or more .s files with the resource information and if not otherwise indicated, a c _.h_ header file. Let's see how to use it.

```bash
rescomp file.res [out.s] [-noheader]
```

We note that several parameters are received:

* _file.res_: Resources File Name.
* _out.s (optional)_: .s result file. If not specified, an .s file is generated with the name of the resource to be imported.
* _-noheader_: indicates that a C _.h_ header file will not be generated.

We can import the following resource types:

* _BITMAP_: BitMap.
* _PALETTE_: Color Palette.
* _TILEMAP_: TileMap (from SGDK version 1.80 or above).
* _TILESET_: Tileset; contains a set of tiles that can be used to generate images or sprites.
* _MAP_: Map type resource; contains a palette, a tileset and the map information (from SGDK Version 1.60 or above).
* _IMAGE_: Image type resource; contains a palette, a tileset and a tilemap.
* _SPRITE_: Sprite type resource; used to control Sprites and animations.
* _XGM_: Music resource using XGM (.vgm or .xgm).
* _XGM2_: Music resource using new sound driver XGM2.
* _WAV_: Sound resource.
* _OBJECTS_: Objects with information from a Tiled .tmx file. We will see it in chapter 12.
* _BIN_: Information stored in binary format.

Over the next few chapters, we will look at each of these resources and how they are used. In this chapter, we will focus on the use of palette and images as a resource.

Let's look at an example of a resource definition:

```res
TILESET moontlset "moontlset.png" 0
PALETTE moontlset_pal "moontlset.png" 0
```

In the example above, we can see how resources are defined as TileSet and as Palette.

**NOTE**: If you use the _Genesis Code_ extension, it includes an editor with context-sensitive help when using _.res_ files.

Finally, it is important to know, that if we use the _makefile_ file that SGDK brings by default, Rescomp is automatically called when a .res file is added (it must be inserted in the _res_ folder); so it is not necessary for us to call it. Also, if you need more information about Rescomp, you can find the documentation for it in the SGDK itself:

[https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt](https://github.com/Stephane-D/SGDK/blob/master/bin/rescomp.txt)

### Images and backgrounds using Recomp

As we have seen, you can import either Palettes, images or resources. Let's see what options and how to define Palette and Image resources.

#### Palettes

A palette is the information of the 16 colors that we can store for use in the different graphics. It is important, that every image we use for SGDK, must be stored as a 4 or 8 bpp indexing.

**NOTE**: From version 1.80 or later, you can use RGB images with additional information for the palette. Simply add in the first pixels a sample of the palette to be used. For more information, see the SGDK documentation.

To define a palette resource for rescomp; the following syntax is used:

```res
PALETTE pal1 "image.png"
```

Where:

* _pal1_: Name of the resource to be referenced.
* _"image.png"_: Name of the image with the palette information. It can be a bmp, png or .pal file.

#### Image

An image for SGDK contains a tileset, a palette and a tilemap of an static image. Let's see an example of the options available to define an image resource in rescomp:

```res
IMAGE img1 "img_file" BEST NONE [mapbase]
```

Where:

* _img1_: Resource Name.
* _"Img_file"_: File of the image to import. It must be an indexed image file in bmp or png format.
* _BEST_: Indicates the compression algorithm to be used; it can have the following values:
    * -1/BEST/AUTO: Best Compression
    * 0/NONE: No compression.
    * 1/APLIB: aplib algorithm (good compression, but slower).
    * 2/FAST/LZ4W: LZ4 algorithm (less compression, but faster).
* _NONE_: Indicates the optimization that can be performed when importing the image. It can take the following values:
    * 0/NONE: No Optimization.
    * 1/ALL: Removes duplicate and mirrored tiles.
    * 2/DUPLICATE: Removes only duplicate tiles.
* _mapbase_: Define the default values such as priority, default palette to use (PAL0, PAL1, PAL2, PAL3), etc...

## Background Example

Once we have seen how the images are treated and how to import them using the rescomp tool; now we are going to see an example of how to use these images, taking advantage of the two available backgrounds and seeing their use in different priorities.

This example, we can see it in the repository of examples that accompanies this book, with the name of _ej5.backgrounds_; which we can observe, that we are going to show 2 backgrounds as the following ones:

![Example Backgrounds](8backgrounds/img/fondosejemplo.png "Example Backgrounds")_Example Backgrounds (Source: OpenGameArt)_

As we can see in the previous figure, we have 2 images; the first one a blue background that mimics the sky; and the second one a background of yellow tiles with a black background.

Let's focus on the second image; in which we see that black background. This background will be transparent, since it will be the first color of the palette of this image.

**NOTE**: If we use the _Genesis Code_ extension, we can see the palette of that image. If it is not displayed, you can right click on the image title and click the _reopen With..._ option.

![Image 2 Details](8backgrounds/img/bgbdetails.png "Image 2 Details")
_Image 2 Details_

We can see in the previous image that the palette's first color is black and that it is a 16-color image. This detail is important, since it will be used as a transparent color.

Once we have the two images, we are going to focus on importing both images using the _rescomp_ tool. Therefore we have to define a _.res_ file with the following content:

```res
IMAGE bg_a "gfx/bga.bmp" NONE 
IMAGE bg_b "gfx/bgb.bmp" NONE
```

We can see that we have created 2 resources of type ``IMAGE``; which do not have any compression. If we compile now our project manually, or using the Genesis Code command, _Genesis Code: Compile Project_; we will see that a _.h_ file will be generated. This file will be used to reference the generated resources.

Once we have seen how these resources have been imported, let's focus on the code; which we can see the source code:

```c
#include <genesis.h>

#include "gfx.h"

int main()
{
    VDP_setScreenWidth320();    
    u16 ind = TILE_USER_INDEX;
    VDP_drawImageEx(BG_B,&bg_a,
    TILE_ATTR_FULL(PAL0,FALSE,FALSE,FALSE
        ,ind),0,0,TRUE,CPU);
    ind+=bg_a.tileset->numTile;
    VDP_drawImageEx(BG_A,&bg_b,
    TILE_ATTR_FULL(PAL1,FALSE,FALSE,FALSE
        ,ind),0,0,TRUE,CPU);
    ind+=bg_b.tileset->numTile;
    while(1)
    {
        //For versions prior to SGDK 1.60
        // use VDP_waitVSync instead.
        SYS_doVBlankProcess();
    }
    return (0);
}
```

Let's see in detail the previous example; first, we include the «LibMD» library header, followed by the header of the resources generated with rescomp. In addition, we can observe the call to a function ```VDP_setScreenWidth320```; which sets the horizontal resolution to 320px (by default it is this resolution).

Next, we can observe that the value of ```TILE_USER_INDEX``` is saved in a variable; this constant will indicate the index to the video memory where the tiles are stored can be accessed. This is important not to show tiles that we don't need at that moment or empty memory areas that can give error; since the first positions of the video memory, SGDK uses them to initialize the palettes etc...

**NOTE**: If you use a version of SGDK lower than 1.80, you must use the constant ```TILE_USERINDEX```.

Next, we can see the call to the function ```VDP_drawImageEx```; which will allow us to draw an image inside a background; let's see what are the parameters of this function:

* _plane_: Plane to be used; it can have the values ```BG_A```, ```BG_B``` or ```WINDOW```; to indicate the plane to use (for versions prior to SGDK 1.60, use ```PLAN_A```, ```PLAN_B```).
* _image_: Memory address where the image resource to be used is located; the & operator can be used together with the name we have given to the resource when defining it in rescomp.
* _TileBase_: Indicates the base Tile by which the image will be loaded. This will be done through the macro ```TILE_ATTR_FULL```; we will see the details of this macro later.
* _X_: X position in Tiles.
* _Y_: Y position in Tiles.
* _loadPal_: indicates whether the palette will be loaded or not.
* _dma_: Indicates whether dma or CPU will be used. This is important since the use of DMA, avoids the CPU having to work to pass the information from the ROM to the VRAM. Therefore you can set the value to ```DMA``` to use the dma, or ```CPU``` to use the CPU itself; keep in mind that both the CPU and the DMA use the same bus and there may be bottlenecks when passing data from ROM to RAM or VRAM.

We have seen that to define the base Tile to load the image, you can use the macro ```TILE_ATTR_FULL```; which receives the following parameters:

* PalIndex: Index of the palette to be used. It can be ```PAL0```, ```PAL2```, ```PAL2```, ```PAL3```. To indicate the 4 available palettes.
* Priority: Indicates the priority by which it will be loaded. ```TRUE``` for high priority, or ```FALSE```; for low priority.
* VFLIP: Vertical Mirroring. Indicates whether it will be vertically mirrored (```TRUE``` for mirrored or ```FALSE``` otherwise).
* HFLIP: Horizontal Mirroring. Indicates whether it will be horizontally mirrored  (```TRUE``` for mirrored or ```FALSE``` otherwise).
* index: Indicates the index to be stored in the video memory. The index variable will be used to store it in memory.

As we can see in the example, we can see that the resource called bg_a is loaded in Plane B and that it will be saved in the ```PAL0``` palette; that is, the first available palette. In addition, it will be with low priority; and it will be loaded using CPU and not DMA.

Then we see the following line:

```c
ind+=bg_a.tileset->numTile;
```

Indicating that the index to be used to save in the video memory, the value is incremented until the end of the tiles contained in the image. This is important in order not to overwrite the video memory. Next we see the second call:

```c
VDP_drawImageEx(BG_A,&bg_b,
TILE_ATTR_FULL(PAL1,FALSE,FALSE,FALSE
,ind),0,0,TRUE,CPU);
```

Which indicates that the second image will be loaded in Plane A and with low priority, it will be painted on top of the previous plane according to the priority scheme. In addition, we can see that palette 1 will be loaded, and that the CPU will be used to load it.

Finally, we can see that the index is incremented again to store in video memory for other images later. In addition to the call to the function ```SYS_doVBlankProcess```; to wait for the screen to finish painting.

If we compile and run the example, we can see the following:

![Example 5: Backgrounds](8backgrounds/img/ej5.png "Example 5: Backgrounds")
_Example 5: Backgrounds_

With this example, we can now see how to load images using Recomp, and draw them on the different planes or backgrounds available. In the following chapters, we will see more uses of backgrounds and how we can use more functionalities provided by SGDK.

## References

* SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* Danibus (Aventuras en Mega Drive)(Spanish): [https://danibus.wordpress.com/](https://danibus.wordpress.com/).
* Ohsat Games: [https://www.ohsat.com/tutorial/mdmisc/creating-graphics-for-md/](https://www.ohsat.com/tutorial/mdmisc/creating-graphics-for-md/).
* Mega Drive Software Manual [PDF]: [https://segaretro.org/images/a/a2/Genesis_Software_Manual.pdf](https://segaretro.org/images/a/a2/Genesis_Software_Manual.pdf).
