class_name SlidingState extends State


@onready var running_state : RunningState = %RunningState
@onready var jumping_state : JumpingState = %JumpingState
@onready var sprite : AnimatedSprite2D = %Sprite
@onready var running_collision : CollisionShape2D = %RunningCollision
@onready var sliding_collision : CollisionShape2D = %SlidingCollision
@onready var slide_timer : Timer = %SlideTimer


func _ready() -> void:

	slide_timer.timeout.connect(_on_slide_timer_timeout)


func enter() -> void:

	SignalBus.sliding_state_entered.emit()
	sprite.play(&"sliding")
	running_collision.set_deferred("disabled", true)
	sliding_collision.set_deferred("disabled", false)
	slide_timer.start()
	_tween_zoom(1, 1)
	Main.level.chunk_speed += Level.CHUNK_SPEED_INCREMENT


func input_event(event: InputEvent) -> void:

	if event.is_action_pressed("jump"):

		transition.emit(jumping_state)

	if event.is_action_released("slide"):

		transition.emit(running_state)


func exit() -> void:

	sliding_collision.set_deferred("disabled", true)
	running_collision.set_deferred("disabled", false)
	slide_timer.stop()
	_tween_zoom(1.05, 1.05)
	Main.level.chunk_speed = Main.level.calculated_speed


func _tween_zoom(x: float, y: float) -> void:

	var tween : Tween = get_tree().create_tween()
	tween.tween_property(get_viewport().get_camera_2d(), "zoom", Vector2(x, y), 0.1)


func _on_slide_timer_timeout() -> void:

	transition.emit(running_state)
