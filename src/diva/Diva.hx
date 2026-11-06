package diva;

import cpp.Pointer;
import cpp.Reference;
import cpp.Star;
import cpp.StdString;
import cpp.vm.Gc;
import d3d11.interfaces.D3d11Device.NativeID3D11Device;
import d3d11.interfaces.D3d11Device;
import d3d11.interfaces.D3d11DeviceContext.NativeID3D11DeviceContext;
import d3d11.interfaces.D3d11DeviceContext;
import diva.hooks.*;
import diva.types.*;
import diva.types.hooktypes.*;
import dxgi.interfaces.DxgiSwapChain.NativeIDXGISwapChain;
import dxgi.interfaces.DxgiSwapChain;
import haxe.Json;
import haxe.Log;
import haxe.PosInfos;
import haxe.Resource;

/**
 * The main class you'll use to interact with Project DIVA.
 * 
 * @since 1.0.0
 */
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml("diva", "../../"))
#end
@:include('diva_types.h')
// I am technically sharing the diva namespace between
// diva_types.h and my package, but hxcpp has special naming conventions
// internally, so it shouldn't be an issue.
@:cppFileCode('
#include <string>

extern "C" __declspec(dllexport) void PreInit() {
    ::diva::Diva_obj::preInit();
}
extern "C" __declspec(dllexport) void Init() {
    ::diva::Diva_obj::init();
}
extern "C" __declspec(dllexport) void PostInit() {
    ::diva::Diva_obj::postInit();
}
extern "C" __declspec(dllexport) void D3DInit(IDXGISwapChain* swapChain, ID3D11Device* device, ID3D11DeviceContext* deviceContext) {
    ::diva::Diva_obj::onD3DInit(swapChain, device, deviceContext);
}
extern "C" __declspec(dllexport) void OnFrame(IDXGISwapChain* swapChain) {
    ::diva::Diva_obj::onFrame(swapChain);
}
extern "C" __declspec(dllexport) void OnResize(IDXGISwapChain* swapChain) {
    ::diva::Diva_obj::onResize(swapChain);
}

// Game hooks
extern "C" __declspec(dllexport) void OnPvInit() {
    ::diva::Diva_obj::onPvInit();
}

extern "C" __declspec(dllexport) void OnPvInitComplete() {
    ::diva::Diva_obj::onPvInitComplete();
}

extern "C" __declspec(dllexport) void OnPvUpdate() {
    ::diva::Diva_obj::onPvUpdate();
}

extern "C" __declspec(dllexport) void OnPvExit() {
    ::diva::Diva_obj::onPvExit();
}

extern "C" __declspec(dllexport) void OnPvReset() {
    ::diva::Diva_obj::onPvReset();
}

extern "C" __declspec(dllexport) void OnPvGetHitState(PVGameArcade* game, PvGameTarget* target, HitState* result) {
    ::diva::Diva_obj::onPvGetHitState(game, target, result);
}

extern "C" __declspec(dllexport) void OnLoadDscUpdate(pv_db::PvDBEntry* data, std::string& path, bool* result) {
    ::diva::Diva_obj::onLoadDscUpdate(data, path, result);
}
')
class Diva {
	/**
	 * The name of the mod.
	 * 
	 * @since 1.0.0
	 */
	public static var modName:String = 'UnknownMod';

	/**
	 * The version of the mod.
	 * 
	 * @since 1.0.0
	 */
	public static var modVersion:Null<String> = null;

	/**
	 * The current `DxgiSwapChain`. Detect changes on the `onSwapChain`
	 * game hook.
	 * 
	 * @since 1.0.0
	 */
	public static var curSwapChain(default, null):DxgiSwapChain;

	/**
	 * The current `D3d11Device`. This should never change.
	 * 
	 * @since 1.0.0
	 */
	public static var curDevice(default, null):D3d11Device;

	/**
	 * The current `D3d11DeviceContext`. This should never change.
	 * 
	 * @since 1.0.0
	 */
	public static var curDeviceContext(default, null):D3d11DeviceContext;

	/**
	 * The global hook manager. If you want to hook into Project DIVA,
	 * use this.
	 * 
	 * @see `DHookManager`
	 * @since 1.0.0
	 */
	public static var hookManager:DHookManager;

	/**
	 * Initializes the mod.
	 * 
	 * @param name The name of the mod.
	 * @param version The version of the mod. Optional.
	 * @since 1.0.0
	 */
	public static function initMod() {
		Log.trace = (v:Dynamic, ?p:PosInfos) -> DLogger.info(v);
		Gc.enable(false);
		var data = Resource.getString('modData');
		if (data != null) {
			var modData = Json.parse(data);
			modName = modData.name ?? modName;
			modVersion = modData.version ?? modVersion;
		}
		hookManager = new DHookManager();
	}

	static function preInit()
		for (hook in hookManager.modHooks['PreInit'].copy())
			runModHook(hook);

	static function init()
		for (hook in hookManager.modHooks['Init'].copy())
			runModHook(hook);

	static function postInit()
		for (hook in hookManager.modHooks['PostInit'].copy())
			runModHook(hook);

	static function onD3DInit(rawSwapChain:Star<NativeIDXGISwapChain>, rawDevice:Star<NativeID3D11Device>, rawDeviceContext:Star<NativeID3D11DeviceContext>) {
		curSwapChain = wrapSwapChain(rawSwapChain);
		curDevice = wrapDevice(rawDevice);
		curDeviceContext = wrapDeviceContext(rawDeviceContext);
		for (hook in hookManager.modHooks['D3DInit'].copy())
			runModHook(hook, curSwapChain, curDevice, curDeviceContext);
		for (hook in hookManager.gameHooks['OnSwapChain'].copy())
			runGameHook(hook, curSwapChain);
	}

	static function onFrame(rawSwapChain:Star<NativeIDXGISwapChain>) {
		if (rawSwapChain != curSwapChain.ptr) {
			curSwapChain = wrapSwapChain(rawSwapChain);
			for (hook in hookManager.gameHooks['OnSwapChain'].copy())
				runGameHook(hook, curSwapChain);
		}
		for (hook in hookManager.modHooks['OnFrame'].copy())
			runModHook(hook, curSwapChain);
	}

	static function onResize(rawSwapChain:Star<NativeIDXGISwapChain>) {
		if (rawSwapChain != curSwapChain.ptr) {
			curSwapChain = wrapSwapChain(rawSwapChain);
			for (hook in hookManager.gameHooks['OnSwapChain'].copy())
				runGameHook(hook, curSwapChain);
		}
		for (hook in hookManager.modHooks['OnResize'].copy())
			runModHook(hook, curSwapChain);
	}

	// --------- GAME HOOKS --------- //
	static function onPvInit()
		for (hook in hookManager.gameHooks['OnPvInit'].copy())
			runGameHook(hook);

	static function onPvInitComplete()
		for (hook in hookManager.gameHooks['OnPvInitComplete'].copy())
			runGameHook(hook);

	static function onPvUpdate()
		for (hook in hookManager.gameHooks['OnPvUpdate'].copy())
			runGameHook(hook);

	static function onPvExit()
		for (hook in hookManager.gameHooks['OnPvExit'].copy())
			runGameHook(hook);

	static function onPvReset()
		for (hook in hookManager.gameHooks['OnPvReset'].copy())
			runGameHook(hook);

	static var hitCtx:HitContext = new HitContext();

	static function onPvGetHitState(game:Star<PVGameArcade>, target:Star<PvGameTarget>, result:Pointer<HitState>) {
		hitCtx.game = Pointer.fromStar(game);
		hitCtx.target = Pointer.fromStar(target);
		hitCtx.result = result.ref;

		for (hook in hookManager.gameHooks['OnPvGetHitState'].copy()) {
			switch (hook) {
				case OnPvGetHitState(cb):
					try {
						cb(hitCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnPvGetHitState game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}

		result.ref = hitCtx.result;
	}

	static var dscCtrlCtx:DscCtrlContext = new DscCtrlContext();

	static function onLoadDscUpdate(data:Star<PvDBEntry>, path:StdString, result:Pointer<Bool>) {
		dscCtrlCtx.data = Pointer.fromStar(data);
		dscCtrlCtx.path = path.toString();
		dscCtrlCtx.result = result.ref;

		for (hook in hookManager.gameHooks['OnLoadDscUpdate'].copy()) {
			switch (hook) {
				case OnLoadDscUpdate(cb):
					try {
						cb(dscCtrlCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnLoadDscUpdate game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}

		result.ref = dscCtrlCtx.result;
	}

	// --------- UTILS --------- //
	static function wrapSwapChain(rawPtr:Star<NativeIDXGISwapChain>):DxgiSwapChain {
		var obj = new DxgiSwapChain();
		untyped __cpp__('{0}->ptr = {1}', obj, rawPtr);
		return obj;
	}

	static function wrapDevice(rawPtr:Star<NativeID3D11Device>):D3d11Device {
		var obj = new D3d11Device();
		untyped __cpp__('{0}->ptr = {1}', obj, rawPtr);
		return obj;
	}

	static function wrapDeviceContext(rawPtr:Star<NativeID3D11DeviceContext>):D3d11DeviceContext {
		var obj = new D3d11DeviceContext();
		untyped __cpp__('{0}->ptr = {1}', obj, rawPtr);
		return obj;
	}

	static function runModHook(hook:DModHook, args:...Dynamic) {
		try {
			var argList = args.toArray();
			switch (hook) {
				case PreInit(preInitHook):
					preInitHook();
				case Init(initHook):
					initHook();
				case PostInit(postInitHook):
					postInitHook();
				case D3DInit(d3dInitHook):
					d3dInitHook(argList[0], argList[1], argList[2]);
				case OnFrame(onFrameHook):
					onFrameHook(argList[0]);
				case OnResize(onResizeHook):
					onResizeHook(argList[0]);
			}
		} catch (e) {
			DLogger.error('Uncaught error during ${Type.enumConstructor(hook)} mod hook: ${e.message}\nStack:\n${e.stack.toString()}');
		}
	}

	static function runGameHook(hook:DGameHook, args:...Dynamic) {
		try {
			var argList = args.toArray();
			switch (hook) {
				case OnSwapChain(onSwapChain):
					onSwapChain(argList[0]);
				case OnPvInit(onPvInitHook):
					onPvInitHook();
				case OnPvInitComplete(onPvInitCompleteHook):
					onPvInitCompleteHook();
				case OnPvUpdate(onPvUpdateHook):
					onPvUpdateHook();
				case OnPvExit(onPvExitHook):
					onPvExitHook();
				case OnPvReset(onPvResetHook):
					onPvResetHook();
				default:
			}
		} catch (e) {
			DLogger.error('Uncaught error during ${Type.enumConstructor(hook)} game hook: ${e.message}\nStack:\n${e.stack.toString()}');
		}
	}
}
