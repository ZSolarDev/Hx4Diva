package diva.types;

import cpp.Int32;

enum abstract HitState(Int32) from Int32 to Int32 {
    var Cool = 0;
    var Fine = 1;
    var Safe = 2;
    var Sad = 3;
    var WrongCool = 4;
    var WrongFine = 5;
    var WrongSafe = 6;
    var WrongSad = 7;
    var Worst = 8;
    var CoolDouble = 9;
    var FineDouble = 10;
    var SafeDouble = 11;
    var SadDouble = 12;
    var CoolTriple = 13;
    var FineTriple = 14;
    var SafeTriple = 15;
    var SadTriple = 16;
    var CoolQuad = 17;
    var FineQuad = 18;
    var SafeQuad = 19;
    var SadQuad = 20;
    var None = 21;
}