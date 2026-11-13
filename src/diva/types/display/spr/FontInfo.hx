package diva.types.display.spr;

import cpp.Reference;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.Star;
import cpp.Void as CppVoid;

@:include('diva_types.h')
@:native('FontInfo')
@:structAccess
extern class FontInfo {
	@:native('font_id') var fontId:Int32;
	@:native('raw_font') var rawFont:Star<CppVoid>;
	@:native('spr_id') var sprId:Int32;
	@:native('font_size') var fontSize:Reference<Vec2>;
	@:native('font_box_size') var fontBoxSize:Reference<Vec2>;
	@:native('size') var size:Reference<Vec2>;
	@:native('scale') var scale:Reference<Vec2>;
	@:native('spacing') var spacing:Reference<Vec2>;
	@:native('::SetSize') function setSize(width:Float32, height:Float32):Void;

	@:native('new FontInfo') static function create():RawPointer<FontInfo>;
	@:native('::FontInfo::CreateSpriteFont') static function createSpriteFont(spriteId:Int32, width:Int32, height:Int32):RawPointer<FontInfo>;
}
