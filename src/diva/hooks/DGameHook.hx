package diva.hooks;

import dxgi.interfaces.DxgiSwapChain;

enum DGameHook {
    OnSwapChain(hook:(DxgiSwapChain) -> Void);
}