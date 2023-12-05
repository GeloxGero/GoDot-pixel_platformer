extends Area2D

var rng = RandomNumberGenerator.new()
var snap = 0
var thrown = false
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = hash("Godot")
	rng.randomize()
	rng.state = 100

	var rand = rng.randi_range(1, 10)
	
	if rand == 1:
		$Sprite2D.texture.region = Rect2(128,216,32,24)
	elif rand == 2:
		$Sprite2D.texture.region = Rect2(160, 184, 16, 24)
	elif rand == 3:
		$Sprite2D.texture.region = Rect2(192, 184, 16, 24)
	elif rand == 4:
		$Sprite2D.texture.region = Rect2(224, 184, 16, 24)
	elif rand == 5:
		$Sprite2D.texture.region = Rect2(112, 216, 16, 24)
	elif rand == 6:
		$Sprite2D.texture.region = Rect2(128, 216, 32, 24)
	elif rand == 7:
		$Sprite2D.texture.region = Rect2(176, 216, 16, 24)
	elif rand == 8:
		$Sprite2D.texture.region = Rect2(208, 216, 16, 24)
	elif rand == 9:
		$Sprite2D.texture.region = Rect2(224, 216, 16, 24)
	elif rand == 10:
		$Sprite2D.texture.region = Rect2(240, 216, 16, 24)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	




func throw(vector: Vector2):
	direction = vector
	thrown = true
	

func move():
	pass

func _on_body_entered(body):
	if body.char_name == "Player":
		get_owner().remove_child(self)
		body.store_item(self)
		self.hide()


