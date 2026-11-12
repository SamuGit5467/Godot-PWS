extends Area2D

@export var damage: int = 1
@export var hit_cooldown: float = 0.25  # seconds per body to avoid repeat spam
@export var spike_direction: String = "up"  # "up"=floor, "down"=ceiling, "left"=left wall, "right"=right wall
@onready var sprite_node = $Sprite2D
#var _last_hit_time := {}

func _ready() -> void:
	monitoring = true
	#connect("body_entered", Callable(self, "_on_body_entered"))
	
	match spike_direction:
		"up":
			sprite_node.rotation_degrees = 0
		"down":
			sprite_node.rotation_degrees = 180
		"left":
			sprite_node.rotation_degrees = -90
		"right":
			sprite_node.rotation_degrees = 90
func _on_body_entered(body: Node) -> void:
	# Only affect objects that implement take_damage
	if not body or( not body.has_method("take_damage") and not body.has_method("kill_enemy")):
		return
	if body.has_method("take_damage"):
		# Call player's damage function
		body.take_damage(damage)
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
		
