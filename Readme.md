# Hx4Diva

## Compiling

To compile, run:

```haxe
haxelib git hxcpp_extern_helpers https://github.com/Aidan63/hxcpp_extern_helpers
haxelib git linc_directx https://github.com/Aidan63/linc_directx
```

Then open `runtime/Hx4Diva/Hx4Diva.vcxproj` in Visual Studio and build the project. Take the dll from `runtime/Hx4Diva/x64/Release/Hx4Diva.dll` and put it in a new mod for Project DIVA.

Then to compile haxe-side, do `haxe build.hxml` and take the resulting dll under `hxLib`. Then in your new mod for Project DIVA, make a `hxLib/` folder, and put the haxe-side dll in it. Ensure your mods `config.toml` loads specifically the Hx4Diva dll build from visual studio.

## Credits

[New Classics mod](https://divamodarchive.com/post/169) - I used their code as a ***HEAVY*** reference for how to structure Hx4Diva and the c++ runtime. I took it's [`diva.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/diva.h), [`diva.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/diva.cpp), and [`hooks.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/hooks.h) out of the repository, and used those as main parts in Hx4Diva. I'm honestly very glad that this was open source and had comments littered around, as it made a good example and base for me to build upon.
[Diva Mod Loader](https://github.com/blueskythlikesclouds/DivaModLoader/tree/0abc2c89229c4b307bfa1555656c54c2e5cff480) - I used the info in their [`README.MD`](https://github.com/blueskythlikesclouds/DivaModLoader/blob/0abc2c89229c4b307bfa1555656c54c2e5cff480/README.md) as a starting point for the Hx4Diva runtime.
