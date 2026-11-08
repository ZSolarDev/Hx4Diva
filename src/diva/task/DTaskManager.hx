package diva.task;

class DTaskManager {
	public var taskBank:Map<String, DTask>;

	public function new() {
		taskBank = [];
	}

	public function registerTask(name:String, task:DTask) {
		task.init();
		taskBank.set(name, task);
	}

	public function unregisterTask(name:String, ?destroy:Bool = true) {
		if (!taskBank.exists(name))
			return;
		if (destroy)
			taskBank.get(name).destroy();
		taskBank.remove(name);
	}

	public function getTask(name:String):DTask
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
