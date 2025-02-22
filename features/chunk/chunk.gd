class_name Chunk extends StaticBody2D


signal screen_exited()


@onready var player_ref : CharacterBody2D = %PlayerRef
@onready var vosn : VisibleOnScreenNotifier2D = %VOSN
@onready var obstacles : Array[Area2D] = [%Obstacle, %BigObstacle, %LongObstacle]


func _ready() -> void:

	player_ref.hide()
	vosn.screen_exited.connect(_on_vosn_screen_exited)

	var obstacle : Area2D
	if Main.level is Level and Main.level.chunk_speed >= 300:

		obstacle = obstacles.pick_random()

	else:

		obstacle = obstacles[0]

	obstacle.body_entered.connect(_on_obstacle_body_entered)
	obstacle.visible = true if Main.tutorials_completed else false
	obstacle.monitoring = obstacle.visible


func _on_vosn_screen_exited() -> void:

	screen_exited.emit()


func _on_obstacle_body_entered(body: Node2D) -> void:

	if body is Player:

		get_tree().paused = true
