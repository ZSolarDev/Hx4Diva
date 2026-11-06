package;

import diva.Diva;
import diva.types.PvGameTarget;

class Main {
	public static function main() {
		Diva.initMod();
		Diva.hookManager.registerGameHook(OnPvGetHitState((ctx) -> {
			var target = ctx.target.ref;
			for (vertIdx in 0...40) {
				var vert = PvGameTarget.getKiseki(target, vertIdx);
				vert.color = 0xFFFFFF00;
			}
		}));
	}
}
