package diva.types;

import cpp.Float32;

@:include('diva_types.h')
@:native('::diva::vec2')
@:structAccess
extern class Vec2Val {
    var x:Float32;
    var y:Float32;
    @:native('::MakeVec2') static function makeVec2(x:Float32, y:Float32):Vec2Val;
}