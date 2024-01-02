# 13. Scroll

Until now, we have been working with backgrounds and images that take up the entire width of the screen; but what if an image is larger than the screen allows; and if our scenery is changing as our character or characters move, in these cases we use Scroll.

A scroll is nothing more than the possibility of moving the elements of a background in one direction; in such a way that we can give the sensation of movement.

In this chapter, we are going to show how to use the scrolling capabilities of the Mega Drive, thanks to the VDP chip.

We will see the different types of Scroll that there are, and we will also see in which directions we can do it.

In addition, we will see the different examples, with different use cases with the Scroll.

## Scrolling

As we have already mentioned, scrolling is the ability to move parts of the image we are displaying; in the case of the Sega Mega Drive, it is the ability to move the tiles of each plane in different directions.

The VDP; allows different types of displacement of the two planes (A and B); either depending on the direction (Horizontal or vertical) or the portion of the screen (per line or per column); this allows different effects and give a better sense of movement. This effect is commonly known as _Parallax_.

We can differentiate the Scroll by direction, which can be of two types:

* _Horizontal_: when scrolling from right to left or vice versa.
* _Vertical_: when scrolling from top to bottom or vice versa.

Also, depending on the portion of screen scrolled, we can find three types:

* _Line_: The VDP can scroll horizontally up to 224 lines; vertically, however, it is capable of scrolling some portions.
* _Plane_: The VDP allows a complete plane to be moved both horizontally and vertically.
* _Tile_: It is possible to scroll the different Tiles of a line.

In this section, we will focus on these types of Scroll and see how it can be performed in each of the proposed directions.

### Line Scroll

We will start by talking about line scrolling; in this case we can scroll up to 240 lines per screen horizontally; one per pixel (224 in NTSC). In such a way that we can scroll different portions of the screen independently. This is done by the VDP chip itself, thanks to the scrolling table stored in VRAM.

Each of the 224 lines stores a fragment of the plan that can be shifted to the right or left so that the direction can be changed if necessary. It is not possible to scroll for each column, although it can be done for every 2 Tiles.

We remind you that this can be done in each of the two available plans.

### Plane Scroll

On the other hand, a complete plane can also be scrolled; for example, because a plane can be scrolled from top to bottom and from right to left; in such a way that we can have images or maps larger than what is allowed on the screen (320x240 or 320x224).

This is due to the fact that the VDP, allows to store planes of greater capacity than the screen; to be able to carry out this displacement. For a better understanding, let's see a scheme.

![Scroll Scheme](13Scroll/img/esquemascroll.png "Scroll Scheme")
_Scroll Scheme_

As we can see in the diagram, the visible part is for example only 320px wide; and SGDK, reserves up to 640px wide to be able to store the rest of the image; whatever is left of the image will still be stored in the ROM and will have to be moved to the hidden part to be able to perform a scroll.

A 512x256px plane is allowed with the usual configuration, so we can store more image than visible, and then move it both horizontally and vertically.

### Tile Scroll

The same as the displacement by lines, it can be done by Tiles; depending on whether it is a horizontal or vertical displacement, we can perform different Tiles movements.

In the case of horizontal movement, it can be done for each Tile; however, for vertical movement, it must be done for every 2 Tiles; therefore, it can be done for 20 columns of 2 Tiles each.

All displacement information, both vertical and horizontal, is stored in the VRAM and is accessible by the VDP.

## Example using Scroll

We have seen the theory of how to scroll by line, plane or Tiles; so in order to better understand how these scrolls are performed, let's see three examples:

* Example of displacement by lines; let's see how to deform a logo to make an effect using displacement.
* Example of plane displacement; in this case, we are going to perform the famous paralax effect so that we can see how the plane is displaced to show a larger map.
* Example of displacement by Tiles; in this last example, we are going to see how using 1 Tile and a Tilemap, we can generate a rain effect, using displacement by Tiles.
* Example of plane displacement but using the new Structure called Map.

Remember that all the examples mentioned in this book are available in the Github repository that accompanies this book; here is the address:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

### Line Scrolling

In this first example, we are going to focus on scrolling by lines; remember that we can scroll the 224 horizontal lines that we have available. This example corresponds to the folder _ej11.linescroll_; that you will find in the examples repository.

For this example, we will use an image with a logo that reminds us the Sonic home screen; this is the image.

![Example Image](13Scroll/img/logo.png "Example Image")
_Example Image_

What we are going to do is to make a displacement of each line; the even lines will go to one side, and the odd ones to the other. Let's see how we can do it.

First, we need to draw the image on the Background to be used:

```c
VDP_drawImageEx(BG_B,&logo,
    TILE_ATTR_FULL(PAL0,FALSE,
     FALSE,FALSE,index)
    ,0,0,TRUE,DMA);
```

Once drawn, we are going to configure what type of Scroll we are going to use both horizontally and vertically; for it, we will use the function ```VDP_setScrollingMode``; which allows to configure what type or mode of Scroll we will use; let's see what parameters this function receives:

* _HScrollMode_: Mode to be used for horizontal scrolling. It can take the following values:
    * ```HSCROLL_LINE```: The horizontal Line Scroll will be used.
    * ```HSCROLL_PLANE```: The Plane Scroll will be used.
    * ```HSCROLL_TILE```: The Tile Scroll will be used.
* _VScrollMode_: Mode to be used for vertical Scroll. It can take the following values:
    * ```VSCROLL_PLANE```: Indica que se realizará un desplazamiento vertical por plano.
    * ```VSCROLL_COLUMN```: Indicates that a vertical scrolling will be performed for every 2 Tile (By columns); for versions prior to SGDK 1.90, use ```VSCROLL_2TILES```.

Remember that in this case, we are going to scroll per line horizontally, so we will have to configure the Scroll as follows:

```c
VDP_setScrollingMode(
    HSCROLL_LINE,VSCROLL_PLANE);
```

Once configured, we are going to load the offsets that each line will have so we will need one variable per line; so we will create an array to store all the offsets.

```c
s16 lines[224];
```

This array we initialize it to zero; so all the positions have value; and later it is when we give values to each position; for the even lines the displacement is increased, and for the odd ones it is decreased. This will allow us, to give a sensation of movement and to create a deformation of the logo.

```c
for(i=84;i<121;i+=2){
    lines[i]+=2;
}

for(i=85;i<120;i+=2){
    lines[i]-=2;
}
```

Finally, the only thing left to do is to move the lines:

```c
VDP_setHorizontalScrollLine(BG_B,0,lines
    ,224,DMA_QUEUE);
```

This function named ```VDP_setHorizontalScrollLine``` allows to perform line scrolling of a plane fragment. It receives the following parameters:

* _plane_: Background To use; it can be ```BG_A``` or ```BG_B```.
* _firstLine_: First line to be changed.
* _lines_: scrolling information for each line to be scrolled.
* _nLines_: Number of lines to move.
* _tm_: Transfer method; allows to use the CPU, or the different DMA values; it can have the following values:
    * CPU: CPU is used.
    * DMA: DMA is used.
    * DMA_QUEUE: DMA queue is used.
    * DMA_QUEUE_COPY: DMA Copy queue is used.

You may have seen that we are sending information of each of the lines; whether they move or not; this is not the most efficient; since we can create an array only with the information of the lines to be moved. In such a way it will be more efficient and less resource consuming for the hardware.

Once we have been able to explain the code and how this example works, we can now compile and run, so that we can see in an emulator how this effect looks like.

![Example 11: Line Scroll](13Scroll/img/ej11.png "Example 11: Line Scroll")
_Example 11: Line Scroll_

### Plane Scrolling

We have been able to see the scrolling by lines; but in many occasions, we need to scroll the plane because it can be bigger than what we show on the screen; in addition, the image to show may be that a scenario is much bigger than what can be stored in a plane.

We remember that the VDP, allows to store a plane of up to 512x256px; but in ROM, it is possible to store much bigger information. In this aspect, we are going to show a much larger image, and it will scroll as we need it.

This example can be found in the examples repository under the name _ej12.planescroll_; in this case, we will use a fixed plane, and a second plane, which we will scroll horizontally when necessary.

In this example, we will not only move the plane; we will generate the needed Tiles as necessary so that we will discover the scenery little by little. Let's see the images that we will use as planes.

The foreground, which we will use as the sky; it is a static image that we will draw in plane B.

<div class="centered_image">
<img src="13Scroll/img/Sky_pale.png" title="Background Image 1" alt="Background Image 1"/>
<em>Background Image 1 (Open Game Art)</em>
</div>

Then, we will have the background that we will be moving; which is an image of 640x224 pixels; that we will store in ROM memory and that we will be showing as needed.

![Background Image 2](13Scroll/img/map1.png "Background Image 2")
_Background Image 2 (Open Game Art)_

As we can see in the previous image, the red background color will be the transparent color (it is the first color of the color palette). With these two backgrounds and one Sprite, is what we are going to work with.

Once we have the images, let's review the code; which we have decided to divide into three parts; the main function, the control handling function and finally a function to update the screen when needed.

We will start by talking about the main function; where we will initialize all the global variables and draw the backgrounds. Let's see a fragment:

```c
struct{
    Sprite* elliSprt;
    u16 x;
    u16 y;
    u16 offset;
}player;

u16 xord;
u16 countpixel;
u16 col_update;
u16 ind;
```

We see that a number of global variables are initialized; let's show their utility:

* A Struct called _player_, with information about the player; such as the Sprite to use, x, y and the offset to move.
* _xord_: Indicates whether it needs to be scrolled or not.
* _countpixel_: This variable will help us to generate a new Tile when necessary; remember that the movement of the Sprites is at pixel level, while the backgrounds are at Tiles level.
* _col_update_: Indicates whether a column needs to be updated or not; it will be necessary to generate a new column.
* _ind_: Index to calculate the Tiles to be stored in VRAM.

With these variables, we are going to perform the scrolling; but first we will draw both planes, and draw the necessary Sprites.

```c
SPR_init();
ind = TILE_USER_INDEX;
VDP_drawImageEx(BG_B,&sky,
    TILE_ATTR_FULL(PAL0,FALSE,
    FALSE,FALSE,ind)
        ,0,0,TRUE,CPU);
ind+= sky.tileset->numTile;
VDP_drawImageEx(BG_A,&map1,
    TILE_ATTR_FULL(PAL1,FALSE,
        FALSE,FALSE,ind),
        0,0,TRUE,CPU);
player.elliSprt=SPR_addSprite(&elli,
    20,135,
    TILE_ATTR(PAL2,FALSE,FALSE,FALSE));
SPR_setAnim(player.elliSprt,IDLE);
PAL_setPalette(PAL2,elli.palette->data,CPU);
```

Once the screen and the Sprites have been drawn, we will go on to configure the Scroll mode:

```c
 VDP_setScrollingMode(
    HSCROLL_PLANE,VSCROLL_PLANE);
```

As we can see in the previous fragment, we will configure both horizontal and vertical scroll as Plane scrolling. Then inside the game loop, we will call the rest of the functions and the Sprite table will be updated.

Let's see how the rest of the functions work; as in the case of the function ```void inputHandle()```, that manages the input of the buttons. In this case, the idea is that when the character moves to the right and reaches a certain point, it moves and can advance through the stage; however in this case we will only implement the displacement to the left so if the Sprite moves in the opposite direction it will not advance.

Let's see a function's fragment:

```c
 if(value & BUTTON_RIGHT){
    SPR_setAnim(player.elliSprt, RIGTH);
        if(player.x>220){
        xord=1;
    }else{
        player.x+=2;
        xord=0;
    } 
 }
```

In this fragment, we can see that if the right button has been pressed and the character is more than 220 pixels to the right, the ```xord``` variable will be set to 1; indicating that there will be a displacement. Besides that the animation of the Sprite will be updated.

Otherwise, the ```xord``` variable will be set to zero indicating that there is no displacement; in addition to updating the position and animation of the Sprite.

Let's look at the next function; it is the ```void updatePhisics()``` function, which will update everything needed to perform the scrolling. Let's see a Fragment:

```c
SPR_setPosition(player.elliSprt
    ,player.x,player.y);
if(xord>0){
    player.offset+=2;
    countpixel++;
    if(countpixel>7) countpixel=0;
}
```

In this case, we see if the variable ```xord``` is greater than zero, the offset and the pixel counter will be updated; so if the counter is greater than 7, a new Tile will need to be calculated. Let's look at one last fragment to see how we generate such a Tile at the end of the plane.

```c
if(player.offset>640) player.offset=0;
    if(countpixel==0){
        col_update=(((player.offset+320)
                >>3)&79);
        VDP_setMapEx(BG_A,map1.tilemap,
        TILE_ATTR_FULL(PAL1,FALSE,FALSE,
            FALSE,ind),col_update,0,
            col_update,0,1,28);
    }
    VDP_setHorizontalScroll(BG_A,-player.offset);
```

We see how at the beginning, it is checked that the offset is not greater than the size of the plane. If this happens, the offset is initialized again to zero to give a sense of infinity. Once this is done, we will check that ```countpixel```, is zero; if so, the column to update will be calculated; let's see this formula:

```c
col_update=(((player.offset+320)>>3)&79);
```

In this case the offset is calculated by adding 320 and making a shift to the right of 3 positions (which will be the same as dividing by 8; but more efficient since the division operation in the Motorola 68000, can last up to 158 cycles). Finally, a new column will be generated at the end of the Plane; let's see that fragment:

```c
VDP_setMapEx(BG_A,map1.tilemap,
    TILE_ATTR_FULL(PAL1,FALSE,FALSE,
        FALSE,ind),col_update,0,
        col_update,0,1,28);
```

We see that the function ```VDP_setMapEx``` is called, which allows to update a fragment of the map and place a new fragment using the TileMap of the image itself. Let's see the parameters of this function:

* _plane_: Background to be updated can be ```BG_A``` or ```BG_B```.
* _TileMap_: Tilemap Information Pointer.
* _baseTile_: Tile Base; The macro ```TILE_ATTR_FULL``` can be used to generate this information.
* _x_: X position in Tiles.
* _y_: Y Position in Tiles.
* _xm_: TileMap X Position.
* _ym_: TileMap Y Position.
* _wm_: TileMap's width in Tiles.
* _hm_: TileMap's height in Tiles.

Finally, for this example, we are going to perform the scrolling itself. we will use the function ```VDP_setHorizontalScroll```; which performs a horizontal scroll of the plane; it receives the following parameters:

* _plane_: Background to be Updated can be ```BG_A``` or ```BG_B```.
* _offset_: offset applied.

After seeing the last function, we can now compile and execute the example in such a way that we can see, if we push right and the character reaches a certain point, the plane scrolling is performed.

![Example 12: Plane Scrolling](13Scroll/img/ej12.png "Example 12: Plane Scrolling")
_Example 12: Plane Scrolling_

### Tile Scrolling

There is still a Scroll mode to see; this is the ability to scroll the plane at the Tile level; this can be useful to create different effects and give a better experience to the player. Let's see, for example, how to make a rain effect, using Tile scrolling. In this case, we are going to use the example found in the examples repository; inside the folder named _ej13.tilescroll_. In this example, we are going to create a rain effect, using a TileMap and scrolling 2 Tiles vertically.

First, we are going to use a background, and a TileMap that we will generate from a small TileSet; so we will import each resource using _rescomp_ with the information of the resources to import:

```res
PALETTE rainplt "rain.png"
TILESET rain "rain.png" NONE NONE
IMAGE city "city3.png" NONE NONE
```

We see that we import an image, a tileSet and the corresponding palette. The background to be used is a city at night; we show the background image.

<div class="centered_image">
<img src="13Scroll/img/city3.png" title="Example 13 Background" alt="Example 13 Background"/>
<em>Example 13 Background (Open Game Art)</em>
</div>

Once we have seen this image, let's review the source code; we will start by seeing how to draw each background; one as an image, and the other one we will use the TileSet _rain_, to generate a TileMap and simulate the rain. Let's see a fragment:

```c
 u16 ind = TILE_USER_INDEX;
VDP_loadTileSet(&rain,ind,DMA);
PAL_setPalette(PAL1,rainplt.data,CPU);
u16 tileMap[2048];
int i;
for(i=0;i<2048;i++){
    tileMap[i]=TILE_ATTR_FULL(
        PAL1,FALSE,
        FALSE,FALSE,ind);
}
VDP_setTileMapDataRect(BG_A,tileMap,
0,0,40,32,40,DMA_QUEUE);
```

As you can see, we create a TileMap from Tiles; that compose the TileSet we have loaded; and we draw the screen, using a rectangle of 40x32 Tiles (All the available space at the top). Once the TileMap is loaded in the background A, we will draw the image in the background B; both with low priority; so the background B will be behind the background A; giving sensation of depth.

```c
VDP_drawImageEx(BG_B,&city,
    TILE_ATTR_FULL(PAL0,FALSE,
        FALSE,FALSE,ind),0,0,TRUE,CPU);
```

After having drawn both backgrounds, the only thing left to do is to perform the scrolling; so we will set the Scroll mode.

```c
VDP_setScrollingMode(
    HSCROLL_PLANE,VSCROLL_COLUMN);  
```

For versions lower than SGDK 1.90:

```c
VDP_setScrollingMode(
    HSCROLL_PLANE,VSCROLL_2TILE);  
```

We have configured the horizontal scroll, as of flat type (in this example we will not scroll horizontally); and the vertical scroll as ```VSCROLL_COLUMN``` which indicates that it is made scroll every 2 Tiles; since in Mega Drive it is not possible to make vertical scroll of only 1 Tile.

**NOTE:** For versions prior to SGDK 1.90, ```VSCROLL_2TILE``` must be used.

Once configured, we will load a vector with the Displacement values:

```c
s16 scrollVector[20];
  
for(i=0;i<20;i++){
    scrollVector[i]=0;
}
```

This array of 20 positions, (1 per displaced column), will allow us to load the value that will be displacing each of the columns. Once loaded, we will pass to carry out inside the loop of the game, the displacement.

```c
while(1)
    {
        for(i=0;i<20;i++){
            scrollVector[i]-=5;
        }
        VDP_setVerticalScrollTile(BG_A,
            0,scrollVector,20,CPU);
        SYS_doVBlankProcess();
    }
```

You will see that a displacement is made every 5 units; that will be the number of Tiles that will be displaced by each section; in addition we see that we use the function ```VDP_setVerticalScrollTile```; it is the one that makes the displacement. This function receives the following parameters:

* _plane_: Background to displace the Tiles; it can be  ```BG_A``` or ```BG_B```.
* _firstcol_: First column to be scrolled.
* _scroll_: Array with the values to be moved.
* ncols: Number of columns to move.
* _tm_: transfer method; it allows using the CPU, or the different DMA values; it can have the following values:
    * CPU: CPU is used.
    * DMA: DMA is used.
    * DMA_QUEUE: DMA queue is used.
    * DMA_QUEUE_COPY: DMA Copy queue is used.

After reviewing the functions and verifying that the code is correct, we can compile and execute this example. You will be able to see how the rain is moving over the city; although in this case we are moving all the positions at the same time, and it can give the sensation of displacement of plane, we can change these values and make more tests to verify its use.

![Example 13](13Scroll/img/ej13.png "Example 13")
_Example 13: Tile Scrolling_

### Scroll using MAP

There is still a way to scroll; as you may have seen, in the example of scrolling by plane, it is quite complicated to calculate the next Tile to be displayed; therefore, alternative functions can be used, thanks to the ```Map``` structure.

This structure was added in SGDK version 1.60; therefore, this example can only be used in that version or higher; a Map is a structure that stores a large amount of information about an image or scenario; therefore, using this type of functions we have to be careful not to bottleneck the CPU or DMA.

For this example, we will reuse example 12 to move a plane, but we will modify it to use Map, instead of moving it ourselves.

Let's start by showing how we are going to import the resources; since they will no longer be two images; but instead an image, a Tileset, a palette and finally a Map will be used.

```res
PALETTE pltmap "map1.png"
TILESET map_tileset "map1.png" NONE ALL
MAP map1 "map1.png" map_tileset NONE 0 
IMAGE sky "Sky_pale.png" NONE 
```

As we can see, we load a palette, a Tileset and a Map from the image we want to display. Let's see how to import a Map resource:

```
MAP name "file" tileset-ref compression offset
```

* _name_: Resource's Name
* _file_: File to be loaded; it can be an image, or a TMX file from Tiled.
* _tileset-ref_: Tileset's Reference.
* _compression_: Compression Type:
    * -1/BEST/AUTO: Use the best possible compression.
    * 0/NONE: No compression.
    * 1/APLIB: APLIB Compression is used.
    * 2/FAST/LZ4W: Custom implementation of L4Z is used.
* _mapbase_: Tileset Base or offset.

**NOTE**: Remember that to load TMX files, you will need SGDK version 1.80 or higher.

Once the resources are loaded with _rescomp_, we can create the map and perform Scroll; let's see how the map is created.

```c
Map* map=MAP_create(&map1,BG_A,
    TILE_ATTR_FULL(PAL1,FALSE,
        FALSE,FALSE,ind));
```

The function ```Map_create```; creates a new struct Map; that will allow us to have the information of this map and we will be able to use the resources that it has; let's see its parameters:

* _map_: Pointer to Map's definition created with _rescomp_.
* _plane_: Plane to be scrolled; it can be ```BG_A``` or ```BG_B```.
* _TileBase_: TileBase to use; you can use the macro ```TILE_ATTR_FULL```, to load the Tile information.

**NOTE**: It is very important to know that this function uses the DMA to load the information in VRAM, so it is not recommended to load several maps in the same frame.

This function returns a pointer to a ```Map``` structure with all the information of the map or scenario to be displayed.

After seeing how to create a map, let's move on to how to perform Scroll; in this case we use the function ```MAP_scrollTo```; that performs the Scroll of the map and recalculates the Tiles as they are needed. It is no longer necessary to count the Tiles and generate the Tiles off screen; this function does it. Let's see the parameters it receives:

* _map_: Pointer with the information of the created map (returned by the ```Map_create``` function).
* _x_: X axis offset (in pixels).
* _y_: Y axis offset (in pixels).

This function is called inside ```updatePhisics```; it is no longer performed with any condition, but when the ```offset``` variable is modified.

We can now compile and run this example; which we will see has a behavior analogous to example 12. However, the logic is much simpler. You can find more information about the Map structure and the functions that use it in the SGDK documentation.

![Example 14](13Scroll/img/ej12.png "Example 14")
_Example 14: Plane Scrolling using Map_

After seeing this last example, we can conclude this chapter; where we have been able to see how the Scroll works, which allows to create different effects and to give a better sensation to our games.

## References

* SGDK: [https://github.com/Stephane-D/SGDK](https://github.com/Stephane-D/SGDK).
* Scroll (Sega Retro): [https://segaretro.org/Sega_Mega_Drive/Scrolling](https://segaretro.org/Sega_Mega_Drive/Scrolling).
* VDP Scrolling (Mega Drive Wiki): [https://wiki.megadrive.org/index.php?title=VDP_Scrolling](https://wiki.megadrive.org/index.php?title=VDP_Scrolling).
* Line Scrolling (Danibus) (Spanish): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-lineas/).
* Plane Scrolling (Danibus) (Spanish): [https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/](https://danibus.wordpress.com/2019/10/10/leccion-9-scroll-3-mas-alla-de-los-512px/).
* Tile Scrolling (Danibus) (Spanish): [https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/](https://danibus.wordpress.com/2019/10/08/leccion-9-scroll-por-tiles/).
* TileSet Nature (Open Game Art): [https://opengameart.org/content/nature-tileset](https://opengameart.org/content/nature-tileset).
* Street Backgrounds (Open Game Art): [https://opengameart.org/content/pixel-art-street-backgrounds](https://opengameart.org/content/pixel-art-street-backgrounds).
