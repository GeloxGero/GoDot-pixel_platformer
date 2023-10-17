extends Node2D

var inc = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

func _on_edge_right_body_entered(body):
	if body.has_method("player"):
		inc = 1
		Global.transition_scene = true


func _on_edge_right_body_exited(body):
	if body.has_method("player"):
		inc = 0
		Global.transition_scene = false

func _on_edge_left_body_entered(body):
	if body.has_method("player"):
		inc = -1
		Global.transition_scene = true


func _on_edge_left_body_exited(body):
	if body.has_method("player"):
		inc = 0
		Global.transition_scene = false



func change_scene():
	if Global.transition_scene == true:
		if inc > 0:
			get_tree().change_scene_to_file("res://Scenes/LevelA3.tscn")
			Global.finish_changescenes(1)
		elif inc < 0:
			get_tree().change_scene_to_file("res://Scenes/LevelA1.tscn")
			Global.finish_changescenes(-1)



