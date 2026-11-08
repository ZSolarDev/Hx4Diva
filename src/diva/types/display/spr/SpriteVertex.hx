package diva.types.display.spr;

import cpp.UInt32;

@:include('diva_types.h')
@:native('::SpriteVertex')
@:structAccess
extern class SpriteVertex {
	@:native('pos') var pos:Vec3;
	@:native('uv') var uv:Vec2;
	// 0xAABBGGRR color
	@:native('color') var color:UInt32;
}
