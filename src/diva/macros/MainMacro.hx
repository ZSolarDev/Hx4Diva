package diva.macros;

#if macro
import haxe.Json;
import haxe.Resource;
import haxe.macro.*;

using StringTools;

class MainMacro {
	static var defined = false;

	public static function mainClass(name:String) {
		if (defined)
			return;
		defined = true;

		var path = name.split('.');

		Context.defineModule('DivaMain', [
			{
				pack: [],
				pos: Context.currentPos(),
				name: 'DivaMain',
				doc: 'The main class of ${Json.parse(Resource.getString('modData')).name}.',
				kind: TDClass(),
				fields: [
					{
						name: 'main',
						access: [APublic, AStatic],
						doc: 'The main function. A stub, it\'s so that hxcpp can compile thinking there\'s a valid entrypoint, even though it never calls it.',
						kind: FFun({
							args: [],
							expr: macro {}
						}),
						pos: Context.currentPos()
					},
					{
						name: 'entrypoint',
						access: [APublic, AStatic],
						doc: 'The actual entrypoint. Calls `' + name.split('.').pop() + '.main()`.',
						kind: FFun({
							args: [],
							expr: macro $p{path}.main()
						}),
						pos: Context.currentPos()
					}
				]
			}
		]);
	}
}
#end
