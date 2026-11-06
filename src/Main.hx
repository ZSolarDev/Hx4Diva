package;

import diva.Diva;

class Main {
	public static function main() {
		Diva.initMod();
		Diva.hookManager.registerGameHook(OnPvGetHitState((ctx) -> {
			if (ctx.target.ref.flyingTimeRemaining <= 0)
				ctx.result = Cool;
		}));
	}
}
