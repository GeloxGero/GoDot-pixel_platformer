extends Control


func _ready():
	pass
	#$AudioStreamPlayer2D.play()

func _on_StartButton_pressed():
	get_tree().change_scene_to_file(StageManager.GetPlayerName)
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
