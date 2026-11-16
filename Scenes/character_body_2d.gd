extends CharacterBody2D

@onready var ai_controller: AIController2D = $AIController2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var iteration = 0
var wins = 0
var losses = 0
var succesrate = 0
@onready var spawnpoint = global_position

func goal_reached():
	ai_controller.reward += 5
	position = spawnpoint
	iteration +=1
	wins +=1
func take_damage(damage):
	ai_controller.reward -= 1
	position = spawnpoint
	iteration +=1
	losses +=1
	pass

func _rotate(delta: float) -> void:
	#sprite_2d.flip_h = false
	#sprite_2d.offset.x = 0

	if velocity:
		if velocity.x > 0:
			sprite_2d.rotate(delta * velocity.x * 0.03)
		if velocity.x < 0:
			sprite_2d.rotate(delta * velocity.x * 0.03)

func _physics_process(delta: float) -> void:
	_rotate(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if ai_controller.jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	var direction = ai_controller.move.x
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	

	move_and_slide()
