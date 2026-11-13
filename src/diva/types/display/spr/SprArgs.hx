package diva.types.display.spr;

import cpp.Int32;
import cpp.RawPointer;
import cpp.Reference;
import cpp.SizeT;
import cpp.Star;
import cpp.UInt32;
import cpp.UInt8;
import cpp.Void as CppVoid;

@:include('diva_types.h')
@:native('SprArgs')
@:structAccess
extern class SprArgs {
	@:native('kind') var kind:UInt32;
	@:native('id') var id:UInt32;
	@:native('color') var color:RawPointer<UInt8>;
	@:native('attr') var attr:Int32;
	@:native('blend') var blend:Int32;
	@:native('index') var index:Int32;
	@:native('layer') var layer:Int32;
	@:native('priority') var priority:Int32;
	@:native('resulution_mode_screen') var resolutionModeScreen:Int32;
	@:native('resulution_mode_sprite') var resolutionModeSprite:Int32;
	@:native('center') var center:Reference<Vec3>;
	@:native('trans') var trans:Reference<Vec3>;
	@:native('scale') var scale:Reference<Vec3>;
	@:native('rot') var rot:Reference<Vec3>;
	@:native('skew_angle') var skewAngle:Reference<Vec2>;
	@:native('mat') var mat:Reference<Mat4>;
	@:native('texture') var texture:Star<CppVoid>;
	@:native('shader') var shader:Int32;
	@:native('transform') var transform:Reference<Mat4>;
	@:native('vertex_array') var vertexArray:RawPointer<SpriteVertex>;
	@:native('num_vertex') var numVertex:SizeT;
	@:native('set_viewport') var setViewport:Bool;
	@:native('viewport') var viewport:Reference<Mat4>;
	@:native('flags') var flags:UInt32;
	@:native('sprite_size') var spriteSize:Reference<Vec2>;
	@:native('texture_pos') var texturePos:Reference<Vec2>;
	@:native('texture_size') var textureSize:Reference<Vec2>;
	@:native('tex') var tex:Star<CppVoid>;

	@:native('::SprArgNext') static function getNextSprArgs(SprArgs:SprArgs):Reference<SprArgs>;
	@:native('::HasSprArgsNext') static function hasNextSprArgs(SprArgs:SprArgs):Bool;
	@:native('new SprArgs') static function create():RawPointer<SprArgs>;
}
