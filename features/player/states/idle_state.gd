class_name IdleState extends State


@onready var running_state : RunningState = %RunningState


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("jump"):

		transition.emit(running_state)
		Main.level.chunk_speed = Level.CHUNK_INITIAL_SPEED


func exit() -> void:

	SignalBus.idle_state_exited.emit()
