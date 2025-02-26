class_name Chunk extends StaticBody2D


signal screen_exited


@onready var vosn : VisibleOnScreenNotifier2D = %VOSN
@onready var obstacles : Array[Area2D] = [
	%SmallObstacle,
	%BigObstacle,
	%VentObstacle,
	%CablesObstacle,
	%OrbObstacle,
]


func _ready() -> void:

	vosn.screen_exited.connect(_on_vosn_screen_exited)
	var obstacle : Area2D
	obstacle = obstacles.pick_random()
	obstacle.body_entered.connect(_on_obstacle_body_entered)
	#print(Main.tutorials_completed)
	obstacle.visible = true if Main.tutorials_completed else false
	obstacle.monitoring = obstacle.visible


func _on_vosn_screen_exited() -> void:

	screen_exited.emit()


func _on_obstacle_body_entered(body: Node2D) -> void:

	if body is Player:

		SignalBus.player_collided.emit()
