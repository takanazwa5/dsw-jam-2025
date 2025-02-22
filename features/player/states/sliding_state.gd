class_name SlidingState extends State


@onready var running_state : RunningState = %RunningState
@onready var jumping_state : JumpingState = %JumpingState
@onready var running_sprite : Sprite2D = %RunningSprite
@onready var sliding_sprite : Sprite2D = %SlidingSprite
@onready var running_collision : CollisionShape2D = %RunningCollision
@onready var sliding_collision : CollisionShape2D = %SlidingCollision
@onready var slide_timer : Timer = %SlideTimer


func _ready() -> void:

	slide_timer.timeout.connect(_on_slide_timer_timeout)


func enter() -> void:

	running_sprite.hide()
	sliding_sprite.show()
	running_collision.set_deferred("disabled", true)
	sliding_collision.set_deferred("disabled", false)
	slide_timer.start()


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("jump"):

		transition.emit(jumping_state)

	if event.is_action_released("slide"):

		transition.emit(running_state)


func exit() -> void:

	sliding_sprite.hide()
	running_sprite.show()
	sliding_collision.set_deferred("disabled", true)
	running_collision.set_deferred("disabled", false)
	slide_timer.stop()


func _on_slide_timer_timeout() -> void:

	transition.emit(running_state)
