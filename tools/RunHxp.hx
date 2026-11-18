import hxp.Haxelib;
import hxp.Path;
import hxp.Script;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class RunHxp extends Script {
	override public function new() {
		super();
		var args = Sys.args();

		args.pop();
		args.pop();
		args.shift();
		var tCwd = args.pop();
		var command = args.shift();

		if (FileSystem.exists('../_current'))
			FileSystem.deleteFile('../_current');
		File.saveContent('../_current', Haxelib.getVersion(new Haxelib('hx4diva')));

		function getData(id:Int):String
			return File.getContent('__data').split('==--==')[id].replace('{VERSION_PLACEHOLDER}', File.getContent('../_current')).trim();
		switch (command) {
			case 'build':
				Sys.exit(Sys.command('haxelib', ['run', 'hxp', 'BuildMod'].concat(args).concat(['-D_TARGET_CWD=$tCwd'])));
			case 'create':
				Sys.exit(Sys.command('haxelib', ['run', 'hxp', 'MakeDefault'].concat(args).concat(['-D_TARGET_CWD=$tCwd'])));
			case 'setup':
				var libs = [
					'hxcpp_extern_helpers' => 'https://github.com/Aidan63/hxcpp_extern_helpers',
					'linc_directx' => 'https://github.com/Aidan63/linc_directx',
					'linc_imgui' => 'https://github.com/Aidan63/linc_imgui'
				];
				for (lib => url in libs) {
					if (Sys.command('haxelib', ['git', lib, url, '--skip-dependencies']) != 0) {
						Sys.println('Failed to install $lib.');
						Sys.exit(1);
					}
				}
				var haxePath = Sys.getEnv('HAXEPATH');
				if (haxePath == null || !FileSystem.exists(haxePath)) {
					Sys.println('HAXEPATH is not set, can\'t install alias for Hx4Diva.');
					Sys.exit(1);
				}
				var bat = Path.join([haxePath, 'hx4diva.bat']);
				File.saveContent(bat, '@echo off\nhaxelib run hx4diva %*\n');
				Sys.println('Created alias. Success.');
			case 'help':
				Sys.println(getData(0));
			default:
				Sys.println(getData(1));
		}
	}
}
