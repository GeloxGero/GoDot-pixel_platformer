extends KinematicBody2D

enum States {ON_GROUND, IN_AIR, CLIMB, DROP, CROUCH, SWIM}
onready var animation = $AnimationPlayer

var _state : int = States.ON_GROUND


# Member variables
var speed = 140
var jump_speed = -250 # Negative because 2D space's y-axis is down
var gravity = 980 # The force of gravity
var velocity = Vector2()
var jump_force = 1

func _physics_process(delta):
	# Get input direction
	#
	# continuous click
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	
	# per click
	var down = Input.is_action_just_pressed('ui_down')
	var up = Input.is_action_just_pressed('ui_up')
	var on_floor = is_on_floor()
	var direction = Vector2()
	
	if _state != States.CROUCH and on_floor:
		_state = States.ON_GROUND
	
	if(up):
		if _state == States.CROUCH:
			_state = States.ON_GROUND
		elif _state == States.ON_GROUND:
			animation.play("jump")
			velocity.y = jump_speed * jump_force
			_state = States.IN_AIR
	elif(down):
		if _state == States.ON_GROUND:
			_state = States.CROUCH
	elif(right):
		if _state == States.ON_GROUND:
			animation.play("run")
		$Sprite.flip_h = false
		direction.x += 1
	elif(left):
		if _state == States.ON_GROUND:
			animation.play("run")
		$Sprite.flip_h = true
		direction.x -= 1
		animation.play("run")
	else:
		if _state == States.ON_GROUND:
			animation.play("idle")
		
	

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
