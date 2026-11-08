package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.Reference;

@:include('diva_types.h')
@:native('PVGameArcade')
@:structAccess
extern class PVGameArcade {
	@:native('play') var play:Bool;
	@:native('target_time') var targetTime:Float32;
	@:native('cool_early_window') var coolEarlyWindow:Float32;
	@:native('cool_late_window') var coolLateWindow:Float32;
	@:native('fine_early_window') var fineEarlyWindow:Float32;
	@:native('fine_late_window') var fineLateWindow:Float32;
	@:native('safe_early_window') var safeEarlyWindow:Float32;
	@:native('safe_late_window') var safeLateWindow:Float32;
	@:native('sad_early_window') var sadEarlyWindow:Float32;
	@:native('sad_late_window') var sadLateWindow:Float32;
	@:native('current_time') var currentTime:Float32;
	// Array, length is 64
	@:native('hit_effects') var hitEffects:RawPointer<Int32>;
	@:native('hit_effect_index') var hitEffectIndex:Int32;
	// Array, length is 64
	@:native('slide_hit_effects') var slideHitEffects:RawPointer<Int32>;
	@:native('slide_hit_effect_index') var slideHitEffectIndex:Int32;
	@:native('mute_slide_chime') var muteSlideChime:Bool;

	// Array, length is 64
	@:native('::ArcadeTargetAt') static function targetAt(arcade:PVGameArcade, index:Int):Reference<PvGameTarget>;
	@:native('::ArcadeCurrentTarget') static function curTarget(arcade:PVGameArcade):Reference<PvGameTarget>;
}
