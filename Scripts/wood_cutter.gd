extends CharacterBody2D

@export var starting_move_direction : Vector2 = Vector2.LEFT
@onready var animation = $AnimationPlayer
var movement_speed = 30.0

enum State {WALK, CHASE, IDLE, DAMAGED, DEATH}

var attacking = false
var _state = State.IDLE
var speed = 30.0
var player = null

var gravity = 980 # The force of gravity

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if not attacking:
		match _state:
			State.IDLE:
				movement_speed = 30.0
				animation.play("idle")
			State.CHASE:
				movement_speed = 200.0
				animation.play("run")
				#velocity = direction * speed
			State.WALK:
				animation.play("walk")
			State.DAMAGED:
				animation.play("damaged")
			State.DEATH:
				animation.play("death")
	
	if attacking:
		animation.play("attack")

	var direction: Vector2 = starting_move_direction
	if direction:
		velocity.x = direction.x * movement_speed	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()






func _on_attacking_area_body_entered(body):
	if body.name == "Player":
		attacking = true


func _on_attacking_area_body_exited(body):
	if body.name == "Player":
		attacking = false
	

func _on_damaging_area_body_entered(body):
	if body.name == "Player":
		print("Damaged")


func _on_damaging_area_body_exited(body):
	pass # Replace with function body.


func _on_detection_area_body_entered(body):
	if body.name == "Player":
		_state = State.CHASE


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		_state = State.IDLE
