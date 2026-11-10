package diva.types.hooktypes;

import cpp.Star;

class DscCtrlContext {
	public var data:Star<PVGamePvData>;
	public var entry:Star<PvDBEntry>;
	public var difficulty:Star<PvDBDifficulty>;
	public var path:String;
	public var result:Bool;

	public function new() {}
}
