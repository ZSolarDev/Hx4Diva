package diva.types.display.aet;

import cpp.Float32;

// Since 1.0.0-alpha.3
@:include('diva_types.h')
@:native('AetFrameRateControl')
@:structAccess
extern class AetFrameRateControl {
	@:native('frame_speed') var frameSpeed:Float32;
}
