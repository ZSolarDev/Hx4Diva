package diva.types.prj;

import cpp.Reference;
import cpp.SizeT;

@:include('diva_types.h')
@:native('prj::vector')
@:structAccess @:unreflective
extern class PrjVector<T> {
	function size():SizeT;
	function empty():Bool;
	function clear():Void;
	@:native('at') function get(i:SizeT):Reference<T>;
}
