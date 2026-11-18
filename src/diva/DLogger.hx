package diva;

import haxe.Resource;
import sys.io.File;
import sys.io.FileOutput;

/**
 * The main class for logging to console.
 * 
 * @since 1.0.0-alpha.1
 */
class DLogger {
	/**
	 * The text appended to error messages. Optional.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public static var errorPostfix:String = 'The mod will be disabled.';

	/**
	 * The text appended to native/fatal error messages. Optional.
	 * 
	 * @since 1.0.0-alpha.5
	 */
	public static var nativeErrorPostfix:String = 'The mod will be disabled.';

	public static function log(message:String, level:String) {
		Sys.println('[${Diva.modName} ' + (Diva.modVersion != null ? ' ${Diva.modVersion}' : '') + '::$level] $message');
		Sys.stdout().flush();
	}

	public static function info(message:String)
		log(message, 'INFO');

	public static function warning(message:String)
		log(message, 'WARNING');

	static function showErrorBox(message:String, kind:String):Void {
		var title:String = Diva.modName;
		if (Diva.modVersion != null)
			title += ' ' + Diva.modVersion;
		title += ' - ' + kind;

		untyped __cpp__('(int)MessageBoxW(NULL, {0}.wchar_str(), {1}.wchar_str(), MB_OK | MB_ICONERROR | MB_SYSTEMMODAL | MB_SETFOREGROUND | MB_TOPMOST)',
			message, title);
	}

	public static function error(message:String) {
		var full = message;
		if (errorPostfix != null)
			full += '\n\n' + errorPostfix;

		log(full, 'ERROR');
		showErrorBox(full, 'ERROR');
	}

	// Since 1.0.0-alpha.5
	public static function nativeError(message:String) {
		var full = message;
		if (nativeErrorPostfix != null)
			full += '\n\n' + nativeErrorPostfix;

		log(full, 'FATAL ERROR');
		showErrorBox(full, 'FATAL ERROR');
	}
}
