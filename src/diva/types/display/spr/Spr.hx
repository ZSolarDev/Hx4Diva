package diva.types.display.spr;

import cpp.ConstCharStar;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.Star;
import cpp.UInt32;
import cpp.UInt32;
import cpp.Void as CppVoid;
import diva.types.prj.PrjString;

@:include('diva_types.h')
@:structAccess
@:unreflective
extern class Spr {
	// NOTE: Queues SprSet file to be loaded
	@:native('::spr::LoadSprSet') static function loadSprSet(id:UInt32, out:RawPointer<ConstCharStar>):Void;
	// NOTE: Returns true if SprSet file is still loading, false otherwise
	@:native('::spr::CheckSprSetLoading') static function checkSprSetLoading(id:UInt32):Bool;
	// NOTE: Free SprSet file from memory
	@:native('::spr::UnloadSprSet') static function unloadSprSet(id:UInt32):Void;
	// NOTE: Draw sprite to screen
	@:native('::spr::DrawSprite') static function drawSprite(args:RawPointer<SprArgs>):RawPointer<SprArgs>;
	// NOTE: Retrieves a font from the font list
	@:native('::spr::GetFont') static function getFont(font:RawPointer<FontInfo>, font_id:Int32):RawPointer<FontInfo>;
	@:native('::spr::GetLocaleFont') static function getLocaleFont(font:RawPointer<FontInfo>, id:Int32, a3:Bool):RawPointer<FontInfo>;
	@:native('::spr::SetFontSize') static function setFontSize(font:RawPointer<FontInfo>, w:Float32, h:Float32):Void;
	// NOTE: Draw text to the screen (UTF-8, char*)
	@:native('::spr::DrawTextA') static function drawTextA(params:RawPointer<TextArgs>, flags:UInt32, text:ConstCharStar):Void;
	@:native('::spr::DrawSimpleText') static function drawSimpleText(x:Float32, y:Float32, res:Int32, prio:Int32, text:ConstCharStar, center:Bool,
		color:UInt32, clip:RawPointer<Vec4>):Star<Star<CppVoid>>;
	// FROM: https://github.com/vixen256/ps4/tree/master/src/diva.cpp
	@:native('::spr::GetSpriteId') static function getSpriteId(a1:Star<CppVoid>, name:ConstCharStar):RawPointer<UInt32>;
}
