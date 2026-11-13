package diva.types.display.aet;

import cpp.ConstCharStar;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.Reference;
import cpp.UInt32;
import cpp.Void as CppVoid;
import diva.types.prj.PrjMap;
import diva.types.prj.PrjString;

@:include('diva_types.h')
@:native('AetArgs')
@:structAccess
extern class AetArgs {
	@:native('scene_id') var sceneId:UInt32;
	@:native('layer_name') var layerName:ConstCharStar;
	@:native('start_marker') var startMarker:Reference<PrjString>;
	@:native('end_marker') var endMarker:Reference<PrjString>;
	@:native('loop_marker') var loopMarker:Reference<PrjString>;
	@:native('start_time') var startTime:Float32;
	@:native('end_time') var endTime:Float32;
	@:native('flags') var flags:Int32;
	@:native('index') var index:Int32;
	@:native('layer') var layer:Int32;
	@:native('prio') var prio:Int32;
	@:native('res_mode') var resMode:AetResMode;
	@:native('pos') var pos:Reference<Vec3>;
	@:native('rot') var rot:Reference<Vec3>;
	@:native('scale') var scale:Reference<Vec3>;
	@:native('anchor') var anchor:Reference<Vec3>;
	@:native('frame_speed') var frameSpeed:Float32;
	@:native('color') var color:Reference<Vec4>;
	@:native('layer_sprites') var layerSprites:Reference<PrjMap<PrjString, Int32>>;
	@:native('sound_path') var soundPath:Reference<PrjString>;
	@:native('sound_replace') var soundReplace:Reference<PrjMap<PrjString, PrjString>>;
	@:native('sound_queue_index') var soundQueueIndex:Int32;
	@:native('sprite_replace') var spriteReplace:Reference<PrjMap<UInt32, UInt32>>;
	@:native('sprite_texture') var spriteTexture:Reference<PrjMap<UInt32, RawPointer<CppVoid>>>;
	@:native('sprite_discard') var spriteDiscard:Reference<PrjMap<UInt32, UInt32>>;
	@:native('frame_rate_control') var frameRateControl:RawPointer<AetFrameRateControl>;
	@:native('sound_voice') var soundVoice:Bool;
	@:native('id') var id:Int32;
	@:native('pos_2') var pos2:Reference<Vec3>;

	@:native('new AetArgs') public static function create():RawPointer<AetArgs>;
	@:native('new AetArgs') public static function createLayer(scene:UInt32, layer:ConstCharStar, prio:Int32, markerMode:Int32):RawPointer<AetArgs>;
	@:native('delete') public static function destroy(a:RawPointer<AetArgs>):Void;
}
