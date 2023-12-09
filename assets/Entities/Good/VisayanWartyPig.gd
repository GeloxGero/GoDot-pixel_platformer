extends CharacterBody2D

@onready animation = $AnimationPlayer

@export var trapped : bool = false

func _physics_process(delta):
	
