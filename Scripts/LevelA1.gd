extends Node2D
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(Global.two_to_one)
	player = get_node("Player")
	if(Global.two_to_one):
		teleport(1900, -500)

func _on_edge_right_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(StageManager.Level2)
		
	

func _on_edge_right_body_exited(body):
	if body.has_method("layer"):
		Global.transition_scene = false


func teleport(x, y):
	player.global_position = Vector2(x, y)
