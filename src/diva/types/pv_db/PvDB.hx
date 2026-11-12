package diva.types.pv_db;

import cpp.Int32;
import cpp.RawPointer;

// Since 1.0.0-alpha.3
@:include('diva_types.h')
@:structAccess
@:unreflective
extern class PvDB {
	@:native('::pv_db::FindPVEntry') static function findPVEntry(pvId:Int32):RawPointer<PvDBEntry>;
	@:native('::pv_db::FindDifficulty') static function findDifficulty(entry:RawPointer<PvDBEntry>, difficulty:Int32, edition:Int32):RawPointer<PvDBDifficulty>;
}
