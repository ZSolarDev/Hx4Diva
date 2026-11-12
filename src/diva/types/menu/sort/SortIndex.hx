package diva.types.menu.sort;

import cpp.Int32;

// Since 1.0.0-alpha.3
enum abstract SortIndex(Int32) from Int32 to Int32 {
	// Sorting by name.
	var NameAB = 0;
	var NameCD = 1;
	var NameEH = 2;
	var NameIL = 3;
	var NameMN = 4;
	var NameOR = 5;
	var NameS = 6;
	var NameT = 7;
	var NameUZ = 8;
	var Name19 = 9;
	var NameAll = 10;
	var NameFav = 11;

	// Sorting by stars.
	var Stars6 = 10;
	var Stars65 = 11;
	var Stars7 = 12;
	var Stars75 = 13;
	var Stars8 = 14;
	var Stars85 = 15;
	var Stars9 = 16;
	var Stars95 = 17;
	var Stars10 = 18;
	var StarsAll = 19;
	var StarsFav = 20;

	// Sorting by singer.
	var SingerMiku = 0;
	var SingerRin = 1;
	var SingerLen = 2;
	var SingerLuka = 3;
	var SingerKaito = 4;
	var SingerMeiko = 5;
	var SingerAll = 6;
	var SingerFav = 7;

	// Sorting by score.
	var ScoreNC = 0;
	var ScoreStandard = 1;
	var ScoreGreat = 2;
	var ScoreExcellent = 3;
	var ScorePerfect = 4;
	var ScoreAll = 5;
	var ScoreFav = 6;
}
