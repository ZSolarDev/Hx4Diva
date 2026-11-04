package;

import imgui.ImGui;
import diva.Diva;
import dxgi.interfaces.DxgiSwapChain;
import imgui.ImGuiDx11;
import d3d11.interfaces.D3d11Device;
import d3d11.interfaces.D3d11DeviceContext;

class Main {
    public static function main() {
        trace('Called main!');

        Diva.initMod('Hx4Diva-TestMod', 'v1.0.0');
        Diva.hookManager.registerModHook(D3DInit(onD3DInit));
        Diva.hookManager.registerModHook(OnFrame(onFrame));
    }

    static function onD3DInit(swapChain:DxgiSwapChain, device:D3d11Device, deviceContext:D3d11DeviceContext) {
        ImGuiDx11.init(swapChain, device, deviceContext);
    }

    static function onFrame(swapChain:DxgiSwapChain) {
        ImGuiDx11.begin();
        ImGui.showDemoWindow();
        ImGuiDx11.end(swapChain);
    }
}