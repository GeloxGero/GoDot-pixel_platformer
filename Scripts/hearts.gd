extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
