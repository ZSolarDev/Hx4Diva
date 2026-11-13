package diva.types.display.aet;

import cpp.Reference;
import cpp.Float32;
import cpp.Int32;
import cpp.UInt32;
import cpp.UInt8;

@:include('diva_types.h')
@:native('AetLayout')
@:structAccess
extern class AetLayout {
	@:native('matrix') var matrix:Reference<Mat4>;
	@:native('position') var position:Reference<Vec3>;
	@:native('anchor') var anchor:Reference<Vec3>;
	@:native('width') var width:Float32;
	@:native('height') var height:Float32;
	@:native('opacity') var opacity:Float32;
	@:native('color') var color:UInt32;
	@:native('resolution_mode') var resolutionMode:Int32;
	@:native('blendMode') var blendMode:UInt8;
	@:native('transferFlags') var transferFlags:UInt8;
	@:native('trackMatte') var trackMatte:UInt8;

	function new();
}
