package diva.types.menu.sort;

import cpp.Int32;

// Since 1.0.0-alpha.3
enum abstract SortMode(Int32) from Int32 to Int32 {
	var Name = 0;
	var Stars = 1;
	var Singer = 2;
	var Score = 3;
}
