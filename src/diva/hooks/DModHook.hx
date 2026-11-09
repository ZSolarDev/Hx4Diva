package diva.hooks;

import d3d11.interfaces.D3d11Device;
import d3d11.interfaces.D3d11DeviceContext;
import dxgi.interfaces.DxgiSwapChain;

/**
 * Functions that are called by Diva Mod Loader.
 * 
 * @since 1.0.0-alpha.1
 */
enum DModHook {
	/**
	 * Runs before the game's global variables are initialized.
	 * 
	 * @param hook The function.
	 * @since 1.0.0-alpha.1
	 */
	PreInit(hook:Void->Void);

	/**
	 * Ran after the game's global variables are initialized. Run most
	 * of your mod initialization here.
	 * 
	 * @param hook The function.
	 * @since 1.0.0-alpha.1
	 */
	Init(hook:Void->Void);

	/**
	 * Ran after the all DLL mods are initialized.
	 * 
	 * @param hook The function.
	 * @since 1.0.0-alpha.1
	 */
	PostInit(hook:Void->Void);

	/**
	 * Runs when the game's Direct3D is initialized. You can use this in
	 * combination with `OnFrame()` and `ImGuiDx11` to render ImGui.
	 * 
	 * @param hook The function, containing the swap chain, device, and device context.
	 * @see `ImGuiDx11`
	 * @since 1.0.0-alpha.1
	 */
	D3DInit(hook:(DxgiSwapChain, D3d11Device, D3d11DeviceContext) -> Void);

	/**
	 * Ran every frame before the current frame is presented to the screen.
	 * 
	 * @param hook The function, containing the swap chain.
	 * @since 1.0.0-alpha.1
	 */
	OnFrame(hook:DxgiSwapChain->Void);

	/**
	 * Ran after the games buffers are resized.
	 * 
	 * @param hook The function, containing the swap chain.
	 * @since 1.0.0-alpha.1
	 */
	OnResize(hook:DxgiSwapChain->Void);

	/**
	 * Ran when the swap chain is changed.
	 * 
	 * @param hook The function, containing the swap chain.
	 * @since 1.0.0-alpha.1
	 */
	OnSwapChain(hook:DxgiSwapChain->Void);
}
