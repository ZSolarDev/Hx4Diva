package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.StdString;

@:include('diva_types.h')
@:native('::pv_db::PvDBEntry')
@:structAccess
extern class PvDBEntry {
	@:native('pv_id') var pvId:Int32;
	@:native('date') var date:Int32;
	@:native('song_name') var songName:StdString;
	@:native('song_name_reading') var songNameReading:StdString;
	@:native('bpm') var bpm:Int32;
	@:native('song_file_name') var songFileName:StdString;
	@:native('sabi_start_time') var sabiStartTime:Float32;
	@:native('sabi_play_time') var sabiPlayTime:Float32;

	@:native('::DifficultySlotValid') public static function difficultySlotValid(slot:Int):Bool;
	@:native('::DifficultyCount') public static function difficultyCount(entry:PvDBEntry, slot:Int):Int;
	@:native('::DifficultyAt') public static function difficultyAt(entry:PvDBEntry, slot:Int, index:Int):PvDBDifficulty;
}
