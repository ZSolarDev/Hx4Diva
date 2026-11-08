package diva.types.menu;

import cpp.Int32;
import cpp.RawPointer;

@:include('diva_types.h')
@:native('::pvsel::CommonMenu')
@:structAccess
extern class CommonMenu {
	var selectedIndex:Int32;
	var maxCount:Int32;
}
