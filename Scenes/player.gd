extends CharacterBody2D
@onready var tile_map: TileMapLayer = $"../TileMapLayer"

const SPEED = 64.0
const JUMP_VELOCITY = -400.0

func try_move(direction):
	var current_cell = tile_map.local_to_map(
		tile_map.to_local(position)
	)
	var next_cell = current_cell + direction
 	
	if tile_map.get_cell_source_id(next_cell) == -1:
		position += Vector2(direction) * SPEED
func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("up"):
		try_move(Vector2i(0, -1))
	if Input.is_action_just_pressed("down"):
		try_move(Vector2i(0, 1))
	if Input.is_action_just_pressed("left"):
		try_move(Vector2i(-1, 0))
	if Input.is_action_just_pressed("right"):
		try_move(Vector2i(1, 0))


	move_and_slide()
