class_name Player extends CharacterBody2D


const SPEED : float = 150.0
const ACCELERATION : float = 0.01
const JUMP_VELOCITY : float = 500.0


static var can_jump : bool = false
static var can_slide : bool = false
static var can_move : bool = false

var gravity_multiplier : int = 1


@onready var jump_buffer : Timer = %JumpBuffer
@onready var state_machine : StateMachine = %StateMachine
@onready var sliding_state : SlidingState = %SlidingState


func _ready() -> void:

	can_jump = false
	can_slide = false
	can_move = false

	Main.player = self
	State.player = self


func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("jump"):

		jump_buffer.start()


func _physics_process(delta: float) -> void:

	if not is_on_floor():

		velocity += get_gravity() * gravity_multiplier * delta

	#velocity.x = lerpf(velocity.x, SPEED, ACCELERATION)

	var direction : float = Input.get_axis("walk_left", "walk_right")
	velocity.x = direction * SPEED if can_move else 0.0
	position.x = clampf(position.x, 100, 500)

	move_and_slide()


func _process(_delta: float) -> void:

	DebugPanel.add_property(velocity.y, "velocity_y", 6)
	DebugPanel.add_property(gravity_multiplier, "gravity_multiplier", 7)
