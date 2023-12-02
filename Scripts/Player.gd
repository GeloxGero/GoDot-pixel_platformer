extends CharacterBody2D

var previous_scene_position : Vector2

enum States {ON_GROUND, IN_AIR, CLIMB, DROP, CROUCH, SWIM}
@export var player_position : Vector2
@onready var animation = $AnimationPlayer
# Member variables
@export var speed: float = 140
@export var jump_force: float = 1.2
@export var projectile: PackedScene

var player
var _state : int = States.ON_GROUND

var lock_x : bool = false
var lock_jump: bool = false
var on_ladder : bool = false

var jump_speed = -250 # Negative because 2D space's y-axis is down
var gravity = 980 # The force of gravity

func _physics_process(delta):	
	player_position = position
	if Global.hp <= 0:
		print("death")
	
	if(_state == States.IN_AIR):
		if not $AnimationPlayer.current_animation == "jump": 
			_state == States.DROP

	# continuous click
	var up = Input.is_action_pressed('up')
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	
	# per click

	if Input.is_action_just_pressed("Shoot"):
		shoot()
	var down = Input.is_action_just_pressed('down')
	var jump = Input.is_action_just_pressed('jump')
	var direction = Vector2()
	
	var on_floor = is_on_floor()
	
	if on_floor and _state != States.CROUCH and _state != States.CLIMB:
		_state = States.ON_GROUND
	
	match _state:
		States.ON_GROUND:
			lock_x = false
			lock_jump = false
		States.DROP:
			lock_jump = true
			animation.play("fall")
		States.CLIMB:
			down = Input.is_action_pressed('down')
			velocity.y = 0
			gravity = 0
			if not on_ladder:
				_state = States.DROP
				gravity = 980
		States.DROP:
			lock_jump = true
		States.IN_AIR:
			lock_jump = true
	
	if(jump and not lock_jump):
		if on_ladder:
			_state = States.DROP
			gravity = 980
		else:
			animation.play("jump")
			velocity.y = jump_speed * jump_force
			_state = States.IN_AIR
		
	elif(up):
		if on_ladder:
			if _state == States.CLIMB:
				velocity.y = -80
				animation.play("climb")
			else:
				_state = States.CLIMB
		elif _state == States.CROUCH:
			_state = States.ON_GROUND
	elif(down):
		if on_ladder:
			if _state == States.CLIMB:
				velocity.y = 80
				animation.play("climb")
			else:
				_state = States.CLIMB
		if _state == States.ON_GROUND:
			_state = States.CROUCH
	elif(right and not lock_x):
		if _state == States.ON_GROUND:
			animation.play("run")
		$Sprite2D.flip_h = false
		direction.x += 1
	elif(left and not lock_x):
		if _state == States.ON_GROUND:
			animation.play("run")
		$Sprite2D.flip_h = true
		direction.x -= 1
	else:
		if _state == States.ON_GROUND:
			animation.play("idle")
		
	

	# Normalize direction
	direction = direction.normalized()


	# Apply horizontal movement
	velocity.x = direction.x * speed
	velocity.y += gravity * delta
	

	
	
	
	# Move the character
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()




	# Keep the character within the screen bounds
	
	#var screen_size = get_viewport_rect().size
	#if position.x < 0:
		#position.x = 0
	#if position.x > screen_size.x:
		#position.x = screen_size.x

func _on_ladder_checker_body_entered(body):
	on_ladder = true

func _on_ladder_checker_body_exited(body):
	on_ladder = false

func take_damage(damage):
	if Global.hp == 1:
		die()
	Global.hp -= damage
	
func shoot():
	print("Shooting")
	print(owner.get_child_count())
	var boko = projectile.instantiate()
	add_child(boko)
	
	
func die():
	get_tree().change_scene_to_file(StageManager.game_over)
