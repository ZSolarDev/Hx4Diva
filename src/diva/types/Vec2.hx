package diva.types;

import cpp.Float32;

@:include('diva_types.h')
@:native('::diva::vec2')
@:structAccess
extern class Vec2 {
	var x:Float32;
	var y:Float32;

	function new(x:Float32, y:Float32);
}
