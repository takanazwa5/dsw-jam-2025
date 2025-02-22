class_name RunningState extends State


@onready var sliding_state : SlidingState = %SlidingState
@onready var jumping_state : JumpingState = %JumpingState
@onready var sprite : AnimatedSprite2D = %Sprite
@onready var running_collision : CollisionShape2D = %RunningCollision
@onready var sliding_collision : CollisionShape2D = %SlidingCollision


func enter() -> void:

	sprite.play(&"running")


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("jump") and player.is_on_floor() and Player.can_jump:

		transition.emit(jumping_state)

	if event.is_action_pressed("slide") and player.is_on_floor() and Player.can_slide:

		transition.emit(sliding_state)


func update(_delta: float) -> void:

	sprite.speed_scale = clampf(Main.level.chunk_speed / 100.0, 1, 3)
