package diva.types.menu;

import cpp.RawPointer;
import cpp.SizeT;
import cpp.UInt8;
import diva.types.prj.PrjVector;

@:include('diva_types.h')
@:native('::pvsel::SelPvList')
@:structAccess
extern class SelPvList {
	@:native('pv_data') var pvData:RawPointer<PrjVector<RawPointer<PvData>>>;
	@:native('GetSongCount') function getSongCount():SizeT;
}
