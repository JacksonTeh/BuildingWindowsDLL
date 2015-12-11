Building Windows DLL
====================

Commands
========
To view all available commands issue:
```
rake -T
```
The new commands added by `scripts/dllexample.rb` are:
```
rake release:Dll
rake release:main
```

Release
=======
To build DLL file, type:
```
rake release:Dll
```
(Need to output dll directly from command to allow main.exe to be execute
by input "gcc -o src/TestDll.dll src/TestDll.o -s -shared -Wl,--subsystem,windows" command)

To build main.exe, type:
```
rake release:main
```