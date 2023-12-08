extends CharacterBody2D

@onready var animation := $AnimationPlayer
@onready var timer := $Timer # create a new Timer instance
@onready var random := RandomNumberGenerator.new()
@onready var marker := $Marker2D # get the Marker2D node

enum STATE { HIT, ALIVE, SHOOT, DEAD }

var health := 100
var currState := STATE.ALIVE

class TurretProjectile extends Area2D:
	@onready var sprite := Sprite2D.new()
	@onready var collision := CollisionShape2D.new()
	var distance := 0.0

	var speed := 2.5

	func _ready() -> void:
		connect("body_entered", Callable(self, "on_area_2d_body_entered"))
		sprite.texture = load("res://assets/Entities/Player/Projectiles/Item_Rock1.png")
		sprite.z_index = 3

		self.add_child(sprite)

		collision.shape = CircleShape2D.new()
		collision.shape.radius = sprite.texture.get_width() / 2.0
		self.add_child(collision)

	func _process(_delta: float) -> void:
		var movement = transform.x * speed

		self.position -= movement
		distance += movement.length()

		if distance >= 250:
			self.queue_free()

		print("Distance: ", distance)

	func on_area_2d_body_entered(body: Node2D) -> void:
		if body.has_method("mc"):
			body.take_damage(1)
			self.queue_free()

func _ready():
	random.randomize()
	timer.set_wait_time(random.randf_range(0.5, 1.5))

	add_child(timer)

func _process(_delta: float) -> void:
	match (currState):
		STATE.ALIVE:
			animation.play("idle")
		STATE.HIT:
			animation.play("hurt")
		STATE.SHOOT:
			animation.play("shoot")
		STATE.DEAD:
			animation.play("death")

# Spawns a projectile at the marker's position.
func spawn_projectile():
	var projectile := TurretProjectile.new()
	projectile.global_position = marker.global_position

	get_parent().add_child(projectile)

# Take damage function in taking damage of turret
func take_damage(damage: int) -> void:
	health -= damage

	if health <= 0:
		currState = STATE.DEAD
	else:
		currState = STATE.HIT

func turret():
	pass

# Function connections

func _on_timer_timeout() -> void:
	currState = STATE.SHOOT

	spawn_projectile()
	timer.set_wait_time(random.randf_range(1.0, 3.5))


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished: ", anim_name)
	if anim_name == "death":
		self.queue_free()

	if anim_name == "hurt":
		currState = STATE.ALIVE

	if anim_name == "shoot":
		currState = STATE.ALIVE
