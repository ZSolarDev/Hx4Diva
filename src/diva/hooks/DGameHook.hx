package diva.hooks;

import diva.types.hooktypes.*;
import dxgi.interfaces.DxgiSwapChain;

enum DGameHook {
	// Runs when the swapchain is changed.
	OnSwapChain(hook:DxgiSwapChain->Void);
	// Runs when the pv is being initialized. Run logic here.
	OnPvInit(hook:Void->Void);
	// Runs when the pv is fully initialized and about to start.
	OnPvInitComplete(hook:Void->Void);
	// Runs every time the pv is being updated.
	OnPvUpdate(hook:Void->Void);
	// Runs when you exit to song select. DOES NOT run when you
	// go to the results screen or restart a song. when you go to the results screen,
	// it doesn't run onPvExit until you've exited the results screen
	// and went back to the song select.
	OnPvExit(hook:Void->Void);
	// Runs when you restart a song.
	OnPvReset(hook:Void->Void);
	// Runs for the target(s) that are next in line to be hittable.
	OnPvGetHitState(cb:HitContext->Void);
	// Runs when loading a dsc, during song loading screen.
	OnLoadDscUpdate(cb:DscCtrlContext->Void);
	// Runs at game startup when loading all pv's.
	OnPvDBParseEntry(cb:PvDBParseContext->Void);
}
