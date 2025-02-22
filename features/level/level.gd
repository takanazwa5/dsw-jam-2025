class_name Level extends Node2D


const CHUNK_SCENE : PackedScene = preload("res://features/chunk/chunk.tscn")

const CHUNK_INITIAL_SPEED : int = 100
const CHUNK_SPEED_INCREMENT : int = 40
const CHUNK_SPEED_INCREMENT_RATE : int = 2


var chunk_speed : int = CHUNK_INITIAL_SPEED
var chunk_counter : int = 0


@onready var chunks_container : Node = %ChunksContainer
@onready var chunks : Array[Chunk] = [%Chunk, %Chunk2]


func _ready() -> void:

	for chunk : Chunk in chunks:

		chunk.screen_exited.connect(_on_chunk_screen_exited)


func _process(delta: float) -> void:

	DebugPanel.add_property(chunk_counter, "chunk_counter", 2)
	DebugPanel.add_property(chunk_speed, "chunk_speed", 3)

	for chunk : Chunk in chunks_container.get_children():

		chunk.position.x -= chunk_speed * delta


func _on_chunk_screen_exited() -> void:

	var new_chunk : Chunk = CHUNK_SCENE.instantiate()
	new_chunk.position = chunks[-1].position + Vector2(640, 0)
	new_chunk.screen_exited.connect(_on_chunk_screen_exited)
	chunks.append(new_chunk)
	chunks_container.add_child(new_chunk)
	chunks.pop_front().queue_free()
	chunk_counter += 1
	if chunk_counter % CHUNK_SPEED_INCREMENT_RATE == 0:

		chunk_speed += CHUNK_SPEED_INCREMENT
