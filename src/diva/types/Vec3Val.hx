package diva.types;

import cpp.Float32;

@:include('diva_types.h')
@:native('::diva::vec3')
@:structAccess
extern class Vec3Val {
    var x:Float32;
    var y:Float32;
    var z:Float32;
    @:native('::MakeVec3') static function makeVec3(x:Float32, y:Float32, z:Float32):Vec3Val;
}