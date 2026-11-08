package diva;

import diva.hooks.DModHook;
import haxe.Timer;

/**
 * The main class for using timers.
 * 
 * @since 1.0.0-alpha.1
 */
class DTimer {
	var timer:DModHook;
	var repeatsLeft:Int;
	var pausedRemaining:Float = 0;

	/**
	 * The total seconds this `DTimer` is supposed to run for.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public var seconds(default, null):Float = 0;

	/**
	 * The time when this `DTimer` expires.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public var dueTime(default, null):Float = 0;

	/**
	 * Whether this `DTimer` is paused.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public var paused(default, null):Bool = false;

	/**
	 * The number of seconds left until this `DTimer` expires.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public var remainingTime(get, never):Float;

	function get_remainingTime():Float
		return paused ? pausedRemaining : Math.max(0, dueTime - Timer.stamp());

	/**
	 * Creates a new `DTimer`.
	 * 
	 * @param seconds The time in seconds.
	 * @param onFinish The function to call when this `DTimer` expires.
	 * @param loops The number of times to repeat this `DTimer`. Negative values loop forever,
	 * and 0 means no repeats.
	 * @since 1.0.0-alpha.1
	 */
	public function new(seconds:Float, onFinish:Void->Void, loops:Int = 0) {
		this.seconds = seconds;
		repeatsLeft = loops;
		dueTime = Timer.stamp() + seconds;

		timer = OnFrame(_ -> {
			if (Timer.stamp() < dueTime)
				return;

			if (repeatsLeft == 0) {
				stop();
			} else {
				if (repeatsLeft > 0)
					repeatsLeft--;
				dueTime += seconds;
			}

			onFinish();
		});
		Diva.hookManager.registerModHook(timer);
	}

	/**
	 * Pauses this `DTimer`.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function pause() {
		if (paused)
			return;
		pausedRemaining = Math.max(0, dueTime - Timer.stamp());
		paused = true;
	}

	/**
	 * Unpauses this `DTimer`.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function unpause() {
		if (!paused)
			return;
		dueTime = Timer.stamp() + pausedRemaining;
		paused = false;
	}

	/**
	 * Stops this `DTimer`.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function stop() {
		Diva.hookManager.unregisterModHook(timer);
	}
}
