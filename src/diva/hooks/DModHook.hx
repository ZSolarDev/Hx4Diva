package diva.hooks;

import d3d11.interfaces.D3d11DeviceContext;
import d3d11.interfaces.D3d11Device;
import dxgi.interfaces.DxgiSwapChain;

enum DModHook {
    PreInit(hook:Void->Void);
    Init(hook:Void->Void);
    PostInit(hook:Void->Void);
    D3DInit(hook:(DxgiSwapChain, D3d11Device, D3d11DeviceContext) -> Void);
    OnFrame(hook:DxgiSwapChain->Void);
    OnResize(hook:DxgiSwapChain->Void);
}