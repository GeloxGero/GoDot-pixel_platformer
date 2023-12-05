extends CharacterBody2D

var char_name = "Enemy"

@export var starting_move_direction : Vector2 = Vector2.LEFT

@export var can_attack : bool

@export var health_points : int = 20
@export var attack_left_position : Vector2
@export var attack_right_position : Vector2

@onready var animation = $AnimationPlayer


var hitpoints = 100
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
	check_death()
	
	
	#flip sprite and area2Ds
	if flipped:
		$Sprite2D.flip_h = true
		$AttackingArea/AttackingDetect.position = attack_right_position
		$DamagingArea/AttackingCollide.position = attack_right_position
	else:
		$Sprite2D.flip_h = false
		$AttackingArea/AttackingDetect.position = attack_left_position
		$DamagingArea/AttackingCollide.position = attack_left_position
	
	
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
			movement_speed = 30.0
			animation.play("walk")
		State.DAMAGED:
			movement_speed = 0
			animation.play("damaged")
		State.DEATH:
			movement_speed = 0
			animation.play("death")
		State.ATTACK:
			if can_attack:
				animation.play("attack")


	
	
	
	if direction:
		velocity.x = direction.x * movement_speed	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if not can_attack:
		velocity.x = 0
	move_and_slide()



func take_damage(damage):
	hitpoints -= damage
	_state = State.DAMAGED

func check_death():
	if hitpoints <= 0:
		_state = State.DEATH


func _on_attacking_area_body_entered(body):
	if body.name == "Player":
		_state = State.ATTACK


func _on_attacking_area_body_exited(body):
	if body.name == "Player":
			can_attack = true
			$DamagingArea.monitoring = false
			_state = State.IDLE
	

func _on_damaging_area_body_entered(body):
	if body.name == "Player":
		print("Hit")
		body.take_damage(1)


func _on_damaging_area_body_exited(body):
	pass # Replace with function body.


func _on_detection_area_body_entered(body):
	if body.name == "Player":
		if body.position < self.position:
			direction = Vector2.LEFT
			flipped = false
		else:
			direction =  Vector2.RIGHT
			flipped = true
		_state = State.CHASE


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		_state = State.IDLE

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		self.queue_free()
	elif anim_name == "damaged":
		_state = State.IDLE
