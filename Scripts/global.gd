extends Node

var level_index = 0

var transition_scene = false

var Levels = ["LevelA1", "LevelA2", "LevelA3", "LevelA4"]
var current_scene = Levels[0]

var player_LevelA1_right_posx = 0

func finish_changescenes(inc):
	if transition_scene == true:
		transition_scene = false
		level_index += inc
		current_scene = Levels[level_index]
