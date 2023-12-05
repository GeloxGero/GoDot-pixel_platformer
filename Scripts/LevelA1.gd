extends Node2D
var player

@export var limit_x_left : int
@export var limit_x_right : int
@export var limit_y_up : int
@export var limit_y_down : int

var y_offset = -82
# Called when the node enters the scene tree for the first time.
func _ready():
	#MusicController.play_music()

	player = get_node("Player")
	
	if(Global.two_to_one):
		teleport(3329.34, -15 - y_offset)
	
	var camera = get_node("Player/Camera2D")
	camera.limit_left = limit_x_left
	camera.limit_right = limit_x_right
	camera.limit_top = limit_y_up
	camera.limit_bottom = limit_y_down

func _on_edge_right_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(StageManager.Level2)


func _on_edge_right_body_exited(body):
	if body.has_method("layer"):
		Global.transition_scene = false


func teleport(x, y):
	player.global_position = Vector2(x, y)


func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.name == 'Player':
		player.die()
