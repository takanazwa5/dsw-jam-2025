class_name JumpingState extends State


var slided : bool = false


@onready var sprite : AnimatedSprite2D = %Sprite
@onready var running_state : RunningState = %RunningState
@onready var sliding_state : SlidingState = %SlidingState
@onready var jump_buffer : Timer = %JumpBuffer
@onready var running_collision : CollisionShape2D = %RunningCollision
@onready var sliding_collision : CollisionShape2D = %SlidingCollision
@onready var jumping_collision : CollisionShape2D = %JumpingCollision


func enter() -> void:

	SignalBus.jumping_state_entered.emit()
	sprite.play(&"jumping")
	player.velocity.y = -Player.JUMP_VELOCITY
	jumping_collision.set_deferred("disabled", false)


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("slide"):

		if not slided:

			player.velocity.y = 100

		player.gravity_multiplier = 5

	else:

		player.gravity_multiplier = 1


func physics_update(_delta: float) -> void:

	if player.is_on_floor():

		if Input.is_action_pressed("slide") and Player.can_slide:

			transition.emit(sliding_state)

		elif Input.is_action_pressed("jump") and not jump_buffer.is_stopped() and Player.can_jump:

			transition.emit(self)

		else:

			transition.emit(running_state)


func exit() -> void:

	player.gravity_multiplier = 1
	slided = false
	jumping_collision.set_deferred("disabled", true)
