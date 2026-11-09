> [!WARNING]
> *Many of the exposed types or features are untested simply due to my lack of experience modding Project DIVA Mega Mix+. If anyone would like to test this framework further, seriously or not, and tell me the results of what's broken and what isn't, please do.*

<div align="center">
<img width="400" src="https://github.com/ZSolarDev/Hx4Diva/blob/main/_art/Logo.png">
<h1 align="center">
  <img src="https://badgen.net/haxelib/d/Hx4Diva?color=EA8220&labelColor=333333&scale=1.5">
  <img src="https://badgen.net/haxelib/v/Hx4Diva?color=EA8220&labelColor=333333&scale=1.5">
  <img src="https://badgen.net/haxelib/license/Hx4Diva?color=EA8220&labelColor=333333&scale=1.5">
</h1>

### *Simple creation of [Hatsune Miku: Project DIVA Mega Mix+](https://miku.sega.com/megamixplus/index.html) mods in [Haxe](https://haxe.org).*
  
[***Welcome***](#welcome-to-hx4diva) • [***Setup***](#setup) • [***Planned Features***](#planned-features) • [***Credits***](#credits)
</div>

# Welcome to *Hx4Diva*

Hx4Diva is a modding framework for *Haxe* that allows you to mod *Project DIVA Mega Mix+*. Currently, it exposes:
- Simple hooking,
- Simple AET usage,
- Many, many structs exposed (with more to come),
- Simple task system,

...etc.

## Setup

Setting up Hx4Diva is simple.
- Install the haxelib: `haxelib install Hx4Diva`
- Run `haxelib run Hx4Diva setup`
- To make a project, you can use `hx4diva create [project name]`.
- To build the project into a working mod, you can then open the folder in terminal or something with a terminal, and run `hx4diva build`.

In case anything does fail during this process, [*don't hesitate to report an issue.*](https://github.com/ZSolarDev/Hx4Diva/issues).

## Planned Features

- Sound
- Keyboard input
- Controller input
- Assets
- Maybe more.

## Credits

- [New Classics](https://divamodarchive.com/post/169) - I used their code as a ***HEAVY*** reference for how to structure Hx4Diva and the c++ runtime. I took it's [`diva.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/diva.h), [`diva.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/diva.cpp), part of [`common.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/ui/common.cpp) and [`common.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/ui/common.h), [`hooks.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/hooks.h), and hooks/structs from [`pv_sel.h`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/ui/pv_sel.h), [`pv_sel_ps4.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/ui/pv_sel_ps4.cpp), [`pv_sel_switch.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/ui/pv_sel_switch.cpp), [`target.cpp`](https://github.com/mrcloverthecoder/nc/blob/c41d4f1c7113ff44dbc7afb888803ea252e201f6/src/game/target.cpp), and probably more, all from out of the repository, and used those as main parts in Hx4Diva. I'm honestly ***VERY*** glad that this was open source and had comments littered around, as it made a great example and base for me to build upon. HUGE CREDITS to Clover and anyone else that contributed to New Classics.
- [MMPlusMods](https://github.com/korenkonder/MMPlusMods) - I used the repository as a submodule, so that I could access more systems that belong to Project DIVA to expose to haxe. At the moment, I'm using their implementation of the task system.
- [Diva Mod Loader](https://github.com/blueskythlikesclouds/DivaModLoader/tree/0abc2c89229c4b307bfa1555656c54c2e5cff480) - I used the info in their [`README.MD`](https://github.com/blueskythlikesclouds/DivaModLoader/blob/0abc2c89229c4b307bfa1555656c54c2e5cff480/README.md) as a starting point for the Hx4Diva runtime.
