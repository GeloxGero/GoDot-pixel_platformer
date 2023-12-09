extends Node2D

var inc = 0


@export var limit_x_left : int
@export var limit_x_right : int
@export var limit_y_up : int
@export var limit_y_down : int

var Enemy = preload("res://assets/Entities/Enemy/Woodcutter/wood_cutter.tscn")

var data
func _initial_data():
	data = {
		"player": null,
		"garbage": [],
		"enemy": [],
	}


func update_player():
	var player = $Player
	data.player = {
		"position_y" = player.position.y,
		"position_x" = player.position.x
	}

func inst(node: PackedScene, position: Vector2):
	var object = node.instantiate()
	if object.has_method("enemy"):
		data.enemy.append({
			"position_y" = position.y,
			"position_x" = position.x
		})
	add_child(object)
	object.position = position
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var camera = get_node("Player/Camera2D")
	camera.limit_left = limit_x_left
	camera.limit_right = limit_x_right
	camera.limit_top = limit_y_up
	camera.limit_bottom = limit_y_down
	
	if !Persist.Scene3:
		_initial_data()
		inst(Enemy, Vector2(664, -194))
		inst(Enemy, Vector2(903, -164))
		inst(Enemy, Vector2(1563, -97))
		update_player()
	else:
		data = Persist.Scene3
		$Player.position = Vector2(data.player.position_x, data.player.position_y)

func _on_edge_left_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(StageManager.Level2)


func _on_edge_left_body_exited(body):
	if body.has_method("player"):
		pass


func _on_edge_right_body_entered(body):
	print(body.has_method("mc"))
	if body.has_method("mc"):
		update_player()
		data.player.position_x -= 50
		Persist.update_data(data, "Scene3")
		get_tree().change_scene_to_file(StageManager.Level3)


func _on_edge_right_body_exited(body):
	pass # Replace with function body.
