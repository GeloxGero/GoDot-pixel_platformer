extends CharacterBody2D

var speed: float = 100
var gravity: float = 2000
var direction: Vector2 = Vector2.RIGHT
var random = RandomNumberGenerator.new()


# Initialize mob state
enum States {IDLE, FLYING}
var state: States = States.IDLE

# Handle movement
func _physics_process(delta):
	var rand = random.randf_range(1, 10)
	
	if state == States.IDLE:
		print($AnimationPlayer)
		if rand <= 10:
			state = States.FLYING
	elif state == States.FLYING:
		direction = Vector2(random.randf() - 0.5, random.randf() - 0.5)
		velocity = direction * speed
		if randf_range(1, 100) <= 10:
			state = States.IDLE
		# Attack logic
		velocity = Vector2.ZERO
		# After attack animation, switch back to IDLE or FLYING
		state = States.IDLE



#func _on_area_2d_area_entered(area):
#	if body is player:
#		state = States.FLYING
