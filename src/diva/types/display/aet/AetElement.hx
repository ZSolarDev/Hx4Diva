package diva.types.display.aet;

import cpp.ConstCharStar;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import cpp.UInt32;

/**
 * This class makes it easier to interface with AET elements.
 * 
 * @since 1.0.0-alpha.1
 */
@:include('diva_types.h')
@:include('aet_helper.h')
@:native('AetElement')
@:structAccess
@:unreflective
extern class AetElement {
	@:native('new AetElement') static function create():RawPointer<AetElement>;
	@:native('new AetElement') static function createScene(sceneId:UInt32):RawPointer<AetElement>;
	@:native('delete') static function destroy(e:RawPointer<AetElement>):Void;

	@:native('SetScene') function setScene(id:UInt32):Void;
	@:native('SetLayer') overload function setLayer(name:ConstCharStar, flags:Int32, prio:Int32, resMode:AetResMode, startMarker:ConstCharStar,
		endMarker:ConstCharStar, pos:RawPointer<Vec3>):Bool;
	@:native('SetLayer') overload function setLayer(name:ConstCharStar, prio:Int32, resMode:AetResMode, action:AetAction):Bool;
	@:native('GetLayout') function getLayout(layerName:ConstCharStar, finalLayout:AetLayout):Bool;
	// Since 1.0.0-alpha.3
	@:native('SetScale') function setScale(scale:Vec3):Void;
	@:native('SetPosition') function setPosition(pos:Vec3):Void;
	@:native('SetOpacity') function setOpacity(opacity:Float32):Void;
	@:native('SetLoop') function setLoop(loop:Bool):Void;
	@:native('SetVisible') function setVisible(visible:Bool):Void;
	@:native('SetColor') function setColor(color:Int32):Void;
	@:native('SetMarkers') overload function setMarkers(startMarker:ConstCharStar, endMarker:ConstCharStar):Void;
	@:native('SetMarkers') overload function setMarkers(startMarker:ConstCharStar, endMarker:ConstCharStar, loop:Bool):Void;
	@:native('DrawSpriteAt') function drawSpriteAt(layerName:ConstCharStar, spriteId:UInt32, prio:Int32):Bool;
	@:native('DeleteHandle') function deleteHandle():Void;
	@:native('Remake') function remake():Void;

	// all since 1.0.0-alpha.3
	@:native('GetSceneID') function getSceneID():UInt32;
	@:native('GetArgs') function getArgs():AetArgs;
	@:native('Ended') function hasEnded():Bool;
	@:native('IsPlaying') function isPlaying():Bool;

	@:native('::GetLayoutAdjustedPosition') static function getLayoutAdjustedPosition(layout:AetLayout, layerName:ConstCharStar):Vec2;
	@:native('::DrawSpriteAtLayout') static function drawSpriteAtLayout(layout:AetLayout, layerName:ConstCharStar, spriteId:UInt32, prio:Int32, res:Int32,
		adjustPos:Bool):Void;
	@:native('::FindSpriteID') static function findSpriteId(name:ConstCharStar):UInt32;
	@:native('::FindSpriteIDWithLocale') static function findSpriteIdWithLocale(baseName:ConstCharStar):UInt32;
	@:native('::GetLanguageSuffix') static function getLanguageSuffix():RawStdString;
}
