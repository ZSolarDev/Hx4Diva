package diva.types.hooktypes;

import cpp.Star;
import diva.types.pv_db.PvDBDifficulty;
import diva.types.pv_db.PvDBEntry;

class DscCtrlContext {
	public var data:Star<PVGamePvData>;
	public var entry:Star<PvDBEntry>;
	public var difficulty:Star<PvDBDifficulty>;
	public var path:String;
	public var result:Bool;

	public function new() {}
}
