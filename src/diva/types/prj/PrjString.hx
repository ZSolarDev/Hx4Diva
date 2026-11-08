package diva.types.prj;

import cpp.ConstCharStar;
import cpp.SizeT;

@:include('diva_types.h')
@:native('prj::string')
@:structAccess @:unreflective
extern class PrjString {
	function c_str():ConstCharStar;
	function size():SizeT;
	function assign(s:ConstCharStar):Void;

	function new(s:ConstCharStar);
}
