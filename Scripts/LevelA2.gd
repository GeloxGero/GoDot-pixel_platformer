extends Node2D

var inc = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_edge_right_body_entered(body):
	if body.has_method("player"):
		inc = 1
		Global.transition_scene = true


func _on_edge_right_body_exited(body):
	if body.has_method("player"):
		inc = 0
		Global.transition_scene = false

func _on_edge_left_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(StageManager.Level1)
		Global.two_to_one = true


func _on_edge_left_body_exited(body):
	if body.has_method("player"):
		inc = 0
		Global.transition_scene = false




