package diva.task;

/**
 * A base class for tasks.
 * 
 * @since 1.0.0-alpha.1
 */
class DTask {
	/**
	 * Called when this `DTask` is registered.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function init() {}

	/**
	 * Called when this `DTask` is updated.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function update() {}

	/**
	 * Called when this `DTask` is destroyed.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function destroy() {}

	/**
	 * Called when this `DTask` has the ability to draw.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function draw() {}

	public function basic() {}

	/**
	 * Creates a new `DTask`.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public function new() {}
}
