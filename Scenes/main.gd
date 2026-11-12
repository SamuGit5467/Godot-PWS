extends Node2D
@onready var tilemap_layer: TileMapLayer = $TileMapLayer   # change this path 
@onready var SpikeScene = preload("res://Scenes/spike.tscn")
@onready var player: CharacterBody2D = $CharacterBody2D

var spawn_position = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_position = player.global_position
	for cell in tilemap_layer.get_used_cells():
		var tile_data = tilemap_layer.get_cell_tile_data(cell)
		if tile_data and tile_data.get_custom_data("spike"):
			var spike = SpikeScene.instantiate()
			# Set spike direction from custom data
			spike.spike_direction = tile_data.get_custom_data("direction")
			# get local position for the cell and center it
			var local_pos = tilemap_layer.map_to_local(cell)
			#local_pos += tile_size_vec2

			spike.global_position = tilemap_layer.to_global(local_pos)
			add_child(spike)

	pass # Replace with function body.

func reset_character():
	player.position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
