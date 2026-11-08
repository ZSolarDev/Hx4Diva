package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import diva.types.prj.PrjVector;

@:include('diva_types.h')
@:native('::pv_db::PvDBPerformer')
@:structAccess
extern class PvDBPerformer {
	@:native('type') var type:Int32;
	@:native('chara') var chara:Int32;
	@:native('costume') var costume:Int32;
	@:native('pv_costume') var pvCostume:RawPointer<Int32>;
	@:native('fixed') var fixed:Bool;
	@:native('exclude') var exclude:Int32;
	@:native('size') var size:Int32;
	@:native('pseudo_same_id') var pseudoSameId:Int32;
	@:native('item') var item:RawPointer<Int32>;
}
