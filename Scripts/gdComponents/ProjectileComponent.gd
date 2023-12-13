extends Node2D
class_name ProjectileComponent


@export var speed : float = 4.0
@export var duration : float = 1.0
@export var timer : Timer
@export var sprite : Sprite2D
var direction
var projectile

func _ready():
	timer.start(duration)
	projectile = get_parent()


func _process(_delta):
	move()

func set_direction(vector: Vector2):
	direction = vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	if direction == Vector2.LEFT:
		projectile.position -= transform.x * speed
	else:
		projectile.position += transform.x * speed

func _on_timer_timeout():
	
	projectile.queue_free()


func _on_body_entered(body):
	pass


func _on_projectile_body_entered(body):
	if body.has_node("TerrainComponent"):
		projectile.queue_free()
	if body.has_method("enemy"):
		if body._state != body.State.DEATH:
			body.take_damage(20)
			projectile.queue_free()

	if body.has_method("mc"):
		body.take_damage(1)
		projectile.queue_free()
	if body.has_method("turret"):
		body.take_damage(20)
		projectile.queue_free()

