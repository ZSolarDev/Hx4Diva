package diva.hooks;

import diva.types.hooktypes.*;
import dxgi.interfaces.DxgiSwapChain;

enum DGameHook {
	OnSwapChain(hook:(DxgiSwapChain) -> Void);
	OnPvInit(hook:Void->Void);
	OnPvInitComplete(hook:Void->Void);
	OnPvUpdate(hook:Void->Void);
	OnPvExit(hook:Void->Void);
	OnPvReset(hook:Void->Void);
	OnPvGetHitState(cb:HitContext->Void);
	OnLoadDscUpdate(cb:DscCtrlContext->Void);
}
