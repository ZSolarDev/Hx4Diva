# Compiling

To compile, run:

```haxe
haxelib git hxcpp_extern_helpers https://github.com/Aidan63/hxcpp_extern_helpers
haxelib git linc_directx https://github.com/Aidan63/linc_directx
```

Then open `runtime/Hx4Diva/Hx4Diva.vcxproj` in Visual Studio and build the project. Take the dll from `runtime/Hx4Diva/x64/Release/Hx4Diva.dll` and put it in a new mod for Project DIVA.

Then to compile haxe-side, do `haxe build.hxml` and take the resulting dll under `hxLib`. Then in your new mod for Project DIVA, make a `hxLib/` folder, and put the haxe-side dll in it. Ensure your mods `config.toml` loads specifically the Hx4Diva dll build from visual studio.
