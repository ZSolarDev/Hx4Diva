package diva.types.pv_db;

import cpp.Int32;
import cpp.Int64;

@:include('diva_types.h')
@:native('::pv_db::PvDBDifficulty')
@:structAccess
extern class PvDBDifficulty {
	@:native('difficulty') var difficulty:Int32;
	@:native('edition') var edition:Int32;
	@:native('extra') var extra:Int32;
	@:native('attributes') var attributes:Int64;
	@:native('script_file_name') var scriptFileName:RawStdString;
	@:native('level') var level:Int32;
	@:native('level_sort_index') var levelSortIndex:Int32;
	@:native('button_se') var buttonSE:RawStdString;
	@:native('success_se') var successSE:RawStdString;
	@:native('slide_se') var slideSE:RawStdString;
	@:native('slidechain_start_se') var slidechainStartSE:RawStdString;
	@:native('slidechain_se') var slidechainSE:RawStdString;
	@:native('slidechain_success_se') var slidechainSuccessSE:RawStdString;
	@:native('slidechain_failure_se') var slidechainFailureSE:RawStdString;
	@:native('slide_touch_se') var slideTouchSE:RawStdString;
	@:native('script_format') var scriptFormat:Int32;
}
