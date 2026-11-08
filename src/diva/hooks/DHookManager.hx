package diva.hooks;

/**
 * The global hook manager, use via `Diva.hookManager`.
 * 
 * @since 1.0.0
 */
class DHookManager {
	/**
	 * Hooks local to the mod, such as initialization, window resizing, etc.
	 * 
	 * @since 1.0.0
	 */
	public var modHooks:Map<String, Array<DModHook>>;

	/**
	 * Hooks specific to when you're inside of PV.
	 * 
	 * @since 1.0.0
	 */
	public var gameHooks:Map<String, Array<DGameHook>>;

	/**
	 * Hooks specific to when you're inside of the PV select menu.
	 * Future Tone UI only.
	 * 
	 * @since 1.0.0
	 */
	public var dftMenuHooks:Map<String, Array<DFTMenuHook>>;

	/**
	 * Hooks specific to when you're inside of the PV select menu.
	 * Mega Mix+ UI only.
	 * 
	 * @since 1.0.0
	 */
	public var menuHooks:Map<String, Array<DMenuHook>>;

	/**
	 * Creates a new hook manager.
	 * 
	 * @since 1.0.0
	 */
	@:allow(diva.Diva) private function new() {
		modHooks = [
			'PreInit' => [],
			'Init' => [],
			'PostInit' => [],
			'D3DInit' => [],
			'OnFrame' => [],
			'OnResize' => [],
			'OnSwapChain' => []
		];
		gameHooks = [
			'OnPvInit' => [],
			'OnPvInitComplete' => [],
			'OnPvUpdate' => [],
			'OnPvExit' => [],
			'OnPvReset' => [],
			'OnPvGetHitState' => [],
			'OnLoadDscUpdate' => [],
			'OnPvDBParseEntry' => [],
			'OnDrawGame' => [],
			'OnDrawGamePost' => [],
			'OnUpdateTargets' => [],
			'OnDrawKiseki' => []
		];
		dftMenuHooks = [
			'OnMenuInit' => [],
			'OnMenuCreateSortedPVList' => [],
			'OnMenuUpdate' => [],
			'OnMenuDraw' => [],
			'OnMenuExit' => []
		];
		menuHooks = [
			'OnMenuInit' => [],
			'OnMenuCreateSortedPVList' => [],
			'OnMenuUpdate' => [],
			'OnMenuDraw' => [],
			'OnMenuExit' => []
		];
	}

	/**
	 * Registers a new `DModHook`.
	 * 
	 * @since 1.0.0
	 */
	public function registerModHook(hook:DModHook)
		modHooks[Type.enumConstructor(hook)].push(hook);

	/**
	 * Unegisters a registered `DModHook`.
	 * 
	 * @since 1.0.0
	 */
	public function unregisterModHook(hook:DModHook)
		modHooks[Type.enumConstructor(hook)].remove(hook);

	/**
	 * Registers a new `DGameHook`.
	 * 
	 * @since 1.0.0
	 */
	public function registerGameHook(hook:DGameHook)
		gameHooks[Type.enumConstructor(hook)].push(hook);

	/**
	 * Unegisters a registered `DGameHook`.
	 * 
	 * @since 1.0.0
	 */
	public function unregisterGameHook(hook:DGameHook)
		gameHooks[Type.enumConstructor(hook)].remove(hook);

	/**
	 * Registers a new `DFTMenuHook`.
	 * 
	 * @since 1.0.0
	 */
	public function registerDFTMenuHook(hook:DFTMenuHook)
		dftMenuHooks[Type.enumConstructor(hook)].push(hook);

	/**
	 * Unegisters a registered `DFTMenuHook`.
	 * 
	 * @since 1.0.0
	 */
	public function unregisterDFTMenuHook(hook:DFTMenuHook)
		dftMenuHooks[Type.enumConstructor(hook)].remove(hook);

	/**
	 * Registers a new `DMenuHook`.
	 * 
	 * @since 1.0.0
	 */
	public function registerMenuHook(hook:DMenuHook)
		menuHooks[Type.enumConstructor(hook)].push(hook);

	/**
	 * Unegisters a registered `DMenuHook`.
	 * 
	 * @since 1.0.0
	 */
	public function unregisterMenuHook(hook:DMenuHook)
		menuHooks[Type.enumConstructor(hook)].remove(hook);
}
