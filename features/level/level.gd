class_name Level extends Node2D


const CHUNK_SCENE : PackedScene = preload("res://features/chunk/chunk.tscn")
const CHUNK_INITIAL_SPEED : int = 100
const CHUNK_SPEED_INCREMENT : int = 40


var chunk_speed : int = 0
var chunk_counter : int = 0
var next_speed_up_chunk : int = 2
var calculated_speed : int = CHUNK_INITIAL_SPEED


@onready var chunks_container : Node = %ChunksContainer
@onready var chunks : Array[Chunk] = [%Chunk, %Chunk2]


func _ready() -> void:

	Main.level = self

	for chunk : Chunk in chunks:

		chunk.screen_exited.connect(_on_chunk_screen_exited)


func _process(delta: float) -> void:

	DebugPanel.add_property(chunk_counter, "chunk_counter", 2)
	DebugPanel.add_property(chunk_speed, "chunk_speed", 3)
	DebugPanel.add_property(next_speed_up_chunk, "next_speed_up", 4)

	for chunk : Chunk in chunks_container.get_children():

		chunk.position.x -= chunk_speed * delta


func _on_chunk_screen_exited() -> void:

	var new_chunk : Chunk = CHUNK_SCENE.instantiate()
	new_chunk.position = chunks[-1].position + Vector2(640, 0)
	new_chunk.screen_exited.connect(_on_chunk_screen_exited)
	chunks.append(new_chunk)
	chunks_container.add_child(new_chunk)
	chunks.pop_front().queue_free()
	chunk_counter += 1 if Main.tutorials_completed else chunk_counter

	if chunk_counter == next_speed_up_chunk:

		next_speed_up_chunk = floor(next_speed_up_chunk * 1.5) + 1
		calculated_speed = chunk_speed + CHUNK_SPEED_INCREMENT

		if not Main.player.state_machine.state == Main.player.sliding_state:

			chunk_speed = calculated_speed
