package diva;

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
	public static var errorPostfix:String = null;

	public static function log(message:String, level:String) {
		Sys.println('[${Diva.modName}' + (Diva.modVersion != null ? ' ${Diva.modVersion}' : '') + '::$level] $message');
		Sys.stdout().flush();
	}

	public static function info(message:String)
		log(message, 'INFO');

	public static function warning(message:String)
		log(message, 'WARNING');

	public static function error(message:String)
		log(message + (errorPostfix != null ? '\n${errorPostfix}' : ''), 'ERROR');
}
