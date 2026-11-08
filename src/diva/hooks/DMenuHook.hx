package diva.hooks;

import diva.types.hooktypes.*;

enum DMenuHook {
	// Runs when the pv select menu is initialized. Run logic here.
	OnMenuInit(hook:ResultContext->Void);
	OnMenuCreateSortedPVList(hook:MenuSelectionContext->Void);
	// Called when the pv select menu is updated.
	OnMenuUpdate(hook:MenuSelectionContext->Void);
	// Called when the pv select menu is drawn. Draw here.
	OnMenuDraw(hook:Void->Void);
	// Called when the pv select menu is exited.
	OnMenuExit(hook:ResultContext->Void);
}
