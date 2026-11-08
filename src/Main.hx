package;

import diva.Diva;
import diva.types.display.spr.Spr;

/* AET testing, only works with New Classics installed (i think)
	import diva.types.display.aet.AetElementContainer;
	class Main {
	static var played = false;

	public static function main() {
		Diva.initMod();
		var container:AetElementContainer = null;

		Diva.hookManager.registerGameHook(OnPvInitComplete(() -> {
			container = new AetElementContainer();
			played = false;
		}));

		Diva.hookManager.registerGameHook(OnPvUpdate(() -> {
			if (container == null || played)
				return;
			container.element.setScene(14010085);
			var ok = container.element.setLayer("bonus_zone", 5, 14, 1);
			trace('SetLayer returned $ok');
			played = true;
		}));

		Diva.hookManager.registerGameHook(OnPvExit(() -> {
			if (container != null)
				container.destroy();
			container = null;
		}));
	}
	}
 */
/* Task system testing.
	import diva.task.DTask;
	import diva.types.display.spr.Spr;

	class Main {
		public static function main() {
			Diva.initMod();
			Diva.taskManager.registerTask('test', new TestTask());
		}
	}

	class TestTask extends DTask {
		override public function draw() {
			Spr.drawSimpleText(100, 100, 14, 20, 'Dummy text!', true, 0xFFFFFFFF, null);
		}
	}
 */
class Main {
	public static function main() {
		Diva.initMod();
		Diva.hookManager.registerMenuHook(OnMenuUpdate(ctx -> trace('menu update')));
		Diva.hookManager.registerMenuHook(OnMenuDraw(() -> {
			Spr.drawSimpleText(100, 100, 14, 20, 'Only shows in menu!', true, 0xFF0000FF, null);
		}));
	}
}
