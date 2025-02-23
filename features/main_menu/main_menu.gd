class_name MainMenu extends Control


@onready var play_button : TextureButton = %PlayButton
@onready var quit_button : TextureButton = %QuitButton


func _ready() -> void:

	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_play_button_pressed() -> void:

	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_button_pressed() -> void:

	get_tree().quit()
