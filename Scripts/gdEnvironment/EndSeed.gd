extends StaticBody2D



func _on_area_2d_body_entered(body):
	if body.has_method("mc"):
		get_tree().change_scene_to_file(StageManager.TitleScreen)
