extends Area2D

@export var speed : float = 4.0
@export var duration : float = 1.0
@export var timer : Timer
@export var sprite : Sprite2D

var direction: Vector2


func set_direction(vector: Vector2):
	direction = vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	if direction == Vector2.LEFT:
		self.position -= transform.x * speed
	else:
		self.position += transform.x * speed

func detect_collision(body):
	if body.name == "TileMap":
		self.queue_free()
	if body.has_method("enemy"):
		if body._state != body.State.DEATH:
			body.take_damage(20)
			self.queue_free()

	if body.has_method("turret"):
		body.take_damage(20)
