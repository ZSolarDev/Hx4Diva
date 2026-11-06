package diva.types.hooktypes;

import cpp.Pointer;
import cpp.StdString;

class DscCtrlContext {
	public var data:Pointer<PvDBEntry>;
	public var path:String;
	public var result:Bool;

	public function new() {}
}
