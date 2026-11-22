package diva.types.dsc;

import cpp.ConstStar;
import cpp.Int32;

@:include('diva_types.h')
@:structAccess
@:unreflective
extern class Dsc {
	// NOTE: Returns a pointer to a struct that describes DSC opcode <id>
	@:native('::dsc::GetOpcodeInfo') static function getOpcodeInfo(id:Int32):ConstStar<OpcodeInfo>;
}
