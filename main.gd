class_name Main extends Node


static var player : Player
static var level : Level

static var tutorials_completed : bool = false
static var time : float = 0.0


@onready var debug_info : Control = %DebugInfo
@onready var tutorial : Label = %Tutorial
@onready var jump_tutorial : Label = %JumpTutorial
@onready var slide_tutorial : Label = %SlideTutorial


func _ready() -> void:

	debug_info.visible = OS.is_debug_build()

	SignalBus.idle_state_exited.connect(_on_idle_state_exited)
	SignalBus.jumping_state_entered.connect(_on_jumping_state_entered)
	SignalBus.sliding_state_entered.connect(_on_sliding_state_entered)


func _input(event: InputEvent) -> void:

	if not OS.is_debug_build():

		return

	if event is InputEventKey and event.pressed and not event.echo:

		if event.physical_keycode == KEY_ESCAPE:

			get_tree().quit()

		if event.physical_keycode == KEY_R:

			get_tree().reload_current_scene()

		if event.physical_keycode == KEY_BRACKETLEFT:

			if DisplayServer.window_get_mode() == Window.MODE_WINDOWED:

				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

			else:

				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _process(_delta: float) -> void:

	DebugPanel.add_property(Engine.get_frames_per_second(), "FPS", 1)


func _on_idle_state_exited() -> void:

	tutorial.hide()
	await get_tree().create_timer(1.0).timeout
	jump_tutorial.show()
	Player.can_jump = true


func _on_jumping_state_entered() -> void:

	SignalBus.jumping_state_entered.disconnect(_on_jumping_state_entered)
	Player.can_jump = false
	jump_tutorial.hide()
	await get_tree().create_timer(1.0).timeout
	slide_tutorial.show()
	Player.can_slide = true


func _on_sliding_state_entered() -> void:

	SignalBus.sliding_state_entered.disconnect(_on_sliding_state_entered)
	slide_tutorial.hide()
	Player.can_jump = true
	tutorials_completed = true
