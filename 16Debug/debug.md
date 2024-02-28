# 16. Debug

We have reached the last chapter of this book and our journey through the details of programming for the Sega Mega Drive. From when we started talking about what a Mega Drive is, its history, architecture, setting up our environment, to seeing all the tools available to create our games.

It only remains to talk about a topic that is quite important for anyone who faces programming; and it is at the time of debugging and to be able to see the traceability of our code. Important thing, to be able to detect possible execution errors or commonly called "bugs".

There are many useful tools when it comes to finding such errors. Such as being able to visualize the memory of our device, and being able to see the value of our variables, instruction that we are executing, etc.

Such tools as debuggers, log tools and even memory image viewing are available in many of the emulators mentioned in this book, such as Gens KMod, Blastem or Kega Fusion, and the SGDK itself provides some of these tools.

In this chapter, we are going to see what tools we can use to debug our games and to be able to detect bugs or errors.

## Debugging and traceability

As we have been talking in this chapter, it is important to know and use tools to be able to detect the errors of our game and to see that it is doing correctly what it should; in many occasions this type of errors are not detected with the first sight and we need tools to see what is happening.

Therefore, we need to be able to have traceability, and the possibility of using a debugger for our game. SGDK, provides us with tools to be able to perform this traceability.

### KLog

The use of trace files (or logs) is common when working with systems. Therefore, some emulators are able to write a trace with messages that the programmer himself uses; in many occasions they could be put on the screen. But, it is much better to be able to have a trace file with these messages.

Some emulators such as Gens KMod or Blastem, have a section to view these traces and display it by that console or file. Let's see how the messages could be seen in the Gens emulator with the KMod modification.

<div class="centered_image">
<img src="16Debug/img/messages.png" title="Gens Kmod Messages Screen" alt="Gens Kmod Messages Screen"/>
<em>Gens Kmod Messages Screen</em>
</div>

To access this section, you can find it in the menu _CPU->Debug->Messages_; and here we will be able to see the messages we send with a special function that SGDK contains.

The function to send information to this trace is ```kprintf```; which writes a message to this trace instead of writing it to the screen. This function is analogous to the use of ```printf``` in standard c; that is, it receives 1 or more parameters:

* _fmt_: character string that can contain a series of formatters starting with `%`; that will allow us to write variables of different types and formats. To know how to use these specific formatters, you can check the standard C documentation (we leave information link in the references). It is important to know, that this function has an internal buffer of 255 bytes; so we have to take this into account when writing a very long message.
* ...: the rest of the parameters, will be each one of the variables that will replace each one of the formatters included in the previous parameter.

The ```kprintf``` function returns the number of bytes written (until 255) in the trace.

## Using a Debugger

We have talked about how to use the text console that comes with some emulators to write a series of traces. But in many occasions it occurs to us we need to use tools such as debuggers to be able to see what is happening at a given moment in our program.

Therefore, we are going to show firstly, how this debugging could be done for our games; first in a more theoretical way, and then we will go into more detail depending on our emulator or tools to use.

If you have worked with programming before, you will have had to debug many programs; usually on the machine itself and compile the code for the same architecture you are working with (usually x86_64 or ARM); however, in this case we are not going to work with these architectures; but we will work with the Motorola 68000 architecture. Therefore we need a way to debug this code using an emulator for example (there are ways to debug with real hardware; but with much more expensive). Let's see a schematic to understand what we want to do.

![Remote Debug Scheme](16Debug/img/depuracionremota.jpg "Remote Debug Scheme")
_Remote Debug Scheme_

As we can see in the diagram, different elements are available; some on the local machine, which would be the computer we are working on, and others on a remote machine, which in this case would be the Mega Drive itself or an emulator.

If we focus on the local machine, we can see that we have the editor, which can be any code editor or integrated development environment, with the ability to connect to a debugger; in the image you can see that it is _Visual Studio Code_.

On the other hand, we will need to use a program that allows us to connect to a remote (or local) machine in order to obtain the necessary information to debug; such as memory, current instruction, step by step execution, etc. For it, we will use the debugger GDB [^65]; which is going to allow us to connect to an emulator (Normally using a network port), to be able to debug our game. SGDK, includes GDB to be able to debug our games.

[^65]: GDB: Gnu Project Debugger, will allow us to see what happens inside a program; besides allowing to stop the execution and to be able to visualize the variables or to change the values of these.

Finally, the remote machine that can be an emulator, to be connected to GDB and provide all the information needed by the debugger. The emulator, has to be able to receive and send this information to the debugger to be able to have a correct operation; for a better understanding of how this could be done or what tools we have, we are going to see in detail for some emulators already mentioned.

### Gens KMod

As we have seen in other chapters, Gens is an open source emulator that provides us with a number of additional tools to help us in development. For example, we can see the state of the processor registers and how it is:

![Motorola 68K Debugger](16Debug/img/m68debug.png "Motorola 68K Debugger")
_Motorola 68K Debugger (Gens Kmod)_

This can be useful to see the status of the processor; but it is not what we are looking for; since we will need the KMod modification, to be able to define the options of remote debugging. In the menu _options->Debug_, we can set the ports and options related to remote debugging.

<div class="centered_image">
<img src="16Debug/img/debugoptgens.png" title="Gens KMod Debugging Options" alt="Gens KMod Debugging Options"/>
<em>Gens KMod Debugging Options</em>
</div>

These options will open a port (6868 by default) to debug the M68k processor. This port will be used by GDB to connect.

You can find more tools for debugging or viewing the VDP memory, etc. For more information, see the Gens KMod help.

### Blastem

Another emulator that we have mentioned for this book is Blastem. It also has debugging options, including remote debugging. However, it does not work properly or is still under development. So the use of remote debugging is only supported by the latest versions of Blastem (we recommend using the Nightly version; you can find more information in the references).

In this case, we can use an internal debugger, starting Blastem with the -d option; which will allow us to execute step by step. However, this option will show us the instructions in assembler and we will have to translate them to see what is happening.

If we want to use remote debugging, we will need to execute the following command inside GDB:

```bash
target remote:1234| blastem.exe rom.bin -D
```

This will tell GDB to connect to port 1234 (can be changed on Blastem's configuration) and to start Blastem emulating our ROM, and to activate the remote emulation. With this, we will be able to debug our game through GDB.

### Genesis Code

However, although we have been able to start the emulation, we still have something left; to be able to connect GDB with our development environment to be able to see the instructions of our C code and also to be able to visualize step by step those instructions.

For this, we are going to see an example using Visual Studio Code, with the extension _Genesis Code_; that we have been able to see in this book, which is an aid for the development using SGDK. This extension, when it creates a project, generates a configuration in the _.vscode_ directory; this configuration, helps us to be able to manage the .h files, and also to generate the configuration to start the debugging; if we take a look at the _launch.json_ file, we can see.

```json
...
"name": "Debug with gdb remote",
"request": "launch",
"type": "cppdbg",
"program": "%CD%\\out\\rom.out",
"miDebuggerServerAddress": "localhost:6868",
"sourceFileMap": {
  "d:\\apps\\sgdk\\src\\": "${env:GDK}\\src\\",
},
"args": [],
"stopAtEntry": true,
"cwd": "${workspaceFolder}",
"environment": [],
"externalConsole": false,
"MIMode": "gdb",
"launchCompleteCommand": "exec-continue",
"miDebuggerPath": "${env:GDK}\\gdb.exe",
"setupCommands": [
    {
        "text": 
        "set directories '${workspaceFolder}
            ;$cwd;$cdir'"
    }
],
...
```

We can see some properties in this file:

* _name_: Name of the configuration that we will be able to see in VSCODE.
* _program_: The name of the binary that gdb will use to start debugging; this is the _rom.out_ file that is generated when compiling in debug mode.
* _miDebuggerServerAddress_: Specifies the address and port where gdb will connect to do remote debugging. It must match the emulator port.
* _sourceFileMap_: This property is important since GDB has established paths with which it was compiled and configured (specifically those of the SGDK project); therefore it must be mapped to our SGDK source folder.
* _cwd_:Indicates the working directory.
* _MIMode_: Indicates the debugger mode in this case gdb.
* _miDebuggerPath_: Path where GDB is located; in this case the one integrated in SGDK is used. Another one can be defined.
* _setupCommands_: Indicates the commands and settings to be passed to GDB. Among them, the source directory is set.

After viewing this configuration, we can generate the rom with debugging options, using the _Genesis Code: Compile For Debugging_ command; to generate the rom adding the symbol table and everything needed for debugging.

Finally, we can run the debugging in the Visual Studio Code editor itself; if everything goes correctly, we will be able to see something like the following screen.

![VScode Debugging](16Debug/img/vscodedebug.png "VScode Debugging")
_VScode Debugging_

**NOTE**: For Linux systems using GENDEV, debugging is not available because GENDEV does not include the SGDK symbol tables.

## Example using KLog

After seeing the tools and how to debug, we are going to show the example of this section and how to use the traces correctly; for this, we are going to create a very simple example that will send us a trace when we press a button (A, B or C). Remember this example, you can find it in the repository of examples that accompanies this book; corresponding to the folder _ej17.klog_.

First we define the function that will manage the controls. for this example in an asynchronous way; that will be the function ```handleAsyncInput```. In this function, we are going to check when button A, B or C is pressed; saving each button in a variable. Let's see a fragment:

```c
char button='\0';
...
if(state & changed & BUTTON_A){
            button='A';
}else{
...
```

We see that for each button, the variable ```button```, stores a character with the corresponding button; and later we will see that we use the function ```kprintf```, to show the corresponding trace; let's see a fragment.

```c
#ifdef DEBUG
kprintf("Button Pushed: %c \n",button);
#endif
```

As you will have been able to see, the instruction is between two preprocessor instructions; these instructions, will make this code only available, if the constant ```DEBUG``` is defined. This is a good practice; since if our game is going to be published, we do not need these traces; they will only be useful while it is being developed.

If we have already compiled and executed this example, when we press a key, we can see in the Blastem console (or in the corresponding section of Gens KMod), our message.

![Blastem Debugging Console](16Debug/img/blastemconsole.png "Blastem Debugging Console")
_Example 17: Blastem Debugging Console_

After seeing our last example, we end our journey through the Sega 16-bit console; and we hope the reader liked it. And hopefully this will encourage you to create your own games and publish more homebrew software. Of course I don't forget to thank you personally for your reading.

## References

* Printf (C Documentation): [https://cplusplus.com/reference/cstdio/printf/](https://cplusplus.com/reference/cstdio/printf/).
* Gens KMod: [https://segaretro.org/Gens_KMod](https://segaretro.org/Gens_KMod).
* Blastem: [https://www.retrodev.com/blastem/nightlies/](https://www.retrodev.com/blastem/nightlies/).
* GNU GDB: [https://www.sourceware.org/gdb/](https://www.sourceware.org/gdb/).
* Debugging Mega Drive Article (Spanish): [https://zerasul.me/blog/debug](https://zerasul.me/blog/debug).
* Visual Studio Code C Debug: [https://code.visualstudio.com/docs/cpp/cpp-debug](https://code.visualstudio.com/docs/cpp/cpp-debug).
