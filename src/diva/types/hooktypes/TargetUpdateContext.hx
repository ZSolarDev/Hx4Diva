package diva.types.hooktypes;

import cpp.Float32;
import cpp.Star;

class TargetUpdateContext {
	public var game:Star<PVGameArcade>;
	public var dt:Float32;

	public function new() {}
}
