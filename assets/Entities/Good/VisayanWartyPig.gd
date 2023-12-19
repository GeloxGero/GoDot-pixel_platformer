extends CharacterBody2D

@onready var animation = $AnimationPlayer

@export var trapped : bool = false

var interacted := false
var has_player := false

func _process(delta):
	if has_player and Input.is_action_just_pressed("Interact") and not interacted:
		var animator = $AnimationPlayer
		animator.play("idle")
		interacted = true
	


func _on_area_2d_body_entered(body):
	has_player = true


func _on_area_2d_body_exited(body):
	has_player = false
