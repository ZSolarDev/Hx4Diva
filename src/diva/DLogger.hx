package diva;

import sys.FileSystem;
import sys.io.File;

class DLogger {
    public static var errorPostfix:String = null;

    public static function log(message:String, level:String) {
        Sys.println('[${Diva.modName}' + (Diva.modVersion != null ? ' ${Diva.modVersion}' : '') + '::$level] $message');
        if (!FileSystem.exists('__hxLog.txt'))
            File.saveContent('__hxLog.txt', '');
        File.saveContent('__hxLog.txt', File.getContent('__hxLog.txt') + '\n$message');
    }
    public static function info(message:String)
        log(message, 'INFO');
    public static function warning(message:String)
        log(message, 'WARNING');
    public static function error(message:String)
        log(message + (errorPostfix != null ? '\n${errorPostfix}' : ''), 'ERROR');
}