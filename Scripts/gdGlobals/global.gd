extends Node

var random = RandomNumberGenerator.new()

var TIMER = 0

var two_to_one = false

var hp = 5
var trashthrown = 0
var trash_disposed = 0
var seeds_collected = 0

var switches_destroyed = 0

func reset():
	hp = 5
	two_to_one = false
