package diva.types.display.spr;

import cpp.Reference;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.SizeT;
import cpp.UInt16;
import cpp.UInt32;

@:include('diva_types.h')
@:native('PrintWork')
@:structAccess
extern class PrintWork {
	@:native('color') var color:Int32;
	@:native('fill_color') var fillColor:Int32;
	@:native('clip') var clip:Bool;
	@:native('clip_data') var clipData:Reference<Vec4>;
	@:native('prio') var prio:Int32;
	@:native('layer') var layer:Int32;
	@:native('res_mode') var resMode:Int32;
	@:native('text_current') var textCurrent:Reference<Vec2>;
	@:native('line_origin') var lineOrigin:Reference<Vec2>;
	@:native('line_length') var lineLength:SizeT;
	@:native('font') var font:RawPointer<FontInfo>;
	@:native('empty_char') var emptyChar:UInt16;
	@:native('SetColor') function setColor(color:UInt32, fill:UInt32):Void;
	@:native('SetOpacity') function setOpacity(opacity:Float32):Void;

	@:native('new PrintWork') static function create():RawPointer<PrintWork>;
}
