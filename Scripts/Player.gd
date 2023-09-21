extends KinematicBody2D

# Member variables
var speed = 200
var jump_speed = -500 # Negative because 2D space's y-axis is down
var gravity = 980 # The force of gravity
var velocity = Vector2()

func _physics_process(delta):
	# Get input direction
	var direction = Vector2()
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1

	# Normalize direction
	direction = direction.normalized()

	# Apply horizontal movement
	velocity.x = direction.x * speed

	# Apply gravity
	velocity.y += gravity * delta

	# Jumping
	if Input.is_action_just_pressed('ui_up') and is_on_floor():
		velocity.y = jump_speed

	# Move the character
	velocity = move_and_slide(velocity, Vector2.UP)
