package diva.types.dsc;

import cpp.ConstCharStar;
import cpp.Int32;

@:include('diva_types.h')
@:native('::dsc::OpcodeInfo')
@:structAccess
extern class OpcodeInfo {
	@:native('id') var id:Int32;
	@:native('length') var length:Int32;
	@:native('length_old') var lengthOld:Int32;
	@:native('name') var name:ConstCharStar;
}
