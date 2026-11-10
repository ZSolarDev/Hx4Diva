package diva.types.hooktypes;

import cpp.Star;

class HitContext {
	public var game:Star<PVGameArcade>;
	public var target:Star<PvGameTarget>;
	public var result:HitState;

	public function new() {}
}
