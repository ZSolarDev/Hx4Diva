package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.Int64;
import cpp.StdString;

@:include('diva_types.h')
@:native('::pv_db::PvDBDifficulty')
@:structAccess
extern class PvDBDifficulty {
	@:native('difficulty') var difficulty:Int32;
	@:native('edition') var edition:Int32;
	@:native('extra') var extra:Int32;
	@:native('attributes') var attributes:Int64;
	@:native('script_file_name') var scriptFileName:StdString;
	@:native('level') var level:Int32;
	@:native('level_sort_index') var levelSortIndex:Int32;
	@:native('button_se') var buttonSE:StdString;
	@:native('success_se') var successSE:StdString;
	@:native('slide_se') var slideSE:StdString;
	@:native('slidechain_start_se') var slidechainStartSE:StdString;
	@:native('slidechain_se') var slidechainSE:StdString;
	@:native('slidechain_success_se') var slidechainSuccessSE:StdString;
	@:native('slidechain_failure_se') var slidechainFailureSE:StdString;
	@:native('slide_touch_se') var slideTouchSE:StdString;
	@:native('script_format') var scriptFormat:Int32;
}
