extends Area2D

var speed : float = 4
var direction

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == Vector2.LEFT:
		self.position -= transform.x * speed
	else:
		self.position += transform.x * speed


func set_direction(vector: Vector2):
	direction = vector
