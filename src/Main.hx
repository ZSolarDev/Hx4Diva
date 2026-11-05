package;

import diva.Diva;

class Main {
    public static function main() {
        Diva.initMod('Hx4Diva-TestMod', 'v1.0.0');
        Diva.hookManager.registerGameHook(OnPvGetHitState((ctx) -> {
            if (ctx.target.ref.flyingTimeRemaining <= 0)
                ctx.result = Cool;
        }));
    }
}