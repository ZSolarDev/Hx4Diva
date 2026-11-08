package diva.types.menu;

import cpp.RawPointer;

@:include('diva_types.h')
@:native('PvDataPS4')
@:structAccess
extern class PvDataPS4 {
	@:native('data2') var data2:RawPointer<PvData2>;
}
