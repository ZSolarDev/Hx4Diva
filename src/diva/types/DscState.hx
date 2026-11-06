package diva.types;

import cpp.Int32;

enum abstract DscState(Int32) from Int32 to Int32 {
	var Idle = 0;
	var Load = 1;
	var Ready = 2;
	var Missing = 3;
}
