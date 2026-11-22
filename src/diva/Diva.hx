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
import diva.types.pv_db.*;
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
@:include('cstdio')
// I am technically sharing the diva namespace between
// diva_types.h and my package, but hxcpp has special naming conventions
// internally, so it shouldn't be an issue.
@:cppFileCode('
#include "DivaMain.h"

// Entrypoint
extern "C" __declspec(dllexport) void Main() {
    if (g_haxeDead) return;
    DivaMain_obj::entrypoint();
}

// Mod hooks
extern "C" __declspec(dllexport) void PreInit() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::preInit();
}
extern "C" __declspec(dllexport) void Init() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::init();
}
extern "C" __declspec(dllexport) void PostInit() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::postInit();
}
extern "C" __declspec(dllexport) void D3DInit(IDXGISwapChain* swapChain, ID3D11Device* device, ID3D11DeviceContext* deviceContext) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onD3DInit(swapChain, device, deviceContext);
}
extern "C" __declspec(dllexport) void OnFrame(IDXGISwapChain* swapChain) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onFrame(swapChain);
}
extern "C" __declspec(dllexport) void OnResize(IDXGISwapChain* swapChain) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onResize(swapChain);
}

// Game hooks
extern "C" __declspec(dllexport) void OnPvInit() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvInit();
}

extern "C" __declspec(dllexport) void OnPvInitComplete() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvInitComplete();
}

extern "C" __declspec(dllexport) void OnPvUpdate() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvUpdate();
}

extern "C" __declspec(dllexport) void OnPvExit() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvExit();
}

extern "C" __declspec(dllexport) void OnPvReset() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvReset();
}

extern "C" __declspec(dllexport) void OnPvGetHitState(PVGameArcade* game, PvGameTarget* target, HitState* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvGetHitState(game, target, result);
}

extern "C" __declspec(dllexport) void OnLoadDscUpdate(PVGamePvData* data, pv_db::PvDBEntry* entry, pv_db::PvDBDifficulty* difficulty, std::string& path, bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onLoadDscUpdate(data, entry, difficulty, path, result);
}

extern "C" __declspec(dllexport) void OnPvDBParseEntry(pv_db::PvDBEntry* entry, bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvDBParseEntry(entry, result);
}

extern "C" __declspec(dllexport) void OnDrawGame(PVGameArcade* game) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onDrawGame(game);
}

extern "C" __declspec(dllexport) void OnDrawGamePost(PVGameArcade* game) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onDrawGamePost(game);
}

extern "C" __declspec(dllexport) void OnUpdateTargets(PVGameArcade* game, float dt) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onUpdateTargets(game, dt);
}

extern "C" __declspec(dllexport) void OnDrawKiseki(PvGameTarget* target) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onDrawKiseki(target);
}

// FT PV selection menu hooks
extern "C" __declspec(dllexport) void OnPvMenuInitFT(PVselPS4* sel, bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuInitFT(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuCreateSortedPVListFT(PVselPS4* sel) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuCreateSortedPVListFT(sel);
}

extern "C" __declspec(dllexport) void OnPvMenuCtrlFT(PVselPS4* sel, bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuCtrlFT(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuDestFT(bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuDestFT(result);
}

extern "C" __declspec(dllexport) void OnPvMenuDispFT() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuDispFT();
}

// MM+ PV selection menu hooks
extern "C" __declspec(dllexport) void OnPvMenuInit(bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuInit(result);
}

extern "C" __declspec(dllexport) void OnPvMenuCreateSortedPVList(PVSelectorSwitch* sel, bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuCreateSortedPVList(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuCtrl(PVSelectorSwitch* sel, bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuCtrl(sel, result);
}

extern "C" __declspec(dllexport) void OnPvMenuDest(bool* result) {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuDest(result);
}

extern "C" __declspec(dllexport) void OnPvMenuDisp() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onPvMenuDisp();
}

// Tasks
extern "C" __declspec(dllexport) void OnHxTaskCtrl() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onHxTaskCtrl();
}

extern "C" __declspec(dllexport) void OnHxTaskDisp() {
    if (g_haxeDead) return;
    ::diva::Diva_obj::onHxTaskDisp();
}

extern "C" __declspec(dllexport) void OnHxTaskBasic() {
    if (g_haxeDead) return;
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
		DCrashHandler.install();
		DCrashHandler.guarded(() -> {
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
		});
	}

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
						DCrashHandler.guarded(() -> {
							onPvGetHitState(hitCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnPvGetHitState game hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
		dscCtrlCtx.path = path.toString();
		dscCtrlCtx.result = result.ref;

		for (hook in hookManager.gameHooks['OnLoadDscUpdate'].copy()) {
			switch (hook) {
				case OnLoadDscUpdate(onLoadDscUpdate):
					try {
						DCrashHandler.guarded(() -> {
							onLoadDscUpdate(dscCtrlCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnLoadDscUpdate game hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onPvDBParseEntry(pvdbParseCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnPvDBParseEntry game hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onDrawGame(drawCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnDrawGame game hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onDrawGamePost(drawCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnDrawGamePost game hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onUpdateTargets(targetUpdateCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnUpdateTargets game hook: ${e.message}\n\nStack:${e.stack.toString()}');
					}
				default:
			}
		}
	}

	static function onDrawKiseki(target:Star<PvGameTarget>) {
		var targetCtx:TargetContext = new TargetContext();
		targetCtx.target = target;
		for (hook in hookManager.gameHooks['OnDrawKiseki'].copy()) {
			switch (hook) {
				case OnDrawKiseki(onDrawKiseki):
					try {
						DCrashHandler.guarded(() -> {
							onDrawKiseki(targetCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnDrawKiseki game hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuInit(menuSelCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuInit[FT] menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuCreateSortedPVList(basicMenuSelCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuCreateSortedPVList[FT] menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuUpdate(menuSelCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuUpdate[FT] menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(onMenuDraw);
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuDraw[FT] menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuExit(resCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuExit[FT] menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuInit(resCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuInit menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuCreateSortedPVList(menuSelCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuCreateSortedPVList menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuUpdate(menuSelCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuUpdate menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(() -> {
							onMenuExit(resCtx);
						});
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuExit menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
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
						DCrashHandler.guarded(onMenuDraw);
					} catch (e) {
						DCrashHandler.markDead();
						DLogger.error('Uncaught error during OnMenuDraw menu hook: ${e.message}\n\nStack:${e.stack.toString()}');
					}
				default:
			}
		}
	}

	// ------------ TASKS ------------ //
	static function onHxTaskCtrl() {
		try {
			DCrashHandler.guarded(taskManager.update);
		} catch (e) {
			DCrashHandler.markDead();
			DLogger.error('Uncaught error during task update: ${e.message}\n\nStack:${e.stack.toString()}');
		}
	}

	static function onHxTaskDisp() {
		try {
			DCrashHandler.guarded(taskManager.draw);
		} catch (e) {
			DCrashHandler.markDead();
			DLogger.error('Uncaught error during task draw: ${e.message}\n\nStack:${e.stack.toString()}');
		}
	}

	static function onHxTaskBasic() {
		try {
			DCrashHandler.guarded(taskManager.basic);
		} catch (e) {
			DCrashHandler.markDead();
			DLogger.error('Uncaught error during task basic: ${e.message}\n\nStack:${e.stack.toString()}');
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
					DCrashHandler.guarded(preInitHook);
				case Init(initHook):
					DCrashHandler.guarded(initHook);
				case PostInit(postInitHook):
					DCrashHandler.guarded(postInitHook);
				case D3DInit(d3dInitHook):
					DCrashHandler.guarded(() -> {
						d3dInitHook(argList[0], argList[1], argList[2]);
					});
				case OnFrame(onFrameHook):
					DCrashHandler.guarded(() -> {
						onFrameHook(argList[0]);
					});
				case OnResize(onResizeHook):
					DCrashHandler.guarded(() -> {
						onResizeHook(argList[0]);
					});
				case OnSwapChain(onSwapChain):
					DCrashHandler.guarded(() -> {
						onSwapChain(argList[0]);
					});
			}
		} catch (e) {
			DCrashHandler.markDead();
			DLogger.error('Uncaught error during ${Type.enumConstructor(hook)} mod hook: ${e.message}\n\nStack:${e.stack.toString()}');
		}
	}

	static function runGameHook(hook:DGameHook, args:...Dynamic) {
		try {
			var argList = args.toArray();
			switch (hook) {
				case OnPvInit(onPvInitHook):
					DCrashHandler.guarded(onPvInitHook);
				case OnPvInitComplete(onPvInitCompleteHook):
					DCrashHandler.guarded(onPvInitCompleteHook);
				case OnPvUpdate(onPvUpdateHook):
					DCrashHandler.guarded(onPvUpdateHook);
				case OnPvExit(onPvExitHook):
					DCrashHandler.guarded(onPvExitHook);
				case OnPvReset(onPvResetHook):
					DCrashHandler.guarded(onPvResetHook);
				default:
			}
		} catch (e) {
			DCrashHandler.markDead();
			DLogger.error('Uncaught error during ${Type.enumConstructor(hook)} game hook: ${e.message}\n\nStack:${e.stack.toString()}');
		}
	}
}
