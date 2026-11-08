#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <vector>
#include <string>
#include "hooks.h"
#include "task.hpp"
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

// To get the current PV entry and difficulty, you can use this function. It will set the out parameters to nullptr if it fails to find
// the entry or difficulty.
static void ResolveCurrentPv(pv_db::PvDBEntry** out_entry, pv_db::PvDBDifficulty** out_diff)
{
    *out_entry = nullptr;
    *out_diff = nullptr;

    auto* load = game::GetPVLoadParam();
    auto& param = load->data[load->data[0].int8];

    void* entry = pv_db::FindPVEntry(param.pv_id);
    if (!entry)
        return;

    *out_entry = static_cast<pv_db::PvDBEntry*>(entry);
    *out_diff = pv_db::FindDifficulty(entry, param.difficulty, param.edition);
}

// The global task.
class HxTask : public app::Task {
public:
    bool init() override {
        return true;
    }

    bool ctrl() override {
        CallOnAll<void()>("OnHxTaskCtrl");
        return false;
    }

    bool dest() override {
        return true;
    }

    void disp() override {
        CallOnAll<void()>("OnHxTaskDisp");
    }

    void basic() override {
        CallOnAll<void()>("OnHxTaskBasic");
    }
};

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

HOOK(bool, __fastcall, LoadDscCtrl, 0x14024E270, PVGamePvData* pv_data, prj::string& path, void* a3, bool a4)
{
    bool result = originalLoadDscCtrl(pv_data, path, a3, a4);
    pv_db::PvDBEntry* entry = nullptr;
    pv_db::PvDBDifficulty* diff = nullptr;
    ResolveCurrentPv(&entry, &diff);
    CallOnAll<void(PVGamePvData*, pv_db::PvDBEntry*, pv_db::PvDBDifficulty*, std::string&, bool*)>("OnLoadDscUpdate", pv_data, entry, diff, std::string(path.data(), path.size()), &result);
    return result;
}

HOOK(bool, __fastcall, TaskPvDBParseEntry, 0x1404B1020, uint64_t a1, pv_db::PvDBEntry* entry, void* prop, int32_t id)
{
    bool result = originalTaskPvDBParseEntry(a1, entry, prop, id);
    CallOnAll<void(pv_db::PvDBEntry*, bool*)>("OnPvDBParseEntry", entry, &result);
    return result;
}

HOOK(void, __fastcall, DrawArcadeGame, 0x140271AB0, PVGameArcade* data)
{
    CallOnAll<void(PVGameArcade*)>("OnDrawGame", data);
    originalDrawArcadeGame(data);
    CallOnAll<void(PVGameArcade*)>("OnDrawGamePost", data);
}

HOOK(void, __fastcall, UpdateTargets, 0x14026DD80, PVGameArcade* data, float dt)
{
    CallOnAll<void(PVGameArcade*, float)>("OnUpdateTargets", data, dt);
    originalUpdateTargets(data, dt);
}

HOOK(void, __fastcall, DrawKiseki, 0x140271030, PvGameTarget* target)
{
    CallOnAll<void(PvGameTarget*)>("OnDrawKiseki", target);
    originalDrawKiseki(target);
}

// FT PV selection menu hooks
HOOK(bool, __fastcall, PVselPS4Init, 0x140202D50, PVselPS4* sel)
{
    bool result = originalPVselPS4Init(sel);
    CallOnAll<void(PVselPS4*, bool*)>("OnPvMenuInitFT", sel, &result);
	return result;
}

HOOK(void, __fastcall, PVselPS4CreateSortedPVList, 0x140206C30, PVselPS4* sel)
{
    originalPVselPS4CreateSortedPVList(sel);
    CallOnAll<void(PVselPS4*)>("OnPvMenuCreateSortedPVListFT", sel);
}

HOOK(bool, __fastcall, PVselPS4Ctrl, 0x1402033C0, PVselPS4* sel)
{
    bool result = originalPVselPS4Ctrl(sel);
    CallOnAll<void(PVselPS4*, bool*)>("OnPvMenuCtrlFT", sel, &result);
    return result;
}

HOOK(bool, __fastcall, PVselPS4Dest, 0x140204DA0, uint64_t a1)
{
    bool result = originalPVselPS4Dest(a1);
    CallOnAll<void(bool*)>("OnPvMenuDestFT", &result);
    return result;
}

HOOK(void, __fastcall, PVselPS4Disp, 0x140204EB0, uint64_t a1)
{
    CallOnAll<void()>("OnPvMenuDispFT");
    originalPVselPS4Disp(a1);
}

// MM+ PV selection menu hooks
HOOK(bool, __fastcall, PVSelectorSwitchInit, 0x1406ED9D0, uint64_t a1)
{
    bool result = originalPVSelectorSwitchInit(a1);
    CallOnAll<void(bool*)>("OnPvMenuInit", &result);
    return result;
}

HOOK(bool, __fastcall, PVSelectorSwitchCreateSortedPVList, 0x1406F3100, PVSelectorSwitch* sel)
{
    bool result = originalPVSelectorSwitchCreateSortedPVList(sel);
    CallOnAll<void(PVSelectorSwitch*, bool*)>("OnPvMenuCreateSortedPVList", sel, &result);
    return result;
}

HOOK(bool, __fastcall, PVSelectorSwitchCtrl, 0x1406EDC40, PVSelectorSwitch* sel)
{
    bool result = originalPVSelectorSwitchCtrl(sel);
    CallOnAll<void(PVSelectorSwitch*, bool*)>("OnPvMenuCtrl", sel, &result);
    return result;
}

HOOK(bool, __fastcall, PVSelectorSwitchDest, 0x1406EE720, uint64_t a1)
{
    bool result = originalPVSelectorSwitchDest(a1);
    CallOnAll<void(bool*)>("OnPvMenuDest", &result);
    return result;
}

HOOK(void, __fastcall, PVSelectorSwitchDisp, 0x1406EE7B0, uint64_t a1)
{
    CallOnAll<void()>("OnPvMenuDisp");
    originalPVSelectorSwitchDisp(a1);
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
        INSTALL_HOOK(LoadDscCtrl);
        INSTALL_HOOK(TaskPvDBParseEntry);
	    INSTALL_HOOK(DrawArcadeGame);
		INSTALL_HOOK(UpdateTargets);
		INSTALL_HOOK(DrawKiseki);

        INSTALL_HOOK(PVselPS4Init);
        INSTALL_HOOK(PVselPS4CreateSortedPVList);
        INSTALL_HOOK(PVselPS4Ctrl);
        INSTALL_HOOK(PVselPS4Dest);
        INSTALL_HOOK(PVselPS4Disp);

		INSTALL_HOOK(PVSelectorSwitchInit);
        INSTALL_HOOK(PVSelectorSwitchCreateSortedPVList);
        INSTALL_HOOK(PVSelectorSwitchCtrl);
        INSTALL_HOOK(PVSelectorSwitchDest);
		INSTALL_HOOK(PVSelectorSwitchDisp);

		app::TaskWork::add_task(new HxTask(), "HxTask", 1);

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