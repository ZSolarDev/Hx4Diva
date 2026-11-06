package diva.types;

import cpp.ConstCharStar;

@:include('string')
@:native('std::string')
@:structAccess
@:unreflective
extern class RawStdString {
	function c_str():ConstCharStar;
	function size():Int;
}
