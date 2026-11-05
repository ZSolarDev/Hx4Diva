package diva.types;

import cpp.Int64;
import cpp.Int32;

@:include('diva_types.h')
@:native('PvDscTargetGroup')
@:structAccess
extern class PvDscTargetGroup {
    @:native('target_count') var targetCount:Int32;
    @:native('spawn_time') var spawnTime:Int64;
    @:native('hit_time') var hitTime:Int64;
    @:native('slide_chain') var slideChain:Bool;

    // Array, length is 4
    @:native('::GroupTargetAt') public static function targetAt(targetGroup:PvDscTargetGroup, index:Int):PvDscTarget;
}