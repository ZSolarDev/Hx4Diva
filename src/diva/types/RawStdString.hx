package diva.types;

import cpp.ConstCharStar;

@:include('string')
@:native('std::string')
@:structAccess
@:unreflective
extern class RawStdString {
	function c_str():ConstCharStar;
	function size():Int;

	/**
	 * Turns this `RawStdString` into a `String`.
	 * 
	 * @since 1.0.0-alpha.3
	 */
	public inline function toString():String
		return c_str().toString();
}
