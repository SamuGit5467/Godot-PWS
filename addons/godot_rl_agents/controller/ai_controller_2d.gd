extends Node2D
class_name AIController2D

@export var reset_after := 1000
@onready var player: CharacterBody2D = $".."
@onready var goal: Area2D = $"../../Goal"

var heuristic := "human"
var done := false
var reward := 0.0
var n_steps := 0
var needs_reset := false

var _player: Node2D

var move = Vector2(0,0)
var jump = false
func _ready():
	add_to_group("AGENT")
	
func init(player: Node2D):
	_player = player
	
#-- Methods that need implementing using the "extend script" option in Godot --#
func get_obs() -> Dictionary:
	var obs := [
		player.position.x,
		player.position.y,
		goal.position.x,
		goal.position.y
	]
	return {"obs":obs}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 1,
			"action_type": "continuous"
		},
		"jump" : {
			"size": 1,
			"action_type": "discrete"
		},
		}
	
func set_action(action) -> void:	
	move.x = action['move'][0]
	jump = action['jump']
# -----------------------------------------------------------------------------#
	
func _physics_process(delta):
	n_steps += 1
	if n_steps > reset_after:
		needs_reset = true
		
func get_obs_space():
	# may need overriding if the obs space is complex
	var obs = get_obs()
	return {
		"obs": {
			"size": [len(obs["obs"])],
			"space": "box"
		},
	}

func reset():
	n_steps = 0
	needs_reset = false

func reset_if_done():
	if done:
		reset()
		
func set_heuristic(h):
	# sets the heuristic from "human" or "model" nothing to change here
	heuristic = h

func get_done():
	return done
	
func set_done_false():
	done = false

func zero_reward():
	reward = 0.0
	
