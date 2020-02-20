extends Node2D

var velocity : Vector2 = Vector2()
export (int) var SPEED : int = 400
var timeToLive = 3

func _process(delta):
	if timeToLive < 0:
		queue_free()
	else :
		timeToLive -= delta
		move_local_y(SPEED * delta)
