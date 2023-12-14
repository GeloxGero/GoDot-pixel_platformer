extends CharacterBody2D

@onready var animation := $AnimationPlayer
@onready var timer := $Timer # create a new Timer instance
@onready var random := RandomNumberGenerator.new()

@export var projectile: PackedScene

var flipped := false

enum STATE { HIT, ALIVE, SHOOT, DEAD }

var health := 100
var currState := STATE.ALIVE

func _ready():
	random.randomize()
	timer.set_wait_time(random.randf_range(0.5, 1.5))

func _process(_delta: float) -> void:
	match (currState):
		STATE.ALIVE:
			animation.play("idle")
		STATE.HIT:
			animation.play("hurt")
		STATE.SHOOT:
			animation.play("shoot")
		STATE.DEAD:
			self.queue_free()

func shoot():
	var bullet = projectile.instantiate()
	owner.add_child(bullet)
	bullet.position = position
	
	var component = bullet.get_node("ProjectileComponent")
	component.set_direction(Vector2.LEFT) 


# Take damage function in taking damage of turret
func take_damage(damage: int) -> void:
	health -= damage

	if health <= 0:
		currState = STATE.DEAD
	else:
		currState = STATE.HIT

func _on_timer_timeout() -> void:
	print("Shooting")
	currState = STATE.SHOOT

	shoot()
	timer.set_wait_time(random.randf_range(1.0, 3.5))


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished: ", anim_name)
	if anim_name == "death":
		self.queue_free()

	if anim_name == "hurt":
		currState = STATE.ALIVE

	if anim_name == "shoot":
		currState = STATE.ALIVE


func enemy():
	pass
