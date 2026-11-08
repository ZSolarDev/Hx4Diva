package diva.types.display.aet;

import cpp.ConstCharStar;
import cpp.UInt32;
import haxe.Int32;

@:include('diva_types.h')
@:native('::AetSetInfo')
@:structAccess
@:unreflective
extern class AetSetInfo {
	@:native('id') var id:UInt32;
	@:native('name') var name:ConstCharStar;
	@:native('file_name') var fileName:ConstCharStar;
	@:native('index') var index:Int32;
	@:native('spr_set_id') var sprSetId:UInt32;
}
