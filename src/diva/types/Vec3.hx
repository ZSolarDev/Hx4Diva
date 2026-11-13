package diva.types;

import cpp.Float32;
import cpp.Star;

@:include('diva_types.h')
@:native('::diva::vec3')
@:structAccess
extern class Vec3 {
	var x:Float32;
	var y:Float32;
	var z:Float32;
	@:native('new diva::vec3') static function alloc():Star<Vec3>;

	function new(x:Float32, y:Float32, z:Float32);
}
