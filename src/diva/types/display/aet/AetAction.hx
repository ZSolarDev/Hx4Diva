package diva.types.display.aet;

import cpp.Int32;

enum abstract AetAction(Int32) from Int32 to Int32 {
	var None = 0;
	var InOnce = 1;
	var InLoop = 2;
	var Loop = 3;
	var OutOnce = 4;
	var SpecialOnce = 5;
	var SpecialLoop = 6;
}
