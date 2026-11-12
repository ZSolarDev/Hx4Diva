package diva.types.display.aet;

import cpp.Int32;

// Since 1.0.0-alpha.3
enum abstract AetFlags(Int32) from Int32 to Int32 {
	var None = 0x000000;
	var End = 0x000001;
	var Reverse = 0x000002;
	var Pause = 0x000004;
	var Hidden = 0x000008;
	var Loop = 0x010000;
	var Play_Once = 0x020000;
	var FlipH = 0x040000;
	var FlipV = 0x080000;
	var Flag100000 = 0x100000;

	public inline function has(flag:AetFlags):Bool
		return(this & flag) == flag;

	public inline function hasAny(flags:AetFlags):Bool
		return(this & flags) != 0;
}
