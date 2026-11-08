import haxe.Json;
import hxp.Log;
import hxp.Path;
import hxp.Script;
import hxp.System;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class MakeDefault extends Script {
	override public function new() {
		try {
			super();
			var tCwd = defines.get('_TARGET_CWD');
			var name = commandArgs[0];
			if (name == null)
				name = 'DummyMod';
			Log.info('', 'Creating mod "$name".');
			FileSystem.createDirectory(Path.join([tCwd, name]));
			copyDirectory('template/', Path.join([tCwd, name]));
			var modJson = Path.join([tCwd, name, 'mod.json']);
			File.saveContent(modJson, File.getContent(modJson).replace('{NAME}', name));
			Log.info('\n>>\n>> Mod "$name" was created successfully.\n>>\n');
		} catch (e) {
			Log.info('FATAL ERROR: ${e.message}', 'FATAL ERROR: ${e.message}\nStack:${e.stack.toString()}');
			Sys.exit(1);
		}
	}

	public static function copyDirectory(source:String, destination:String):Void {
		if (!FileSystem.exists(destination))
			FileSystem.createDirectory(destination);

		for (item in FileSystem.readDirectory(source)) {
			var srcPath = Path.join([source, item]);
			var dstPath = Path.join([destination, item]);

			if (FileSystem.isDirectory(srcPath))
				copyDirectory(srcPath, dstPath);
			else
				File.copy(srcPath, dstPath);
		}
	}
}
