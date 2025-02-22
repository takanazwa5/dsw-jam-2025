class_name Main extends Node


@onready var debug_info : Control = %DebugInfo


func _ready() -> void:

	debug_info.visible = OS.is_debug_build()


func _input(event: InputEvent) -> void:

	if not OS.is_debug_build():

		return

	if event is InputEventKey and event.pressed and not event.echo:

		if event.physical_keycode == KEY_ESCAPE:

			get_tree().quit()

		if event.physical_keycode == KEY_BRACKETLEFT:

			if DisplayServer.window_get_mode() == Window.MODE_WINDOWED:

				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

			else:

				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _process(_delta: float) -> void:

	DebugPanel.add_property(Engine.get_frames_per_second(), "FPS", 1)
