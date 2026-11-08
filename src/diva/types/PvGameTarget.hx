package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.Int64;
import cpp.Reference;
import diva.types.display.spr.SpriteVertex;

@:include('diva_types.h')
@:native('PvGameTarget')
@:structAccess
extern class PvGameTarget {
	@:native('target_type') var targetType:Int32;
	@:native('flying_time_remaining') var flyingTimeRemaining:Float32;
	@:native('player_hit_time') var playerHitTime:Float32;
	@:native('amplitude') var amplitude:Float32;
	@:native('freq') var frequency:Float32;
	@:native('cur_freq') var curFrequency:Float32;
	@:native('slide_chain_start') var slideChainStart:Bool;
	@:native('slide_chain_end') var slideChainEnd:Bool;
	@:native('slide_left') var slideLeft:Bool;
	@:native('slide_right') var slideRight:Bool;
	@:native('slide_chain') var slideChain:Bool;
	@:native('hit_time') var hitTime:Int64;
	@:native('target_aet') var targetAet:Int32;
	@:native('button_aet') var buttonAet:Int32;
	@:native('target_eff_aet') var targetEffAet:Int32;
	@:native('target_pos') var targetPos:Vec2;
	@:native('button_pos') var buttonPos:Vec2;
	@:native('delta_pos') var deltaPos:Vec2;
	@:native('delta_pos_sq') var deltaPosSQ:Vec2;
	@:native('vecA0') var vecA0:Vec2;
	@:native('note_active') var noteActive:Bool;
	@:native('out_start_time') var outStartTime:Float32;
	@:native('hit_state') var hitState:HitState;
	@:native('multi_count') var multiCount:Int32;
	@:native('button_opacity') var buttonOpacity:Float32;
	@:native('target_opacity') var targetOpacity:Float32;
	@:native('sudden_appear_frame') var suddenAppearFrame:Float32;
	@:native('scaling_end_time') var scalingEndTime:Float32;
	@:native('sprite_index') var spriteIndex:Int32;
	@:native('appear_time') var appearTime:Int64;
	@:native('kiseki_width') var kisekiWidth:Float32;
	@:native('target_index') var targetIndex:Int32;

	@:native('::TargetPrev') static function getPreviousTarget(target:PvGameTarget):Reference<PvGameTarget>;
	@:native('::TargetNext') static function getNextTarget(target:PvGameTarget):Reference<PvGameTarget>;
	@:native('::HasPrev') static function hasPreviousTarget(target:PvGameTarget):Bool;
	@:native('::HasNext') static function hasNextTarget(target:PvGameTarget):Bool;
	// kiseki means 'trail'. It's a list of 40 trail vertices.
	@:native('::KisekiAt') static function getKiseki(target:PvGameTarget, index:Int):Reference<SpriteVertex>;
}
