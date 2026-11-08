package diva.types.display.aet;

import cpp.ConstCharStar;
import cpp.UInt32;

@:include('diva_types.h')
@:native('::AetSceneInfo')
@:structAccess
@:unreflective
extern class AetSceneInfo {
	@:native('id') var id:UInt32;
	@:native('name') var name:ConstCharStar;
}
