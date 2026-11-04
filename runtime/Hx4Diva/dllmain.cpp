#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <vector>
#include <string>

// Loads all DLLs from the "hxLib" folder and loads them.
std::vector<HMODULE> loadedLibs;

void LoadAllFromFolder(const char* folder) {
    std::string searchPath = std::string(folder) + "\\*.dll";
    WIN32_FIND_DATAA findData;
    HANDLE hFind = FindFirstFileA(searchPath.c_str(), &findData);

    if (hFind == INVALID_HANDLE_VALUE) return;

    do {
        std::string fullPath = std::string(folder) + "\\" + findData.cFileName;
        HMODULE hLib = LoadLibraryA(fullPath.c_str());
        if (hLib) {
            loadedLibs.push_back(hLib);
        }
    } while (FindNextFileA(hFind, &findData));

    FindClose(hFind);
}

// Unloads all loaded libraries and clears the list.
void UnloadAll() {
    for (HMODULE h : loadedLibs) FreeLibrary(h);
    loadedLibs.clear();
}

// Just calls a function with any signature on all loaded haxe DLLs, only if it's exported.
typedef void (*hxRunLibrary_t)();

template<typename FuncSig, typename... Args>
void CallOnAll(const char* exportName, Args... args) {
    for (HMODULE h : loadedLibs) {
        FARPROC proc = GetProcAddress(h, exportName);
        if (proc) {
            auto fn = reinterpret_cast<FuncSig*>(proc);
            fn(args...);
        }
    }
}

// Loads all DLLs from the "hxLib" folder and calls their "hxRunLibrary" export on process attach, and unloads them on process detach.
// Yes, Haxe uses hxRunLibrary instead of the standard DllMain. Dunno why, but honestly it was much more compatible than I had expected.
// Better than not being able to compile DLLs at all, so I guess I'll take it.
BOOL APIENTRY DllMain(HMODULE hModule, DWORD fdwReason, LPVOID lpReserved) {
    switch (fdwReason) {
    case DLL_PROCESS_ATTACH:
        LoadAllFromFolder("hxLib");
        CallOnAll<void()>("hxRunLibrary");
        break;
    case DLL_PROCESS_DETACH:
        UnloadAll();
        break;
    }
    return TRUE;
}

// DML hooks for Haxe libraries to call into, taken straight from the DML readme.
extern "C" {
    void __declspec(dllexport) PreInit() {
        CallOnAll<void()>("PreInit");
    }

    void __declspec(dllexport) Init() {
        CallOnAll<void()>("Init");
    }

    void __declspec(dllexport) PostInit() {
        CallOnAll<void()>("PostInit");
    }

    void __declspec(dllexport) D3DInit(IDXGISwapChain* swapChain, ID3D11Device* device, ID3D11DeviceContext* deviceContext) {
        CallOnAll<void(IDXGISwapChain*, ID3D11Device*, ID3D11DeviceContext*)>(
            "D3DInit", swapChain, device, deviceContext
        );
    }

    void __declspec(dllexport) OnFrame(IDXGISwapChain* swapChain) {
        CallOnAll<void(IDXGISwapChain*)>("OnFrame", swapChain);
    }

    void __declspec(dllexport) OnResize(IDXGISwapChain* swapChain) {
        CallOnAll<void(IDXGISwapChain*)>("OnResize", swapChain);
    }

}