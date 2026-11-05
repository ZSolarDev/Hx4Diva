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
     * Hooks specific to Project DIVA.
     * 
     * @since 1.0.0
     */
    public var gameHooks:Map<String, Array<DGameHook>>;

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
            'OnResize' => []
        ];
        gameHooks = [
            'OnSwapChain' => [],
            'OnPvInit' => [],
            'OnPvInitComplete' => [],
            'OnPvUpdate' => [],
            'OnPvExit' => [],
            'OnPvReset' => [],
            'OnPvGetHitState' => []
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
}