extends Node

var BACKGROUND = load("res://Assets/Audio/BG.mp3")
var AXE = load("res://assets/Audio/Axe.mp3")
var JUMP = load("res://assets/Audio/Jumping.mp3")
var WALK = load("res://assets/Audio/Walking.mp3")
var DAMAGE = load("res://assets/Audio/Damage.mp3")
var BURN = load("res://assets/Audio/Burning.mp3")

@onready var MUSIC = $Music
@onready var SFX = $SFX
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play(player, audio):
	player.stream = audio
	player.play()


func stop(player):
	player.stop()
