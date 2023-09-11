extends KinematicBody2D

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player Working")




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity.y += 5
	if Input.is_action_pressed("ui_right"):
		velocity.x = 30
	if Input.is_action_pressed("ui_left"):
		velocity.x = - 30
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -150
	if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		velocity.x = 0
	if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
		velocity.x = 0
	velocity = move_and_slide(velocity)
	

