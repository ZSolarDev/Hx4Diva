package diva.types;

import cpp.Float32;

@:include('diva_types.h')
@:native('::diva::vec3')
@:structAccess
extern class Vec3 {
    @:native('x') var x:Float32;
    @:native('y') var y:Float32;
    @:native('z') var z:Float32;
}