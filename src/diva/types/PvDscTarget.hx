package diva.types;

import cpp.Reference;
import cpp.Float32;
import cpp.Int32;

@:include('diva_types.h')
@:native('PvDscTarget')
@:structAccess
extern class PvDscTarget {
    @:native('type') var type:Int32;
    @:native('target_pos') var targetPos:Reference<Vec2>;
    @:native('start_pos') var startPos:Reference<Vec2>;
    @:native('amplitude') var amplitude:Float32;
    @:native('frequency') var frequency:Int32;
    @:native('slide_chain_start') var slideChainStart:Bool;
    @:native('slide_chain_end') var slideChainEnd:Bool;
    @:native('slide_chain_left') var slideChainLeft:Bool;
    @:native('slide_chain_right') var slideChainRight:Bool;
    @:native('slide_chain') var slideChain:Bool;
}