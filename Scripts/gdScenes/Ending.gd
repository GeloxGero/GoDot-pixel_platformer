extends Node2D

@export var limit_x_left : int
@export var limit_x_right : int
@export var limit_y_up : int
@export var limit_y_down : int




@onready var deer = $VisayanSpottedDeer/AnimationPlayer
@onready var pig = $VisayanWartyPig/AnimationPlayer
@onready var bird = $NegrosBleedingHeart/AnimationPlayer


func _ready():
	var camera = get_node("Player/Camera2D")
	camera.limit_left = limit_x_left
	camera.limit_right = limit_x_right
	camera.limit_top = limit_y_up
	camera.limit_bottom = limit_y_down
	
	
	deer.play("idle")
	pig.play("idle")
	bird.play("idle")
	
	show_achievements()
	await DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/ending.dialogue"), "start")
	

func show_achievements():
	await DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/ending.dialogue"), "achievements")
