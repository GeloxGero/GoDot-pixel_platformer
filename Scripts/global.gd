extends Node


var current_scene = "LevelA1"
var transition_scene = false

var player_LevelA1_right_posx = 0

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "LevelA1":
			current_scene = "LevelA2"
