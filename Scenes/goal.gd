extends Area2D


#var _last_hit_time := {}

func _ready() -> void:
	monitoring = true
	#connect("body_entered", Callable(self, "_on_body_entered"))
	
	#match spike_direction:
		#"up":
			#sprite_node.rotation_degrees = 0
		#"down":
			#sprite_node.rotation_degrees = 180
		#"left":
			#sprite_node.rotation_degrees = -90
		#"right":
			#sprite_node.rotation_degrees = 90
func _on_body_entered(body: Node) -> void:
	# Only affect objects that implement take_damage
	if not body or( not body.has_method("take_damage") and not body.has_method("kill_enemy")):
		return
	if body.has_method("goal_reached"):
		# Call player's damage function
		body.goal_reached()
		#if body is CharacterBody2D:
			## Determine horizontal direction relative to spike
			#var hor_dir = sign(body.global_position.x - global_position.x)
			#if hor_dir == 0:
				#hor_dir = 1  # default if perfectly centered

			#match spike_direction:
				#"up":  # floor spike
					#body.velocity.y = -400
					#body.velocity.x += hor_dir * 250
				#"down":  # ceiling spike
					#body.velocity.y = 200
					#body.velocity.x += hor_dir * 20
				#"left":  # wall spike on left
					#body.velocity.x = -250
					#body.velocity.y = -100  # optional vertical lift
				#"right":  # wall spike on right
					#body.velocity.x = 250
					#body.velocity.y = -100

			# Trigger player stunned state
			#body.start_stun()
	#if body.has_method("kill_enemy"):
		#body.kill_enemy()
			#
		
