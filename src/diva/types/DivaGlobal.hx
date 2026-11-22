package diva.types;

import cpp.Reference;
import cpp.Star;
import diva.types.Vec2;

@:include('diva_types.h')
@:structAccess
@:unreflective
extern class DivaGlobal { // Will expand eventually..
	// NOTE: Converts a DSC gameplay position to screen space.
	@:native('::GetScaledPosition') static function getDSCScaledPosition(v:Reference<Vec2>):Vec2;
	// inline FUNCTION_PTR(PVGameData*, __fastcall, GetPVGameData, 0x140266720);
	@:native('::GetPVGameData') static function getPvGameData():Star<PVGameData>;
}
