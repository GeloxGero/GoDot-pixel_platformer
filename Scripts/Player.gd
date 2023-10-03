extends KinematicBody2D

enum States {ON_GROUND, IN_AIR, CLIMB, DROP, CROUCH, SWIM}


var _state : int = States.ON_GROUND


# Member variables
var speed = 140
var jump_speed = -250 # Negative because 2D space's y-axis is down
var gravity = 980 # The force of gravity
var velocity = Vector2()
var jump_force = 1

func _physics_process(delta):
	# Get input direction
	
	if _state != States.CROUCH and is_on_floor():
		_state = States.ON_GROUND
	
	if(Input.is_action_just_pressed('ui_up')):
		if _state == States.CROUCH:
			_state = States.ON_GROUND
		elif _state == States.ON_GROUND:
			velocity.y = jump_speed * jump_force
			_state = States.IN_AIR
	
	if _state == States.ON_GROUND and Input.is_action_pressed('ui_down'):
		_state = States.CROUCH
	
	print(_state)
	
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

	# Move the character
	velocity = move_and_slide(velocity, Vector2.UP)


	# Keep the character within the screen bounds
	var screen_size = get_viewport_rect().size
	if position.x < 0:
		position.x = 0
	if position.x > screen_size.x:
		position.x = screen_size.x
