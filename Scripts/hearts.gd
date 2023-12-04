extends CanvasLayer

func _ready():
	$PauseUI.hide()


func _process(delta):
	if Global.hp == 5:
		$Hearts.set_frame(0)
	if Global.hp == 4:
		$Hearts.set_frame(1)
	if Global.hp == 3:
		$Hearts.set_frame(2)
	if Global.hp == 2:
		$Hearts.set_frame(3)
	if Global.hp == 1:
		$Hearts.set_frame(4)
	if Global.hp == 0:
		$Hearts.set_frame(5)

func _on_pause_button_pressed():
	get_tree().paused = true
	$PauseUI.show()




func _on_play_button_pressed():
	get_tree().paused = false
	$PauseUI.hide()
