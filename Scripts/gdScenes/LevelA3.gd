extends Node2D

@export var limit_x_left : int
@export var limit_x_right : int
@export var limit_y_up : int
@export var limit_y_down : int

@onready var bird = $NegrosBleedingHeart/AnimationPlayer


var level_start : bool = false
var found_switch : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var camera = get_node("Player/Camera2D")
	camera.limit_left = limit_x_left
	camera.limit_right = limit_x_right
	camera.limit_top = limit_y_up
	camera.limit_bottom = limit_y_down
	
	bird.play("idle")
	DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s3content.dialogue"), "tooltip")
	DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s3content.dialogue"), "start")



func _on_edge_left_body_entered(body):
	if body.has_method("mc"):
		get_tree().change_scene_to_file(StageManager.Level2)


func _on_edge_left_body_exited(body):
	if body.has_method("player"):
		pass


func _on_edge_right_body_entered(body):
	if body.has_method("mc"):
		get_tree().change_scene_to_file(StageManager.Ending)


func _on_edge_right_body_exited(body):
	pass


func tell_switch():
	if not found_switch:
		DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s3content.dialogue"), "pollution")
		found_switch = true
func motivate():
	DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s3content.dialogue"), "motivate")


func unlock():
	$Lock.queue_free()
	DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s3content.dialogue"), "completed")

