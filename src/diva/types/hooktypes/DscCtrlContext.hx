package diva.types.hooktypes;

import cpp.Pointer;

class DscCtrlContext {
	public var data:Pointer<PVGamePvData>;
	public var entry:Pointer<PvDBEntry>;
	public var difficulty:Pointer<PvDBDifficulty>;
	public var path:String;
	public var result:Bool;

	public function new() {}
}
