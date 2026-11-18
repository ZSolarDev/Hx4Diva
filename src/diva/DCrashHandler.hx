package diva;

import haxe.CallStack;

// Since 1.0.0-alpha.5
@:headerCode('
#include <windows.h>
extern volatile bool g_haxeDead;
')
@:cppFileCode('
#include <stdio.h>

volatile bool g_haxeDead = false;
static volatile LONG g_reporting = 0;
static __declspec(thread) int t_guardDepth = 0;

static bool InOwnModule(void* addr) {
    HMODULE a = NULL, b = NULL;
    GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT, (LPCSTR)addr, &a);
    GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT, (LPCSTR)&InOwnModule, &b);
    return a != NULL && a == b;
}

static bool IsFatal(DWORD c) {
    return c == EXCEPTION_ACCESS_VIOLATION || c == EXCEPTION_INT_DIVIDE_BY_ZERO ||
           c == EXCEPTION_ILLEGAL_INSTRUCTION || c == EXCEPTION_STACK_OVERFLOW ||
           c == EXCEPTION_PRIV_INSTRUCTION || c == EXCEPTION_IN_PAGE_ERROR;
}

static LONG CALLBACK HaxeVehHandler(EXCEPTION_POINTERS* info) {
    DWORD code = info->ExceptionRecord->ExceptionCode;
    if (!IsFatal(code)) return EXCEPTION_CONTINUE_SEARCH;

    void* addr = info->ExceptionRecord->ExceptionAddress;
    if (t_guardDepth == 0 && !InOwnModule(addr)) return EXCEPTION_CONTINUE_SEARCH;
    if (InterlockedCompareExchange(&g_reporting, 1, 0) != 0) return EXCEPTION_CONTINUE_SEARCH;

    char mod[MAX_PATH] = "?";
    HMODULE hm = NULL;
    size_t off = 0;
    if (GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT, (LPCSTR)addr, &hm)) {
        GetModuleFileNameA(hm, mod, MAX_PATH);
        off = (size_t)((char*)addr - (char*)hm);
    }

    ULONG_PTR kind = info->ExceptionRecord->NumberParameters > 0 ? info->ExceptionRecord->ExceptionInformation[0] : 0;
    ULONG_PTR target = info->ExceptionRecord->NumberParameters > 1 ? info->ExceptionRecord->ExceptionInformation[1] : 0;

    char addrStr[32], offStr[32], targetStr[32];
    snprintf(addrStr, sizeof(addrStr), "%p", addr);
    snprintf(offStr, sizeof(offStr), "0x%llX", (unsigned long long)off);
    snprintf(targetStr, sizeof(targetStr), "%p", (void*)target);
    const char* access = kind == 1 ? "write" : (kind == 8 ? "dep" : "read");

    ::diva::DCrashHandler_obj::reportCrash((int)code, ::String(addrStr), ::String(mod), ::String(offStr), ::String(access), ::String(targetStr));

    return EXCEPTION_CONTINUE_SEARCH;
}

static int SehFilter(DWORD code) {
    return IsFatal(code) ? EXCEPTION_EXECUTE_HANDLER : EXCEPTION_CONTINUE_SEARCH;
}

static bool SehCallPending() {
    if (g_haxeDead) return false;
    bool ok = false;
    t_guardDepth++;
    __try {
        ::diva::DCrashHandler_obj::runPending();
        ok = true;
    } __except (SehFilter(GetExceptionCode())) {
        g_haxeDead = true;
    }
    t_guardDepth--;
    return ok;
}
')
class DCrashHandler {
	static var pending:Void->Void;

	public static function install():Void {
		untyped __cpp__('
			static bool s_installed = false;
			if (!s_installed) {
				s_installed = true;
				AddVectoredExceptionHandler(1, HaxeVehHandler);
			}
		');
	}

	@:keep
	public static function reportCrash(code:Int, address:String, module:String, offset:String, access:String, target:String):Void {
		var msg = 'Native exception 0x${StringTools.hex(code, 8)}\nAt $address\n$module + $offset\n$access address $target\n\nStack:'
			+ CallStack.toString(CallStack.callStack());

		// Restore the cursor the game hid.
		untyped __cpp__('
        ClipCursor(NULL);
        while (ShowCursor(TRUE) < 0) {}
        SetCursor(LoadCursor(NULL, IDC_ARROW));
        ');

		DLogger.nativeError(msg);
	}

	public static function guarded(f:Void->Void):Bool {
		if (isDead())
			return false;
		var prev = pending;
		pending = f;
		var ok:Bool = untyped __cpp__('SehCallPending()');
		pending = prev;
		return ok;
	}

	public static function guardedValue<T>(f:Void->T, fallback:T):T {
		var result = fallback;
		guarded(function()result = f());
		return result;
	}

	public static function isDead():Bool
		return untyped __cpp__('g_haxeDead');

	public static function markDead() {
		untyped __cpp__('g_haxeDead = true;');
	}

	public static function testCrash():Void {
		untyped __cpp__('*(volatile int*)0 = 1;');
	}

	@:keep
	public static function runPending():Void {
		pending();
	}
}
