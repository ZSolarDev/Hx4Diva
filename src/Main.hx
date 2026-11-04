package;

import diva.DTimer;
import diva.Diva;
import haxe.Timer;
import dxgi.interfaces.DxgiSwapChain;
import dxgi.structures.DxgiFrameStatistics;
import d3d11.interfaces.D3d11Device;
import d3d11.interfaces.D3d11DeviceContext;

class Main {
    public static function main() {
        trace('Called main!');

        Diva.initMod('Hx4Diva-TestMod', 'v1.0.0');
        Diva.hookManager.registerModHook(Init(onInit));
        Diva.hookManager.registerModHook(D3DInit(onD3DInit));
    }

    static function onInit() {
        trace('Init fired!');
    }

    static function onD3DInit(swapChain:DxgiSwapChain, device:D3d11Device, deviceContext:D3d11DeviceContext) {
        var stats = new DxgiFrameStatistics();
        var result = swapChain.getFrameStatistics(stats);
        
        trace('OnResize fired! getFrameStatistics result: ' + StringTools.hex(result, 8));
        trace('PresentCount: ' + stats.backing.presentCount);
        trace('PresentRefreshCount: ' + stats.backing.presentRefreshCount);
        trace('SyncRefreshCount: ' + stats.backing.syncRefreshCount);
        trace('SyncQPCTime: ' + stats.syncQpcTime);
        trace('SyncGPUTime: ' + stats.syncGpuTime);
    }
}