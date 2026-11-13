package diva.types.display.spr;

import cpp.Reference;
import cpp.Float32;
import cpp.RawPointer;

@:include('diva_types.h')
@:native('TextArgs')
@:structAccess
extern class TextArgs {
	@:native('max_width') var maxWidth:Float32;
	@:native('print_work') var printWork:Reference<PrintWork>;
	@:native('new TextArgs') static function create():RawPointer<TextArgs>;
}
