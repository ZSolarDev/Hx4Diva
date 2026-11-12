package diva.types.menu.sort;

import cpp.Int32;

// Since 1.0.0-alpha.3
enum abstract AllSortIndices(Int32) from Int32 to Int32 {
	var Name = SortIndex.NameAll;
	var Stars = SortIndex.StarsAll;
	var Singer = SortIndex.SingerAll;
	var Score = SortIndex.ScoreAll;
}
