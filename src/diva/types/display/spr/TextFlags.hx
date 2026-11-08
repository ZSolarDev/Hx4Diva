package diva.types.spr;

import cpp.Int32;

enum abstract TextFlags(Int32) from Int32 to Int32 {
	var AlignLeft = 0x1;
	var AlignRight = 0x2;
	var AlignHCenter = 0x4;
	var AutoAlignHCenter = 0x8;
	var AlignVCenter = 0x10;
	var AutoAlignVCenter = 0x20;
	var Clip = 0x200;
	var Outline = 0x10000;

	var AutoAlign = AutoAlignHCenter | AutoAlignVCenter;
}
