extends Node2D

@export var limit_x_left : int
@export var limit_x_right : int
@export var limit_y_up : int
@export var limit_y_down : int

var level_blocked := false
var extras : bool = false

var y_offset = -82
# Called when the node enters the scene tree for the first time.

var Garbage = preload("res://assets/Environment/Misc/Trash/Garbage.tscn")
var Enemy = preload("res://assets/Entities/Enemy/Woodcutter/wood_cutter.tscn")
var Seed = preload("res://assets/Environment/Seeds/LevelSeed.tscn")

@onready var area_blocked = $Lock/LevelBlock
@onready var level_blocker = $Lock/LevelBlocker

var data

func _initial_data():
	data = {
		"player": null,
		"enemy": [],
		"dialogue": []
	}

#dialogue[0] would be initial dialogue

func inst_seed(node: PackedScene, position: Vector2, to_animate: String):
	var object = node.instantiate()
	object.to_animate = to_animate
	add_child(object)
	object.position = position


func inst(node: PackedScene, position: Vector2):
	var object = node.instantiate()
	if object.has_method("enemy"):
		data.enemy.append({
			"position_y" = position.y,
			"position_x" = position.x
		})
	add_child(object)
	object.position = position

func update_player():
	var player = $Player
	data.player = {
		"position_y" = player.position.y,
		"position_x" = player.position.x
	}

func _ready():	
	if !Persist.Scene1:
		_initial_data()
		inst(Enemy, Vector2(664, -194))
		inst(Enemy, Vector2(903, -164))
		inst(Enemy, Vector2(1563, -97))
		update_player()
		inst_seed(Seed, Vector2(228, -63), "apple_float")
		inst_seed(Seed, Vector2(623, -221), "banana_float")
		inst_seed(Seed, Vector2(1037, -191), "grapes_float")
		inst_seed(Seed, Vector2(1743, -209), "orange_float")
		inst_seed(Seed, Vector2(2420, -94), "strawberry_float")
		inst_seed(Seed, Vector2(2542, -37), "apple_float")
		DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/initial.dialogue"), "level1")
	else:
		data = Persist.Scene1
		$Player.position = Vector2(data.player.position_x, data.player.position_y)
		#for load in data.enemy:
			#inst(Enemy, Vector2(load.position_x, load.position_y))
	

	#MusicController.play_music()
	if Global.seeds_collected == 6:
		$Terrain/CPUParticles2D.emitting = true
	
	
	var camera = get_node("Player/Camera2D")
	camera.limit_left = limit_x_left
	camera.limit_right = limit_x_right
	camera.limit_top = limit_y_up
	camera.limit_bottom = limit_y_down
	

func _on_edge_right_body_entered(body):
	if body.has_method("mc"):
		update_player()
		data.player.position_x -= 50
		Persist.update_data(data, "Scene1")
		get_tree().change_scene_to_file(StageManager.Level2)


func _on_edge_right_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.has_method("mc"):
		body.die()


func _on_surprise_dialog_body_entered(body):
	if !extras:
		extras = true
		DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s1extra1.dialogue"), "s1extra1")
		print(DialogueManager.got_dialogue)


func _on_surprise_dialog_body_exited(body):
	pass


func _on_level_block_body_entered(body):
	if body.has_method("mc"):
		if Global.seeds_collected == 6:
			set_deferred("monitoring", false)
			level_blocker.queue_free()
		else:
			DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s1end.dialogue"), "incomplete")


func all_seeds_collected():
	DialogueManager.show_example_dialogue_balloon(load("res://assets/Words/s1extra1.dialogue"), "s1extra1")
	$Terrain/CPUParticles2D.emitting = true
