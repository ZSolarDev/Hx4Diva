package diva;

import cpp.vm.Gc;
import haxe.Log;
import diva.hooks.*;
import haxe.PosInfos;
import cpp.Star;
import dxgi.interfaces.DxgiSwapChain;
import dxgi.interfaces.DxgiSwapChain.NativeIDXGISwapChain;
import d3d11.interfaces.D3d11Device;
import d3d11.interfaces.D3d11Device.NativeID3D11Device;
import d3d11.interfaces.D3d11DeviceContext;
import d3d11.interfaces.D3d11DeviceContext.NativeID3D11DeviceContext;

/**
 * The main class you'll use to interact with Project DIVA.
 * 
 * @since 1.0.0
 */
@:cppFileCode('
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
')
class Diva {
    /**
     * The name of the mod.
     * 
     * @since 1.0.0
     */
    public static var modName:String = 'TestMod';

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
    public static function initMod(name:String, ?version:String = null) {
        Log.trace = (v:Dynamic, ?p:PosInfos) -> DLogger.info(v);
        Gc.enable(false);
        modName = name;
        modVersion = version;
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

	// Native utils, to create actual DirectX objects from their pointers.
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
            switch(hook) {
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
            switch(hook) {
                case OnSwapChain(onSwapChain):
                    onSwapChain(argList[0]);
            }
        } catch (e) {
            DLogger.error('Uncaught error during ${Type.enumConstructor(hook)} game hook: ${e.message}\nStack:\n${e.stack.toString()}');
        }
    }
}
