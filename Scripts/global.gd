extends Node

var inital = true
var level_index = 0
var transition_scene = false
var player

var two_to_one = false

var hp = 5
var seeds = 0

var player_LevelA1_right_posx = 0

func finish_changescenes(inc):
	if transition_scene == true:
		transition_scene = false
		level_index += inc

func change_scene(new_scene, player_posx, player_posy):
	get_tree().change_scene(new_scene)
	player.position = Vector2(player_posx, player_posy)
