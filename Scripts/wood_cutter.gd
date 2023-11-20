extends CharacterBody2D

@export var starting_move_direction : Vector2 = Vector2.LEFT
@onready var animation = $AnimationPlayer
var movement_speed = 30.0

enum State {WALK, CHASE, IDLE, DAMAGED, DEATH, ATTACK}

var attacking = false
var _state = State.IDLE
var speed = 30.0
var player = null
var flipped = false

var gravity = 980 # The force of gravity

var direction: Vector2 = starting_move_direction
func _physics_process(delta):
	if flipped:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	

	match _state:
		State.IDLE:
			movement_speed = 30.0
			animation.play("idle")
		State.CHASE:
			movement_speed = 100.0
			animation.play("run")
			#velocity = direction * speed
		State.WALK:
			animation.play("walk")
		State.DAMAGED:
			animation.play("damaged")
		State.DEATH:
			animation.play("death")
		State.ATTACK:
			animation.play("attack")


	
	
	
	
	if direction:
		velocity.x = direction.x * movement_speed	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()






func _on_attacking_area_body_entered(body):
	if body.name == "Player":
		_state = State.ATTACK


func _on_attacking_area_body_exited(body):
	if body.name == "Player":
			_state = State.IDLE
	

func _on_damaging_area_body_entered(body):
	if body.name == "Player":
		Global.hp -= 1


func _on_damaging_area_body_exited(body):
	pass # Replace with function body.


func _on_detection_area_body_entered(body):
	if body.name == "Player":
		if body.position < self.position:
			flipped = false
		else:
			direction = (body.position - position).normalized()
			flipped = true
		_state = State.CHASE


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		_state = State.IDLE
