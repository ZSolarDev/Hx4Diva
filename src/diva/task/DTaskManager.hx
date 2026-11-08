package diva.task;

/**
 * The class that manages tasks. Use this through `Diva.taskManager`.
 * 
 * @since 1.0.0-alpha.1
 */
class DTaskManager {
	/**
	 * The task bank, containing all registered tasks.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	public var taskBank:Map<String, DTask>;

	@:allow(diva.Diva) private function new() {
		taskBank = [];
	}

	/**
	 * Registers and initializes a task.
	 * 
	 * @param name The name of the task.
	 * @param task The task to register.
	 * @since 1.0.0-alpha.1
	 */
	public function registerTask(name:String, task:DTask) {
		taskBank.set(name, task);
		task.init();
	}

	/**
	 * Unregisters a task.
	 * 
	 * @param name The name of the task.
	 * @param destroy Whether to destroy the task. Defaults to `true`.
	 * @since 1.0.0-alpha.1
	 */
	public function unregisterTask(name:String, ?destroy:Bool = true) {
		if (!taskBank.exists(name))
			return;
		if (destroy)
			taskBank.get(name).destroy();
		taskBank.remove(name);
	}

	/**
	 * Gets a task.
	 * 
	 * @param name The name of the task.
	 * @return `Null<DTask>` The task, or `null` if the task doesn't exist.
	 * @since 1.0.0-alpha.1
	 */
	public function getTask(name:String):Null<DTask>
		return taskBank.get(name);

	@:allow(diva.Diva)
	private function update()
		for (task in taskBank)
			task.update();

	@:allow(diva.Diva)
	private function draw()
		for (task in taskBank)
			task.draw();

	@:allow(diva.Diva)
	private function basic()
		for (task in taskBank)
			task.basic();
}
