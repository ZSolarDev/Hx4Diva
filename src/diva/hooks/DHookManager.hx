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
     * Hooks specific to the game.
     * TODO: this..
     * 
     * @since 1.0.0
     */
    public var gameHooks:Map<String, Array<DModHook>>;

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
    }

    /**
     * Registers a new mod hook.
     * 
     * @since 1.0.0
     */
    public function registerModHook(hook:DModHook)
        modHooks[Type.enumConstructor(hook)].push(hook);

    /**
     * Unegisters a registered mod hook.
     * 
     * @since 1.0.0
     */
    public function unregisterModHook(hook:DModHook)
        modHooks[Type.enumConstructor(hook)].remove(hook);
}