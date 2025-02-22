class_name RunningState extends State


@onready var sliding_state : SlidingState = %SlidingState
@onready var jumping_state : JumpingState = %JumpingState
@onready var running_sprite : Sprite2D = %RunningSprite
@onready var sliding_sprite : Sprite2D = %SlidingSprite
@onready var running_collision : CollisionShape2D = %RunningCollision
@onready var sliding_collision : CollisionShape2D = %SlidingCollision


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("jump") and player.is_on_floor():

		transition.emit(jumping_state)

	if event.is_action_pressed("slide") and player.is_on_floor():

		transition.emit(sliding_state)
