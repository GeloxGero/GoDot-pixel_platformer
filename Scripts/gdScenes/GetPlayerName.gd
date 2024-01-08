extends Node2D

@onready var input = $TextEdit
@onready var temp = $Temp

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var input_text = input.get_text()
		
		Global.player_name = input_text.substr(0, input_text.length() - 1)
		input.clear()
		temp.clear()
		get_tree().change_scene_to_file(StageManager.Level1)
