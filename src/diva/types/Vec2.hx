package diva.types;

import cpp.Float32;

@:include('diva_types.h')
@:native('::diva::vec2')
@:structAccess
extern class Vec2 {
    @:native('x') var x:Float32;
    @:native('y') var y:Float32;
}