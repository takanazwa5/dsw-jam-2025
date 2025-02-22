class_name Player extends CharacterBody2D


const SPEED : float = 300.0
const ACCELERATION : float = 0.01
const JUMP_VELOCITY : float = 500.0


var gravity_multiplier : int = 1


func _ready() -> void:

	State.player = self


func _physics_process(delta: float) -> void:

	if not is_on_floor():

		velocity += get_gravity() * gravity_multiplier * delta

	#velocity.x = lerpf(velocity.x, SPEED, ACCELERATION)

	move_and_slide()


func _process(_delta: float) -> void:

	DebugPanel.add_property(velocity.y, "velocity_y", 5)
	DebugPanel.add_property(gravity_multiplier, "gravity_multiplier", 6)
