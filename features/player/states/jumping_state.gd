class_name JumpingState extends State


@onready var running_state : RunningState = %RunningState
@onready var sliding_state : SlidingState = %SlidingState
@onready var jump_buffer : Timer = %JumpBuffer


func enter() -> void:

	player.velocity.y = -Player.JUMP_VELOCITY


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("slide"):

		player.velocity.y = 0
		player.gravity_multiplier = 2

	else:

		player.gravity_multiplier = 1


func physics_update(_delta: float) -> void:

	if player.is_on_floor():

		if Input.is_action_pressed("jump") and not jump_buffer.is_stopped():

			transition.emit(self)

		elif Input.is_action_pressed("slide"):

			transition.emit(sliding_state)

		else:

			transition.emit(running_state)


func exit() -> void:

	player.gravity_multiplier = 1
