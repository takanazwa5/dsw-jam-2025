class_name Main extends Node


func _process(_delta: float) -> void:

	DebugPanel.add_property(Engine.get_frames_per_second(), "FPS", 1)
