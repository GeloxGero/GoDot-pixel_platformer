extends Area2D

var has_player : bool = false
var interacted : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_player and Input.is_action_just_pressed("Interact") and not interacted:
		
		var sprite = $AnimatedSprite2D
		Global.switches_destroyed += 1
		sprite.play("default")
		sprite.show()
		interacted = true
		
		var owner = get_owner()
		
		owner.tell_switch()
		if Global.switches_destroyed % 4 == 0:
			owner.motivate()


func _on_body_entered(body):
	if body.has_method("mc"):
		has_player = true
		print(body)
	
		


func _on_body_exited(body):
		has_player = false
