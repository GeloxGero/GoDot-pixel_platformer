extends Node2D

var inc = 0


@export var limit_x_left : int
@export var limit_x_right : int
@export var limit_y_up : int
@export var limit_y_down : int

@onready var piganimation = $VisayanWartyPig/AnimationPlayer
@onready var damage_tick = $DamageTick

var found_pig = false
var saved_pig = false
var poison_player = false

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
	piganimation.play("trapped")
	DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s2initial.dialogue"), "s2first")
	
	var camera = get_node("Player/Camera2D")
	camera.limit_left = limit_x_left
	camera.limit_right = limit_x_right
	camera.limit_top = limit_y_up
	camera.limit_bottom = limit_y_down
	
	if !Persist.Scene2:
		_initial_data()
		inst(Enemy, Vector2(664, -194))
		inst(Enemy, Vector2(903, -164))
		inst(Enemy, Vector2(1563, -97))
		update_player()
	else:
		data = Persist.Scene2
		$Player.position = Vector2(data.player.position_x, data.player.position_y)

func _on_edge_left_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(StageManager.Level1)


func _on_edge_left_body_exited(body):
	if body.has_method("player"):
		pass


func _on_edge_right_body_entered(body):
	if body.has_method("mc"):
		update_player()
		data.player.position_x -= 50
		Persist.update_data(data, "Scene2")
		get_tree().change_scene_to_file(StageManager.Level3)


func _on_edge_right_body_exited(body):
	pass # Replace with function body.


func _on_found_pig_body_entered(body):
	if !found_pig:
		DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s2pig.dialogue"), "pig")



func _on_death_zone_body_entered(body):
	if body.has_method("mc"):
		$Player.die()



func _on_damage_zone_body_entered(body):
	if body.has_method("mc"):
		poison_player = true
		damage_tick.start(1)


func _on_damage_zone_body_exited(body):
	if body.has_method("mc"):
		poison_player = false
		



func _on_damage_tick_timeout():
	if poison_player:
		$Player.take_damage(1)
		damage_tick.start(1)
