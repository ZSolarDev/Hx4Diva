package diva.types.display.aet;

import cpp.Pointer;
import cpp.Reference;
import cpp.UInt32;

class AetElementContainer {
	public var __element(default, null):Pointer<AetElement> = null;

	public var element(get, never):Reference<AetElement>;

	private function get_element():Reference<AetElement>
		return __element.ref;

	public function new(?sceneId:UInt32)
		__element = sceneId != null ? Pointer.fromRaw(AetElement.createScene(sceneId)) : Pointer.fromRaw(AetElement.create());

	public function destroy():Void {
		AetElement.destroy(__element.raw);
		__element = null;
	}
}
