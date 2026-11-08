package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import diva.types.prj.PrjVector;

@:include('diva_types.h')
@:native('::pv_db::PvDBEntry')
@:structAccess
extern class PvDBEntry {
	@:native('pv_id') var pvId:Int32;
	@:native('date') var date:Int32;
	@:native('song_name') var songName:RawStdString;
	@:native('song_name_reading') var songNameReading:RawStdString;
	@:native('bpm') var bpm:Int32;
	@:native('song_file_name') var songFileName:RawStdString;
	@:native('sabi_start_time') var sabiStartTime:Float32;
	@:native('sabi_play_time') var sabiPlayTime:Float32;
	@:native('edit_type') var editType:Int32;
	@:native('disable_motfrm_calc_limit') var disableMotfrmCalcLimit:Bool;
	@:native('performers') var performers:PrjVector<PvDBPerformer>;
	// prj::vector<PvDBDifficulty>[5]>
	@:native('difficulties') var difficulties:RawPointer<PrjVector<PvDBDifficulty>>;
}
