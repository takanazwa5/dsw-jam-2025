class_name Player extends CharacterBody2D


const SPEED : float = 300.0
const ACCELERATION : float = 0.01
const JUMP_VELOCITY : float = 500.0


func _physics_process(delta: float) -> void:

	if not is_on_floor():

		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():

		velocity.y = -JUMP_VELOCITY

	#velocity.x = lerpf(velocity.x, SPEED, ACCELERATION)

	move_and_slide()


func _process(_delta: float) -> void:

	#DebugPanel.add_property(velocity.x, "velocity_x", 2)
	pass
