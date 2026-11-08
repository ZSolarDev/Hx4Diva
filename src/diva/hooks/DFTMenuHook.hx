package diva.hooks;

import diva.types.hooktypes.*;

enum DFTMenuHook {
	// Runs when the pv select menu is initialized. Run logic here.
	OnMenuInit(hook:FTMenuSelectionContext->Void);
	OnMenuCreateSortedPVList(hook:BasicFTMenuSelectionContext->Void);
	// Called when the pv select menu is updated.
	OnMenuUpdate(hook:FTMenuSelectionContext->Void);
	// Called when the pv select menu is drawn. Draw here.
	OnMenuDraw(hook:Void->Void);
	// Called when the pv select menu is exited.
	OnMenuExit(hook:ResultContext->Void);
}
