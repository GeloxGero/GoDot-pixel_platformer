extends Area2D

var random = RandomNumberGenerator.new()
var speed : float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed
	
