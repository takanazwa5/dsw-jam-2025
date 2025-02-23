class_name Main extends Node


const MAIN_MENU_SCENE : PackedScene = preload("res://features/main_menu/main_menu.tscn")


static var player : Player
static var level : Level
static var tutorials_completed : bool = false
static var dead : bool = false
static var move_tutorial_shown : bool = false


@onready var debug_info : Control = %DebugInfo
@onready var tutorial : Label = %Tutorial
@onready var jump_tutorial : Label = %JumpTutorial
@onready var slide_tutorial : Label = %SlideTutorial
@onready var move_tutorial : Label = %MoveTutorial
@onready var game_over_labels : Control = %GameOverLabels
@onready var points_label : Label = %PointsLabel


func _ready() -> void:

	tutorials_completed = false
	dead = false
	move_tutorial_shown = false

	debug_info.visible = OS.is_debug_build()

	SignalBus.idle_state_exited.connect(_on_idle_state_exited)
	SignalBus.jumping_state_entered.connect(_on_jumping_state_entered)
	SignalBus.sliding_state_entered.connect(_on_sliding_state_entered)
	SignalBus.player_collided.connect(_on_player_collided)
	SignalBus.points_changed.connect(_on_points_changed)


func _input(event: InputEvent) -> void:

	if event.is_action_pressed("restart") and dead:

		tutorials_completed = false
		get_tree().reload_current_scene()

	elif event.is_action_pressed("quit") and dead:

		tutorials_completed = false
		get_tree().change_scene_to_packed(MAIN_MENU_SCENE)

	if not OS.is_debug_build():

		return

	if event is InputEventKey and event.pressed and not event.echo:

		if event.physical_keycode == KEY_ESCAPE:

			get_tree().quit()

		if event.physical_keycode == KEY_BRACKETRIGHT:

			get_tree().reload_current_scene()

		if event.physical_keycode == KEY_BRACKETLEFT:

			if DisplayServer.window_get_mode() == Window.MODE_WINDOWED:

				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

			else:

				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _process(_delta: float) -> void:

	DebugPanel.add_property(Engine.get_frames_per_second(), "FPS", 1)


func game_over() -> void:

	player.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	level.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	game_over_labels.show()
	dead = true


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
	await get_tree().create_timer(1.0).timeout
	move_tutorial.show()
	move_tutorial_shown = true
	Player.can_move = true
	await get_tree().create_timer(3.0).timeout
	move_tutorial.hide()


func _on_player_collided() -> void:

	game_over()


func _on_points_changed(amount: int) -> void:

	points_label.text = str(amount)
