package diva;

import cpp.Float32;
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
import diva.task.*;
import diva.types.*;
import diva.types.hooktypes.*;
import diva.types.menu.*;
import dxgi.interfaces.DxgiSwapChain.NativeIDXGISwapChain;
import dxgi.interfaces.DxgiSwapChain;
import haxe.Json;
import haxe.Log;
import haxe.PosInfos;
import haxe.Resource;

/**
 * The main class you'll use to interact with the game.
 * 
 * @since 1.0.0-alpha.1
 */
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml("diva", "../../"))
#end
@:include('diva_types.h')
@:include('string')
// I am technically sharing the diva namespace between
// diva_types.h and my package, but hxcpp has special naming conventions
// internally, so it shouldn't be an issue.
@:cppFileCode('
#include <cstdio>
// Mod hooks
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

extern "C" __declspec(dllexport) void OnLoadDscUpdate(PVGamePvData* data, pv_db::PvDBEntry* entry, pv_db::PvDBDifficulty* difficulty, std::string& path, bool* result) {
    ::diva::Diva_obj::onLoadDscUpdate(data, entry, difficulty, path, result);
}

extern "C" __declspec(dllexport) void OnPvDBParseEntry(pv_db::PvDBEntry* entry, bool* result) {
    ::diva::Diva_obj::onPvDBParseEntry(entry, result);
}

extern "C" __declspec(dllexport) void OnDrawGame(PVGameArcade* game) {
    ::diva::Diva_obj::onDrawGame(game);
}

extern "C" __declspec(dllexport) void OnDrawGamePost(PVGameArcade* game) {
    ::diva::Diva_obj::onDrawGamePost(game);
}

extern "C" __declspec(dllexport) void OnUpdateTargets(PVGameArcade* game, float dt) {
    ::diva::Diva_obj::onUpdateTargets(game, dt);
}

extern "C" __declspec(dllexport) void OnDrawKiseki(PvGameTarget* target) {
    ::diva::Diva_obj::onDrawKiseki(target);
}

// FT PV selection menu hooks
extern "C" __declspec(dllexport) void OnPvMenuInitFT(PVselPS4* sel, bool* result) {
    ::diva::Diva_obj::onPvMenuInitFT(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuCreateSortedPVListFT(PVselPS4* sel) {
    ::diva::Diva_obj::onPvMenuCreateSortedPVListFT(sel);
}

extern "C" __declspec(dllexport) void OnPvMenuCtrlFT(PVselPS4* sel, bool* result) {
    ::diva::Diva_obj::onPvMenuCtrlFT(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuDestFT(bool* result) {
    ::diva::Diva_obj::onPvMenuDestFT(result);
}

extern "C" __declspec(dllexport) void OnPvMenuDispFT() {
    ::diva::Diva_obj::onPvMenuDispFT();
}

// MM+ PV selection menu hooks
extern "C" __declspec(dllexport) void OnPvMenuInit(bool* result) {
    ::diva::Diva_obj::onPvMenuInit(result);
}

extern "C" __declspec(dllexport) void OnPvMenuCreateSortedPVList(PVSelectorSwitch* sel, bool* result) {
    ::diva::Diva_obj::onPvMenuCreateSortedPVList(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuCtrl(PVSelectorSwitch* sel, bool* result) {
    ::diva::Diva_obj::onPvMenuCtrl(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuDest(bool* result) {
    ::diva::Diva_obj::onPvMenuDest(result);
}

extern "C" __declspec(dllexport) void OnPvMenuDisp() {
    ::diva::Diva_obj::onPvMenuDisp();
}

// Tasks
extern "C" __declspec(dllexport) void OnHxTaskCtrl() {
    ::diva::Diva_obj::onHxTaskCtrl();
}

extern "C" __declspec(dllexport) void OnHxTaskDisp() {
    ::diva::Diva_obj::onHxTaskDisp();
}

extern "C" __declspec(dllexport) void OnHxTaskBasic() {
    ::diva::Diva_obj::onHxTaskBasic();
}
')
class Diva {
	/**
	 * The name of the mod.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static var modName:String = 'UnknownMod';

	/**
	 * The version of the mod.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static var modVersion:Null<String> = null;

	/**
	 * The current `DxgiSwapChain`. Detect changes on the `onSwapChain`
	 * game hook.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static var curSwapChain(default, null):DxgiSwapChain;

	/**
	 * The current `D3d11Device`. This should never change.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static var curDevice(default, null):D3d11Device;

	/**
	 * The current `D3d11DeviceContext`. This should never change.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static var curDeviceContext(default, null):D3d11DeviceContext;

	/**
	 * The global hook manager. This is mainly what you'd use to hook into
	 * the game.
	 * 
	 * @see `DHookManager`
	 * @since 1.0.0-alpha.1
	 */
	public static var hookManager:DHookManager;

	/**
	 * The global task manager. This is mainly what you'd use to create
	 * tasks that run in the game.
	 * 
	 * @see `DTaskManager`
	 * @since 1.0.0-alpha.1
	 */
	public static var taskManager:DTaskManager;

	/**
	 * Initializes the mod. Required.
	 * 
	 * @since 1.0.0-alpha.1
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
		taskManager = new DTaskManager();
	}

	/**
	 * Turns a `RawStdString` into a `String`.
	 * 
	 * @param rawStr The string to convert.
	 * @since 1.0.0-alpha.1
	 */
	public static function toString(rawStr:RawStdString):String
		return rawStr.c_str().toString();

	// --------- MOD HOOKS --------- //
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
		for (hook in hookManager.modHooks['OnSwapChain'].copy())
			runModHook(hook, curSwapChain);
	}

	static function onFrame(rawSwapChain:Star<NativeIDXGISwapChain>) {
		if (rawSwapChain != curSwapChain.ptr) {
			curSwapChain = wrapSwapChain(rawSwapChain);
			for (hook in hookManager.modHooks['OnSwapChain'].copy())
				runModHook(hook, curSwapChain);
		}
		for (hook in hookManager.modHooks['OnFrame'].copy())
			runModHook(hook, curSwapChain);
	}

	static function onResize(rawSwapChain:Star<NativeIDXGISwapChain>) {
		if (rawSwapChain != curSwapChain.ptr) {
			curSwapChain = wrapSwapChain(rawSwapChain);
			for (hook in hookManager.modHooks['OnSwapChain'].copy())
				runModHook(hook, curSwapChain);
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

	static function onPvGetHitState(game:Star<PVGameArcade>, target:Star<PvGameTarget>, result:Pointer<HitState>) {
		var hitCtx:HitContext = new HitContext();
		hitCtx.game = game;
		hitCtx.target = target;
		hitCtx.result = result.ref;

		for (hook in hookManager.gameHooks['OnPvGetHitState'].copy()) {
			switch (hook) {
				case OnPvGetHitState(onPvGetHitState):
					try {
						onPvGetHitState(hitCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnPvGetHitState game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}

		result.ref = hitCtx.result;
	}

	static function onLoadDscUpdate(data:Star<PVGamePvData>, entry:Star<PvDBEntry>, difficulty:Star<PvDBDifficulty>, path:RawStdString, result:Pointer<Bool>) {
		var dscCtrlCtx:DscCtrlContext = new DscCtrlContext();
		dscCtrlCtx.data = data;
		dscCtrlCtx.entry = entry != null ? entry : null;
		dscCtrlCtx.difficulty = difficulty != null ? difficulty : null;
		dscCtrlCtx.path = toString(path);
		dscCtrlCtx.result = result.ref;

		for (hook in hookManager.gameHooks['OnLoadDscUpdate'].copy()) {
			switch (hook) {
				case OnLoadDscUpdate(onLoadDscUpdate):
					try {
						onLoadDscUpdate(dscCtrlCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnLoadDscUpdate game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}

		result.ref = dscCtrlCtx.result;
	}

	static function onPvDBParseEntry(entry:Star<PvDBEntry>, result:Pointer<Bool>) {
		var pvdbParseCtx = new PvDBParseContext();
		pvdbParseCtx.entry = entry;
		pvdbParseCtx.result = result.ref;

		for (hook in hookManager.gameHooks['OnPvDBParseEntry'].copy()) {
			switch (hook) {
				case OnPvDBParseEntry(onPvDBParseEntry):
					try {
						onPvDBParseEntry(pvdbParseCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnPvDBParseEntry game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}

		result.ref = pvdbParseCtx.result;
	}

	static function onDrawGame(game:Star<PVGameArcade>) {
		var drawCtx:DrawContext = new DrawContext();
		drawCtx.game = game;
		for (hook in hookManager.gameHooks['OnDrawGame'].copy()) {
			switch (hook) {
				case OnDrawGame(onDrawGame):
					try {
						onDrawGame(drawCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnDrawGame game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	static function onDrawGamePost(game:Star<PVGameArcade>) {
		var drawCtx:DrawContext = new DrawContext();
		drawCtx.game = game;
		for (hook in hookManager.gameHooks['OnDrawGamePost'].copy()) {
			switch (hook) {
				case OnDrawGamePost(onDrawGamePost):
					try {
						onDrawGamePost(drawCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnDrawGamePost game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	static function onUpdateTargets(game:Star<PVGameArcade>, dt:Float32) {
		var targetUpdateCtx:TargetUpdateContext = new TargetUpdateContext();
		targetUpdateCtx.game = game;
		targetUpdateCtx.dt = dt;
		for (hook in hookManager.gameHooks['OnUpdateTargets'].copy()) {
			switch (hook) {
				case OnUpdateTargets(onUpdateTargets):
					try {
						onUpdateTargets(targetUpdateCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnUpdateTargets game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	static function onDrawKiseki(game:Star<PvGameTarget>) {
		var targetCtx:TargetContext = new TargetContext();
		targetCtx.game = game;
		for (hook in hookManager.gameHooks['OnDrawKiseki'].copy()) {
			switch (hook) {
				case OnDrawKiseki(onDrawKiseki):
					try {
						onDrawKiseki(targetCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnDrawKiseki game hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	// --------- FT PV SELECTION MENU HOOKS --------- //
	static function onPvMenuInitFT(sel:Star<PVselPS4>, result:Pointer<Bool>) {
		var menuSelCtx:FTMenuSelectionContext = new FTMenuSelectionContext();
		menuSelCtx.selection = sel;
		menuSelCtx.result = result.ref;
		for (hook in hookManager.dftMenuHooks['OnMenuInit'].copy()) {
			switch (hook) {
				case OnMenuInit(onMenuInit):
					try {
						onMenuInit(menuSelCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuInit[FT] menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = menuSelCtx.result;
	}

	static function onPvMenuCreateSortedPVListFT(sel:Star<PVselPS4>) {
		var basicMenuSelCtx:BasicFTMenuSelectionContext = new BasicFTMenuSelectionContext();
		basicMenuSelCtx.selection = sel;
		for (hook in hookManager.dftMenuHooks['OnMenuCreateSortedPVList'].copy()) {
			switch (hook) {
				case OnMenuCreateSortedPVList(onMenuCreateSortedPVList):
					try {
						onMenuCreateSortedPVList(basicMenuSelCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuCreateSortedPVList[FT] menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	static function onPvMenuCtrlFT(sel:Star<PVselPS4>, result:Pointer<Bool>) {
		var menuSelCtx:FTMenuSelectionContext = new FTMenuSelectionContext();
		menuSelCtx.selection = sel;
		menuSelCtx.result = result.ref;
		for (hook in hookManager.dftMenuHooks['OnMenuUpdate'].copy()) {
			switch (hook) {
				case OnMenuUpdate(onMenuUpdate):
					try {
						onMenuUpdate(menuSelCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuUpdate[FT] menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = menuSelCtx.result;
	}

	static function onPvMenuDispFT() {
		for (hook in hookManager.dftMenuHooks['OnMenuDraw'].copy()) {
			switch (hook) {
				case OnMenuDraw(onMenuDraw):
					try {
						onMenuDraw();
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuDraw[FT] menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	static function onPvMenuDestFT(result:Pointer<Bool>) {
		var resCtx:ResultContext = new ResultContext();
		resCtx.result = result.ref;
		for (hook in hookManager.dftMenuHooks['OnMenuExit'].copy()) {
			switch (hook) {
				case OnMenuExit(onMenuExit):
					try {
						onMenuExit(resCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuExit[FT] menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = resCtx.result;
	}

	// --------- MM+ PV SELECTION MENU HOOKS --------- //
	static function onPvMenuInit(result:Pointer<Bool>) {
		var resCtx:ResultContext = new ResultContext();
		resCtx.result = result.ref;
		for (hook in hookManager.menuHooks['OnMenuInit'].copy()) {
			switch (hook) {
				case OnMenuInit(onMenuInit):
					try {
						onMenuInit(resCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuInit menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = resCtx.result;
	}

	static function onPvMenuCreateSortedPVList(sel:Star<PVSelectorSwitch>, result:Pointer<Bool>) {
		var menuSelCtx:MenuSelectionContext = new MenuSelectionContext();
		menuSelCtx.selection = sel;
		menuSelCtx.result = result.ref;
		for (hook in hookManager.menuHooks['OnMenuCreateSortedPVList'].copy()) {
			switch (hook) {
				case OnMenuCreateSortedPVList(onMenuCreateSortedPVList):
					try {
						onMenuCreateSortedPVList(menuSelCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuCreateSortedPVList menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = menuSelCtx.result;
	}

	static function onPvMenuCtrl(sel:Star<PVSelectorSwitch>, result:Pointer<Bool>) {
		var menuSelCtx:MenuSelectionContext = new MenuSelectionContext();
		menuSelCtx.selection = sel;
		menuSelCtx.result = result.ref;
		for (hook in hookManager.menuHooks['OnMenuUpdate'].copy()) {
			switch (hook) {
				case OnMenuUpdate(onMenuUpdate):
					try {
						onMenuUpdate(menuSelCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuUpdate menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = menuSelCtx.result;
	}

	static function onPvMenuDest(result:Pointer<Bool>) {
		var resCtx:ResultContext = new ResultContext();
		resCtx.result = result.ref;
		for (hook in hookManager.menuHooks['OnMenuExit'].copy()) {
			switch (hook) {
				case OnMenuExit(onMenuExit):
					try {
						onMenuExit(resCtx);
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuExit menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
		result.ref = resCtx.result;
	}

	static function onPvMenuDisp() {
		for (hook in hookManager.menuHooks['OnMenuDraw'].copy()) {
			switch (hook) {
				case OnMenuDraw(onMenuDraw):
					try {
						onMenuDraw();
					} catch (e) {
						DLogger.error('Uncaught error during OnMenuDraw menu hook: ${e.message}\nStack:\n${e.stack.toString()}');
					}
				default:
			}
		}
	}

	// ------------ TASKS ------------ //
	static function onHxTaskCtrl() {
		try {
			taskManager.update();
		} catch (e) {
			DLogger.error('Uncaught error during task update: ${e.message}\nStack:\n${e.stack.toString()}');
		}
	}

	static function onHxTaskDisp() {
		try {
			taskManager.draw();
		} catch (e) {
			DLogger.error('Uncaught error during task draw: ${e.message}\nStack:\n${e.stack.toString()}');
		}
	}

	static function onHxTaskBasic() {
		try {
			taskManager.basic();
		} catch (e) {
			DLogger.error('Uncaught error during task basic: ${e.message}\nStack:\n${e.stack.toString()}');
		}
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
				case OnSwapChain(onSwapChain):
					onSwapChain(argList[0]);
			}
		} catch (e) {
			DLogger.error('Uncaught error during ${Type.enumConstructor(hook)} mod hook: ${e.message}\nStack:\n${e.stack.toString()}');
		}
	}

	static function runGameHook(hook:DGameHook, args:...Dynamic) {
		try {
			var argList = args.toArray();
			switch (hook) {
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
