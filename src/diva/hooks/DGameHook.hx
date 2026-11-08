package diva.hooks;

import diva.types.hooktypes.*;

enum DGameHook {
	/**
	 * Runs when the pv is being initialized. Run logic here.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvInit(hook:Void->Void);

	/**
	 * Runs when the pv is fully initialized and about to start.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvInitComplete(hook:Void->Void);

	/**
	 * Runs every frame that the pv is being updated.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvUpdate(hook:Void->Void);

	/**
	 * Runs when you exit to song select. DOES NOT run when you
	 * go to the results screen or restart a song. when you go
	 * to the results screen, it doesn't run onPvExit until you've
	 * exited the results screen and went back to the PV select.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvExit(hook:Void->Void);

	/**
	 * Runs when you restart a song.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvReset(hook:Void->Void);

	/**
	 *  Runs for the target(s) that are next in line to be hittable.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvGetHitState(cb:HitContext->Void);

	/**
	 * Runs when loading a dsc, during song loading screen.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnLoadDscUpdate(cb:DscCtrlContext->Void);

	/**
	 * Runs at game startup when loading all pv's.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnPvDBParseEntry(cb:PvDBParseContext->Void);

	/**
	 * Runs when drawing the game.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnDrawGame(hook:DrawContext->Void);

	/**
	 * Runs after drawing the game.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnDrawGamePost(hook:DrawContext->Void);

	/**
	 * Runs when updating the targets.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnUpdateTargets(hook:TargetUpdateContext->Void);

	/**
	 * Runs when drawing a target's kiseki.
	 * 
	 * @param hook The hook.
	 * @since 1.0.0-alpha.1
	 */
	OnDrawKiseki(hook:TargetContext->Void);
}
