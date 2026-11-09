package diva.hooks;

import diva.types.hooktypes.*;

enum DMenuHook {
	/**
	 * Runs when the PV select menu is initialized. Run
	 * initialization logic here.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnMenuInit(hook:ResultContext->Void);

	/**
	 * Runs when the game builds its sorted list of PV's.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnMenuCreateSortedPVList(hook:MenuSelectionContext->Void);

	/**
	 * Runs when the PV select menu is updated.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnMenuUpdate(hook:MenuSelectionContext->Void);

	/**
	 * Runs when the PV select menu is drawn. Draw here.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnMenuDraw(hook:Void->Void);

	/**
	 * Runs when the PV select menu is exited.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnMenuExit(hook:ResultContext->Void);
}
