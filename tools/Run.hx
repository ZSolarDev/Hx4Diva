package tools;

class Run {
	public static function main()
		Sys.exit(Sys.command('haxelib', ['run', 'hxp', 'tools/RunHxp'].concat(Sys.args())));
}
