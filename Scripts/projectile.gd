extends Area2D

var random = RandomNumberGenerator.new()
var speed : float = 4
var direction: Vector2
var max_time = 2
var snap 

# Called when the node enters the scene tree for the first time.
func _ready():
	snap = Global.TIMER - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if max_time == 0:
		self.queue_free()
	if Global.TIMER == snap:
		max_time -= 1
	
	print(max_time)
	
	
	if direction == Vector2.LEFT:
		self.position -= transform.x * speed
	else:
		self.position += transform.x * speed

	


func set_direction(vector: Vector2):
	direction = vector


func _on_body_entered(body):
	if body.char_name == "Enemy":
		body.take_damage(20)
		self.queue_free()
