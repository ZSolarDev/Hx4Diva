package diva.types.prj;

import cpp.Reference;
import cpp.SizeT;

@:include('diva_types.h')
@:native('prj::map')
@:structAccess @:unreflective
extern class PrjMap<K, V> {
	function size():SizeT;
	function clear():Void;
	function count(key:K):SizeT;
	@:native('insert_or_assign') function set(key:K, value:V):Void;
	@:native('operator[]') function get(key:K):Reference<V>;

	function new();
}
