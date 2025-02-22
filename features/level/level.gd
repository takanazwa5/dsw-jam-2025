class_name Level extends Node2D


const CHUNK_SPEED : int = 100


const CHUNK_SCENE : PackedScene = preload("res://features/chunk/chunk.tscn")


@onready var chunks : Array[Chunk] = [%Chunk, %Chunk2]


func _ready() -> void:

	for chunk : Chunk in chunks:

		chunk.screen_exited.connect(_on_chunk_screen_exited)


func _process(delta: float) -> void:

	for chunk : Chunk in get_children():

		chunk.position.x -= CHUNK_SPEED * delta


func _on_chunk_screen_exited() -> void:

	var new_chunk : Chunk = CHUNK_SCENE.instantiate()
	new_chunk.position = chunks[-1].position + Vector2(640, 0)
	new_chunk.screen_exited.connect(_on_chunk_screen_exited)
	chunks.append(new_chunk)
	add_child(new_chunk)
	chunks.pop_front().queue_free()
