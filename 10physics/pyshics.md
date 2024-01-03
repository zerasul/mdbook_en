# 10. Physics and Maths in Mega Drive

There is an important thing we need to know when working with computers that we have to take into consideration. Especially when creating video games that have different interactions. A computer is nothing more than a calculator that performs calculations in binary numbers[^53].

Therefore, we have to take into consideration that in each architecture and processor, it can have different behaviors when performing calculations; either from a simple addition, to more expensive operations such as accessing memory or the division or multiplication itself.

In this chapter, we are going to talk about how the Motorola 68000 works and the different operations it can perform. We will also go into detail on working with floating point, and we will even see at the end how to implement collision between different Sprites using SGDK.

This topic can be a little complicated to understand; but it is necessary to be able to create in the most efficient way possible, our videogame without having loss of frames or the screen freezes.

[^53]: The binary system is a numbering system in base 2, so you can only have two values 0 or 1.

## Arithmetic on Motorola 68000

We are going to start talking about the Motorola 68000 processor; because this is the main processor of the Sega Mega Drive and although it also has a Zilog Z80 processor, we will focus on the Motorola. Remember that you can see more information about the architecture and operation of these processors in Sega Mega Drive in chapter 3.

In this section we will show how some arithmetic operations are performed and how they can be performed more efficiently.

We begin by explaining how the m68k processor works; it is a processor that has 32-bit registers and can work with them thanks to its two ALU [^54]. It is important to know the limitations provided by this processor; although it can work perfectly with any mathematical operation, it cannot work with decimal numbers for example, or the efficiency when working with the different mathematical operations.

A microprocessor does not take the same time to perform an addition or to perform a multiplication or division; normally the duration of these operations are performed in cycles (the duration of a processor cycle is 1/F; where F is the clock frequency). We are going to show the cost in cycles of the different arithmetic operations can take.

| **Operation** | **Description** | **Cost (cycles)**   |
|:-------------:|-----------------|---------------------|
|      ADD      | Add             |                   8 |
|      AND      | And             |                  12 |
|      CMP      | Comparison      |                   6 |
|      DIVS     | Division        |                 158 |
|      DIVU     | Integer Division|                 140 |
|      EOR      | XOR             |                  12 |
|      MUL      | Multiply        |                  70 |
|       OR      | Or              |                  12 |
|      SUB      | Subtract        |                  12 |
|      ASR,ASL  | Shift           |                  8  |
_Table3: Motorola 68000 Processor Operations and Cost_

We can observe that both multiplication and division are very costly operations so performing them can be inefficient (158 and 70 cycles respectively). Therefore, it is necessary to avoid using these operations.

An alternative to multiplying is to use both left and right shifts; as we can see in the table above, a shift can take up to 8 clock cycles to complete, so it is much more efficient when performing multiplication or division.

Let's see an example:

```c

int a=3;
int b=2;

a*b;// 6
a<<1; //6

```

We see how in the previous example, both operations are equivalent; since multiplying by 2, is the same as shifting 1 to the left. This can also be applied to division.

```c

int a=6;

a/2; //3
a>>1; //3
```

Shifting to the right, we can see it can be divided by 2. So it can be more efficient when working with these arithmetic operations.

**NOTE**: It is important to know whether the compiler used can transform multiplication or division operations into more efficient operations[^55].

After seeing the arithmetic operations and how to optimize them, we are going to show another section to take into account when programming for Sega Mega Drive; it is the use of the different types of data to be able to optimize the use of memory; since this is important when working with systems with few resources (64kb of RAM memory).

[^54]: (ALU); Arithmetic Logic Unit; it is the component of a microprocessor in charge of performing different mathematical operations.
[^55]: The different operations or optimizations that can be used depend on the compiler and the compiler version. See the Gcc documentation for more information.

## Numbers and Data type in SGDK

When working with different types of data, we need to know how they are stored in memory and how they can be used; for example, when working with numbers.

Therefore, we are going to show the different types of numerical data that SGDK provides us; although we can continue using the classic types of C (they are re-definitions from them); let's see a table with the different types of data and how much they consume in memory.

| **SGDK Type** |  **Type (C)**  | **Description**             | **Range**               |
|---------------|:--------------:|-----------------------------|-------------------------|
|       u8      |  unsigned char | 8 Bits Unsigned Integer  | 0 to 55                 |
|       s8      |      char      | 8 Bits Signed Integer  | -128 to 127             |
|      u16      | unsigned short | 16 Bits Unsigned Integer | 0 to 5535               |
|      s16      |      short     | 16 Bits Signed Integer | -32678 to 32677          |
|      u32      |  unsigned long | 32 Bits Unsigned Integer | 0 to 294967295          |
|      s32      |      long      | 32 Bits Signed Integer | -2147483648 to 217483647 |
_Table 4: SGDK data type and C equivalent._

We can see that there are different types of data available for integers, so we must always take into account the value it can contain in order to avoid overflows and unexpected behavior.

You may have noticed that we have not included numeric data types with decimals; this is because the Motorola 68000 processor did not have floating point support; however, we can use it with SGDK special Types.

## Floating Point

The Motorola 68000 processor does not support floating point therefore, calculations with decimal numbers cannot be performed; so all calculations must be implemented with integers and transformations must be performed to work with them.

Therefore SGDK, brings a series of data prepared to work with floating point; these data types are the ```FIX16``` and ```FIX32```; that would correspond to the ```float``` and ```double``` types of C; let's see a table with its data:

| **SGDK Type** | **Type (C)** | **Description** | **Range**               |
|---------------|:------------:|-----------------|-------------------------|
|     fix16     |     float    | Simple Decimal  | 3.4*E^-38 to 3.4*E^+38   |
|     fix32     |    double    | Double Decimal  | 1.7*E^-308 to 1.7*E^+308 |
_Table 5: Decimal data types in SGDK._

Note that the ```fix16``` or ```fix32``` data types are not equivalent to float or double in code. For example:

```c

fix16 a = 1.24;// Error
```

It is a wrong instruction; since you have to transform the value to that type; for that reason we can use the different functions provided by SGDK. For example to declare a type as ```fix16``` or ```fix32```.

```c
fix16 a = FIX16(1.24);
```

In the previous fragment; whether it is a correct instruction to declare in this case a variable of type fix16. In addition, we can see some useful functions to use with decimal data types. Let's see a table with some of them.

| **Functions**         | **Description**  |
|-----------------------|-------------------------------------------------------------------------------|
| FIX16(nº)             | Create a new Fix 16 from a Decimal Number                                  |
| FIX32(nº)             | Create a new Fix32 from a Decimal Number                                  |
| intToFix16(nº)        | Convert an integer number to Fix16                                                   |
| intToFix32(nº)        | Convert an integer number to Fix32                                                   |
| fix16ToInt(nº)        | Convert fix16 to integer (truncate)                                       |
| fix32ToInt(nº)        | Convert fix32 to integer(truncate)                                        |
| fix16ToRoundedInt(nº) | Convert a fix16 to integer by rounding                                      |
| fix32ToRoundedInt(nº) | Converts a fix32 to integer by rounding                                      |
| fix16Add(a,b)         | Perform the sum of two fix16                                                 |
| fix32Add(a,b)         | Performs the sum of two fix32                                                  |
| fix16Sub(a,b)         | Perform subtraction of two fix16                                                 |
| fix32Sub(a,b)         | Perform subtraction of two fix32                                                 |
| fix16Mul(a,b)         | Performs the product of two fix16                                              |
| fix32Mul(a,b)         | Performs the product of two fix32                                              |
| fix16sqrt(a)          | Performs the square root of a fix16                                          |
| fix32sqrt(a)          | Performs the square root of a fix32                                          |
| sinFix16(v)           | Performs the sine of the angle in radians represented in the range from 0 to 1024.   |
| cosFix32(v)           | Performs the cosine of the angle in radians represented in the range from 0 to 1024 |
_Table 6: Functions for use with Fix16 or Fix32_

If you need more information on how to use ```Fix16``` or ```Fix32```, you can see on the SGDK documentation, the file that includes all the definitions:

[https://github.com/Stephane-D/SGDK/blob/master/inc/maths.h](https://github.com/Stephane-D/SGDK/blob/master/inc/maths.h)

Now that we know the different types of data that we can use and how to operate with them through the different functions, let's focus on the objective of this chapter; to be able to implement physics and collisions between the different Sprites.

## Physics and collisions

When working with different Sprites, it is important to know if a Sprite is touching another one, or even if a Sprite is touching the ground. Therefore it is important to know how we can see if two or more Sprites are colliding to be able to calculate for example when they have attacked our character, or on the contrary, if our character is attacking, when to destroy the enemy, etc.

There is no single method to calculate the collision between two Sprites, so here we will show only some of them. First of all, we can check when some Sprite collides using SGDK, and a special register that has the VDP to indicate such situation:

```c
GET_VDPSTATUS(VDP_SPRCOLLISION_FLAG)
```

The macro ```GET_VDPSTATUS``` will return different from 0, when two or more sprites collide; although this method allows us to indicate when the sprites collide, we have to check one by one, which of them has been and can be inefficient.

To better check how Sprites can collide, we will talk about collision boxes or commonly called colliders; and then we will see how to calculate the collision between them.

A collision box or _collider_, is an area within a Sprite that represents that collision can occur within that area. It is usually represented by a rectangle or a circle.

It is common to define a box (BOX) or a circle (CIRCLE); with SGDK, you can define the type of collider you will have when importing sprites with _rescomp_; however, this functionality is not yet fully implemented.

We are going to focus on the different examples of colliders that can be used to calculate collisions. With this data, we can easily calculate collisions between different colliders; let's see some examples between the different cases.

### Point vs Rectangle

In this first case, we are going to check when a point is inside a rectangle; in such a way, for example, that we can detect when a point is reached or if the character is touching the ground.

<div class="centered_image">
<img src="10physics/img/pointvsbox.png" title="Collision point against box" alt="Collision point against box"/>
<em>Collision point vs. box</em>
</div>

As we can see in the previous image, we have to detect that this point is inside the rectangle or box; to do so, we can use the following formula.

```c#
if (point_x >= box_x1) and
   (point_x <= box_x2) and
   (point_y >= box_y1) and
   (point_y <= box_y2) then
...
```

Where:

* ```point_x```: Point X Position in Pixels.
* ```point_y```: Point Y Position in Pixels.
* ```box_x1```: X position from the beginning of the box.
* ```box_y1```: Y position from the beginning of the box.
* ```box_x2```: X position at the end of the box.
* ```box_y2```: Y position of the end of the box.

As we can see, it is simply to check that the point is within the defined parameters of the rectangle or box.

### Rectangle vs Rectangle

Another more common example is to check that two rectangles or boxes overlap; in this way we can check collisions between two Sprites in a simpler way.

<div class="centered_image">
<img src="10physics/img/boxvsbox.png" title="Collision box against box" alt="Collision against vs box"/>
<em>Collision box against box</em>
</div>

As we can see in the previous image, we have to check when the collision box of two or more Sprites overlap. For this we can follow the following formula very similar to the one used for point versus box.

```c#
if (box1_x1 <= box2_x2) and
   (box1_x2 >= box2_x1) and
   (box1_y1 <= box2_y2) and
   (box1_y2 >= box2_y1)
then
...
```

Where:

* ```box1_x1```: X position from the beginning of the first box.
* ```box1_y1```: Y position from the beginning of the first box.
* ```box1_x2```: Y position from the end of the first box.
* ```box1_y2```: Y position from the end of the first box.
* ```box2_x1```: X position of the beginning of the second box.
* ```box2_y1```: Y position of the beginning of the second box.
* ```box2_x2```: X position of the end of the second box.
* ```box2_y2```: Y position of the end of the second box.

In this case, the aim is to check whether the two areas overlap.

### Dot vs. Circle

It is also possible to check when a point is inside a circle; in this way we can calculate for example when a Sprite with a circular collision area touches a point or is above such a point etc.

<div class="centered_image">
<img src="10physics/img/pointvscircle.png" title="Collision point against circle" alt="Collision point against circle"/>
<em>Collision point against circle</em>
</div>

To check that a point belongs to a circle, we can use the Pythagorean theorem to calculate the distance between the point and the center of the circle is correct.

```c
distance^2= X difference^2 + Y difference^2
```

Considering that the difference is the subtraction of each coordinate of the center of the circle with the point. Being able to implement this formula and check the collision as follows:

```c#
delta_x = circle_x - point_x
delta_y = circle_y - point_y
limit = circle_radius

if (delta_x * delta_x) +
   (delta_y * delta_y) <= (limit * limit)
then
   ...
```

Where:

* ```circle_x```: X position of the center of the circle in pixels.
* ```circle_y```: Y position of the center of the circle in pixels.
* ```point_x```: X position of the point in pixels.
* ```point_y```: Y position of the point in pixels.
* ```circle_radius```: is the radius of the circumference.

In this case we have been able to check the distance of a point with respect to the center of the circle and see that it is smaller than the radius.

### Circle against Circle

The last example we will show, is to see if two circles overlap; this way we can detect if two Sprites with this type of collision, overlap and therefore have some type of action, etc.

<div class="centered_image">
<img src="10physics/img/circlevscircle.png" title="Circle against circle collision" alt="Circle against circle collision"/>
<em>Circle against circle collision</em>
</div>

As we can see in the previous image, we can see that areas of each circle can overlap and we have to be able to detect them in order to decide what to do with the collision. Let's see a formula based on the previous case.

```c#
delta_x = circle2_x - circle1_x
delta_y = circle2_y - circle1_y
limit = circle2_radius + circle1_radius

if (delta_x * delta_x) +
   (delta_y * delta_y) <= (limit * limit)
then
...
```

Where:

* ```circle1_x```: X position of the center of the first circle.
* ```circle1_y```: Y position of the center of the first circle.
* ```circle2_x```: X position of the center of the second circle.
* ```circle2_y```: Y position of the center of the second circle.
* ```circle1_radius```: Radius of the first circle.
* ```circle2_radius```: Radius of the second circle.

Although there are more combinations such as a box versus circle, these can be calculated by performing combinations. In addition, it is important to see that we have studied the formulas and these include multiplications so that as far as possible, transform such multiplications into shifts.

## Sprites Collision Example

Once we have seen the theories on how to calculate collisions, we can look at the example of this chapter. In this case, we are going to take the previous example as a baseline, but adding collision checking.

You can find the example for this section in the example repository that accompanies this book; in this case, it is located in the _ej7.collisions_ folder; you will find both the source code and the resources for this example.

In order to understand the collisions better, we have modified the Sprites to draw the outline of the collision boxes. You can see those modified Sprites in the _res_ folder of the example.

A C Struct has been created to store the collision box data; in this example we will use a rectangular box to check the collision.

```c
typedef struct {
    s8 x;
    s8 y;
    s8 w;
    s8 h;
}BoxCollider;
```

Where the properties of this Struct are:

* _x_: X coordinate in pixels of the upper left corner.
* _y_: Y coordinate in pixels of the upper left corner.
* _w_: Rectangle Width in pixels.
* _h_: Rectangle height in pixels.

In addition, the ```checkCollision``` function has been added, which receives two Sprites, and returns an integer. This function will be called in each Frame since it will be included in the infinite loop.

Let's take a look at this function, we will see some fragments for a better understanding.

```c
int checkCollision(Sprite* sprt1, Sprite* sprt2){

    BoxCollider sprt1Collider;
    sprt1Collider.x=sprt1->x+4;
    sprt1Collider.y=sprt1->y+4;
    sprt1Collider.w=20;
    sprt1Collider.h=26;

    BoxCollider sprt2Collider;
    sprt2Collider.x=sprt2->x+7;
    sprt2Collider.y=sprt2->y+6;
    sprt2Collider.w=18;
    sprt2Collider.h=21;
```

As we can see in this first fragment, the structures of each Collider corresponding to each Sprite are created; this time a fixed value has been set, but depending on each case, it could change by animation, frame, etc.

Once these variables have been obtained, we calculate each point necessary to check whether the two boxes overlap; let's look at the fragment.

```c
   
   s8 box1_x1 = sprt1Collider.x;
   s8 box1_y1 = sprt1Collider.y;
   s8 box1_x2 = sprt1Collider.x + sprt1Collider.w;
   s8 box1_y2 = sprt1Collider.y + sprt1Collider.h;

   s8 box2_x1 = sprt2Collider.x;
   s8 box2_y1 = sprt2Collider.y;
   s8 box2_x2 = sprt2Collider.x + sprt2Collider.w;
   s8 box2_y2 = sprt2Collider.y + sprt2Collider.h;
```

We see how in each case both the x1,y1 position and the x2,y2 position are calculated, corresponding to the initial and final point of the rectangle that forms the collision box. Once we have each point, we can perform the check:

```c
   
   if ((box1_x1 <= box2_x2) &&
            (box1_x2 >= box2_x1) &&
            (box1_y1 <= box2_y2) &&
            (box1_y2 >= box2_y1)){
                return TRUE;
            }else{
                return FALSE;
            }
```

We see how if the check is correct it will return ```TRUE``` (or 1); while if it is not fulfilled, it will return ```FALSE``` (or 0); so there would be no collision. Finally, we will show the code fragment where the call to the ```checkCollision``` function is made:

```c

SPR_update();
int collision = checkCollision(sha, elli);
sprintf(buffer, "Collision: %d", collision);
VDP_drawText(buffer,3,3);
...
```

We see how in each iteration of the loop, the collision between the Sprites ```sha``` and ```elli``` is checked in this way, it is shown on the screen when both Sprites collide.

Finally, we only have to compile and run the example; either manually, or using the _Genesis Code_ extension, with the command _Genesis Code: compile & Run Project_. If everything goes correctly, it will show us the following result:

![Example 7: Collisions](10physics/img/ejemplo7.png "Example 7: Collisions")
_Example 7: Collisions_

After seeing this example, we can see how to use physics and maths when working with Sega Mega Drive. From the different arithmetic instructions that we can do with the Motorola 68000, to review the collisions between Sprites and how we can implement them in our games.

In the next chapter, we will discuss how Sega mega Drive manages colors and the different palettes we can use and change.

## References

* Motorola 68000 Instructions: [https://wiki.neogeodev.org/index.php?title=68k_instructions_timings](https://wiki.neogeodev.org/index.php?title=68k_instructions_timings)
* GCC Optimizations: [https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html)
* C Basic Types: [https://ccia.ugr.es/~jfv/ed1/c/cdrom/cap2/cap24.htm](https://ccia.ugr.es/~jfv/ed1/c/cdrom/cap2/cap24.htm)
* PlutieDev: [https://plutiedev.com/basic-collision](https://plutiedev.com/basic-collision)
* DaniBus (Aventuras en Mega Drive)(Spanish): [https://danibus.wordpress.com/2019/10/13/leccion-10-colisiones/](https://danibus.wordpress.com/2019/10/13/leccion-10-colisiones/)
