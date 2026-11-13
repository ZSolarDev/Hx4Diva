package diva.types.display.spr;

import cpp.Reference;
import cpp.UInt32;

@:include('diva_types.h')
@:native('::SpriteVertex')
@:structAccess
extern class SpriteVertex {
	@:native('pos') var pos:Reference<Vec3>;
	@:native('uv') var uv:Reference<Vec2>;
	// 0xAABBGGRR color
	@:native('color') var color:UInt32;
}
