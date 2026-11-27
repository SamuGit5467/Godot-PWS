extends CharacterBody2D

@onready var ai_controller: AIController2D = $AIController2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var invTimer: Timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var iteration = 0
var wins = 0
var losses = 0
var succesrate = 0
@onready var spawnpoint = global_position
var recent_results: Array[int] = []
var invulnerable = false

func goal_reached():
	ai_controller.reward += 5
	position = spawnpoint
	iteration +=1
	wins +=1
	update_succesrate(true)
func take_damage(damage):
	if invulnerable == false:
		invulnerable = true
		invTimer.start()
		ai_controller.reward -= 1
		position = spawnpoint
		velocity = Vector2(0,0)
		iteration +=1
		losses +=1
		update_succesrate(false)
		
	pass

func _rotate(delta: float) -> void:
	#sprite_2d.flip_h = false
	#sprite_2d.offset.x = 0

	if velocity:
		if velocity.x > 0:
			sprite_2d.rotate(delta * velocity.x * 0.03)
		if velocity.x < 0:
			sprite_2d.rotate(delta * velocity.x * 0.03)

# Call this when an iteration finishes
func update_succesrate(won: bool):
	
	recent_results.append(1 if won else 0)

	# Keep only the last 100 results
	if recent_results.size() > 10:
		recent_results.pop_front()

	# Calculate success rate
	var wins_last_100 = 0
	for result in recent_results:
		wins_last_100 += result

	succesrate = float(wins_last_100) / recent_results.size() * 100
	print('list')
	print(recent_results)
func _physics_process(delta: float) -> void:
	_rotate(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if ai_controller.jump and is_on_floor():
		#velocity.y = JUMP_VELOCITY
##
	### Get the input direction and handle the movement/deceleration.
	### As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = ai_controller.move.x
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#
	##if losses != 0:
		##succesrate = roundf(float(wins) *10000 / float(iteration)) /100
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#if losses != 0:
		#succesrate = roundf(float(wins) *10000 / float(iteration)) /100
	

	move_and_slide()


func _on_timer_timeout() -> void:
	invulnerable = false
	pass # Replace with function body.
