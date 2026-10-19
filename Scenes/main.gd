extends Node2D
@onready var player = $player
var points = 0
@onready var start_position = player.global_position


func reset():
	player.position = start_position

func death():
	reset()
func victory():
	reset()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_goal_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#points += 1
	#print(points)
	victory()
	pass # Replace with function body.


func _on_death_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	death()
	pass # Replace with function body.


func _on_death_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	death()
	pass # Replace with function body.


func _on_death_3_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	death()
	pass # Replace with function body.


func _on_death_4_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	death()
	pass # Replace with function body.
