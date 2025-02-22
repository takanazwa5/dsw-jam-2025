class_name Chunk extends StaticBody2D


signal screen_exited()


@onready var vosn : VisibleOnScreenNotifier2D = %VOSN


func _ready() -> void:

	vosn.screen_exited.connect(_on_vosn_screen_exited)


func _on_vosn_screen_exited() -> void:

	screen_exited.emit()
