package diva.types.display.aet;

import cpp.ConstCharStar;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.Star;
import cpp.UInt32;
import cpp.UInt32;
import cpp.Void as CppVoid;
import diva.types.prj.PrjString;

@:include('diva_types.h')
@:structAccess
@:unreflective
extern class Aet {
	// NOTE: Queues AetSet file to be loaded
	@:native('::aet::LoadAetSet') static function loadAetSet(id:UInt32, out:RawPointer<PrjString>):Void;
	// NOTE: Returns true if AetSet file is still loading, false otherwise
	@:native('::aet::CheckAetSetLoading') static function checkAetSetLoading(id:UInt32):Bool;
	// NOTE: Free AetSet file from memory
	@:native('::aet::UnloadAetSet') static function unloadAetSet(id:UInt32):Void;
	// NOTE: Plays an Aet layer described by the `args` variable passed in.
	@:native('::aet::Play') static function play(args:AetArgs, id:Int32):Int32;
	// NOTE: Returns the current from on an Aet object.
	@:native('::aet::GetFrame') static function getFrame(id:Int32):Float32;
	// NOTE: Returns whether an Aet object has ended playback. Will always return false if the loop flag is set.
	@:native('::aet::GetEnded') static function getEnded(id:Int32):Bool;
	// NOTE: Retrieves layout data for specific Aet object ID.
	@:native('::aet::GetComposition') static function getComposition(comp:RawPointer<AetComposition>, id:Int32):Void;
	// NOTE: Returns the time where the specified marker is placed on a layer
	@:native('::aet::GetMarkerTime') static function getMarkerTime(id:UInt32, layer:ConstCharStar, marker:ConstCharStar):Float32;
	// NOTE: Plays a layer from AET_GAM_CMN. Resolution mode is HDTV720
	@:native('::aet::PlayGamCmnLayer') static function playGamCmnLayer(prio:Int32, _a2:Star<CppVoid>, layer:ConstCharStar, pos:RawPointer<Vec2>):Int32;
	// NOTE: Sets the position of the layer object
	@:native('::aet::SetPosition') static function setPosition(id:Int32, pos:RawPointer<Vec3>):Void;
	// NOTE: Sets the scale of the layer object
	@:native('::aet::SetScale') static function setScale(id:Int32, scale:RawPointer<Vec3>):Void;
	// NOTE: Sets the current frame of the layer objects
	@:native('::aet::SetFrame') static function setFrame(id:Int32, frame:Float32):Void;
	// NOTE: Sets if the layer object should play (1) or pause (0)
	@:native('::aet::SetPlay') static function setPlay(id:Int32, play:Bool):Void;
	// NOTE: Sets if the layer object should be visible
	@:native('::aet::SetVisible') static function setVisible(id:Int32, visible:Bool):Void;
	// NOTE: Sets the opacity of the layer object
	@:native('::aet::SetOpacity') static function setOpacity(id:Int32, opacity:Float32):Void;

	@:native('::aet::CreateAetArgs') overload static function createAetArgs(args:RawPointer<AetArgs>, sceneId:UInt32, layerName:ConstCharStar, prio:Int32):Void;
	@:native('::aet::CreateAetArgs') overload static function createAetArgs(args:RawPointer<AetArgs>, sceneId:UInt32, layerName:ConstCharStar, flags:Int32,
		layer:Int32, prio:Int32, startMarker:ConstCharStar, endMarker:ConstCharStar):Void;

	// NOTE: Stops (removes, not pause!) an Aet layer object created by `diva::aet::Play`
	@:native('::aet::Stop') overload static function stop(id:Int32):Void;
	// NOTE: Same as the normal one, but sets id to 0 afterwards
	@:native('::aet::Stop') overload static function stop(id:RawPointer<Int32>):Void;
	// NOTE: Stops if GetEnded() returns true and returns the value of GetEnded().
	@:native('::aet::StopOnEnded') static function stopOnEnded(id:RawPointer<Int32>):Bool;

	@:native('::aet::PlayLayer') overload static function playLayer(sceneId:UInt32, prio:Int32, flags:Int32, layer:ConstCharStar, pos:RawPointer<Vec2>,
		index:Int32, startMarker:ConstCharStar, endMarker:ConstCharStar, startTime:Float32, endTime:Float32, a11:Int32, frmctl:Star<CppVoid>):Int32;
	@:native('::aet::PlayLayer') overload static function playLayer(sceneId:UInt32, prio:Int32, flags:Int32, layer:ConstCharStar, pos:RawPointer<Vec2>,
		startMarker:ConstCharStar, endMarker:ConstCharStar):Int32;
	@:native('::aet::PlayLayer') overload static function playLayer(sceneId:UInt32, prio:Int32, layer:ConstCharStar, action:Int32):Int32;

	@:native('::aet::GetLayout') static function getLayout(handle:Int32, layerName:ConstCharStar, out:RawPointer<AetLayout>):Bool;

	@:native('::aet::FindAetScene') static function findAetScene(name:ConstCharStar):RawPointer<AetSceneInfo>;
	@:native('::aet::FindAetSet') static function findAetSet(name:ConstCharStar):RawPointer<AetSetInfo>;
}
