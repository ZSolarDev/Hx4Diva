package diva.types;

import cpp.Float32;
import cpp.Star;

@:include('diva_types.h')
@:native('::diva::vec4')
@:structAccess
extern class Vec4 {
	var x:Float32;
	var y:Float32;
	var z:Float32;
	var w:Float32;
	@:native('new diva::vec4') static function alloc():Star<Vec4>;

	function new(x:Float32, y:Float32, z:Float32, w:Float32);
}
