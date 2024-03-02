# 7. Input

In the last chapter, we were already able to see our first example and see how to start developing the code for our game.

In this chapter, we already started to talk about video game development concepts and we are going to see the different modules or parts that we have to deal with when creating our game. One of the most important parts when creating a video game is the controls to interact with the game.

It is one of the most important parts to be able to use controls because otherwise, it would not be possible to control the character or do any action in the game. Either through a controller, or any other device that allows sending information to the console and this is able to act accordingly within our game.

In this chapter, we are going to show how to use these controls; through different examples for different devices such as the Sega Mega Drive controllers with 3 or 6 buttons, or even the _Sega Mouse_.

## Input Devices

For Sega Mega Drive, numerous input devices were created; from 3 or 6 button controllers, the famous _Sega Mouse_, light guns like the famous _The Justifier_ that allowed to play aiming games with a gun; and for sure, the Sega Activator is defined as a motion controller for Sega Mega Drive.

Obviously it is important to remember that the Sega Mega Drive had 2 Atari or DE-9 type input ports; that is where the devices are connected. Although it was expandable thanks to other devices like the _Super Multi Play_; that allowed to connect up to 4 controllers per port; or some games like the _Micro Machines 2_ [^44] that included 2 additional ports in the cartridge itself.

To better understand the DE-9 port and how it is composed for a 3-button controller:

![DE-9](7controls/img/de-9.png "DE-9")
_DE-9 Port Pinout_

Where:

1. Up
2. Down
3. Left
4. Right
5. Vcc
6. C/Start
7. GND
8. Select (Depending if its setter to 0 or 1 it will use one function or another on pins 6 or 9).
9. A/B

[^44]: Micro Machines 2: Turbo Tournament was a game published by Codemasters that allowed up to 4 simultaneous players.

If you need to know more about the different controllers and how they are composed, we have left additional information at the references of this chapter.

In this section, we are going to see some of them to comment on their characteristics, and which versions can be found.

### 3 Buttons Gamepad

The best known Sega Mega Drive controller, it had a directional pad, and also 4 buttons called A, B, C, and START Button.

Some other third-party drivers added some extra functionality such as autoFire or other options.

There were different designs depending on the Mega Drive version (Japan/Europe or America); in addition, many other third party controllers had many other designs.

![3 Button Controller](7controls/img/controller3Button.jpg "3 Button Controller")
_3 Button GamePad_

### 6 Buttons Gamepad

Another version of the controller for Sega Mega Drive, is the 6-button controller; which added three additional buttons (X,Y and Z). This version was used by some games like _Comix Zone_ [^45] or even _Streets of Rage 3_ [^46].

Also, as there were some games that were not compatible with the 6-button mode, an additional button was added, which allowed the user to use the controller in "3-button" mode. This button called _MODE_, if pressed when starting the game, changed the controller mode [^47].

![6 Buttons Controller](7controls/img/md6buttons.jpg "6 Buttons Controller")
_Retro-bit brand 6 Buttons Controller._

[^45]: Comix Zone is a video game developed by Sega and published in 1995.
[^46]: Streets of Rage 3 is the third part of the Streets of Rage saga, published in 1994.
[^47]: The controller in the image is not official, but it is licensed for Sega Mega Drive. In the references you can find a purchase link.

### Sega Mouse

Another of the peripherals that we can find for Sega Mega Drive, is the famous _Sega Mouse_; it was a mouse with 2 buttons with different versions. It allowed the player to play some games that were compatible. Like the famous _lemmings 2_ [^48], or _Cannon Fodder_ [^49].

The 2-button mouse allowed the use of the A and B buttons; however, to use the C button, the mouse ball itself was clickable, which allowed for greater compatibility. The Sega Mouse, however, did not reach Sega America so it was only seen in Japan and Europe. But Sega America has its own version called _Mega Mouse_ which had 3 buttons and a start button; removing the possibility of clicking with the mouse ball itself.

[^48]:Lemmings; it was a strategy game, where you controlled cute characters called lemmings, each one had a function and you had to solve a puzzle. The Mega Drive version was published by Sega and released in 1992.
[^49]: Cannon Fodder is a strategy game that was released for the Sega Mega Drive in 1992.

## Input Programming

After seeing in detail some of the input devices we can work with, we are going to show how to program our game to use them. SGDK provides different methods to be able to interact with the controls; using the controller or even the Mouse. Therefore, we are going to show three examples of different methods that can be found to develop our game.

First, we will see how to know what type of controller is being used (3 or 6 buttons, or mouse). In addition, we will show 2 ways to read the input of our controllers, the first one in a synchronous way, and the second one in an asynchronous way; the first one reads at all times if a button has been pressed and asks which of them have been. The second method uses the processor interrupts, in order to define an interrupt routine for each button press.

Finally, we will show an example of how to use the mouse for Sega Mega Drive (you can use an emulator to use the mouse of your computer).

### Controller Type

If our game is compatible with different devices; such as a 3 or 6-button controller, mouse or even a gun, we can use the function ```JOY_getPortType```, to be able to know what type of input device is connected to a port.

The Function ```JOY_getPortType```, has the next parameters:

* ```u16 port``` what port we are going to use:
    * ```PORT_1```: First Console Port.
    * ```PORT_2```: Second Console Port.

This function returns an integer value ```u8``` which can indicate the type of device, using the ```&``` operator. For example:

```c
u8 value = JOY_getPortType(PORT_1);

// check that is a controller
if(value & PORT_TYPE_PAD) 
```

The values we can find are:

* ```PORT_TYPE_MENACER```: Sega Menacer (LightGun).
* ```PORT_TYPE_JUSTIFIER```: Konami Justifier (LightGun).
* ```PORT_TYPE_MOUSE```: Sega MegaMouse.
* ```PORT_TYPE_TEAMPLAYER```: Sega TeamPlayer.
* ```PORT_TYPE_PAD```: Sega joypad.
* ```PORT_TYPE_UNKNOWN```: unidentified or no peripheral.
* ```PORT_TYPE_EA4WAYPLAY```: EA 4-Way Play.

In addition, you can detect the type of controller for each detected input device; if you use a multitap, (such as Sega Player or EA4WayPlay), you need to know what type of device is connected; therefore you use the function ```JOY_getJoypadType```; which you receive as a parameter:

* ```u16 joy```: the number of the input to check:
    * ```JOY_1```: First Input Device.
    * ```JOY_2```: Second Input Device.
    * ...
    * ```JOY_8```: Eighth Input Device.

This function returns an integer value that will allow us to compare with different values to know what type of controller it is; it can have the following values:

* ```JOY_TYPE_PAD3```: 3 buttons joypad.
* ```JOY_TYPE_PAD6```: 6 buttons joypad.
* ```JOY_TYPE_MOUSE```: Sega Mouse.
* ```JOY_TYPE_TRACKBALL```: Sega trackball.
* ```JOY_TYPE_MENACER```: Sega Menacer gun.
* ```JOY_TYPE_JUSTIFIER```: Sega Justifier gun.
* ```JOY_TYPE_UNKNOWN```: Unknown or not connected.

**NOTE**: The above functions will only update the information if the ```JOY_Init()``` or ```JOY_Reset()``` function is called to initialize the SGDK control system; it is not necessary to call them manually as these functions are called automatically when the SGDK is loaded.

### Synchronous

The first way to use the controls is synchronously; this means that in each frame of our game, it will read the state of the buttons pressed for each of the controllers that we have connected.

To better understand how to read the state of the controls in this way, you can see the example called _ej2.controls1_ that you will find in the repository of examples that accompanies this book. This example will display the buttons we have pressed; in this case it is based on a 3-button controller because only the directions, and the buttons A,B,C and Start will be displayed.

In this example, you can see a file called ```constants.h``` has been created and that it includes a series of constants such as the X and Y positions of the different messages to be displayed, in tiles. This file is located in the _inc_; directory of the project.

If we look at the code, we can see that the function ```JOY_readJoypad``` is used, which allows to read the current state of a controller; this function receives the following parameters:

* ```u16 joy```: Input device number; can be the next values:
    * ```JOY_1```: First Input Device.
    * ```JOY_2```: Second Input Device.
    * ...
    * ```JOY_8```: Eighth Input Device.

This function returns an integer ```u16```; which contains the current state of the controller; you can use the ```&``` operator to know which buttons are being used; as we can see in the example:

```c
  if (value & BUTTON_UP)
```

The above fragment checks that the upward direction is being pressed; we can check the following buttons:

* ```BUTTON_UP```: Up.
* ```BUTTON_DOWN```: Down.
* ```BUTTON_LEFT```: Left.
* ```BUTTON_RIGHT```: Right.
* ```BUTTON_A```: A Button.
* ```BUTTON_B```: B Button.
* ```BUTTON_C```: C Button.
* ```BUTTON_START```: Start Button.
* ```BUTTON_X```: X Button (6 Buttons).
* ```BUTTON_Y```: Y Button (6 Buttons).
* ```BUTTON_Z```: Z Button (6 Buttons).
* ```BUTTON_MODE```: MODE Button (6 Buttons).

Also, there are aliases if a mouse is used:

* ```BUTTON_LMB``` = Alias for button A for Mouse.
* ```BUTTON_MMB``` = Alias for button B for Mouse.
* ```BUTTON_RMC``` = Alias for button C for Mouse.

In the example, you can see how a text will be drawn or deleted, depending on the buttons pressed; here you can see a fragment of the example:

```c
  int value = JOY_readJoypad(JOY_1);

    
    if (value & BUTTON_UP)
      printChar(UP_TEXT,POSX_UP,POSY_UP);
    else
      printChar(EMPTY_TEXT,POSX_UP,POSY_UP);
```

Where we see that if the Up button is pressed, a text will be displayed or an empty text will be displayed.

![Example 2: Synchronous Controllers](7controls/img/ej2.png "Example 2: Synchronous Controllers")
_Example 2: Synchronous Controllers_

### Asynchronous

So far we have been able to see how to read the different controls using the synchronous way; that is to say, in each frame the keys pressed in the different controls are read and all the controls are checked whether they are pressed or not.

This can make it more time consuming in the long run and can slow down our game; therefore, because the Motorola 68000 processor has interrupts, we can use a function that handles the events when we press a key.

An interrupt is a signal received by the processor, which stops the current task and executes a function called an interrupt subroutine; it also performs a series of actions and once completed, the processor continues with the previous task. With an interrupt, events received from the hardware can be handled optimally.

SGDK, allows us to create a function to handle the events of the controls asynchronously; in such a way that it will only act if a key has been pressed:

```JOY_setEventHandler```; this function allows you to define a function to be executed when a key is pressed.

It hast the next Parameters:

* ```function*(u16 joy, u16 changed, u16 state)```: function pointer that must receive the following 3 parameters:
    * ```u16 joy```: Input Device Number; can be the Next Values:
        * ```JOY_1```: 1 Input Device.
        * ```JOY_2```: 2 Input Device.
        * ...
        * ```JOY_8```: 8 Input Device.
    * ```u16 changed```: Button Pressed. For Example: ```BUTTON_START```.
    * ```u16 state```: State; show if it is pressed or released. ```state=0``` indicates that the button is released.

Once we have seen how the function is used to handle the events of the controllers, we can see in the examples repository the example _ej3.controls2_; which has the behavior similar to the previous example; however, we can see that the function has been defined to handle the different events.

```c
    JOY_init();

    JOY_setEventHandler(inputHandler);
```

We can see in the above snippet, that the ```JOY_Init``` function is called which initializes the whole engine associated with the controllers (this function is executed when the whole SGDK system is started automatically). We see that the ```inputHandler``` function has been set up; which will handle what happens when a button of one of the controllers is pressed.

If we take a look at the function, we can see the following code:

```c
    void inputHandler(u16 joy, u16 changed,
            u16 state){


        if (changed & state & BUTTON_START)
		{
			printChar(START_TEXT, POSX_START,
              POSY_RIGHT);
		}
    ...
```
We see that the function ```inputHandler```, receives the three commented parameters:

* _joy_: Input Device used.
* _changed_: Button Pressed.
* _state_: Button Status (Pressed or Released).

We observe how the variable changed is compared with state and a button; in this way it is verified that the action will only be performed when the corresponding button is pressed and not when it is released.

![Example 3: Asynchronous Controllers](7controls/img/ej3.png "Example 3: Asynchronous Controllers")
_Example 3: Asynchronous Controllers_

### Sega Mouse Programming

We have been working with controllers; either 3 or 6 button controllers; however, it can be interesting to offer support for using a mouse in our games. In this section, we are going to see how to read the _Sega Mouse_, using SGDK.

First of all, not all of us have access to a Sega Mouse; so it is necessary to use an emulator, which allows us to use the mouse of our computer inside the emulator itself. In this case we recommend the _Kega Fusion_ or fusion emulator. This emulator, using the <kbd>F12</kbd>, captures the mouse of our computer.

We have created a new example; in the repository of examples for this book; remember that you can find it at:

[https://github.com/zerasul/mdbook-examples](https://github.com/zerasul/mdbook-examples)

The example that we are going to treat here, is _ej4.mouse_ Which is going to show on screen the X and Y coordinates of the mouse. The cursor will not be shown on the screen; it can be done, using Sprites.

First, we are going to enable the support to use the mouse; using the function ```JOY_setSupport``` which will allow us to enable the support for different devices; let's see how this function works:

```JOY_setSupport```: enables support for a device; it receives the following parameters:
* ```port```: Input Port; can be the next Values.
    * ```PORT_1```: Console Port 1.
    * ```PORT_2```: Console Port 2.
* ```support```: Supporting device; it has the following values:
    * ```JOY_SUPPORT_OFF```: Disabled.
    * ```JOY_SUPPORT_3BTN```: 3 Button Controller.
    * ```JOY_SUPPORT_6BTN```: 3 Button Controller.
    * ```JOY_SUPPORT_TRACKBALL```: Sega Sports Pad (SMS trackball).
    * ```JOY_SUPPORT_MOUSE```: Sega Mouse.
    * ```JOY_SUPPORT_TEAMPLAYER```: Sega TeamPlayer.
    * ```JOY_SUPPORT_EA4WAYPLAY```: EA 4-Way Play.
    * ```JOY_SUPPORT_MENACER```: Sega Menacer.
    * ```JOY_SUPPORT_JUSTIFIER_BLUE```: Konami Justifier (Only Blue LightGun).
    * ```JOY_SUPPORT_JUSTIFIER_BOTH```: Konami Justifier (All LightGuns).
    * ```JOY_SUPPORT_ANALOGJOY```: Sega analog joypad (Not Supported Yet).
    * ```JOY_SUPPORT_KEYBOARD```: Sega keyboard (Not Supported Yet).

We can also see the ```sprintf``` function which will allow us to display the values of the different variables on the screen. This function works exactly the same as its counterpart in the standard C library.

We can observe that there is a function called ```read_mouse``` which will be in charge of reading the mouse coordinates.

Let's see this function:

```c
void read_mouse(){
    u16 readX;
    u16 readY;

    if(status.portType == PORT_TYPE_MOUSE ){
        readX=JOY_readJoypadX(JOY_1);
        readY=JOY_readJoypadY(JOY_1);
    }
...
```

We see in the previous fragment, that the type of controller is checked; which we have read with the function ```JOY_getPortType``` and we check that it is a mouse connected to port 1. Once checked, we have two functions; ```JOY_readJoypadX``` and ```JOY_readJoypadY``` which will allow us to read both the X coordinate or Y coordinate of the device connected to controller 1.

Once we have seen the code, we can run the example and see how the X and Y values change.

![Example 4: Sega Mouse Programming](7controls/img/ej4.png "Example 4: Sega Mouse Programming")
_Example 4: Sega Mouse Programming_

## References

* Control pad: [https://segaretro.org/Control_Pad_(Mega_Drive)](https://segaretro.org/Control_Pad_(Mega_Drive))
* Control Pad 6 Buttons: [https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive)](https://segaretro.org/Six_Button_Control_Pad_(Mega_Drive))
* Super Multi Play: [https://segaretro.org/Super_Multi-play](https://segaretro.org/Super_Multi-play)
* The Justifier: [https://segaretro.org/The_Justifier](https://segaretro.org/The_Justifier)
* 6 Buttons Controller Buy Link: [https://amzn.to/3lBRnfv](https://amzn.to/3lBRnfv)
* MicroMachines 2 Turbo Tournament: [https://segaretro.org/Micro_Machines_2:_Turbo_Tournament](https://segaretro.org/Micro_Machines_2:_Turbo_Tournament)
* Sega Mouse: [https://segaretro.org/Sega_Mouse](https://segaretro.org/Sega_Mouse)
* Lemmings: [https://segaretro.org/Lemmings](https://segaretro.org/Lemmings)
* Cannon Fodder: [https://segaretro.org/Cannon_Fodder](https://segaretro.org/Cannon_Fodder)
* C++ Sprintf: [https://www.cplusplus.com/reference/cstdio/sprintf/](https://www.cplusplus.com/reference/cstdio/sprintf/)
* Kega Fusion: [https://segaretro.org/Kega_Fusion](https://segaretro.org/Kega_Fusion)
