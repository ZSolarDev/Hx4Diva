package diva.types.hooktypes;

import cpp.Pointer;

class HitContext {
    public var game:Pointer<PVGameArcade>;
    public var target:Pointer<PvGameTarget>;
    public var result:HitState;

    public function new() {}
}