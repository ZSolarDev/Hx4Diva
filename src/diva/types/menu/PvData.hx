package diva.types.menu;

import cpp.RawPointer;
import cpp.UInt8;

@:include('diva_types.h')
@:native('::pvsel::PvData')
@:structAccess
extern class PvData {
	@:native('data2') var data2:RawPointer<PvData2>;
	@:native('data') var data:RawPointer<UInt8>;
}
