package imgui;

import d3d11.interfaces.D3d11Device;
import d3d11.interfaces.D3d11DeviceContext;
import diva.Diva;
import dxgi.interfaces.DxgiSwapChain;
import imgui.ImGui;

/**
 * The class you'd use to interact with ImGui. As such:
 * 
 * ```haxe
 * Diva.hookManager.registerModhook(D3DInit((
 *  swapChain:DxgiSwapChain,
 *  device:D3d11Device,
 *  deviceContext:D3d11DeviceContext) -> {
 *　　ImGuiDx11.init(swapChain, device, deviceContext);
 * }));
 * 
 * Diva.hookManager.registerModhook(OnFrame((_) -> {
 *   ImGuiDx11.begin();
 *   ImGui.showDemoWindow();
 *   ImGuiDx11.end(swapChain);
 * }));
 * ```
 * 
 * @since 1.0.0-alpha.1
 */
@:buildXml('
<set name="IMGUI_BACKENDS" value="${LINC_IMGUI_PATH}lib/cimgui/imgui/backends" />
<files id="haxe">
  <compilerflag value="-I${LINC_IMGUI_PATH}lib/cimgui/imgui/backends" />
</files>
<files id="imgui-backends">
  <cache value="1" name="imgui-backends" />
  <compilerflag value="-DIMGUI_DISABLE_OBSOLETE_FUNCTIONS"/>
  <compilerflag value="-I${LINC_IMGUI_PATH}lib/cimgui/imgui/" />
  <compilerflag value="-I${IMGUI_BACKENDS}" />
  <file name="${IMGUI_BACKENDS}/imgui_impl_dx11.cpp" />
  <file name="${IMGUI_BACKENDS}/imgui_impl_win32.cpp" />
</files>
<target id="haxe">
  <files id="imgui-backends" />
</target>
')
@:headerCode('
#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <imgui.h>
#include <imgui_impl_win32.h>
#include <imgui_impl_dx11.h>
')
@:cppFileCode('
extern IMGUI_IMPL_API LRESULT ImGui_ImplWin32_WndProcHandler(HWND, UINT, WPARAM, LPARAM);

static ID3D11Device* g_dev = nullptr;
static ID3D11DeviceContext* g_ctx = nullptr;
static HWND g_hwnd = nullptr;
static WNDPROC g_oldProc = nullptr;
static ID3D11Texture2D* g_tmpBB = nullptr;
static ID3D11RenderTargetView* g_tmpRTV = nullptr;

static LRESULT CALLBACK HookedWndProc(HWND h, UINT m, WPARAM w, LPARAM l) {
    if (ImGui_ImplWin32_WndProcHandler(h, m, w, l))
        return true;

    ImGuiIO& io = ImGui::GetIO();
    if (io.WantCaptureMouse && (m == WM_LBUTTONDOWN || m == WM_LBUTTONUP ||
        m == WM_RBUTTONDOWN || m == WM_RBUTTONUP || m == WM_MBUTTONDOWN ||
        m == WM_MBUTTONUP || m == WM_MOUSEWHEEL || m == WM_MOUSEMOVE))
        return true;

    if (io.WantCaptureKeyboard && (m == WM_KEYDOWN || m == WM_KEYUP ||
        m == WM_SYSKEYDOWN || m == WM_SYSKEYUP || m == WM_CHAR))
        return true;

    return CallWindowProc(g_oldProc, h, m, w, l);
}
')
class ImGuiDx11 {
	static var initialized:Bool = false;
	static var failed:Bool = false;
	static var hooked:Bool = false;
	static var swapChainHook = OnSwapChain((swapChain:DxgiSwapChain) -> {
		ImGuiDx11.destroy(true);
		ImGuiDx11.init(swapChain, Diva.curDevice, Diva.curDeviceContext);
	});

	/**
	 * Initializes ImGui.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static function init(sc:DxgiSwapChain, dev:D3d11Device, ctx:D3d11DeviceContext) {
		if (initialized || failed)
			return;

		var scNull:Bool = untyped __cpp__('({0}->ptr == nullptr)', sc);
		var devNull:Bool = untyped __cpp__('({0}->ptr == nullptr)', dev);
		var ctxNull:Bool = untyped __cpp__('({0}->ptr == nullptr)', ctx);
		if (scNull || devNull || ctxNull) {
			failed = true;
			return;
		}

		untyped __cpp__('
            g_dev = (ID3D11Device*){0}->ptr;
            g_ctx = (ID3D11DeviceContext*){1}->ptr;
            DXGI_SWAP_CHAIN_DESC d;
            ((IDXGISwapChain*){2}->ptr)->GetDesc(&d);
            g_hwnd = d.OutputWindow;
        ', dev, ctx, sc);
		var hwndVal:Int = untyped __cpp__('(int)(size_t)g_hwnd');
		if (hwndVal == 0) {
			failed = true;
			return;
		}

		ImGui.createContext();
		if (ImGui.getCurrentContext() == null) {
			failed = true;
			return;
		}

		if (!(untyped __cpp__('ImGui_ImplWin32_Init(g_hwnd)'))) {
			failed = true;
			return;
		}

		if (!(untyped __cpp__('ImGui_ImplDX11_Init(g_dev, g_ctx)'))) {
			failed = true;
			return;
		}

		if (!hooked) {
			Diva.hookManager.registerModHook(swapChainHook);
			untyped __cpp__('g_oldProc = (WNDPROC)SetWindowLongPtr(g_hwnd, GWLP_WNDPROC, (LONG_PTR)HookedWndProc)');
			hooked = true;
		}
		initialized = true;
	}

	/**
	 * Begins a new ImGui frame.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static function begin() {
		if (!initialized)
			return;

		untyped __cpp__('
            ImGui_ImplDX11_NewFrame();
            ImGui_ImplWin32_NewFrame();
        ');
		ImGui.newFrame();
	}

	/**
	 * Ends the current ImGui frame.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static function end(sc:DxgiSwapChain) {
		if (!initialized)
			return;

		ImGui.render();

		untyped __cpp__('
            ID3D11Texture2D* bb = nullptr;
            HRESULT r = ((IDXGISwapChain*){0}->ptr)->GetBuffer(0, __uuidof(ID3D11Texture2D), (void**)&bb);
            g_tmpBB = bb;

            ID3D11RenderTargetView* rtv = nullptr;
            g_dev->CreateRenderTargetView(g_tmpBB, nullptr, &rtv);
            g_tmpRTV = rtv;

            g_tmpBB->Release();
            g_tmpBB = nullptr;
            g_ctx->OMSetRenderTargets(1, &g_tmpRTV, nullptr);
            ImGui_ImplDX11_RenderDrawData({1});
            g_tmpRTV->Release();
            g_tmpRTV = nullptr;
        ', sc, ImGui.getDrawData());
	}

	/**
	 * Destroy's ImGui.
	 * 
	 * @param revive If `true`, it will regenerate itself once 
	 * the swap chain is recreated. Used internally to work across
	 * swap chains.
	 * @since 1.0.0-alpha.1
	 */
	public static function destroy(?revive:Bool = false) {
		if (!initialized)
			return;
		untyped __cpp__('
            ImGui_ImplDX11_Shutdown();
            ImGui_ImplWin32_Shutdown();
        ');
		ImGui.destroyContext();
		initialized = false;
		if (!revive)
			Diva.hookManager.unregisterModHook(swapChainHook);
	}
}
