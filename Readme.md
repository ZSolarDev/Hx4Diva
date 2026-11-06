# Hx4Diva

## Compiling

If you don't have haxe installed, get it off the website. OR you can get it with like winget or something:

```bat
winget install --id HaxeFoundation.Haxe
haxelib setup
```

After that or if you already had haxe installed, set up the libraries:

```bat
haxelib git hxcpp_extern_helpers https://github.com/Aidan63/hxcpp_extern_helpers
haxelib git linc_directx https://github.com/Aidan63/linc_directx
haxelib git linc_imgui https://github.com/Aidan63/linc_imgui

haxelib install hxp
haxelib run hxp --install-hxp-alias
```

Then you can simply just run:

```bat
hxp BuildMod
```

And you're done! The mod will be inside of `./Hx4Diva-TestMod/`, or whatever is in the `modOutput` field of the `mod.json`.

## Credits

[New Classics mod](https://divamodarchive.com/post/169) - I used their code as a ***HEAVY*** reference for how to structure Hx4Diva and the c++ runtime. I took it's [`diva.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/diva.h), [`diva.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/diva.cpp), and [`hooks.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/hooks.h) out of the repository, and used those as main parts in Hx4Diva. I'm honestly very glad that this was open source and had comments littered around, as it made a good example and base for me to build upon.
[Diva Mod Loader](https://github.com/blueskythlikesclouds/DivaModLoader/tree/0abc2c89229c4b307bfa1555656c54c2e5cff480) - I used the info in their [`README.MD`](https://github.com/blueskythlikesclouds/DivaModLoader/blob/0abc2c89229c4b307bfa1555656c54c2e5cff480/README.md) as a starting point for the Hx4Diva runtime.
