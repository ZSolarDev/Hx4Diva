package diva.types;

import cpp.Float32;
import cpp.Star;

@:include('diva_types.h')
@:native('::diva::vec2')
@:structAccess
extern class Vec2 {
	var x:Float32;
	var y:Float32;
	@:native('new diva::vec2') static function alloc():Star<Vec2>;

	function new(x:Float32, y:Float32);
}
