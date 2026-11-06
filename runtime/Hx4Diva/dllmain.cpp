#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <vector>
#include <string>
#include "hooks.h"
#include "diva.h"

// Loads all libs from a folder.
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

// Loads all DLLs from the "hxLibs" folder and calls their "hxRunLibrary" export on process attach, and unloads them on process detach.
// Yes, Haxe uses hxRunLibrary instead of the standard DllMain. Dunno why, but honestly it was much more compatible than I had expected.
// Better than not being able to compile DLLs at all, so I guess I'll take it.
BOOL APIENTRY DllMain(HMODULE hModule, DWORD fdwReason, LPVOID lpReserved) {
    switch (fdwReason) {
        case DLL_PROCESS_ATTACH:
            LoadAllFromFolder("hxLibs");
            CallOnAll<void()>("hxRunLibrary");
            break;
    }
    return TRUE;
}

// Taken from new classics.
HOOK(bool, __fastcall, TaskPvGameInit, 0x1405DA040, uint64_t a1)
{
    CallOnAll<void()>("OnPvInit");
    return originalTaskPvGameInit(a1);
}

HOOK(bool, __fastcall, PVGameLoaderFinishUp, 0x140262730, void* a1)
{
    CallOnAll<void()>("OnPvInitComplete");
    return originalPVGameLoaderFinishUp(a1);
}

HOOK(bool, __fastcall, TaskPvGameCtrl, 0x1405DA060, uint64_t a1)
{
    CallOnAll<void()>("OnPvUpdate");
    return originalTaskPvGameCtrl(a1);
}

HOOK(bool, __fastcall, TaskPvGameDest, 0x1405DA0A0, uint64_t a1)
{
    CallOnAll<void()>("OnPvExit");
    return originalTaskPvGameDest(a1);
}

HOOK(void, __fastcall, PVGameReset, 0x1402436F0, PVGameData* pv_game)
{
    CallOnAll<void()>("OnPvReset");
    originalPVGameReset(pv_game);
}

HOOK(HitState, __fastcall, GetHitStateInternal, 0x14026D2E0,
    PVGameArcade* game,
    PvGameTarget* target,
    uint16_t a3,
    uint16_t a4)
{
    HitState result = originalGetHitStateInternal(game, target, a3, a4);
    CallOnAll<void(PVGameArcade*, PvGameTarget*, HitState*)>("OnPvGetHitState", game, target, &result);
	return result;
}

// DML hooks for Haxe libraries to call into, taken straight from the DML readme.
extern "C" {
    void __declspec(dllexport) PreInit() {
        CallOnAll<void()>("PreInit");
    }

    void __declspec(dllexport) Init() {
        INSTALL_HOOK(TaskPvGameInit);
		INSTALL_HOOK(PVGameLoaderFinishUp);
		INSTALL_HOOK(TaskPvGameCtrl);
		INSTALL_HOOK(TaskPvGameDest);
		INSTALL_HOOK(PVGameReset);
		INSTALL_HOOK(GetHitStateInternal);

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