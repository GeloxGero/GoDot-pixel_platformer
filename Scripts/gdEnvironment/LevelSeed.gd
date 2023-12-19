extends Area2D

@export_enum("apple_float", "banana_float", "grapes_float","orange_float","strawberry_float",) var to_animate : String

@onready var animation = $AnimatedSprite2D

func _ready():
	animation.play(to_animate)



func _on_body_entered(body):
	if body.has_method("mc"):
		Global.seeds_collected += 1
		self.queue_free()


func _on_body_exited(body):
	pass # Replace with function body.
